(define-public python-flake8-black
  (package
    (name "python-flake8-black")
    (version "0.2.3")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "flake8-black" version))
        (sha256
          (base32
            "1116979a14ac5626izy15izxc7pj2q165s7bjl8xjndmq55q96f1"))))
    (build-system python-build-system)
    (propagated-inputs
      `(("python-black" ,python-black)
        ("python-flake8" ,python-flake8)
        ("python-toml" ,python-toml)))
    (home-page
      "https://github.com/peterjc/flake8-black")
    (synopsis
      "flake8 plugin to call black as a code style validator")
    (description
      "flake8 plugin to call black as a code style validator")
    (license license:expat)))

