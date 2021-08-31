(define-module (qzdl system minimal)
  #:use-module (qzdl system base)
  #:use-module (qzdl services)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (srfi srfi-1)
  #:use-module (gnu services pm)             ;; clipboard menu
  #:use-module (gnu services cups)           ;; printing
  #:use-module (gnu services docker)
  #:use-module (gnu services databases)
  #:use-module (gnu services virtualization) ;; VMs
  #:use-module (gnu packages xorg)           ;; graphical display
  #:use-module (gnu packages gnuzilla)       ;; GNU mozilla suite
  #:use-module (gnu packages audio)          ;;
  #:use-module (gnu packages emacs)          ;;
  #:use-module (gnu packages pulseaudio)     ;; audio daemon
  #:use-module (gnu packages wm)             ;; lots of wm options (blote)
  #:use-module (gnu packages cups)           ;; printing
  #:use-module (gnu packages mtools)         ;; interact with ms disks
  #:use-module (gnu packages gtk)            ;; gnome stuff  (blote)
  #:use-module (gnu packages web-browsers)   ;; web browsers (blote)
  #:use-module (gnu packages linux)          ;; for bluez
  #:use-module (gnu packages xorg)           ;; xf86-input-libinput
  #:export (minimal-operating-system))

(use-service-modules desktop xorg)

(define minimal-operating-system
  (operating-system
   (inherit base-operating-system)

   (services
    (cons* my-libvirt-service
           my-bluetooth-service
           my-docker-service
           my-login-service
           %desktop-services
           (operating-system-services base-operating-system)))

   (packages
    (cons* pulseaudio
           bluez
           bluez-alsa
           tlp                  ;; laptop power management
           xf86-input-libinput
           emacs
           (operating-system-packages base-operating-system)))))
