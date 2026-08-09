{
  pkgs,
  ...
}:
{
  programs.vscodium = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      usernamehw.errorlens
      pkief.material-icon-theme
      oderwat.indent-rainbow
      visualjj.visualjj
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
      # unfree
      fill-labs.dependi
      ms-vscode.remote-explorer
    ];
    profiles.default.userSettings = {
      "editor.formatOnSave" = true;
      "editor.tabSize" = 2;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "files.autoSave" = "onFocusChange";
      "explorer.incrementalNaming" = "smart";
      "explorer.sortOrder" = "filesFirst";
      "explorer.fileNesting.enabled" = true;
      "nix.enableLanguageServer" = true;
    };
  };
}
