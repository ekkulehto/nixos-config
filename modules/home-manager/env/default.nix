{ pkgs, ... }:

{
  home.sessionVariables = {
    QML_IMPORT_PATH = "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml";
    QML2_IMPORT_PATH = "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml";
  };
}
