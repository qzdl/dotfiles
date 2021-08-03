;; GENERATED BY ~/dotfiles/systems.org

(define-module (donutrust)
 #:use-module (minimal-system)
 #:use-module (gnu))

(operating-system
 (inherit minimal-operating-system)
 (host-name "donutrust")

 (mapped-devices
  (list (mapped-device
         (source (uuid "c9042f21-04bd-48ff-9295-5e314f1d4b37"))
         (target "sys-root")
         (type luks-device-mapping))))

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
