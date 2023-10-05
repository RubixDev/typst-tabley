#import "@preview/cetz:0.1.2"

#let tabley(pos, columns: 3, name: none, vlines: auto, hlines: auto, ..items) = cetz.draw.group(name: name, ctx => {
  import cetz.draw: *
  let items = items.pos().map(it => box(inset: 5pt, it))

  let table = ()
  let row = 0
  while true {
    if row * columns + columns > items.len() { break }
    table.push(items.slice(row * columns, count: columns))
    row += 1
  }
  let item-sizes = table.map(row => row.map(item => measure(item, ctx)))

  let row-heights = item-sizes.map(row => calc.max(..row.map(size => size.at(1))))
  let column-widths = range(item-sizes.at(0).len()).map(col-idx => calc.max(..item-sizes.map(row => row.at(col-idx).at(0))))

  set-origin(pos)
  let y-pos = 0
  for (y, row) in table.enumerate() {
    let x-pos = 0
    let row-height = row-heights.at(y)
    for (x, item) in row.enumerate() {
      let column-width = column-widths.at(x)

      let top-left = (x-pos, y-pos)
      let bottom-right = (x-pos + column-width, y-pos - row-height)
      let top = (x-pos + column-width / 2, y-pos)
      let left = (x-pos, y-pos - row-height / 2)

      let prefix = str(x) + "-" + str(y)
      anchor(prefix + "-top-left", top-left)
      anchor(prefix + "-top-right", (bottom-right.at(0), top-left.at(1)))
      anchor(prefix + "-bottom-right", bottom-right)
      anchor(prefix + "-bottom-left", (top-left.at(0), bottom-right.at(1)))
      anchor(prefix + "-top", top)
      anchor(prefix + "-right", (bottom-right.at(0), left.at(1)))
      anchor(prefix + "-left", left)
      anchor(prefix + "-bottom", (top.at(0), bottom-right.at(1)))
      anchor(prefix + "-center", (top.at(0), left.at(1)))

      content(prefix + "-center", item)

      x-pos += column-width
    }
    y-pos -= row-height
  }

  if hlines == auto {
    line("0-0-top-left", str(column-widths.len() - 1) + "-0-top-right")
    for row in range(row-heights.len()) {
      line("0-" + str(row) + "-bottom-left", str(column-widths.len() - 1) + "-" + str(row) + "-bottom-right")
    }
  }

  if vlines == auto {
    line("0-0-top-left", "0-" + str(row-heights.len() - 1) + "-bottom-left")
    for col in range(column-widths.len()) {
      line(str(col) + "-0-top-right", str(col) + "-" + str(row-heights.len() - 1) + "-bottom-right")
    }
  }
})
