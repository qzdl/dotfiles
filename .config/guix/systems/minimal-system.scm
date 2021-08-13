(define-module (minimal-system)
  #:use-module (base-system)
  #:use-module (gnu)
  #:use-module (srfi srfi-1)
  #:use-module (gnu services pm)             ;; clipboard menu
  #:use-module (gnu services cups)           ;; printing
  #:use-module (gnu services desktop)        ;; desktop services (blote)
  #:use-module (gnu services docker)
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

;; Allow members of the "video" group to change the screen brightness.
(define %udev-rule-backlight
  (udev-rule
   "90-backlight.rules"
   (string-append "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
                  "RUN+=\"/run/current-system/profile/bin/chgrp video /sys/class/backlight/%k/brightness\""
                  "\n"
                  "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
                  "RUN+=\"/run/current-system/profile/bin/chmod g+w /sys/class/backlight/%k/brightness\"")))

(define %xorg-libinput-config
  "Section \"InputClass\"
  Identifier \"Touchpads\"
  Driver \"libinput\"
  MatchDevicePath \"/dev/input/event*\"
  MatchIsTouchpad \"on\"

  Option \"Tapping\" \"on\"
  Option \"TappingDrag\" \"on\"
  Option \"DisableWhileTyping\" \"on\"
  Option \"MiddleEmulation\" \"on\"
  Option \"ScrollMethod\" \"twofinger\"
  Option \"Natural Scrolling\" \"on\"
EndSection
Section \"InputClass\"
  Identifier \"Keyboards\"
  Driver \"libinput\"
  MatchDevicePath \"/dev/input/event*\"
  MatchIsKeyboard \"on\"
EndSection
")

(define %my-desktop-services
  (modify-services %desktop-services
   (elogind-service-type
    config => (elogind-configuration (inherit config)
                           (handle-lid-switch-external-power 'suspend)))
   (udev-service-type
    config => (udev-configuration (inherit config)
                                  (rules (cons %udev-rule-backlight
                                               (udev-configuration-rules config)))))
   ;; (network-manager-service-type
   ;;  config => (network-manager-configuration (inherit config)
   ;;                                           (vpn-plugins (list     network-manager-openvpn))))
  ))

(define-public minimal-operating-system
  (operating-system
   (inherit base-operating-system)

   (services (cons* ;; virtualisation
                    (service libvirt-service-type
                             (libvirt-configuration
                              (unix-sock-group "libvirt")
                              (tls-port "16555")))
                    (service docker-service-type)
                    ;; bluetooth
                    (bluetooth-service #:auto-enable? #t)
                    ;; X11
                    ;; (service slim-service-type
                    ;;    (slim-configuration
                    ;;     (xorg-configuration
                    ;;      (xorg-configuration
                    ;;       (keyboard-layout
                    ;;        (operating-system-keyboard-layout base-operating-system)
                    ;;        (extra-config (list %xorg-libinput-config)))))))
                    ;;
                    ;;(operating-system-services base-operating-system)
                    ;;
                    (remove (lambda (service)
                        (eq? (service-kind service) gdm-service-type))
                     %my-desktop-services)))

   (packages
    (append (list pulseaudio)
                  ;bluez
                  ;bluez-alsa
                  ;tlp
                  ;;
                  ;fx86-input-libinput
                  ;; wms
                  ;dmenu emacs-exwm emacs-desktop-environment
            (operating-system-packages base-operating-system)))))
