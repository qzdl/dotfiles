(define-module (qzdl services)
  #:use-module (qzdl cosas)
  #:use-module (qzdl rules)
  #:use-module (srfi srfi-1)            ;; provides remove, member
  #:use-module (gnu packages gnome)     ;; for network-manager-openvpn
  #:use-module (gnu packages suckless)  ;; for slock
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)   ;; for udev, x11 socket
  #:use-module (gnu services databases) ;; for postgres
  #:use-module (gnu services dbus)
  #:use-module (gnu services desktop)   ;; FIXME %desktop-services is blote
  #:use-module (gnu services docker)
  #:use-module (gnu services networking)
  #:use-module (gnu services sound)
  #:use-module (gnu services ssh)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services xorg)      ;; FIXME to remove gdm-service-type
  #:export (my-libvirt-service
            my-docker-service
            my-dbus-service
            my-bluetooth-service

            my-wpa-supplicant-service
            my-network-manager-service
            my-ssh-service

            my-postgresql-service
            my-postgresql-role-service

            my-xorg-service
            my-x11-socket-directory-service

            my-dbus-service
            my-ntp-service
            my-elogind-service

            %my-desktop-services))

(define my-bluetooth-service
  (bluetooth-service #:auto-enable? #t))

(define my-postgresql-role-service
  (service postgresql-role-service-type
   (postgresql-role-configuration
    (roles
     (list (postgresql-role
            (name "postgres")
            (create-database? #t))
           (postgresql-role
            (name "samuel")
            (create-database? #t)))))))

(define my-postgresql-service
  (service postgresql-service-type))

(define my-network-manager-service
  (service network-manager-service-type
   (network-manager-configuration
    (vpn-plugins (list network-manager-openvpn)))))

(define my-wpa-supplicant-service
  (service wpa-supplicant-service-type))

(define my-ssh-service
  (service openssh-service-type))

(define my-libvirt-service
  (service libvirt-service-type
           (libvirt-configuration
            (unix-sock-group "libvirt")
            (tls-port "16555"))))

(define my-xorg-service
  (service slim-service-type
           (slim-configuration
            (xorg-configuration
             (xorg-configuration
              (keyboard-layout my-keyboard-layout)
              (extra-config (list %xorg-libinput-config
                                  %xorg-intel-antitearing-i915)))))))

(define my-screen-locker-service
  (screen-locker-service slock))

(define my-elogind-service
  (service elogind-service-type
           (elogind-configuration
            (handle-lid-switch-external-power 'suspend))))

(define my-dbus-service
    (dbus-service))

(define my-udev-service-type
  (service udev-service-type
           (udev-configuration
            (rules %udev-rule-backlight))))

(define my-ntp-service
  (service ntp-service-type))

(define my-x11-socket-directory-service
  x11-socket-directory-service)

(define my-pulseaudio-service
 (service pulseaudio-service-type))

(define my-alsa-service
  (service alsa-service-type))

(define my-docker-service
  (service docker-service-type))

(define %my-desktop-services
  (list my-xorg-service
        my-x11-socket-directory-service
        my-pulseaudio-service
        my-alsa-service
        my-screen-locker-service
        my-network-manager-service
        my-wpa-supplicant-service
        my-elogind-service))
