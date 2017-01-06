command: "~/.dotfiles/ubersicht/nerdbar.widget/scripts/screens"

refreshFrequency: 100 # ms

render: (output) ->
  " <div class='kwmmode'></div>"


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


  -webkit-font-smoothing: antialiased
  color: $green
  font: 12px "Input Mono"
  left: 10px
  top: 2px
  width:850px
  height: 16px
  white-space: nowrap
  text-overflow: ellipsis
  overflow: ellipsis
  span2
    color: $foregroundColor
  .icon
    font: 14px fontawesome
    top: 1px
    position relative
  .active
    color: $backgroundColor
    background: $green
  .inactive
    color: $green
"""

update: (output, domEl) ->

  values = output.split('@', 4);

  file = "";
  screenhtml = "";
  mode = values[0];
  screens = values[1];
  wins = values[2];
  win = "";
  i = 0;

  screensegs = screens.split('(');

  for sseg in screensegs
    screensegs[i] = sseg.replace /^\s+|\s+$/g, ""
    i+=1;

  screensegs = (x for x in screensegs  when x != '')

  i = 0;

  for sseg in screensegs
    i+= 1;
    if sseg.slice(-1) == ")"
      screenhtml += "<span class='active'>&nbsp;" + i.toString() + ':' + sseg.slice(0, -1) + "&nbsp;</span><span>&nbsp;</span>" ;
    else
      screenhtml += "<span class='inactive'>&nbsp;" + i.toString() + ':' + sseg + "&nbsp;</span><span>&nbsp;</span>";

  winseg = wins.split('/');
  file = winseg[winseg.length - 1]
  j = winseg.length - 1
  flag = 0

  if j > 1
    while j >= 1
      j -= 1;
      if (win + file).length >= 48
        win = '…/' + win
        break;
      else
        win = winseg[j] + '/' + win;

   while file.length >= 48
    file = file.slice(0, -1)
    flag = 1

   if flag >= 1
     file = file + '…';

  # <span>#{mode}</span>
  $(domEl).find('.kwmmode').html("<strong>λ</strong> goldOS <span class='icon'> </span> " + mode + screenhtml + "<span class='icon'> </span> <span>#{win}</span><span2>#{file}</span2>")
