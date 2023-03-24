local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local MainWindow = Rayfield:CreateWindow({
    Name = "Phantom Forces",
    LoadingTitle = "Scepter Script Hub",
    LoadingSubtitle = "by cyr0zn",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "Scepter", -- Create a custom folder for your hub/game
       FileName = "Phantom Forces"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD.
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Sirius Hub",
       Subtitle = "Key System",
       Note = "Join the discord (discord.gg/sirius)",
       FileName = "SiriusKey",
       SaveKey = true,
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = "Hello"
    }
 })

 -- AIM 
local AimTab = MainWindow:CreateTab("Aim", 4483362458) -- Title, Image
local SilentSection = AimTab:CreateSection("Silent")
local SilentToggle = AimTab:CreateToggle({
    Name = "Enable",
    CurrentValue = false,
    Flag = "SilentEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        SilentSettings.enabled = Value
    end,
})
local SilentPartDropdown = AimTab:CreateDropdown({
    Name = "Target",
    Options = {"Head","Torso"},
    CurrentOption = "Head",
    Flag = "SilentPartTargetValue", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Option)
        SilentSettings.targetPart = string.lower(Option)
    end,
 })
local SilentFovSlider = AimTab:CreateSlider({
   Name = "Fov",
   Range = {0, 80},
   Increment = 1,
   Suffix = "Degrees",
   CurrentValue = 10,
   Flag = "SilentFovValue", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        SilentSettings.fov = Value
   end,
})
local FovRingColorPicker = AimTab:CreateColorPicker({
    Name = "FOV Ring Color",
    Color = Color3.fromRGB(255,255,255),
    Flag = "FovRingColorValue", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        SilentSettings.fovRingColor = Value
    end
})

-- ESP
local EspTab = MainWindow:CreateTab("Esp", 4483362458) -- Title, Image
local LinesSection = EspTab:CreateSection("Lines")
local SkeletonToggle = EspTab:CreateToggle({
    Name = "Skeletons",
    CurrentValue = false,
    Flag = "SkeletonsEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        Lines(Value)
    end,
})
local SkeletonColorPicker = EspTab:CreateColorPicker({
    Name = "Skeleton Color",
    Color = Color3.fromRGB(255,255,255),
    Flag = "SkeletonColorValue", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        LineSettings.color = Value
    end
})
-- ESP/CHAMS
local ChamsSection = EspTab:CreateSection("Chams")
local ChamsToggle = EspTab:CreateToggle({
    Name = "Enable",
    CurrentValue = false,
    Flag = "ChamsEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        Chams(Value)
    end,
})
local ChamsColorPicker = EspTab:CreateColorPicker({
    Name = "Chams Color",
    Color = Color3.fromRGB(255,0,0),
    Flag = "ChamsColorValue", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        UpdateHighlightColor(Value)
    end
})