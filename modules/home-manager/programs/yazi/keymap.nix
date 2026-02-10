{ ... }:

{
  programs.yazi = {
    enable = true;

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "<A-k>" ];
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
          on  = "<A-d>";
          run = "shell --block 'yazi-dndctl toggle'";
          desc = "Toggle yazi-dnd overlay (daemon foundation mode)";
        }
      ];
    };
  };
}

