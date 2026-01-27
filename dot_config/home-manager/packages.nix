# packages.nix
{ pkgs, ... }:

{
    home.packages = with pkgs; with nodePackages_latest; with gnome; [
        # GUI
        vesktop
        brave
        google-chrome
        telegram-desktop
        ghostty
        vscode

        # Terminal
        chezmoi
        git
        micro
        fastfetch
    ];
}