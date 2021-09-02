(define-module (qzdl device donutrust)
  #:use-module (srfi srfi-1)
  #:use-module (gnu)
  #:use-module (gnu services databases)
  #:use-module (nongnu packages linux)
  #:use-module (qzdl system minimal)
  #:export (donutrust-operating-system))

(define donutrust-operating-system
  (operating-system
    (inherit minimal-operating-system)
    (host-name "donutrust")

    (firmware (list linux-firmware sof-firmware))

    (services
     (delete-duplicates
      (operating-system-services minimal-operating-system)))

    (mapped-devices
     (list (mapped-device
            (source (uuid "c9042f21-04bd-48ff-9295-5e314f1d4b37"))
            (target "sys-root")
            (type luks-device-mapping))))


    (file-systems
     (cons*
      (file-system
        (device (file-system-label "sys-root"))
        (mount-point "/")
        (type "ext4")
        (dependencies mapped-devices))
      (file-system
        (device "/dev/nvme0n1p1")
        (mount-point "/boot/efi")
        (type "vfat"))
      %base-file-systems))

    ;; (services
    ;;  (cons*
       ;; (simple-service 'postgres-roles
       ;;                 postgresql-role-service-type
       ;;                 (list (const (postgresql-role
       ;;                               (name "newstore")
       ;;                               (create-database? #t)))))
       ;; (operating-system-services minimal-operating-system)))

  ))

donutrust-operating-system
