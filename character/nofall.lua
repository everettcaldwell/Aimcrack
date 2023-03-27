local network = shared.require("network")

local function nofall(state)
    if state then
        if not Hooks.send then
            Hooks.send = hookfunction(network.send, function(self, event, ...)
                if event == "falldamage" then
                    return
                end
                return Hooks.send(self, event, ...)
            end)
        end
    else
        if Hooks.send then
            hookfunction(network.send, Hooks.send)
            Hooks.send = nil
        end
    end
end

Scepter.nofall = nofall