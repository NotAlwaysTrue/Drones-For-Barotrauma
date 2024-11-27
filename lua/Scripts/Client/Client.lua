charLastControlled = nil
charCurrentControlling = nil

Hook.Add("item.applyTreatment", "Drones.itemused", function(item, usingCharacter, targetCharacter)
    if item == nil or  usingCharacter == nil or targetCharacter == nil then return end
    local identifier = item.Prefab.Identifier.Value
    local methodtorun = Drones.ItemMethods[identifier]
    if(methodtorun~=nil) then 
        methodtorun(item, usingCharacter, targetCharacter)
        return
    end
end)

Hook.Add("client.disconnected", "Drones.resetOnDisconnected", function(client)
    local lastcontrolled = Networking.Start("lastcontrolled")
    lastcontrolled.WriteString(charLastControlled)
    Networking.Send(lastcontrolled)
end)

Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function(character)  --补Hook
    if not character then return end
    if charLastControlled == nil then return end
    if PlayerInput.KeyDown(Keys.F) then
        Character.Controlled = charLastControlled
	end
end, Hook.HookMethodType.After)

Hook.Add("character.death", "Drones.resetOndronesdead", function(character)
    if character.CharacterHealth.GetAffliction('UAV',true) ~= nil then
        Character.Controlled = charLastControlled
    end
end)

Drones.ItemMethods = {}

Drones.ItemMethods.UAVController = function(item, usingCharacter, targetCharacter)
    if targetCharacter.IsPlayer then return end
    charLastControlled = usingCharacter
    Character.Controlled = targetCharacter
    charCurrentControlling = targetCharacter
end