digraph use2dot {
  label="Guile Module Dependencies";
  ratio=fill;
  "(nongnu system install)" -> "(gnu system)";
  "(nongnu system install)" -> "(gnu system install)";
  "(nongnu system install)" -> "(nongnu packages linux)";
  "(nongnu system install)" -> "(gnu packages version-control)";
  "(nongnu system install)" -> "(gnu packages vim)";
  "(nongnu system install)" -> "(gnu packages curl)";
  "(nongnu system install)" -> "(gnu packages emacs)";
  "(nongnu system install)" -> "(gnu packages package-management)";
}