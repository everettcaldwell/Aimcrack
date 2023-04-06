-- global tables
getgenv().Interface = {}
getgenv().Hooks = {}

import('bypass.lua')

repeat task.wait()
until getgenv().ModulesLoaded
print("Modules loaded. Injecting")

import('players.lua')

--esp
import('esp/lines.lua')
import('esp/playerchams.lua')
import('esp/objectchams.lua')

--aim
import('aim/aimbot.lua')
import('aim/rcs.lua')

--character
import('character/speedhack.lua')
import('character/nofall.lua')

--misc
import('misc/noshake.lua')

--ui
import('ui/interface.lua')
