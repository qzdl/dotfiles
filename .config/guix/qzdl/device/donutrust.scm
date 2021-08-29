(define-module (qzdl system donutrust)
 #:use-module (gnu)
 #:use-module (nongnu packages linux)
 #:use-module (qzdl system minimal))

(operating-system
 (inherit minimal-operating-system)
 (host-name "donutrust")

 (firmware (list linux-firmware sof-firmware))

 (mapped-devices
  (list (mapped-device
         (source (uuid "c9042f21-04bd-48ff-9295-5e314f1d4b37"))
         (target "sys-root")
         (type luks-device-mapping))))

 (services
  (cons*
   (operating-system-services minimal-operating-system)
   (service slim-service-type
    (postgresql-role-configuration
     (extensions (list (service-extension
                        postgresql-role-service-type
                        (const (postgresql-role
                                (name "newstore")
                                (create-database? #t))))))))))

 (file-systems (cons*
                (file-system
                 (device (file-system-label "sys-root"))
                 (mount-point "/")
                 (type "ext4")
                 (dependencies mapped-devices))
                (file-system
                 (device "/dev/nvme0n1p1")
                 (mount-point "/boot/efi")
                 (type "vfat"))
                %base-file-systems)))
