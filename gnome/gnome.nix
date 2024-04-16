{lib, ...}: let

  uint32 = lib.hm.gvariant.mkUint32;

in {

  # Set GNOME GSettings
  dconf.settings = {

    "/org/gnome/desktop/interface" = {

      # Dark Theme
      color-scheme = "prefer-dark";

      # Hot Corner 
      # Touch the top-left corner to open the Activities Overview
      enable-hot-corners = true;

    };

    "/org/gnome/mutter" = {

      # Active Screen Edges
      # Drag Window Agaisnt The Top, Left, And Right Screen Edges To Resize Them
      edge-tiling = true;

      # Fixed Number Of Workspaces
      dynamic-workspaces = false;

      # Multi-Monitor: Workspaces On All Displays
      workspaces-only-on-primary = false;

    };

    "/org/gnome/desktop/wm/preferences" ={

      # Number Of Workspaces
      num-workspaces = 4;

    };

    
    "/org/gnome/shell/app-switcher" = {

      # App Switching: Include Apps From All Workspaces
      current-workspace-only = false;

    };

    "/org/gnome/desktop/notifications" = {

      # Lock Screen Notifications
      show-in-lock-screen = true;

      # Do Not Disturb
      show-banners        = true;

    };

    "/org/gnome/desktop/search-providers" = {

      # App Search
      disable-external = false;

    };

  };
}
