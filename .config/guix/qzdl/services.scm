(define-module (qzdl services)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)   ;; for udev
  #:use-module (gnu services databases) ;; for %desktop-services
  #:use-module (gnu services desktop)
  #:use-module (gnu services docker)
  #:use-module (gnu services networking)
  #:use-module (gnu services virtualization)
  #:use-module (srfi srfi-1)             ;; provides remove
  #:export (my-libvirt-service
            my-docker-service
            my-bluetooth-service
            ;;my-xorg-service
            ;;my-network-manager-service
            ;;my-ssh-service
            my-postgresql-service
            my-postgresql-role-service
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

(define my-libvirt-service
  (service libvirt-service-type
           (libvirt-configuration
            (unix-sock-group "libvirt")
            (tls-port "16555"))))

(define my-docker-service
  (service docker-service-type))

(define %my-desktop-services
  (remove
   (lambda (s) (or (eq? s gdm-service-type)
              (eq? s slim-service-type)))
    (modify-services
     %desktop-services
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
