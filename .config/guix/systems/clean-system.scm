(define-public minimal-operating-system
  (operating-system
   (inherit base-operating-system)

   (services (cons* ;; virtualisation
                    (service libvirt-service-type
                             (libvirt-configuration
                              (unix-sock-group "libvirt")
                              (tls-port "16555")))
                    ;; bluetooth
                    (bluetooth-service #:auto-enable? #t))
                    ;; X11
                    (service slim-service-type
                             (slim-configuration
                              (xorg-configuration
                               (xorg-configuration
                                (keyboard-layout keyboard-layout)
                                (extra-config (list %xorg-libinput-config)))))))

   (packages
    (append (list pulseaudio
                  bluez
                  bluez-alsa
                  tlp
                  ;;
                  fx86-input-libinput
                  ;; wms
                  dmenu emacs-exwm emacs-desktop-environment)
            (operating-system-packages base-operating-system)))))

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
                                  (rules (cons %backlight-udev-rule
                                               (udev-configuration-rules config)))))
   (network-manager-service-type
    config => (network-manager-configuration (inherit config)
                                             (vpn-plugins (list     network-manager-openvpn))))))
