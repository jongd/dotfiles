refreshFrequency: 1000 * 60
command: "date +%j"

render: (output) ->
  "<div class='completed' style='width:#{365/output}px'></div>"

style: """
  $backgroundColor = #282c34
  $foregroundColor = #abb2bf
  $red = #e06c75 // red
  $green = #98c379 // green
  $yellow = #d19a66 // yellow
  $blue = #56b6c2 // blue
  $magenta = #c678dd // pink
  $cyan = #56b6c2 // cyan
  $white = #d0d0d0 // light gray
  $lightBlack = #808080 // medium gray
  $height = 22px
  width: 100%;
  height: $height
  background-color: $backgroundColor
  z-index: -1
  .completed
    height: 1px
    width: 0
    background-color: $cyan
    position: relative
"""
