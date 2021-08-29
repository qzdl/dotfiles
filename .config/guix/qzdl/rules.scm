(define-module (qzdl rules)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)
  #:export (%udev-rule-backlight
            %xorg-libinput-config
            %xorg-intel-antitearing-i915))

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

(define %xorg-intel-antitearing-base
  "Section \"Device\"
  Identifier \"Intel Graphics\"
  Driver \"%s\"
  Option \"TearFree\"    \"true\"
EndSection")

(define %xorg-intel-antitearing-i915
 (format #f %xorg-intel-antitearing-base "i915"))
