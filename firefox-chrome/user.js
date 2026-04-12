// Enable userChrome.css and userContent.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Enable backdrop-filter (blur behind elements)
user_pref("layout.css.backdrop-filter.enabled", true);

// GPU rendering
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.enabled", true);
user_pref("layers.acceleration.force-enabled", true);

// Enable Wayland native rendering
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);

// Dark theme
user_pref("browser.theme.content-theme", 0);
user_pref("browser.theme.toolbar-theme", 0);

// Smooth scrolling
user_pref("general.smoothScroll", true);
