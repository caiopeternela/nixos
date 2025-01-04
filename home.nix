{ config, pkgs, ... }:

{
  home.username = "caiopeternela";
  home.homeDirectory = "/home/caiopeternela";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    
    # workstation
    vscode
    vivaldi
    discord
    trezor-suite
    gnome-tweaks
    gnome-mahjongg
    telegram-desktop
    bitwarden-desktop
  ];

  # basic configuration of git, please change to your own 
  programs.git = {
    enable = true;
    userName = "Caio Peternela";
    userEmail = "caiopeternela.dev@gmail.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      # /etc/bashrc: DO NOT EDIT -- this file has been generated automatically.

      # Only execute this file once per shell.
      if [ -n "$__ETC_BASHRC_SOURCED" ] || [ -n "$NOSYSBASHRC" ]; then return; fi
      __ETC_BASHRC_SOURCED=1

      # If the profile was not loaded in a parent process, source
      # it.  But otherwise don't do it because we don't want to
      # clobber overridden values of $PATH, etc.
      if [ -z "$__ETC_PROFILE_DONE" ]; then
          . /etc/profile
      fi

      # We are not always an interactive shell.
      if [ -n "$PS1" ]; then
          # Show current working directory in VTE terminals window title.
      # Supports both bash and zsh, requires interactive shell.
      . /nix/store/ywc32gvil66j8alghcfvjdahszmmv38x-vte-0.78.2/etc/profile.d/vte.sh


      # This function is called whenever a command is not found.
      command_not_found_handle() {
        local p='/nix/store/wkpb86299p5p1nmqdk6c1mbffcphzs6w-command-not-found/bin/command-not-found'
        if [ -x "$p" ] && [ -f '/nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite' ]; then
          # Run the helper program.
          "$p" "$@"
          # Retry the command if we just installed it.
          if [ $? = 126 ]; then
            "$@"
          else
            return 127
          fi
        else
          echo "$1: command not found" >&2
          return 127
        fi
      }

      # Check the window size after every command.
      shopt -s checkwinsize

      # Disable hashing (i.e. caching) of command lookups.
      set +h

      # Provide a nice prompt if the terminal supports it.
      if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
        PROMPT_COLOR="1;31m"
        ((UID)) && PROMPT_COLOR="1;32m"
        if [ -n "$INSIDE_EMACS" ]; then
          # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
          PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
        else
          PS1="\n\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
        fi
        if test "$TERM" = "xterm"; then
          PS1="\[\033]2;\h:\u:\w\007\]$PS1"
        fi
      fi

      eval "$(/nix/store/b1wvkjx96i3s7wblz38ya0zr8i93zbc5-coreutils-9.5/bin/dircolors -b)"

      # Check whether we're running a version of Bash that has support for
      # programmable completion. If we do, enable all modules installed in
      # the system and user profile in obsolete /etc/bash_completion.d/
      # directories. Bash loads completions in all
      # $XDG_DATA_DIRS/bash-completion/completions/
      # on demand, so they do not need to be sourced here.
      if shopt -q progcomp &>/dev/null; then
        . "/nix/store/0zmgwbn1h48qrk6xn3qdbj2xm8vpk1n7-bash-completion-2.14.0/etc/profile.d/bash_completion.sh"
        nullglobStatus=$(shopt -p nullglob)
        shopt -s nullglob
        for p in $NIX_PROFILES; do
          for m in "$p/etc/bash_completion.d/"*; do
            . "$m"
          done
        done
        eval "$nullglobStatus"
        unset nullglobStatus p m
      fi

      alias -- l='ls -alh'
      alias -- ll='ls -l'
      alias -- ls='ls --color=tty'



      fi

      # Read system-wide modifications.
      if test -f /etc/bashrc.local; then
          . /etc/bashrc.local
      fi
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
