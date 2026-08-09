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
    fastfetch
    bat
    dust
    just
    just-lsp
    tlrc
    qq
  ];
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
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings.mgr.ratio = [
      1
      3
      4
    ];
    keymap.input.prepend_keymap = [
      {
        on = "<Esc>";
        run = "close";
        desc = "Cancel input";
      }
    ];
    extraPackages =
      with pkgs;
      [
        glow
        ouch
      ]
      ++ (with pkgs.yaziPlugins; [
        glow
        drag
        jjui
        git
        starship
        chmod
        sshfs
      ]);
    initLua = ''
      Status:children_add(function()
      	local h = cx.active.current.hovered
      	if not h or ya.target_family() ~= "unix" then
      		return ""
      	end
      	return ui.Line {
      		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
      		":",
      		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
      		" ",
      	}
      end, 500, Status.RIGHT)
    ''
    + ''
      Header:children_add(function()
        if ya.target_family() ~= "unix" then
          return ""
        end
        return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
      end, 500, Header.LEFT)
    ''
    + ''
      Status:children_add(function(self)
        local h = self._current.hovered
        if h and h.link_to then
          return " -> " .. tostring(h.link_to)
        else
          return ""
        end
      end, 3300, Status.LEFT)
    '';
    plugins = {
      inherit (pkgs.yaziPlugins)
        chmod
        git
        ;
    };
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
