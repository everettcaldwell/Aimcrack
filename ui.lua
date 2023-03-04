local Bracket = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV33.lua"))()
Bracket:Notification({Title = string.format("Specter V%s loaded", version_info.version), Duration = 5})

local Window = Bracket:Window({Name = string.format("Scepter V%s", version_info.version), Enabled = true, Color = Color3.new(1,0.5,0.25), Size = UDim2.new(0,496,0,496), Position = UDim2.new(0.5,-248,0.5,-248)}) do
    local Tab = Window:Tab({Name = "Aimbot", Side="Left"}) do
        local reloadBotton = Tab:Button({Name = "Reload UI",Side = "Left",Callback = function() Window = nil end, ToolTip="Reload UI"})
        --Button.Name = "Name"
        --Button.Callback = function() end
        --Button:ToolTip("Text")

        --local aimbotToggle = Tab:Toggle({Name = "Aimbot",Flag = "Toggle",Side = "Left",Value = false,Callback = function(toggleBool) end})
        --Toggle.Name = "Name"
        --Toggle.Value = true
        --Toggle.Callback = function(Toggle_Bool) end
        --Toggle:ToolTip("Text")

        -- local ToggleKeybind = Toggle:Keybind({Flag = "Toggle/Keybind",Value = "NONE",DoNotClear = false,Mouse = false,Callback = function(Key_String,Pressed_Bool,Toggle_Bool) end,
        -- Blacklist = {"W","A","S","D","Slash","Tab","Backspace","Escape","Space","Delete","Unknown","Backquote"}})
        -- --ToggleKeybind.Value = "B" -- KeyCode Name
        -- --ToggleKeybind.Callback = function(Key_String,Pressed_Bool,Toggle_Bool) end

        -- local ToggleColorpicker = Toggle:Colorpicker({Flag = "Toggle/Colorpicker",Value = {1,1,1,0,false},Callback = function(HSVAR_Table,Color3) end})
        -- --ToggleColorpicker.Value = {1,1,1,0,false} -- H,S,V,Alpha,Rainbow (HSVAR)
        -- --ToggleColorpicker.Callback = function(HSVAR_Table,Color3) end

        -- local Slider = Tab:Slider({Name = "Slider",Flag = "Slider",Side = "Left",Min = 0,Max = 100,Value = 50,Precise = 2,Unit = "",Callback = function(Value_Number) end})
        -- --Slider.Name = "Name"
        -- --Slider.Value = 50
        -- --Slider.Callback = function(Value_Number) end
        -- --Slider:ToolTip("Text")

        -- local Textbox = Tab:Textbox({Name = "Textbox",Flag = "Textbox",Side = "Left",Value = "Text",Placeholder = "Placeholder",NumberOnly = false,Callback = function(Text_String,EnterPressed) end})
        -- --Textbox.Name = "Name"
        -- --Textbox.Value = "Text"
        -- --Textbox.Placeholder = "Text"
        -- --Textbox.Callback = function(Text_String,EnterPressed) end
        -- --Textbox:ToolTip("Text")

        -- local Keybind = Tab:Keybind({Name = "Keybind",Flag = "Keybind",Side = "Left",Value = "NONE",Mouse = false,DoNotClear = false,Callback = function(Key_String,Pressed_Bool,Toggle_Bool) end,
        -- Blacklist = {"W","A","S","D","Slash","Tab","Backspace","Escape","Space","Delete","Unknown","Backquote"}})
        -- --Keybind.Name = "Name"
        -- --Keybind.Value = "B" -- KeyCode Name
        -- --Keybind.Callback = function(Key_String,Pressed_Bool,Toggle_Bool) end
        -- --Keybind:ToolTip("Text")
        
        -- local Dropdown = Tab:Dropdown({Name = "Dropdown",Flag = "Dropdown",Side = "Left",List = {
        --     {
        --         Name = "Head",
        --         Mode = "Toggle", -- Button or Toggle
        --         Value = false, -- Default
        --         Callback = function(Selected)
        --             print(Selected)
        --         end
        --     },
        --     {
        --         Name = "HumanoidRootPart",
        --         Mode = "Toggle",
        --         Value = false,
        --         Callback = function(Selected)
        --             print(Selected)
        --         end
        --     }
        -- }})
        -- --Dropdown.Name = "Name"
        -- --Dropdown.Value = {"Head"} -- Array of options to enable/select
        -- --Dropdown:BulkAdd(List_Table)
        -- --Dropdown:AddOption(Option_Table)
        -- --Dropdown:RemoveOption("OptionName")
        -- --Dropdown:Clear()
        -- --Dropdown:ToolTip("Text")

        -- local Colorpicker = Tab:Colorpicker({Name = "Colorpicker",Flag = "Colorpicker",Side = "Left",Value = {1,1,1,0,false},Callback = function(HSVAR_Table,Color3) end})
        -- --Colorpicker.Name = "Name"
        -- --Colorpicker.Value = {1,1,1,0,false} -- H,S,V,Alpha,Rainbow (HSVAR)
        -- --Colorpicker.Callback = function(HSVAR_Table,Color3) end
        -- --Colorpicker:ToolTip("Text")

        -- local Section = Tab:Section({Name = "Section",Side = "Right"}) do
        --     --Section.Name = "Name"

        --     --Same Elements as in tab but "Side" not used
        --     Section:Divider()
        --     Section:Label()
        --     Section:Button()

        --     local Toggle = Section:Toggle()
        --     Toggle:Keybind() Toggle:Colorpicker()

        --     Section:Slider()
        --     Section:Textbox()
        --     Section:Keybind()
        --     Section:Dropdown()
        --     Section:Colorpicker()
        --end
    end
    -- local OptionsTab = Window:Tab({Name = "Options"}) do
    --     local MenuSection = OptionsTab:Section({Name = "Menu",Side = "Left"}) do
    --         local UIToggle = MenuSection:Toggle({Name = "UI Enabled",Flag = "UI/Enabled",IgnoreFlag = true,
    --         Value = Window.Enabled,Callback = function(Bool) Window.Enabled = Bool end})
    --         UIToggle:Keybind({Value = "RightShift",Flag = "UI/Keybind",DoNotClear = true})
    --         UIToggle:Colorpicker({Flag = "UI/Color",Value = {1,0.25,1,0,true},
    --         Callback = function(HSVAR,Color) Window.Color = Color end})

    --         MenuSection:Toggle({Name = "Open On Load",Flag = "UI/OOL",Value = true})
    --         MenuSection:Toggle({Name = "Blur Gameplay",Flag = "UI/Blur",Value = false,
    --         Callback = function(Bool) Window.Blur = Bool end})

    --         MenuSection:Toggle({Name = "Watermark",Flag = "UI/Watermark/Enabled",Value = true,
    --         Callback = function(Bool) Window.Watermark.Enabled = Bool end}):Keybind({Flag = "UI/Watermark/Keybind"})
    --     end

    --     OptionsTab:AddConfigSection("Bracket_Example","Left")

    --     local BackgroundSection = OptionsTab:Section({Name = "Background",Side = "Right"}) do
    --         BackgroundSection:Colorpicker({Name = "Color",Flag = "Background/Color",Value = {1,1,0,0,false},
    --         Callback = function(HSVAR,Color) Window.Background.ImageColor3 = Color Window.Background.ImageTransparency = HSVAR[4] end})
    --         BackgroundSection:Textbox({HideName = true,Flag = "Background/CustomImage",Placeholder = "rbxassetid://ImageId",
    --         Callback = function(String,EnterPressed) if EnterPressed then Window.Background.Image = String end end})
    --         BackgroundSection:Dropdown({HideName = true,Flag = "Background/Image",List = {
    --             {Name = "Legacy",Mode = "Button",Callback = function()
    --                 Window.Background.Image = "rbxassetid://2151741365"
    --                 Window.Flags["Background/CustomImage"] = ""
    --             end},
    --             {Name = "Hearts",Mode = "Button",Callback = function()
    --                 Window.Background.Image = "rbxassetid://6073763717"
    --                 Window.Flags["Background/CustomImage"] = ""
    --             end},
    --             {Name = "Abstract",Mode = "Button",Callback = function()
    --                 Window.Background.Image = "rbxassetid://6073743871"
    --                 Window.Flags["Background/CustomImage"] = ""
    --             end},
    --             {Name = "Hexagon",Mode = "Button",Callback = function()
    --                 Window.Background.Image = "rbxassetid://6073628839"
    --                 Window.Flags["Background/CustomImage"] = ""
    --             end},
    --             {Name = "Circles",Mode = "Button",Callback = function()
    --                 Window.Background.Image = "rbxassetid://6071579801"
    --                 Window.Flags["Background/CustomImage"] = ""
    --             end},
    --             {Name = "Lace With Flowers",Mode = "Button",Callback = function()
    --                 Window.Background.Image = "rbxassetid://6071575925"
    --                 Window.Flags["Background/CustomImage"] = ""
    --             end},
    --             {Name = "Floral",Mode = "Button",Callback = function()
    --                 Window.Background.Image = "rbxassetid://5553946656"
    --                 Window.Flags["Background/CustomImage"] = ""
    --             end,Value = true},
    --             {Name = "Halloween",Mode = "Button",Callback = function()
    --                 Window.Background.Image = "rbxassetid://11113209821"
    --                 Window.Flags["Background/CustomImage"] = ""
    --             end},
    --             {Name = "Christmas",Mode = "Button",Callback = function()
    --                 Window.Background.Image = "rbxassetid://11711560928"
    --                 Window.Flags["Background/CustomImage"] = ""
    --             end}
    --         }})
    --         BackgroundSection:Slider({Name = "Tile Offset",Flag = "Background/Offset",Wide = true,Min = 74,Max = 296,Value = 74,
    --         Callback = function(Number) Window.Background.TileSize = UDim2.fromOffset(Number,Number) end})
    --     end
    -- end
end

Window:SetValue("Background/Offset",74)
Window:AutoLoadConfig("Bracket_Example")
Window:SetValue("UI/Enabled",Window.Flags["UI/OOL"])

