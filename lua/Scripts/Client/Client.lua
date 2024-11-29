cd = 0
charLastControlled = nil
charCurrentControlling = nil
controlling = false

Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function(character)  --F to Switch, cooldown for 1s(1000ms) to avoid issue
    if not character then return end
    if charLastControlled == nil or charCurrentControlling == nil then return end
    if controlling and (charLastControlled.IsUnconscious or charCurrentControlling.IsUnconscious) then --Reset controller when controller or controlled is unconscious, only when controlling
        local message = Networking.Start("ControllSwitch")
        message.WriteString(tostring(charLastControlled.ID))
        Networking.Send(message)
        controlling = false
        return
    end
    if PlayerInput.KeyDown(Keys.F) and cd == 0 then
        if controlling then
            cd = 1
            local message = Networking.Start("ControllSwitch")
            message.WriteString(tostring(charLastControlled.ID))
            Networking.Send(message)
            Timer.Wait(function() controlling = false cd = 0 end, minSwitchtime)
        end
        if not controlling then
            cd = 1
            local message = Networking.Start("ControllSwitch")
            message.WriteString(tostring(charCurrentControlling.ID))
            Networking.Send(message)
            Timer.Wait(function() controlling = true cd = 0 end, minSwitchtime)
        end
    end
end, Hook.HookMethodType.After)

Hook.Add("character.death", "Drones.resetOndronesdead", function(character)
    if character == nil or charCurrentControlling == nil or charLastControlled == nil then return end
    if character.Name == charCurrentControlling.Name then  --Reset controller on controlled death
        if not controlling then  --don't send message when not controlling
            charCurrentControlling = nil
            controlling = false
            return
        end  --reset only target
        Character.Controlled = charLastControlled
        charCurrentControlling = nil
        controlling = false
        local message = Networking.Start("ControllSwitch")
        message.WriteString(tostring(charLastControlled.ID))
        Networking.Send(message)
    end
    if character.Name == charLastControlled.Name then  --Reset controller on controller death
        if not controlling then  --don't send message when not controlling
            charLastControlled = nil
            charCurrentControlling = nil
            controlling = false
            return
        end  --reset all since user is dead
        controlling = false
        charCurrentControlling = nil
        local message = Networking.Start("ControllSwitch")
        message.WriteString(tostring(charLastControlled.ID))
        Networking.Send(message)
        charLastControllsed = nil
        Character.Controlled = nil
    end
end)