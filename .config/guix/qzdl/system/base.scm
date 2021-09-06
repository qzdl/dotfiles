(define-module (qzdl system base)
  #:use-module (qzdl cosas)
  #:use-module (qzdl services)
  #:use-module (gnu)
  #:use-module (srfi srfi-1) ; scheme extensions per https://srfi.schemers.org/srfi-159/srfi-159.html
  #:use-module (gnu system nss) ;; network security service; appdev ssl,tls, etc
  #:use-module (gnu services docker)
  #:use-module (gnu services networking)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages package-management)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:export (base-operating-system))

(use-package-modules certs)
(use-package-modules shells)

(define base-operating-system
  (operating-system
   (host-name "unconf")
   (timezone "Europe/Berlin")
   (locale "en_US.UTF-8")

   ;; nonfree kernel :(
   (kernel linux)
   (firmware (list linux-firmware))
   (initrd microcode-initrd)

   ;; disable ipv6 for safe vpn usage; we just aren't there yet :/
   (kernel-arguments '("quiet" "ipv6.disable=1" "net.ifnames=0"))

   ;; kernel layout, not necessarily X layout
   (keyboard-layout my-keyboard-layout)

   ;; UEFI+GRUB
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (target "/boot/efi")
     (keyboard-layout keyboard-layout)))

   (users
    (cons (user-account
           (name "samuel")
           (comment "it me")
           (group "users")
           (home-directory "/home/samuel/")
           (supplementary-groups '("wheel"     ;; sudo
                                   "netdev"    ;; network devices
                                   "kvm"       ;; virtualisation
                                   "tty"
                                   "input"
                                   "lp"        ;; control bluetooth devices
                                   "audio"     ;; control audio devices
                                   "video"     ;; control video devices
                                   "docker")))
          %base-user-accounts))

   (groups
    (cons (user-group (name "docker"))
          %base-groups))

   ;; OVERWRITE THIS WHEN INHERITING
   ;;   AN ARTIFACT OF INCIDENTAL COMPLEXITY IN GUIX
   (file-systems (cons*
                  (file-system
                   (mount-point "/")
                   (device "none")
                   (type "tmpfs")
                   (check? #f))
                  %base-file-systems))

   (services
    (cons* my-docker-service
           (extra-special-file
            "/usr/bin/env"
            (file-append coreutils "/bin/env"))
           %base-services))

   (packages
    (cons* git
           stow
           emacs
           vim
           nss-certs
           %base-packages))))
