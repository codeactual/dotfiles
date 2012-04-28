if [ -f /usr/bin/gsettings ]; then
  # Don't cover the fluxbox.
  gsettings set org.gnome.desktop.background show-desktop-icons false
fi
