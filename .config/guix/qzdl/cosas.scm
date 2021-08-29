(define-module (qzdl cosas)
  #:use-module (gnu system keyboard)
  #:export (my-name
            my-keyboard-layout))

(define my-name "Samuel Culpepper")

(define my-keyboard-layout
  (keyboard-layout "us" "altgr-intl" #:model "thinkpad"))
