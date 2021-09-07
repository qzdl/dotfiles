digraph use2dot {
  label="Guile Module Dependencies";
  ratio=fill;
  "(qzdl services)" -> "(qzdl cosas)";
  "(qzdl services)" -> "(qzdl rules)";
  "(qzdl services)" -> "(srfi srfi-1)";
  "(qzdl services)" -> "(gnu packages gnome)";
  "(qzdl services)" -> "(gnu packages suckless)";
  "(qzdl services)" -> "(gnu services)";
  "(qzdl services)" -> "(gnu services base)";
  "(qzdl services)" -> "(gnu services desktop)";
  "(qzdl services)" -> "(gnu services databases)";
  "(qzdl services)" -> "(gnu services dbus)";
  "(qzdl services)" -> "(gnu services desktop)";
  "(qzdl services)" -> "(gnu services docker)";
  "(qzdl services)" -> "(gnu services networking)";
  "(qzdl services)" -> "(gnu services sound)";
  "(qzdl services)" -> "(gnu services ssh)";
  "(qzdl services)" -> "(gnu services virtualization)";
  "(qzdl services)" -> "(gnu services xorg)";
}