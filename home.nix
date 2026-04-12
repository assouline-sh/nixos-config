{ config, pkgs, ... }:
{
  home.username = "kud";
  home.homeDirectory = "/home/kud";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 20;
    gtk.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Ubuntu Sans Mono Bold";
      size = 11;
    };
  };

  fonts.fontconfig.defaultFonts = {
    monospace = [ "Ubuntu Sans Mono" ];
    sansSerif = [ "Ubuntu Sans Mono" ];
    serif = [ "Ubuntu Sans Mono" ];
  };

  programs.caelestia = {
    enable = true;
    cli.enable = true;
    settings = {
      paths.wallpaperDir = "~/Pictures/Wallpapers";
      general.apps = {
        terminal = [ "kitty" ];
        audio = [ "pavucontrol" ];
        explorer = [ "nautilus" ];
      };
      paths.sessionGif = "~/Pictures/bocchi-pixel-clean.gif";
      launcher.hiddenApps = [
        "btop"
        "uuctl"
        "vim"
        "gvim"
        "nvim"
      ];
      services.smartScheme = true;
      services.useTwelveHourClock = false;
      utilities.quickToggles = [
        { id = "settings"; enabled = true; }
        { id = "wifi"; enabled = false; }
        { id = "bluetooth"; enabled = false; }
        { id = "mic"; enabled = false; }
        { id = "gameMode"; enabled = false; }
        { id = "dnd"; enabled = false; }
        { id = "vpn"; enabled = false; }
      ];
      utilities.toasts.chargingChanged = false;
      bar.activeWindow.inverted = true;
      bar.clock = {
        background = true;
        showDate = true;
        showIcon = true;
      };
      controlCenter.sizes = {
        heightMult = 0.7;
        ratio = 1.778;
      };
      bar.sizes = {
        windowPreviewSize = 250;
        trayMenuWidth = 200;
        batteryWidth = 80;
        networkWidth = 220;
        kbLayoutWidth = 200;
      };
      bar.tray.hiddenIcons = [
        "spotify-client"
        "chrome_status_icon_1"
      ];
      bar.status = {
        showBattery = true;
        showNetwork = true;
        showBluetooth = true;
        showAudio = false;
        showMicrophone = false;
        showKbLayout = false;
        showLockStatus = true;
      };
      appearance = {
        font.size.scale = 0.75;
        padding.scale = 0.75;
        spacing.scale = 0.75;
      };
      border = {
        rounding = 25;
        thickness = 10;
      };
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = false;
        no_fade_in = true;
        no_fade_out = true;
        grace = 0;
      };

      background = [
        {
          monitor = "";
          color = "rgb(000000)";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 0;
          dots_size = 0;
          dots_spacing = 0;
          outer_color = "rgb(000000)";
          inner_color = "rgb(000000)";
          font_color = "rgb(ffffff)";
          fade_on_empty = false;
          placeholder_text = "";
          hide_input = false;
          rounding = 0;
          check_color = "rgb(000000)";
          fail_color = "rgb(fa746f)";
          fail_text = "";
          capslock_color = "rgb(000000)";
          numlock_color = "rgb(000000)";
          bothlock_color = "rgb(000000)";
          font_family = "Ubuntu Sans Mono";
          halign = "center";
          valign = "center";
          position = "0, 0";
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,20"
      ];
      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 2;
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
        };
        shadow = {
          enabled = true;
          range = 20;
        };
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      input = {
        kb_layout = "us";
        touchpad.natural_scroll = true;
        touchpad.tap-to-click = true;
        touchpad.clickfinger_behavior = true;
      };
      misc.disable_hyprland_logo = true;
      bind = [
        ", Print, exec, grim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"
        "SHIFT, Print, exec, grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"
        "ALT, N, exec, kitty"
        "ALT, Q, exec, hyprctl -i 0 activewindow -j | jq -r '.pid' | xargs kill"
        "ALT, W, exec, if [ \"$(hyprctl -i 0 activewindow -j | jq -r '.class')\" = \"firefox\" ]; then hyprctl -i 0 dispatch sendshortcut CTRL,w,activewindow; else hyprctl -i 0 dispatch killactive; fi"
        "ALT, T, exec, if [ \"$(hyprctl -i 0 activewindow -j | jq -r '.class')\" = \"firefox\" ]; then hyprctl -i 0 dispatch sendshortcut CTRL,t,activewindow; fi"
        "ALT, R, exec, if [ \"$(hyprctl -i 0 activewindow -j | jq -r '.class')\" = \"firefox\" ]; then hyprctl -i 0 dispatch sendshortcut ,F5,activewindow; fi"
        "ALT SHIFT, R, exec, if [ \"$(hyprctl -i 0 activewindow -j | jq -r '.class')\" = \"firefox\" ]; then hyprctl -i 0 dispatch sendshortcut CTRL SHIFT,r,activewindow; fi"
        "ALT SHIFT, T, exec, if [ \"$(hyprctl -i 0 activewindow -j | jq -r '.class')\" = \"firefox\" ]; then hyprctl -i 0 dispatch sendshortcut CTRL SHIFT,t,activewindow; fi"
        "ALT, M, movetoworkspacesilent, special:minimized"
        "SUPER, M, exit"
        "SUPER, V, togglefloating"
        "SUPER, F, fullscreen"
        "ALT, space, exec, caelestia-shell ipc call drawers toggle launcher"
        "ALT, 1, workspace, 1"
        "ALT, 2, workspace, 2"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, 5, workspace, 5"
        "ALT SHIFT, 1, movetoworkspace, 1"
        "ALT SHIFT, 2, movetoworkspace, 2"
        "ALT SHIFT, 3, movetoworkspace, 3"
        "ALT SHIFT, 4, movetoworkspace, 4"
        "ALT SHIFT, 5, movetoworkspace, 5"
        "ALT, h, movefocus, l"
        "ALT, l, movefocus, r"
        "ALT, k, movefocus, u"
        "ALT, j, movefocus, d"
        "SUPER SHIFT, L, exec, hyprlock"
        "ALT, TAB, exec, list=$(hyprctl -i 0 clients -j | jq -r '.[] | select(.workspace.name == \"special:minimized\") | \"\\(.address) \\(.class) — \\(.title)\"'); [ -n \"$list\" ] && echo \"$list\" | wofi --dmenu --prompt 'Minimized Windows' | awk '{print $1}' | xargs -I{} hyprctl -i 0 dispatch movetoworkspacesilent e+0,address:{}"
        "ALT, equal, resizeactive, 40 40"
        "ALT, minus, resizeactive, -40 -40"
      ];
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      windowrule = [
        "float on, match:class org.gnome.Nautilus"
        "size 700 450, match:class org.gnome.Nautilus"
        "center on, match:class org.gnome.Nautilus"
        "opacity 0.85, match:class org.gnome.Nautilus"
        "float on, match:class org.keepassxc.KeePassXC"
        "center on, match:class org.keepassxc.KeePassXC"
        "size 700 450, match:class xdg-desktop-portal-gtk"
        "center on, match:class xdg-desktop-portal-gtk"
        "size 700 450, match:title (Open|Save|Select|Choose|Upload|File)"
        "center on, match:title (Open|Save|Select|Choose|Upload|File)"
        "workspace 1 silent, match:class firefox"
        "workspace 2 silent, match:class kitty"
        "opacity 0.75, match:class spotify"
        "workspace 4 silent, match:class spotify"
        "opacity 0.75, match:class vesktop"
        "workspace 5 silent, match:class vesktop"
      ];
      exec-once = [
        "firefox"
        "kitty"
        "spotify"
        "vesktop"
      ];
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    initContent = ''
      export SHELL="$(command -v zsh)"
      eval "$(zoxide init zsh)"
      # fzf keybindings (Ctrl+R for history, Ctrl+T for files)
      eval "$(fzf --zsh)"

      # Better history search with up/down arrows
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward
    '';
    historySubstringSearch.enable = true;
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";
      lt = "eza --tree --icons --level=2";
      cat = "bat --style=plain";
      lg = "lazygit";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";
      add_newline = true;
      character = {
        success_symbol = "[\\$](bold #bbc5ee)";
        error_symbol = "[\\$](bold #fa746f)";
      };
      username = {
        show_always = true;
        style_user = "bold #44def5";
        format = "[$user]($style)";
      };
      hostname = {
        ssh_only = false;
        style = "bold #74757f";
        format = "[@$hostname]($style) ";
      };
      directory = {
        style = "bold #91acd6";
        truncation_length = 3;
        truncation_symbol = ".../";
        read_only = " 󰌾";
      };
      git_branch = {
        symbol = " ";
        style = "bold #a8a2ee";
        format = "on [$symbol$branch]($style) ";
      };
      git_status = {
        style = "bold #ffdcf2";
        format = "[$all_status$ahead_behind]($style)";
      };
      cmd_duration = {
        min_time = 2000;
        style = "bold #74757f";
        format = "took [$duration]($style) ";
      };
      nix_shell = {
        symbol = " ";
        style = "bold #977cff";
        format = "via [$symbol$state]($style) ";
      };
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Ubuntu Sans Mono";
      size = 11;
    };
    settings = {
      # Font
      bold_font = "Ubuntu Sans Mono Bold";
      italic_font = "Ubuntu Sans Mono Italic";
      bold_italic_font = "Ubuntu Sans Mono Bold Italic";
      # Appearance
      shell = "/run/current-system/sw/bin/zsh";
      background_opacity = "0.65";
      background_blur = 32;
      window_padding_width = 12;
      cursor_shape = "beam";
      cursor_blink_interval = "0.5";
      enable_audio_bell = false;
      linux_display_server = "wayland";
      wayland_enable_notifications = "no";
      notify_on_cmd_finish = "never";
      bell_on_tab = "no";
      visual_bell_duration = 0;
      confirm_os_window_close = 0;
      hide_window_decorations = true;

      # Tab bar
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_min_tabs = 2;
      active_tab_foreground = "#0d0e12";
      active_tab_background = "#bbc5ee";
      active_tab_font_style = "bold";
      inactive_tab_foreground = "#74757f";
      inactive_tab_background = "#181920";
      inactive_tab_font_style = "normal";

      # Scrollback
      scrollback_lines = 10000;

      # URL handling
      url_style = "curly";

      # Caelestia dynamic colors (from wallpaper)
      foreground = "#e5e4f0";
      background = "#0d0e12";
      selection_foreground = "#0d0e12";
      selection_background = "#6386d0";
      cursor = "#bbc5ee";
      cursor_text_color = "#0d0e12";
      url_color = "#acc8ff";

      # Black
      color0 = "#353434";
      color8 = "#ac9fa9";

      # Red / purple
      color1 = "#977cff";
      color9 = "#af9aff";

      # Green / cyan
      color2 = "#44def5";
      color10 = "#89ecff";

      # Yellow / pink
      color3 = "#ffdcf2";
      color11 = "#fff0f6";

      # Blue
      color4 = "#91acd6";
      color12 = "#b0c2db";

      # Magenta
      color5 = "#a8a2ee";
      color13 = "#bfb8f7";

      # Cyan
      color6 = "#9cceff";
      color14 = "#bae0ff";

      # White
      color7 = "#e8d3de";
      color15 = "#ffffff";
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+enter" = "new_window_with_cwd";
      "ctrl+shift+l" = "next_tab";
      "ctrl+shift+h" = "previous_tab";
      "ctrl+shift+equal" = "change_font_size all +1.0";
      "ctrl+shift+minus" = "change_font_size all -1.0";
      "ctrl+shift+0" = "change_font_size all 0";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;
  };
  
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    terminus_font
    nerd-fonts.terminess-ttf
    nerd-fonts.ubuntu-mono
    ubuntu-sans-mono
    material-symbols
    zsh-autosuggestions
    zsh-syntax-highlighting
    eza
    bat
    fzf
    fd
    ripgrep
    zoxide
    git
    lazygit
    gcc
    nodejs
    python3
    stylua
    lua-language-server
    nil
    claude-code
    vesktop
    keepassxc
    obsidian
    btop
    nautilus
    fastfetch
    jq
    unzip
    tree
  ];

  programs.spicetify = {
    enable = true;
    colorScheme = "custom";
    customColorScheme = {
      text = "e5e4f0";
      subtext = "aaaab5";
      main = "0d0e12";
      sidebar = "0c0d11";
      player = "0d0e12";
      card = "1e1f26";
      shadow = "000000";
      selected-row = "24252e";
      button = "bbc5ee";
      button-active = "c9d3fd";
      button-disabled = "464750";
      tab-active = "bbc5ee";
      notification = "475174";
      notification-error = "871f21";
      misc = "74757f";
      play-button = "bbc5ee";
      play-button-active = "c9d3fd";
      progress-fg = "bbc5ee";
      progress-bg = "24252e";
      heart = "bbc5ee";
      pagelink-active = "bbc5ee";
      radio-btn-active = "bbc5ee";
    };
  };
}
