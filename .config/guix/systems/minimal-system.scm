(define-module minimal-system
  #:use-module (gnu services pm)             ;; clipboard menu
  #:use-module (gnu services cups)           ;; printing
  #:use-module (gnu services desktop)        ;; desktop services (blote)
  #:use-module (gnu services virtualization) ;; VMs
  #:use-module (gnu packages xorg)           ;; graphical display
  #:use-module (gnu packages gnuzilla)       ;; GNU mozilla suite
  #:use-module (gnu packages audio)          ;;
  #:use-module (gnu packages pulseaudio)     ;; audio daemon
  #:use-module (gnu packages wm)             ;; lots of wm options (blote)
  #:use-module (gnu packages cups)           ;; printing
  #:use-module (gnu packages mtools)         ;; interact with ms disks
  #:use-module (gnu packages gtk)            ;; gnome stuff  (blote)
  #:use-module (gnu packages web-browsers))  ;; web browsers (blote)

(use-service-modules desktop xorg)
