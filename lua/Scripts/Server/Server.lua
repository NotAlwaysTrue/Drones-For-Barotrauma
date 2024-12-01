Controllertargets = { }

Hook.Add("roundEnd", "Drones.resetonend", function() --reset every controller on round end
    for client,character in pairs(Controllers) do
        i.SetClientCharacter(character)
    end
    Controllers = { }
end)

Hook.Add("netMessageReceived", "Drones.ControllerSwitch", function()
    Networking.Receive("ControllSwitch", function(message, client)
        local id = message.readString()
        if findcharacterbyID(id) == nil then return end
        client.SetClientCharacter(findcharacterbyID(id))
    end)
end)