{ pkgs, ... }:

{
  programs.yazi.extraPackages = with pkgs; [
    ffmpeg
    ffmpegthumbnailer
    p7zip
    unar
    jq
    poppler-utils
    fd
    fzf
    zoxide
    imagemagick
    resvg
    chafa
  ];
}

