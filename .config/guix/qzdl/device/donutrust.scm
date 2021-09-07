(define-module (qzdl device donutrust)
  #:use-module (srfi srfi-1)
  #:use-module (gnu)
  #:use-module (gnu services databases)
  #:use-module (nongnu packages linux)
  #:use-module (qzdl services)
  #:use-module (qzdl system minimal)
  #:export (%donutrust-services
            donutrust-operating-system))

(define pg-role-service
  (simple-service
   'adhoc-extension postgresql-role-service-type
   (list (postgresql-role
          (name "newstore")
          (create-database? #t)))))

(define %donutrust-services
  (list pg-role-service))

(define donutrust-operating-system
  (operating-system
    (inherit minimal-operating-system)

    (host-name "donutrust")

    (firmware
     (list linux-firmware sof-firmware))

    (services
      (append %donutrust-services
              %minimal-services
              %base-services))

    (mapped-devices
     (list (mapped-device
            (source (uuid "c9042f21-04bd-48ff-9295-5e314f1d4b37"))
            (target "sys-root")
            (type luks-device-mapping))))

    (file-systems
     (cons* (file-system
              (device (file-system-label "sys-root"))
              (mount-point "/")
              (type "ext4")
              (dependencies mapped-devices))
            (file-system
              (device "/dev/nvme0n1p1")
              (mount-point "/boot/efi")
              (type "vfat"))
            %base-file-systems))))

donutrust-operating-system
