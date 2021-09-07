digraph use2dot {
  label="Guile Module Dependencies";
  ratio=fill;
  "(guile-user)" -> "(guix packages)";
  "(guile-user)" -> "(guix git-download)";
  "(guile-user)" -> "(guix build-system go)";
  "(guile-user)" -> "(guix licenses)";
}