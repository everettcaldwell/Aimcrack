-- Credits To The Original Devs @xz, @goof
getgenv().Config = {
	Invite = "Mc8a2NpMns",
	Version = "0.2",
}

getgenv().luaguardvars = {
	DiscordName = "c3#3468",
}

local library = import("ui/framework.lua")

library:init()

local Window = library.NewWindow({
	title = "aimcrack.com",
	size = UDim2.new(0, 525, 0, 650)
})

local tabs = {
    AimTab = Window:AddTab("Aim"),
	VisualsTab = Window:AddTab("Visuals"),
	PlayerTab = Window:AddTab("Player"),
	Settings = library:CreateSettingsTab(Window),
}

-- 1 = Set Section Box To The Left
-- 2 = Set Section Box To The Right

local AimSections = {
	Aimbot = tabs.AimTab:AddSection("Aimbot", 1),
	Rcs = tabs.AimTab:AddSection("RCS", 2),
	Triggerbot = tabs.AimTab:AddSection("Triggerbot", 2),
}

local VisualsSections = {
	Esp = tabs.VisualsTab:AddSection("Esp", 1),
}

local PlayerSections = {
	CharacterMods = tabs.PlayerTab:AddSection("Character mods")
}

AimSections.Aimbot:AddToggle({
	enabled = true,
	text = "Enable",
	flag = "aimbot_enable_toggle",
	tooltip = "Enables aimbot using the settings below.",
	risky = false,
	callback = function(v)
		Interface.Aimbot.setState(v)
	end
})

AimSections.Aimbot:AddToggle({
	enabled = true,
	text = "Use fov",
	flag = "aimbot_use_fov_toggle",
	tooltip = "Restricts the aimbot to the field of view below.",
	risky = false,
	callback = function(v)

	end
})

AimSections.Aimbot:AddSlider({
	text = "Fov",
	flag = 'aimbot_fov_slider', 
	suffix = "", 
	value = 20, -- get the game fov
	min = 0,
	max = 80,
	increment = 0.1,
	tooltip = "Fov in degrees.",
	risky = false,
	callback = function(v)
		Interface.Aimbot.setFov(v)
	end
})

AimSections.Aimbot:AddToggle({
	enabled = true,
	text = "Show fov",
	flag = "aimbot_show_fov_toggle",
	tooltip = "Renders the fov that the aimbot will use.",
	risky = false,
	callback = function(v)
		Interface.Aimbot.showFov(v)
	end
})

AimSections.Aimbot:AddColor({
    enabled = true,
    text = "Fov",
    flag = "aimbot_fov_draw_color",
    tooltip = "Sets the color of the rendered fov that the aimbot uses.",
    color = Color3.new(255, 255, 255),
    trans = 0,
    open = false,
    callback = function(v)
		Interface.Aimbot.setFovRenderColor(v)
    end
})

AimSections.Aimbot:AddList({
	enabled = true,
	text = "Target part",
	flag = "aimbot_target_part_list",
	multi = false,
	tooltip = "The part that the aimbot will snap to.",
    risky = false,
    dragging = false,
    focused = false,
	value = "Head",
	values = {
		"Head",
		"Torso",
	},
	callback = function(v)
		Interface.Aimbot.setTargetPart(v)
	end
})

AimSections.Aimbot:AddBox({
    enabled = true,
    focused = true,
    text = "Retarget method",
    input = "xy distance",
	flag = "aimbot_retarget_placeholder",
	risky = false,
	callback = function(v)
	end
})

AimSections.Rcs:AddToggle({
	enabled = true,
	text = "Enable",
	flag = "rcs_enable_toggle",
	tooltip = "Enables the recoil control system with the settings below.",
	risky = false,
	callback = function(v)
		Interface.Rcs.setState(v)
	end
})

AimSections.Rcs:AddSlider({
	text = "Recoil Control X",
	flag = 'rcs_recoil_x_slider', 
	suffix = "",
	value = 0,
	min = 0,
	max = 1,
	increment = 0.01,
	tooltip = "Changes the effect of recoil in the x direction.",
	risky = true,
	callback = function(v)
		Interface.Rcs.setRecoilX(v)
	end
})

AimSections.Rcs:AddSlider({
	text = "Recoil Control Y",
	flag = 'rcs_recoil_y_slider', 
	suffix = "",
	value = 0,
	min = 0,
	max = 1,
	increment = 0.01,
	tooltip = "Changes the effect of recoil in the y direction.",
	risky = true,
	callback = function(v)
		Interface.Rcs.setRecoilY(v)
	end
})

VisualsSections.Esp:AddToggle({
	enabled = true,
	text = "Skeletons",
	flag = "esp_skeletons_toggle",
	tooltip = "Draws enemy bones.",
	risky = false,
	callback = function(v)
		Interface.Esp.Skeletons.setState(v)
	end
})

VisualsSections.Esp:AddSeparator({
	text = "Boxes"
})

VisualsSections.Esp:AddToggle({
	enabled = true,
	text = "Enable",
	flag = "esp_boxes_toggle",
	tooltip = "Draws boxes around enemies.",
	risky = false,
	callback = function(v)
		Interface.Esp.Boxes.setState(v)
	end
})

VisualsSections.Esp:AddToggle({
	enabled = true,
	text = "Healthbar",
	flag = "esp_boxes_healthbar_toggle",
	tooltip = "Displays the enemy health on the left of their box.",
	risky = false,
	callback = function(v)
		Interface.Esp.Boxes.setHealthBarState(v)
	end
})

VisualsSections.Esp:AddToggle({
	enabled = true,
	text = "Nametag",
	flag = "esp_boxes_nametag_toggle",
	tooltip = "Displays the enemy name above their box.",
	risky = false,
	callback = function(v)
		Interface.Esp.Boxes.setNameTagState(v)
	end
})

PlayerSections.CharacterMods:AddToggle({
	enabled = true,
	text = "Nofall",
	flag = "charactermods_nofall_toggle",
	tooltip = "No fall damage will be taken when jumping from tall heights.",
	risky = false,
	callback = function(v)
		Interface.Character.Nofall(v)
	end
})

PlayerSections.CharacterMods:AddSlider({
	text = "Speed multiplier",
	flag = 'charactermods_speedmult_slider', 
	suffix = "x",
	value = 1, -- get the game fov
	min = 1,
	max = 3,
	increment = 0.1,
	tooltip = "Multiplies the base speed by this amount.",
	risky = true,
	callback = function(v)
		Interface.Character.SetSpeed(v)
	end
})

AimSections.Rcs:AddToggle({
	enabled = true,
	text = "Noshake",
	flag = "miscvisual_noshake_toggle",
	tooltip = "Removes the camera shake when firing a weapon.",
	risky = false,
	callback = function(v)
		Interface.Rcs.Noshake(v)
	end
})

--Window:SetOpen(true) -- Either Close Or Open Window
