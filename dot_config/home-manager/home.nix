{ config, pkgs, ... }:
let
  homeDirectory = "/home/theycreeper";
in
{
  imports = [
    ./packages.nix
  ];
  nixpkgs.config.allowUnfree = true;

  home.username = "theycreeper";
  home.homeDirectory = "/home/theycreeper";


  nix = {
      package = pkgs.nix;
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
      };
    };

  home.stateVersion = "25.11"; # Please read the comment before changing.
  home.file = {
    "~/.config/hypr".source = ../hypr;
    "~/.config/hypr".recursive = true;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/theycreeper/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
