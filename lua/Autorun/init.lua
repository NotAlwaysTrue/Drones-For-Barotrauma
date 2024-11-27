Drones = {}
Drones.Path = table.pack(...)[1]

if CLIENT then
	dofile(Drones.Path.."/lua/Scripts/Client/Client.lua")
end

if SERVER then
	dofile(Drones.Path.."/lua/Scripts/Server/Server.lua")
end
