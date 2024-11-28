charLastControlled = nil
charCurrentControlling = nil
controlling = false

Hook.Add("item.applyTreatment", "Drones.itemused", function(item, usingCharacter, targetCharacter)
    if item == nil or  usingCharacter == nil or targetCharacter == nil then return end
    local identifier = item.Prefab.Identifier.Value
    local methodtorun = Drones.ItemMethods[identifier]
    if(methodtorun~=nil) then 
        methodtorun(item, usingCharacter, targetCharacter)
        return
    end
end)

Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function(character)  --F to Switch, cooldown for default 1s(1000ms) to avoid issue
    if not character then return end
    if charLastControlled == nil or charCurrentControlling == nil then return end
    if PlayerInput.KeyDown(Keys.F) then
        if controlling then
            Character.Controlled = charLastControlled
            Timer.Wait(function() controlling = false end, minSwitchtime)
        end
        if not controlling then
            Character.Controlled = charCurrentControlling
            Timer.Wait(function() controlling = true end, minSwitchtime)
        end
    end
end, Hook.HookMethodType.After)

Hook.Add("character.death", "Drones.resetOndronesdead", function(character)  --Reset on death
    if character.Name == charCurrentControlling.Name then
        Character.Controlled = charLastControlled
        charCurrentControlling = nil
        controlling = false
    end
    if character.Name == charLastControlled.Name then  --Reset controller on controller death
        Character.Controlled = nil
        controlling = false
        charLastControllsed = nil
        charCurrentControlling = nil
    end
end)

Drones.ItemMethods = {}

Drones.ItemMethods.UAVController = function(item, usingCharacter, targetCharacter)  --The "controller"
    if targetCharacter.IsPlayer then return end
    charLastControlled = usingCharacter
    Character.Controlled = targetCharacter
    charCurrentControlling = targetCharacter
    controlling = true
end