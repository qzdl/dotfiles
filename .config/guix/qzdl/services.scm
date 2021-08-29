(define-module (qzdl services)
  #:use-module (qzdl cosas)
  #:use-module (qzdl rules)
  #:use-module (srfi srfi-1)            ;; provides remove
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)   ;; for udev
  #:use-module (gnu services xorg)      ;; FIXME to remove gdm-service-type
  #:use-module (gnu services databases) ;; for postgres
  #:use-module (gnu services desktop)   ;; FIXME %desktop-services is blote
  #:use-module (gnu services docker)
  #:use-module (gnu services networking)
  #:use-module (gnu services virtualization)
  #:use-module (gnu packages gnome)     ;; for network-manager-openvpn
  #:export (my-libvirt-service
            my-docker-service
            my-bluetooth-service
            ;;my-xorg-service
            ;;my-network-manager-service
            ;;my-ssh-service
            my-postgresql-service
            my-postgresql-role-service
            my-login-service
            %my-desktop-services))

;; X11
             ;; (service slim-service-type
             ;;    (slim-configuration
             ;;     (xorg-configuration
             ;;      (xorg-configuration
             ;;       (keyboard-layout
             ;;        (operating-system-keyboard-layout base-operating-system)
             ;;        (extra-config (list %xorg-libinput-config)))))))

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



(define my-libvirt-service
  (service libvirt-service-type
           (libvirt-configuration
            (unix-sock-group "libvirt")
            (tls-port "16555"))))

(define my-login-service
  (service slim-service-type
           (slim-configuration
            (xorg-configuration
             (xorg-configuration
              (keyboard-layout my-keyboard-layout)
              (extra-config (list %xorg-libinput-config
                                  %xorg-intel-antitearing-i915)))))))

(define my-docker-service
  (service docker-service-type))

;; (define %my-desktop-services
;;   (list (service slim-service-type
;;                  (elogind-configuration
;;                   (handle-lid-switch-external-power 'suspend)))
;;         (service slim-service-type
;;                  (udev-configuration
;;                   (rules (list %udev-rule-backlight))))
;;         (service slim-service-type
;;                  (network-manager-configuration
;;                   (vpn-plugins (list network-manager-openvpn))))))

(define %my-desktop-services
  (remove
   (lambda (s) (eq? (service-kind s) gdm-service-type))
  (modify-services %desktop-services
                   (elogind-service-type config =>
                                         (elogind-configuration (inherit config)
                                                                (handle-lid-switch-external-power 'suspend)))
                   (udev-service-type config =>
                                      (udev-configuration (inherit config)
                                                          (rules (cons %udev-rule-backlight
                                                                       (udev-configuration-rules config)))))
                   (network-manager-service-type config =>
                                                 (network-manager-configuration (inherit config)
                                                                                (vpn-plugins (list network-manager-openvpn)))))))
