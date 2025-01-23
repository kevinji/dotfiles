{
  description = "nix-darwin system flake";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      determinate,
      nix-darwin,
      nixpkgs,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          nixpkgs.config.allowUnfreePredicate =
            pkg:
            builtins.elem (pkgs.lib.getName pkg) [
              "terraform"
            ];

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            # Shell essentials
            pkgs.zsh
            pkgs.antidote
            pkgs.tmux

            # Replacements for system programs
            pkgs.bashInteractive
            pkgs.coreutils-prefixed
            pkgs.gawkInteractive
            pkgs.gnugrep
            pkgs.gnused
            pkgs.vim

            # Version control
            pkgs.git

            # Git helpers
            pkgs.delta
            pkgs.gh
            pkgs.git-filter-repo
            pkgs.git-lfs

            # Editors
            pkgs.neovim

            # Languages and package managers
            pkgs.protobuf
            pkgs.terraform

            pkgs.mise # Language-agnostic
            pkgs.opam # Manages OCaml
            pkgs.rustup # Manages Rust
            pkgs.uv # Python package installer

            pkgs.dnscontrol # DNS configuration as code
            pkgs.golangci-lint # Golang linter
            pkgs.ruff # Python linter/formatter
            pkgs.rust-analyzer # Rust LSP
            pkgs.shellcheck # Bash static analysis
            pkgs.tflint # Terraform linter

            # Databases
            pkgs.postgresql_17
            pkgs.sqlite

            # Shell niceties
            pkgs.curlie
            pkgs.fzf
            pkgs.gnupg
            pkgs.htop
            pkgs.jq
            pkgs.ncdu
            pkgs.wget
            pkgs.zstd

            # Rust-based shell tools
            pkgs.bat # cat
            pkgs.difftastic
            pkgs.eza # ls
            pkgs.hyperfine # bench
            pkgs.fd # find
            pkgs.ripgrep # grep
            pkgs.xsv

            # Containers
            pkgs.dive
            pkgs.docker
            pkgs.docker-buildx
            pkgs.docker-compose
            pkgs.docker-credential-helpers
            pkgs.skopeo

            # Kubernetes
            pkgs.k3d
            pkgs.kubernetes-helm

            # External services
            pkgs.magic-wormhole

            # Video
            pkgs.ffmpeg-full
            pkgs.yt-dlp

            # Image manipulation
            pkgs.pngcrush
            pkgs.pngquant

            # Documentation
            pkgs.graphviz
            pkgs.pandoc

            # Fonts
            pkgs.fontforge

            # Cloud CLIs
            pkgs.awscli
            pkgs.google-cloud-sdk
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable Homebrew support.
          homebrew.enable = true;

          homebrew.brews = [
            "mas"
          ];

          homebrew.casks = [
            # Programming tools
            "emacs"
            "ghostty"
            "iterm2"
            "orbstack"
            "utm"

            # Utilities
            "alfred"
            "appcleaner"
            "bartender"
            "karabiner-elements"
            "monitorcontrol"
            "rectangle"

            # AI
            "ollama"

            # Browsers
            "arc"
            "firefox"
            "google-chrome"

            # Storage
            "dropbox"

            # Audio
            "audio-hijack"
            "focusrite-control"
            "spotify"

            # Applications
            "1password"
            "iina"
            "notion"
            "steam"
            "transmission"

            # Communication
            "discord"
            "obs"
            "signal"
            "zoom"
          ];

          homebrew.masApps = {
            "Xcode" = 497799835;

            "Affinity Photo 2" = 1616822987;
            "DaisyDisk" = 411643860;
            "DaVinci Resolve" = 571213070;
            "Fantastical" = 975937182;
            "Flighty" = 1358823008;
            "Messenger" = 1480068668;
            "Parcel" = 639968404;
            "PDF Expert" = 1055273043;
            "Pixelmator Pro" = 1289583905;
            "Slack for Desktop" = 803453959;
            "Soulver 3" = 1508732804;
            "Tailscale" = 1475387142;
            "Telegram Lite" = 946399090;
            "The Unarchiver" = 425424353;
            "Things 3" = 904280696;
            "Windows App" = 1295203466;
            "Wipr" = 1320666476;
          };

          # Set up zsh shell support.
          programs.zsh.enable = true;
          programs.zsh.promptInit = "";
          programs.zsh.enableGlobalCompInit = false;
          programs.zsh.interactiveShellInit = ''
            source "${pkgs.antidote}/share/antidote/antidote.zsh"
          '';

          # Enable alternative shell support in nix-darwin.
          programs.bash.enable = false;
          programs.fish.enable = false;

          # Enable sudo authentication with Touch ID.
          security.pam.enableSudoTouchIdAuth = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .
      darwinConfigurations."Io" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          determinate.darwinModules.default
        ];
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
