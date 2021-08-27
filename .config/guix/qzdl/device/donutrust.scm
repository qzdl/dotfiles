;; X11
             ;; (service slim-service-type
             ;;    (slim-configuration
             ;;     (xorg-configuration
             ;;      (xorg-configuration
             ;;       (keyboard-layout
             ;;        (operating-system-keyboard-layout base-operating-system)
             ;;        (extra-config (list %xorg-libinput-config)))))))



(define-module (qzdl system donutrust)
 #:use-module (minimal-system)
 #:use-module (gnu)
 #:use-module (nongnu packages linux))

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
   (modify-services
    (operating-system-services minimal-operating-system)
    (postgresql-role-service-type
     config => (postgresql-role-configuration
                (inherit config)
                (extensions (list (service-extension postgresql-role-service-type
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
