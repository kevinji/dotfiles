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
          # Disable nix-darwin's Nix installation management, as it is handled by
          # Determinate Nix.
          nix.enable = false;

          nixpkgs.config.allowUnfreePredicate =
            pkg:
            builtins.elem (pkgs.lib.getName pkg) [
              "claude-code"
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
            pkgs.gnupatch
            pkgs.gnused
            pkgs.rsync
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
            pkgs.nodejs-slim_24 # Used for Emacs LSP servers
            pkgs.opam # Manages OCaml
            pkgs.rustup # Manages Rust

            pkgs.devenv # Nix development envs
            pkgs.rust-analyzer # Rust LSP
            pkgs.shellcheck # Bash static analysis

            # Databases
            pkgs.postgresql_17
            pkgs.sqlite

            # Shell niceties
            pkgs.curlie
            pkgs.direnv
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
            pkgs.xan

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
            pkgs.claude-code
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

          # Set primary user for user-specific settings.
          system.primaryUser = "kevinji";

          # Enable Homebrew support.
          homebrew.enable = true;

          homebrew.casks = [
            # Programming tools
            "emacs-app"
            "ghostty"
            "orbstack"
            "utm"

            # Utilities
            "alfred"
            "appcleaner"
            "jordanbaird-ice"
            "karabiner-elements"
            "monitorcontrol"
            "rectangle"
            "scroll-reverser"

            # Browsers
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
            "Parcel" = 375589283;
            "PDF Expert" = 1055273043;
            "Pixelmator Pro" = 1289583905;
            "Slack for Desktop" = 803453959;
            "Soulver 3" = 1508732804;
            "Tailscale" = 1475387142;
            "Telegram Lite" = 946399090;
            "The Unarchiver" = 425424353;
            "Things 3" = 904280696;
            "Windows App" = 1295203466;
            "Wipr 2" = 1662217862;
          };

          # Set up zsh shell support.
          programs.zsh.enable = true;
          programs.zsh.promptInit = "";
          programs.zsh.enableGlobalCompInit = false;
          programs.zsh.interactiveShellInit = ''
            source "${pkgs.antidote}/share/antidote/antidote.zsh"
          '';

          environment.shells = [ pkgs.zsh ];

          # Enable alternative shell support in nix-darwin.
          programs.bash.enable = false;
          programs.fish.enable = false;

          # Enable sudo authentication with Touch ID.
          security.pam.services.sudo_local.touchIdAuth = true;

          # Set default macOS settings.
          system.defaults.NSGlobalDomain.AppleEnableMouseSwipeNavigateWithScrolls = false;
          system.defaults.NSGlobalDomain.AppleEnableSwipeNavigateWithScrolls = false;
          system.defaults.NSGlobalDomain.AppleICUForce24HourTime = true;
          system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
          system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
          system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
          system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
          system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = true;

          system.defaults.CustomUserPreferences = {
            NSGlobalDomain = {
              "com.apple.mouse.linear" = true;
            };
          };

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
        ];
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
