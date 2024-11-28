Hook.Add("item.applyTreatment", "Drones.itemused", function(item, usingCharacter, targetCharacter)
    if item == nil or  usingCharacter == nil or targetCharacter == nil then return end
    local identifier = item.Prefab.Identifier.Value
    local methodtorun = Drones.ItemMethods[identifier]
    if(methodtorun~=nil) then 
        methodtorun(item, usingCharacter, targetCharacter)
        return
    end
end)

Drones.ItemMethods = {}

Drones.ItemMethods.UAVController = function(item, usingCharacter, targetCharacter)
    if targetCharacter.IsPlayer then return end
    if targetCharacter == nil or targetCharacter == nil then return end
    local usingclient = findclient(usingCharacter)
    if usingclient == nil then return end
    if SERVER then
        usingclient.SetClientCharacter(targetCharacter)
    end
    if CLIENT then
        charLastControlled = usingCharacter
        charCurrentControlling = targetCharacter
        controlling = true
    end
end