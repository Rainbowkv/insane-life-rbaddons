# morellos_swelcome
![Image](https://github.com/user-attachments/assets/6eb3e773-86f3-4e78-9b5c-e614fe251019)

Reach out to us on Discord
Discord - https://discord.gg/733BFBtzjP

A simple yet powerful welcome screen resource for FiveM servers. Display customizable welcome messages, server rules, and information to players upon joining.

## Features

- 🎨 Fully customizable UI with support for:
  - Custom background images
  - Server logo
  - Custom colors
  - Multiple content sections
- ⚙️ Flexible configuration options
- 🔄 Show welcome screen once per player or every time
- 🎮 Compatible with both standalone and QBCore servers
- 📱 Responsive design
- 🔔 Support for ox_lib notifications (optional)

## Installation

1. Download the `morellos_swelcome` folder
2. Place it in your server's `resources` directory
3. Add `ensure morellos_swelcome` to your `server.cfg`

## Configuration

All configuration options are located in `config.lua`. Here are the main settings:

### General Settings
```lua
Config.Enabled = true        -- Enable/disable the welcome screen
Config.WaitAfterSpawn = 2000 -- Delay before showing (in ms)
Config.ShowOnlyOnce = true   -- Show once per player
```

### Appearance
```lua
Config.Title = "Welcome"          -- Welcome screen title
Config.Logo = ""                  -- URL to server logo
Config.BackgroundImage = ""       -- URL to background image
Config.BackgroundColor = "#0f0f0f"-- Fallback background color
Config.TextColor = "#ffffff"      -- Text color
```

### Button Configuration
```lua
Config.AcceptButtonText = "Accept"     -- Accept button text
Config.DeclineButtonText = "Decline"   -- Decline button text
Config.AcceptButtonColor = "#4CAF50"   -- Accept button color
Config.DeclineButtonColor = "#f44336"  -- Decline button color
```

### Content Sections
You can add as many content sections as needed:
```lua
Config.Sections = {
    {
        title = "Server Rules",
        content = [[
            <p>1. Your rules here</p>
            <p>2. Another rule</p>
        ]]
    }
}
```

### Actions
Configure actions for when players accept/decline:
```lua
Config.OnAccept = {
    notification = true,
    notificationText = "Welcome message",
    notificationType = "success"
}

Config.OnDecline = {
    kickReason = "Declined server terms"
}
```

## Dependencies

- None required
- Optional: ox_lib (for enhanced notifications)

## Features

1. **Multiple Display Options**
   - Show on first join only
   - Show every time
   - Configurable delay after spawn

2. **Player Management**
   - Tracks players who have seen the welcome screen
   - Option to kick players who decline
   - Server-side verification

3. **UI Features**
   - Customizable background
   - Support for HTML content
   - Responsive design
   - Custom button colors and text
   - Multiple content sections

4. **Framework Compatibility**
   - Works with standalone FiveM servers
   - QBCore compatible
   - Optional ox_lib integration for notifications

## License

This resource is provided as-is for FiveM server owners.

## Credits

Created by S4int - Version 1.0.0
- If you like my scripts, you can check out my TEBEX store.
https://morelloscript.tebex.io/
