Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function(character)  --F to Switch, cooldown for 0.5s(500ms) to avoid issue
    if not character then return end
    if charLastControlled == nil or charCurrentControlling == nil then return end
    if PlayerInput.KeyDown(Keys.F) then
        if controlling then
            print("Controll Off")
            local message = Networking.Start("ControllSwitch")
            message.WriteString(charLastControlled.Name)
            Networking.Send(message)
            Timer.Wait(function() controlling = false end, 500)
        end
        if not controlling then
            print("Controll On")
            local message = Networking.Start("ControllSwitch")
            message.WriteString(charCurrentControlling.Name)
            Networking.Send(message)
            Timer.Wait(function() controlling = true end, 500)
        end
    end
end, Hook.HookMethodType.After)

Hook.Add("character.death", "Drones.resetOndronesdead", function(character)  
    if character.Name == charCurrentControlling.Name then  --Reset controller on controlled death
        Character.Controlled = charLastControlled
        charCurrentControlling = nil
        controlling = false
        local message = Networking.Start("ControllSwitch")
        message.WriteString(charLastControlled.Name)
        Networking.Send(message)
    end
    if character.Name == charLastControlled.Name then  --Reset controller on controller death
        Character.Controlled = nil
        controlling = false
        charLastControllsed = nil
        charCurrentControlling = nil
        local message = Networking.Start("ControllSwitch")
        message.WriteString(charLastControlled.Name)
        Networking.Send(message)
    end
end)