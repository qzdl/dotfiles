(define-module (base-system)
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
  #:use-module (nongnu system linux-initrd))

(use-package-modules certs)
(use-package-modules shells)

(define-public base-operating-system
  (operating-system
   (host-name "unconf")
   (timezone "Europe/Berlin")
   (locale "en_US.UTF-8")

   ;; nonfree kernel
   (kernel linux)
   (firmware (list linux-firmware))
   (initrd microcode-initrd)

   ;; disable ipv6 for safe vpn usage; we just aren't there yet :/
   (kernel-arguments '("quiet" "ipv6.disable=1"))

   ;; kernel layout, not necessarily X layout
   (keyboard-layout (keyboard-layout "us" "altgr-intl" #:model "thinkpad"))

   ;; UEFI+GRUB
   (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (target "/boot/efi")
                (keyboard-layout keyboard-layout)))

   ;; base user
   (users (cons (user-account
                 (name "samuel")
                 (comment "it me")
                 (group "users")
                 (home-directory "/home/samuel/")
                 (supplementary-groups '("wheel"
                                         "netdev"
                                         "kvm"
                                         "tty"
                                         "input"
                                         "docker")))
                %base-user-accounts))

   ;; OVERWRITE THIS WHEN INHERITING
   ;;   AN ARTIFACT OF INCIDENTAL COMPLEXITY IN GUIX
   (file-systems (cons*
                  (file-system
                   (mount-point "/tmp")
                   (device "none")
                   (type "tmpfs")
                   (check? #f))
                  %base-file-systems)

   (packages (append (list
                      git
                      stow
                      emacs
                      vim
                      openvpn
                      nss-certs


                      ;; fs utils
                      gvfs
                      fuse-exfat
                      exfat-utils)
                     %base-packages))



   ;; Use the "desktop" services, which include the X11 log-in service,
   ;; networking with NetworkManager, and more
   (services (append (list (service docker-service-type)
                           (extra-special-file "/usr/bin/env"
                                               (file-append coreutils "/bin/env"))
                           (service thermald-service-type))
                     %base-services))) ;; TODO INSPECT %base-services
