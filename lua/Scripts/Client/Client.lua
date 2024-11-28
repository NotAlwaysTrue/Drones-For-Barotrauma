Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function(character)  --F to Switch, cooldown for 0.5s(500ms) to avoid issue
    if not character then return end
    if charLastControlled == nil or charCurrentControlling == nil then return end
    if PlayerInput.KeyDown(Keys.F) then
        if controlling then
            
            Timer.Wait(function() controlling = false end, 500)
        end
        if not controlling then
            
            Timer.Wait(function() controlling = true end, 500)
        end
    end
end, Hook.HookMethodType.After)