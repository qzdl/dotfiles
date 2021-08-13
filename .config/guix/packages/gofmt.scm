(use-modules (guix packages)
             (guix git-download)
             (guix build-system go)
             (gnu packages golang)
             (gnu packages cmake)
             (guix licenses))

(define-public go-github-com-creack-pty
  (package
    (name "go-github-com-creack-pty")
    (version "1.1.14")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/creack/pty")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "0pplyz6a1qbjwwrbhwc75ghb8gjm4ns5572d6svz7l75xww417d4"))))
    (build-system go-build-system)
    (arguments
      '(#:import-path "github.com/creack/pty"))
    (home-page "https://github.com/creack/pty")
    (synopsis "pty")
    (description
      "Package pty provides functions for working with Unix terminals.
")
    (license expat)))

(define-public go-mvdan-cc-editorconfig
  (package
    (name "go-mvdan-cc-editorconfig")
    (version "0.2.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/mvdan/editorconfig")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "1rav1rp8pi921gsffqr2wjdhbr12w81g31yv6iw4yb1zyh726qqg"))))
    (build-system go-build-system)
    (arguments
      '(#:import-path "mvdan.cc/editorconfig"))
    (home-page "https://mvdan.cc/editorconfig")
    (synopsis "editorconfig")
    (description
      "Package editorconfig allows parsing and using EditorConfig files, as defined
in @url{https://editorconfig.org/,https://editorconfig.org/}.
")
    (license bsd-3)))

(define-public go-mvdan-cc-sh-v3
  (package
    (name "go-mvdan-cc-sh-v3")
    (version "3.3.1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/mvdan/sh")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "09kfy1xjns4mgm0f4iq92vpyfkapw0j8swnsadk1mmqj6khzlyz3"))))
    (build-system go-build-system)
    (arguments '(#:import-path "mvdan.cc/sh/v3"))
    (propagated-inputs
      `(("go-mvdan-cc-editorconfig"
         ,go-mvdan-cc-editorconfig)
        ("go-golang-org-x-term" ,go-golang-org-x-term)
        ("go-golang-org-x-sys" ,go-golang-org-x-sys)
        ("go-golang-org-x-sync" ,go-golang-org-x-sync)
        ("go-github-com-rogpeppe-go-internal"
         ,go-github-com-rogpeppe-go-internal)
        ("go-github-com-pkg-diff"
         ,go-github-com-pkg-diff)
        ("go-github-com-kr-text" ,go-github-com-kr-text)
        ("go-github-com-kr-pretty"
         ,go-github-com-kr-pretty)
        ("go-github-com-google-renameio"
         ,go-github-com-google-renameio)
        ("go-github-com-creack-pty"
         ,go-github-com-creack-pty)))
    (home-page "https://mvdan.cc/sh/v3")
    (synopsis "sh")
    (description
      "This package provides a shell parser, formatter, and interpreter.  Supports @url{https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html,POSIX Shell}, @url{https://www.gnu.org/software/bash/,Bash}, and
@url{http://www.mirbsd.org/mksh.htm,mksh}.  Requires Go 1.15 or later.")
    (license bsd-3)))

(list go-github-com-creack-pty
      go-mvdan-cc-editorconfig
      go-mvdan-cc-sh-v3)
