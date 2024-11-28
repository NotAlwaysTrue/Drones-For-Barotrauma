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

function findcharacterbyclient(client)
    local clientname = client.Name
    local characterlist = Character.CharacterList
    for i,v in pairs(characterlist) do
        if v.Name == clientname then
            return v
        end
    end
    return nil
end

function findcharacterbyname(name)
    local characterlist = Character.CharacterList
    for i,v in pairs(characterlist) do
        if v.Name == name then
            return v
        end
    end
    return nil
end