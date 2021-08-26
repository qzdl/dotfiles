;; GENERATED BY ~/dotfiles/system.org
(list
 (channel
  (name 'guix)
  (url "https://git.savannah.gnu.org/git/guix.git"))
 ;; for the kernel + firmware
 (channel
  (name 'nonguix)
  (url "https://gitlab.com/nonguix/nonguix"))
 ;; for emacs-libgccjit
 (channel
  (name 'flat)
  (url "https://github.com/flatwhatson/guix-channel.git")
  (commit
   "86fb7253a4384b70c77739a0e03115be75d60ad1")
  (introduction
   (make-channel-introduction
    "33f86a4b48205c0dc19d7c036c85393f0766f806"
    (openpgp-fingerprint
     "736A C00E 1254 378B A982  7AF6 9DBE 8265 81B6 4490"))))
 ;; a great effort from infra hpc
 ;;(channel
 ;; (name 'guix-past)

 ;; (url "https://gitlab.inria.fr/guix-hpc/guix-past")
 ;; (introduction
 ;;  (make-channel-introduction
 ;;   "0c119db2ea86a389769f4d2b9c6f5c41c027e336"
 ;;   (openpgp-fingerprint
 ;;    "3CE4 6455 8A84 FDC6 9DB4  0CFB 090B 1199 3D9A EBB5"))))
)
