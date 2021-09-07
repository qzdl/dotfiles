digraph use2dot {
  label="Guile Module Dependencies";
  ratio=fill;
  "(qzdl system minimal)" -> "(qzdl system base)";
  "(qzdl system minimal)" -> "(qzdl services)";
  "(qzdl system minimal)" -> "(gnu)";
  "(qzdl system minimal)" -> "(gnu system)";
  "(qzdl system minimal)" -> "(srfi srfi-1)";
  "(qzdl system minimal)" -> "(gnu packages gnuzilla)";
  "(qzdl system minimal)" -> "(gnu packages audio)";
  "(qzdl system minimal)" -> "(gnu packages emacs)";
  "(qzdl system minimal)" -> "(gnu packages emacs-xyz)";
  "(qzdl system minimal)" -> "(gnu packages pulseaudio)";
  "(qzdl system minimal)" -> "(gnu packages wm)";
  "(qzdl system minimal)" -> "(gnu packages linux)";
  "(qzdl system minimal)" -> "(gnu packages xorg)";
}