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

function findcharacterbyID(id)
    local characterlist = Character.CharacterList
    for i,v in pairs(characterlist) do
        if tostring(v.ID) == id then
            return v
        end
    end
    return nil
end