(define-module (qzdl system minimal)
  #:use-module (qzdl system base)
  #:use-module (qzdl services)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (srfi srfi-1)
  #:use-module (gnu packages gnuzilla)       ;; GNU mozilla suite
  #:use-module (gnu packages audio)          ;;
  #:use-module (gnu packages emacs)          ;;
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages pulseaudio)     ;; audio daemon
  #:use-module (gnu packages wm)             ;; lots of wm options (blote)
  #:use-module (gnu packages linux)          ;; for bluez
  #:use-module (gnu packages xorg)           ;; xf86-input-libinput
  #:export (%minimal-services
            minimal-operating-system))

(use-service-modules desktop xorg)

(define %minimal-services
  (append
   (list my-libvirt-service
         my-bluetooth-service
         my-postgresql-service
         my-postgresql-role-service)
   %my-desktop-services))

(define minimal-operating-system
  (operating-system
   (inherit base-operating-system)

   (services
    (append %minimal-services
            (operating-system-user-services base-operating-system)))

   ;; suggested operating-system-user-services
   ;; https://issues.guix.gnu.org/37083
   (packages
    (cons* pulseaudio
           bluez
           bluez-alsa
           tlp                  ;; laptop power management
           xf86-input-libinput

           xmonad emacs emacs-exwm emacs-desktop-environment

           (operating-system-packages base-operating-system)))))
