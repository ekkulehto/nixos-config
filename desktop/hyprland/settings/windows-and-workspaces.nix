{
  windowrule = [
    "match:class .*, suppress_event maximize"

    "match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false, no_initial_focus on"

    "match:class ^Moonlight$, workspace 10 silent"
    "match:class ^com\\.moonlight_stream\\.Moonlight$, workspace 10 silent"
  ];

  workspace = [
    "1, persistent:true"
    "2, persistent:true"
    "3, persistent:true"
    "4, persistent:true"
    "5, persistent:true"
    "6, persistent:true"
    "7, persistent:true"
    "8, persistent:true"
    "9, persistent:true"
    "10, persistent:true"
  ];
}
