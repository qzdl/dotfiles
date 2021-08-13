(use-modules (guix inferior)
             (guix channels)
             (srfi srfi-1))

(define pychannel
  (list (channel
         (name 'guix)
         (url "https://git.savannah.gnu.org/git/guix.git")
         (commit "5c798ca71dcd009896654da7d6a1f8942c6f3c50"))))

(define inferior
  (inferior-for-channels pychannel))

(packages->manifest
 (list (first (lookup-inferior-packages inferior "python"))))
