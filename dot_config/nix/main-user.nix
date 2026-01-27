# main-user.nix

{ lib, config, pkgs, ... }

{
options = {
	main-user.enable = lib.mkEnableOption "Enable user module";

	main-user.userName = lib.mkOption {
		default = "mainuser";
		descrition = '' username '';
	};
};

config = lib.mkIf config.main-user.enable {
	users.users.${config.main-user.userName} = {
	   isNormalUser = true;
	   home = "/home/TheyCreeper";
	   initialPassword = "1100";
	   description = "Main User";
	   shell = pkgs.zsh;
	  };
	};
}
