digraph use2dot {
  label="Guile Module Dependencies";
  ratio=fill;
  "(qzdl system base)" -> "(qzdl cosas)";
  "(qzdl system base)" -> "(qzdl services)";
  "(qzdl system base)" -> "(gnu)";
  "(qzdl system base)" -> "(srfi srfi-1)";
  "(qzdl system base)" -> "(gnu system nss)";
  "(qzdl system base)" -> "(gnu services docker)";
  "(qzdl system base)" -> "(gnu services networking)";
  "(qzdl system base)" -> "(gnu packages vim)";
  "(qzdl system base)" -> "(gnu packages emacs)";
  "(qzdl system base)" -> "(gnu packages linux)";
  "(qzdl system base)" -> "(gnu packages version-control)";
  "(qzdl system base)" -> "(gnu packages package-management)";
  "(qzdl system base)" -> "(nongnu packages linux)";
  "(qzdl system base)" -> "(nongnu system linux-initrd)";
}