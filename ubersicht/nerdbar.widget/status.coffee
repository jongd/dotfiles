command: "~/.dotfiles/ubersicht/nerdbar.widget/scripts/compstatus"

refreshFrequency: 3000 # ms

render: (output) ->
  "<div class='compstatus'></div>"

style: """
  $backgroundColor = #282c34
  $foregroundColor = #abb2bf
  $red = #e06c75 // red
  $green = #98c379 // green
  $yellow = #d19a66 // yellow
  $blue = #56b6c2 // blue
  $magenta = #c678dd // pink
  $orange = $yellow
  $cyan = #56b6c2 // cyan
  $white = #d0d0d0 // light gray
  $lightBlack = #808080 // medium gray


  -webkit-font-smoothing: antialiased
  font: 12px "Input Mono"
  text-transform: lowercase
  right: 10px //50
  top: 2px
  color: $foregroundColor
  height: 13
  .wifi
    font: 16px fontawesome
    top: 1px
    position: relative
  .charging
    font: 13px fontawesome
    position: relative
    top: 1px
    color: $foregroundColor
    z-index: 1
  .white
    color: $foregroundColor
  .green
    color: $green
  .greenbg
    background: $green
    color: $backgroundColor
  .yellow
    color: $yellow
  .yellowbg
    background: $yellow
    color: $backgroundColor
  .red
    color: $red
  .icon
    position: relative
    top: 1px
    padding: 0 4px
    font: 14px fontawesome
  .cyan
    color: $blue
  .cyanbg
    background: $blue
    color: $backgroundColor
  .orange
    color: $orange
  .orangebg
    background: $orange
    color: $backgroundColor
  .forecast
    background: #272822
"""

timeAndDate: (date, time) ->
  # returns a formatted html string with the date and time
  return "<span class='white'><span class='icon'>&nbsp&nbsp&nbsp</span>#{date}</span>   <span class='icon'></span>#{time}</span>";

batteryStatus: (battery, state) ->
  #returns a formatted html string current battery percentage, a representative icon and adds a lighting bolt if the
  # battery is plugged in and charging
  batnum = parseInt(battery)
  console.log(state)
  if state == 'AC' and batnum >= 90
    return "<span class='charging'>  </span><span ><span class='icon'> </span>#{batnum}%</span>"
  else if state == 'AC' and batnum >= 50 and batnum < 90
    return "<span class='charging'>  </span><span class='green'><span class='icon'> </span>#{batnum}%</span>"
  else if state == 'AC' and batnum < 50 and batnum >= 15
    return "<span class='charging'>  </span><span class='yellow'><span class='icon'> </span>#{batnum}%</span>"
  else if state == 'AC' and batnum < 15
    return "<span class='charging'>  </span><span class='red'><span class='icon'> </span>#{batnum}%</span>"
  else if batnum >= 90
    return "<span class='green'><span class='icon'>  </span>#{batnum}%</span>"
  else if batnum >= 50 and batnum < 90
    return "<span class='green'><span class='icon'>  </span>#{batnum}%</span>"
  else if batnum < 50 and batnum >= 15
    return "<span class='yellow'><span class='icon'>  </span>#{batnum}%</span>"
  else if batnum < 15
    return "<span class='red'><span class='icon'>  </span>#{batnum}%</span>"

getWifiStatus: (status) ->
  console.log(status)
  if status == "Wi-Fi"
    return "<span class='wifi'>&nbsp</span>";
  if status == 'USB 10/100/1000 LAN' or status == 'Apple USB Ethernet Adapter'
    return "<span class='wifi'></span>";
  else
    return "<span class='grey wifi'>&nbsp</span>";

getCPU: (cpu) ->
  cpuNum = parseFloat(cpu)
  # I have four cores, so I divide my CPU percentage by four to get the proper number
  cpuNum = cpuNum/4
  cpuNum = cpuNum.toFixed(1)
  cpuString = String(cpuNum)
  if cpuNum < 10
    cpuString = '0' + cpuString
  return "<span class='greenbg icon'>&nbsp</span><span class='greenbg'>#{cpuString}%&nbsp</span><span>&nbsp</span>"

getMem: (mem) ->
  memNum = parseFloat(mem)
  memNum = memNum.toFixed(1)
  memString = String(memNum)
  if memNum < 10
    memString = '0' + memString

  return "<span class='yellowbg icon'>&nbsp</span><span class='yellowbg'>#{memString}%&nbsp</span><span>&nbsp</span>"

convertBytes: (bytes) ->
  kb = bytes / 1024
  return @usageFormat(kb)

usageFormat: (kb) ->
  # if kb > 1024
    mb = kb / 1024
    "#{parseFloat(mb.toFixed(2))}MB"

getNetTraffic: (down, up) ->
  downString = @convertBytes(parseInt(down))
  upString = @convertBytes(parseInt(up))
  return "<span>&nbsp</span><span class='icon cyanbg'></span><span class='cyanbg'>#{downString}</span><span>&nbsp</span><span class='icon orangebg'></span><span class='orangebg'>#{upString}</span> "



update: (output, domEl) ->

  # split the output of the script
  values = output.split('@');

  time = values[0].replace /^\s+|\s+$/g, ""
  date = values[1];
  battery = values[2];
  isCharging = values[3]

  cpu = values[4]
  mem = values[5]

  down = values[6]
  up   = values[7]

  netStatus = values[8].replace /^\s+|\s+$/g, ""



  # create an HTML string to be displayed by the widget
  htmlString = @getWifiStatus(netStatus) +
               @batteryStatus(battery, isCharging) +
               #"<span class='icon'>&nbsp</span>" +
               #@getNetTraffic(down, up) +
               #@getMem(mem) +
               #@getCPU(cpu) +
               #"<span class='icon'>&nbsp</span>" +
               @timeAndDate(date, time)

  $(domEl).find('.compstatus').html(htmlString)
