local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local MainWindow = Rayfield:CreateWindow({
    Name = "Scepter",
    LoadingTitle = "Scepter Hub",
    LoadingSubtitle = "made by cyr0zn",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "Scepter",
       FileName = "Phantom Forces"
    },
    Discord = {
       Enabled = true,
       Invite = "XgFMtkGuQj",
       RememberJoins = false
    },
    KeySystem = true,
    KeySettings = {
       Title = "Scepter Hub",
       Subtitle = "Key System",
       Note = "Join the discord (discord.gg/XgFMtkGuQj)",
       FileName = "key",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = "scepterbesthub"
    }
 })

Rayfield:Notify({
   Title = "Join the Discord!",
   Content = "discord.gg/XgFMtkGuQj or you can click the link on GitHub",
   Duration = 10,
   Image = 4483362458,
   Actions = {
    Ignore = {
        Name = "Okay!",
        Callback = function()
        end
   },
},
})

 -- AIM 
local AimTab = MainWindow:CreateTab("Aim", 4483362458)
local SilentSection = AimTab:CreateSection("Silent")
local SilentToggle = AimTab:CreateToggle({
    Name = "Enable",
    CurrentValue = false,
    Flag = "SilentEnabled", 
    Callback = function(Value)
        SilentSettings.enabled = Value
    end,
})

local SilentPartDropdown = AimTab:CreateDropdown({
    Name = "Target",
    Options = {"Head","Torso"},
    CurrentOption = "Head",
    Flag = "SilentPartTargetValue", 
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
   Flag = "SilentFovValue", 
   Callback = function(Value)
        SilentSettings.fov = Value
   end,
})

local FovRingColorPicker = AimTab:CreateColorPicker({
    Name = "FOV Ring Color",
    Color = Color3.fromRGB(255,255,255),
    Flag = "FovRingColorValue", 
    Callback = function(Value)
        SilentSettings.fovRingColor = Value
    end
})

local NoRecoilToggle = AimTab:CreateToggle({
    Name = "No recoil",
    CurrentValue = false,
    Flag = "NoRecoilValue", 
    Callback = function(Value)
        norecoil(Value)
    end,
})

local EspTab = MainWindow:CreateTab("Esp", 4483362458) -- Title, Image
local LinesSection = EspTab:CreateSection("Lines")
local SkeletonToggle = EspTab:CreateToggle({
    Name = "Skeletons",
    CurrentValue = false,
    Flag = "SkeletonsEnabled", 
    Callback = function(Value)
        Lines(Value)
    end,
})

local SkeletonColorPicker = EspTab:CreateColorPicker({
    Name = "Skeleton Color",
    Color = Color3.fromRGB(255,255,255),
    Flag = "SkeletonColorValue",
    Callback = function(Value)
        LineSettings.color = Value
    end
})

local ChamsSection = EspTab:CreateSection("Chams")
local ChamsToggle = EspTab:CreateToggle({
    Name = "Enable",
    CurrentValue = false,
    Flag = "ChamsEnabled",
    Callback = function(Value)
        Chams(Value)
    end,
})

local ChamsColorPicker = EspTab:CreateColorPicker({
    Name = "Chams Color",
    Color = Color3.fromRGB(255,0,0),
    Flag = "ChamsColorValue", 
    Callback = function(Value)
        UpdateHighlightColor(Value)
    end
})

local CharacterTab = MainWindow:CreateTab("Character", 4483362458)
local WalkSpeedSlider = CharacterTab:CreateSlider({
    Name = "Speed multiplier",
    Range = {1, 3},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = 1,
    Flag = "WalkSpeedMultiplierValue", 
    Callback = function(Value)
         setspeed(Value)
    end,
 })
