Hook.Add("netMessageReceived", "Drones.ControllerSwitch", function()
    Networking.Receive("ControllSwitch", function(message, client)
        local id = message.readString()
        if findcharacterbyID(id) == nil then return end
        client.SetClientCharacter(findcharacterbyID(id))
    end)
end)