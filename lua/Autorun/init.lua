Drones = {}
Drones.Path = table.pack(...)[1]

if CLIENT then
	dofile(Drones.Path.."/lua/Scripts/Client/Client.lua")
	--dofile(Drones.Path.."/lua/Scripts/Client/HUD.lua")  --Unfinished GUI works
end

if SERVER then
	dofile(Drones.Path.."/lua/Scripts/Server/Server.lua")
end