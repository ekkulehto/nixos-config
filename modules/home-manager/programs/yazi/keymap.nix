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

        # {
        #   on = [ "<A-d>" ];
        #   run = ''
        #     shell -- ripdrag --no-click --and-exit --icon-size 64 --target --all "$@" \
        #       | while read -r filepath; do
        #           cp -nR -- "$filepath" .
        #         done
        #   '';
        #   desc = "Drag-n-drop files from/to Yazi (no overwrite)";
        # }

        {
          [[mgr.prepend_keymap]];
          on   = [ "<A-d>" ];
          run  = "plugin hyprdnd-for-yazi";
          desc = "Hyprland DnD overlay (hyprdnd-for-yazi)";
        }
      ];
    };
  };
}

