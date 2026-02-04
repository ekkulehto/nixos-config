{ ... }:

{
  programs.yazi = {
    enable = true;

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "K" ];
          run = "shell --orphan --confirm kitty";
          desc = "Open kitty here";
        }
      ];
    };
  };
}

