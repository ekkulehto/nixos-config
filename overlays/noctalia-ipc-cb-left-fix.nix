final: prev: {
  noctalia-shell = prev.noctalia-shell.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace Services/Control/CustomButtonIPCService.qml \
        --replace "button.onClicked();" "button.clicked();"
    '';
  });
}

