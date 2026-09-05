{
  pkgs,
  ...
}:
{
  home.username = "iuyi";
  home.homeDirectory = "/Users/iuyi";
  home.stateVersion = "26.11";
  home.packages = with pkgs; [
    home-manager
    wget
    git-tools
    ripgrep
    fd
    fastfetch
    bat
    dust
    just
    just-lsp
    tlrc
  ];
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    envExtra = ''
      export PATH="$PATH:/opt/homebrew/bin"
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "p10k-config";
        src = ./p10k-config;
        file = ".p10k.zsh";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "swiftpm"
        "jj"
        # "gh"
        "git"
        "macos"
        "dotenv"
        # "docker"
        # "docker-compose"
        "aliases"
        "uv"
        "zoxide"
        "alias-finder"
        "rust"
        # "command-not-found"
        "vscode"
        # "ssh"
        "sudo"
        # "kitty"
        "history"
      ];
    };
  };
  programs.git = {
    enable = true;
  };
  programs.jujutsu = {
    enable = true;
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
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
    ./yazi.nix
    # ./vscodium.nix
    # ./firefox.nix
  ];
}
