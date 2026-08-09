{
  inputs,
  pkgs,
  ...
}:
{
  nix.settings.experimental-features = "nix-command flakes";
  programs.zsh.enable = true;
  users.users.iuyi = {
    home = "/Users/iuyi";
    shell = pkgs.zsh;
  };
  environment.systemPackages = with pkgs; [
    inputs.nix-auth.packages.${pkgs.stdenv.hostPlatform.system}.default
    mihomo
    yazi
    git
    neovim
    nixd
    nil
    nixfmt
  ];
}
