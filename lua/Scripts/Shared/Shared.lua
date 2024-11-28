if CLIENT then
    charLastControlled = nil
    charCurrentControlling = nil
    controlling = false
end

Hook.Add("item.applyTreatment", "Drones.itemused", function(item, usingCharacter, targetCharacter)
    if item == nil or  usingCharacter == nil or targetCharacter == nil then return end
    local identifier = item.Prefab.Identifier.Value
    local methodtorun = Drones.ItemMethods[identifier]
    if(methodtorun~=nil) then 
        methodtorun(item, usingCharacter, targetCharacter)
        return
    end
end)

function findclient(character)
    local charactername = character.Name
    local clientlist = Client.ClientList
    for i,v in pairs(clientlist) do
        if v.Name == charactername then
            return v
        end
    end
    return nil
end

function findcharacter(client)
    local clientname = client.Name
    local characterlist = Character.CharacterList
    for i,v in pairs(characterlist) do
        if v.Name == clientname then
            return v
        end
    end
    return nil
end

Drones.ItemMethods = {}

Drones.ItemMethods.UAVController = function(item, usingCharacter, targetCharacter)
    if targetCharacter.IsPlayer then return end
    if targetCharacter == nil or targetCharacter == nil then return end
    local usingclient = findclient(usingCharacter)
    if usingclient == nil then return end
    if SERVER then
        targetCharacter.SetOwnerClient(usingclient)
        usingclient.SetClientCharacter(targetCharacter)
    end
    if CLIENT then
        charLastControlled = usingCharacter
        charCurrentControlling = targetCharacter
        controlling = true
    end
end