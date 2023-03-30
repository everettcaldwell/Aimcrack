local xor = import("tools/xor.lua")
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local MainWindow = Rayfield:CreateWindow({
    Name = "Scepter",
    LoadingTitle = "scepter.gg",
    LoadingSubtitle = "made by cyr0zn",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Scepter",
        FileName = "Phantom Forces"
    },
    Discord = {
        Enabled = true,
        Invite = "Zk822WFMYC",
        RememberJoins = false
    },
    KeySystem = not version_info.debug,
    KeySettings = {
        Title = "Scepter",
        Subtitle = "Key Sytem",
        Note = "This cheat is 100% free but you need to join Discord!",
        FileName = "key",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = xor.decrypt("18061c1b111c194b1e0c", "key")
    }
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
    Name = "Enable All", -- temporary
    CurrentValue = true,
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
local PlayerChamsToggle = EspTab:CreateToggle({
    Name = "Players",
    CurrentValue = false,
    Flag = "PlayerChamsToggleValue",
    Callback = function(Value)
        Chams(Value)
    end,
})

local WeaponChamsToggle = EspTab:CreateToggle({
    Name = "Weapons",
    CurrentValue = false,
    Flag = "WeaponChamsToggleValue",
    Callback = function(Value)
        weaponchams(Value)
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
 
 local NoFallToggle = CharacterTab:CreateToggle({
    Name = "No fall",
    CurrentValue = false,
    Flag = "NoFallToggleValue",
    Callback = function(Value)
        Scepter.nofall(Value)
    end,
})
