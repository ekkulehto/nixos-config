{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ekku Lehto";
        email = "ekkulehto@proton.me";
      };
      init.defaultBranch = "main";
    };
  };
}
