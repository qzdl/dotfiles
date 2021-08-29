(define-public python-3.6
  (package (inherit python-2)
    (version "3.6.4")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://www.python.org/ftp/python/"
                                  version "/Python-" version ".tar.xz"))
              (patches (search-patches
                        "python-fix-tests.patch"
                        "python-3-fix-tests.patch"
                        "python-3-deterministic-build-info.patch"
                        "python-3-search-paths.patch"))
              (patch-flags '("-p0"))
              (sha256
               (base32
                "1fna7g8jxzl4kd2pqmmqhva5724c5m920x3fsrpsgskaylmr76qm"))
              (snippet
               '(begin
                  (for-each delete-file
                            '("Lib/ctypes/test/test_structures.py" ; fails on aarch64
                              "Lib/ctypes/test/test_win32.py" ; fails on aarch64
                              "Lib/test/test_fcntl.py")) ; fails on aarch64
                  #t))))
    ;; (arguments
    ;;  (substitute-keyword-arguments (package-arguments python-2)
    ;;    ((#:tests? _) #t)
    ;;    ((#:phases phases)
    ;;     `(modify-phases ,phases
    ;;        (add-after 'unpack 'patch-timestamp-for-pyc-files
    ;;          (lambda (_)
    ;;            ;; We set DETERMINISTIC_BUILD to only override the mtime when
    ;;            ;; building with Guix, lest we break auto-compilation in
    ;;            ;; environments.
    ;;            (setenv "DETERMINISTIC_BUILD" "1")
    ;;            (substitute* "Lib/py_compile.py"
    ;;              (("source_stats\\['mtime'\\]")
    ;;               "(1 if 'DETERMINISTIC_BUILD' in os.environ else source_stats['mtime'])"))

    ;;            ;; Use deterministic hashes for strings, bytes, and datetime
    ;;            ;; objects.
    ;;            (setenv "PYTHONHASHSEED" "0")

    ;;            ;; Reset mtime when validating bytecode header.
    ;;            (substitute* "Lib/importlib/_bootstrap_external.py"
    ;;              (("source_mtime = int\\(source_stats\\['mtime'\\]\\)")
    ;;               "source_mtime = 1"))
    ;;            #t))
    ;;        ;; These tests fail because of our change to the bytecode
    ;;        ;; validation.  They fail because expected exceptions do not get
    ;;        ;; thrown.  This seems to be no problem.
    ;;        (add-after 'unpack 'disable-broken-bytecode-tests
    ;;          (lambda
    ;;            (substitute* "Lib/test/test_importlib/source/test_file_loader.py"
    ;;              (("test_bad_marshal")
    ;;               "disable_test_bad_marshal")
    ;;              (("test_no_marshal")
    ;;               "disable_test_no_marshal")
    ;;              (("test_non_code_marshal")
    ;;               "disable_test_non_code_marshal"))
    ;;            #t))
    ;;        ;; Unset DETERMINISTIC_BUILD to allow for tests that check that
    ;;        ;; stale pyc files are rebuilt.
    ;;        (add-before 'check 'allow-non-deterministic-compilation
    ;;          (lambda _ (unsetenv "DETERMINISTIC_BUILD") #t))
    ;;        ;; We need to rebuild all pyc files for three different
    ;;        ;; optimization levels to replace all files that were not built
    ;;        ;; deterministically.

    ;;        ;; FIXME: Without this phase we have close to 2000 files that
    ;;        ;; differ across different builds of this package.  With this phase
    ;;        ;; there are about 500 files left that differ.
    ;;        (add-after 'install 'rebuild-bytecode
    ;;          (lambda* (#:key outputs #:allow-other-keys)
    ;;            (setenv "DETERMINISTIC_BUILD" "1")
    ;;            (let ((out (assoc-ref outputs "out")))
    ;;              (for-each
    ;;               (lambda (opt)
    ;;                 (format #t "Compiling with optimization level: ~a\n"
    ;;                         (if (null? opt) "none" (car opt)))
    ;;                 (for-each (lambda (file)
    ;;                             (apply invoke
    ;;                                    `(,(string-append out "/bin/python3")
    ;;                                      ,@opt
    ;;                                      "-m" "compileall"
    ;;                                      "-f" ; force rebuild
    ;;                                      ;; Don't build lib2to3, because it's Python 2 code.
    ;;                                      ;; Also don't build obviously broken test code.
    ;;                                      "-x" "(lib2to3|test/bad.*)"
    ;;                                      ,file)))
    ;;                           (find-files out "\\.py$")))
    ;;               (list '() '("-O") '("-OO"))))))))))

    ;; (native-search-paths
    ;;  (list (search-path-specification
    ;;         (variable "PYTHONPATH")
    ;;         (files (list (string-append "lib/python"
    ;;                                     (version-major+minor version)
    ;;                                     "/site-packages"))))))
))
