(define-module (qzdl services)
  #:use-module (gnu services)
  #:use-module (gnu services databases)
  #:use-module (gnu services desktop)
  #:use-module (gnu services docker)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services networking)
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
