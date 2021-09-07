digraph use2dot {
  label="Guile Module Dependencies";
  ratio=fill;
  "(qzdl device donutrust)" -> "(srfi srfi-1)";
  "(qzdl device donutrust)" -> "(gnu)";
  "(qzdl device donutrust)" -> "(gnu services databases)";
  "(qzdl device donutrust)" -> "(nongnu packages linux)";
  "(qzdl device donutrust)" -> "(qzdl services)";
  "(qzdl device donutrust)" -> "(qzdl system minimal)";
}