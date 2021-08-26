;; <2021-08-11 Wed 13:33> `guix import go mvdan.cc/sh'
(use-modules (guix packages)
             (guix git-download)
             (guix build-system go)
             (guix licenses))



  (package
    (name "go-mvdan-cc-sh")
    (version "2.6.4+incompatible")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/mvdan/sh")
               (commit (go-version->git-ref version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "1jifac0fi0sz6wzdgvk6s9xwpkdng2hj63ldbaral8n2j9km17hh"))))
    (build-system go-build-system)
    (arguments '(#:import-path "mvdan.cc/sh"))
    (home-page "https://mvdan.cc/sh")
    (synopsis "sh")
    (description
      "This package provides a shell parser, formatter and interpreter.  Supports @url{http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html,POSIX Shell}, @url{https://www.gnu.org/software/bash/,Bash} and
@url{https://www.mirbsd.org/mksh.htm,mksh}.  Requires Go 1.10 or later.")
    (license bsd-3))

;;go-mvdan-cc-sh
