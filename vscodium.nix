{
  pkgs,
  ...
}:
{
  programs.vscodium = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      jjk.jjk
      usernamehw.errorlens
      pkief.material-icon-theme
      oderwat.indent-rainbow
      # fill-labs.dependi
      # ms-vscode.remote-explorer
      arrterian.nix-env-selector
      jnoortheen.nix-ide
      nefrob.vscode-just-syntax
      tamasfe.even-better-toml
      zainchen.json
      mkhl.shfmt
      leanprover.lean4
      charliermarsh.ruff
      llvm-org.lldb-vscode
      llvm-vs-code-extensions.vscode-clangd
      rust-lang.rust-analyzer
    ];
    profiles.default.userSettings = {
      "editor.formatOnSave" = true;
      "editor.tabSize" = 2;
    };
  };
}
