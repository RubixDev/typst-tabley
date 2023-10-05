#import "@preview/cetz:0.1.2"
#import "./tabley.typ": tabley

#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
  import cetz.draw: *
  let data = (
    [a], [bc], [d],
    [e], [fgh\ ijk], [l],
    [a], [bc], [d],
    [e], [fgh\ ijk], [l],
  )
  tabley((0, 0), columns: 3, ..data, name: "a")
  tabley((3, 0), columns: 4, ..data, name: "b")
  bezier(
    "a.1-1-right",
    "b.3-2-left",
    (rel: ( 2, 0), to: "a.1-1-right"),
    (rel: (-2, 0), to: "b.3-2-left"),
    mark: (end: ">"), angle: 50deg,
  )
})

#cetz.canvas({
  import cetz.draw: *
  tabley((.5, 0), columns: 3, name: "a", [left], [middle], [right])
  tabley((0, -2), columns: 2, name: "b", [one], [two])

  tabley(
    (2.5, -1.5),
    columns: 6,
    name: "c",
    hlines: none,
    vlines: none,
    [], [], [b], [], [], [],
    // we fill a cell with invisible text to get the column to the right size,
    // the actual content is manually placed afterwards
    text(fill: white)[world], [c], [d], [e], [g], [h],
    [], [], [f], [], [], [],
  )
  // our "hello world" is manually placed here
  content(("c.0-0-top-left", .5, "c.0-2-bottom-right"), align(center)[hello\ world])
  // draw the lines
  rect("c.top-left", "c.bottom-right")
  line("c.0-0-top-right", "c.0-2-bottom-right")
  line("c.2-1-top-left", "c.2-1-bottom-left")
  line("c.2-1-top-right", "c.2-1-bottom-right")
  line("c.4-0-top-left", "c.4-2-bottom-left")
  line("c.5-0-top-left", "c.5-2-bottom-left")
  line("c.1-0-bottom-left", "c.3-0-bottom-right")
  line("c.1-2-top-left", "c.3-2-top-right")

  bezier(
    "a.1-0-bottom",
    "b.0-0-top",
    (rel: (0, -1), to: "a.1-0-bottom"),
    (rel: (0,  1), to: "b.0-0-top"),
    mark: (end: ">"), angle: 50deg,
  )
  bezier(
    "a.2-0-bottom",
    ("c.2-1-top-left", .3, "c.2-1-left"),
    (rel: (0, -1), to: "a.2-0-bottom"),
    mark: (end: ">"), angle: 50deg,
  )
})
