{
  description = "Example nix-darwin system flake";

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
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            # Shell essentials
            pkgs.zsh
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
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable Homebrew support.
          homebrew.enable = true;

          homebrew.taps = [
            "cargo-lambda/cargo-lambda"
            "hashicorp/tap"
          ];

          homebrew.brews = [
            # macOS App Store
            "mas"

            # Shell essentials
            "zsh"
            "antidote"

            # Languages and package managers
            "protobuf"
            "python"
            "hashicorp/tap/terraform"

            "mise" # Language-agnostic
            "opam" # Manages OCaml
            "rustup" # Manages Rust

            "uv" # Python package installer
            "ruff" # Python linter/formatter

            "bazelisk" # Bazel version manager
            "cargo-lambda" # AWS Lambda functions in Rust
            "dnscontrol" # DNS configuration as code
            "golangci-lint" # Golang linter
            "rust-analyzer" # Rust LSP
            "shellcheck" # Bash static analysis
            "tflint" # Terraform linter

            # Databases
            "postgresql@17"
            "sqlite"

            # Shell niceties
            "curlie"
            "fzf"
            "gnupg"
            "htop"
            "jq"
            "ncdu"
            "wget"

            # Rust-based shell tools
            "bat" # cat
            "difftastic"
            "eza" # ls
            "hyperfine" # bench
            "fd" # find
            "ripgrep" # grep
            "xsv"

            # Containers
            "dive"
            "docker"
            "docker-buildx"
            "docker-compose"
            "docker-credential-helper"
            "skopeo"

            # Kubernetes
            "helm"
            "k3d"

            # External services
            "magic-wormhole"

            # Video
            "ffmpeg"
            "yt-dlp"

            # Image manipulation
            "pngcrush"
            "pngquant"

            # Documentation
            "graphviz"
            "pandoc"

            # Cloud CLIs
            "awscli"

            # Fonts
            "fontforge"
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

            # Cloud CLIs
            "google-cloud-sdk"
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
