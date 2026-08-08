{
  pkgs,
  ...
}:
{
  home.username = "iuyi";
  home.homeDirectory = "/Users/iuyi";
  home.stateVersion = "26.11";
  home.packages = with pkgs; [
    wget
    git-tools
    ripgrep
    fd
    fzf
    zoxide
    fastfetch
    bat
    dust
    just
    just-lsp
    tlrc
    qq
  ];
  programs.git = {
    enable = true;
  };
  programs.jujutsu = {
    enable = true;
  };
  programs.nix-your-shell = {
    enable = true;
    enableZshIntegration = true;
    nix-output-monitor.enable = true;
  };
  programs.aliae = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      alias = [
        {
          name = "g";
          value = "git";
        }
        {
          name = "j";
          value = "just";
        }
        {
          name = "c";
          value = "code .";
        }
      ];
      env = [
        {
          name = "EDITOR";
          value = "nvim";
        }
        {
          name = "http_proxy";
          value = "http://localhost:7897";
        }
        {
          name = "https_proxy";
          value = "http://localhost:7897";
        }
      ];
    };
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };
  imports = [
    ./vscodium.nix
    ./firefox.nix
  ];
}
