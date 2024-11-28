Hook.Add("netMessageReceived", "Drones.ControllerSwitch", function()
    Networking.Receive("ControllSwitch", function(message, client)
        local charname = message.readString()
        if findcharacterbyname(charname) == nil then return end
        client.SetClientCharacter(findcharacterbyname(charname))
    end)
end)