local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("vrp_toogle",func)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORME AS LOCALIZAÇÕES DOS BLIPS E A PERMISSÃO
---------------------------------------------wd------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 452.04, ['y'] = -973.33, ['z'] = 30.69, ['h'] = 291.33, ['perm'] = "policia.permissao" },
	{ ['id'] = 2, ['x'] = 311.83, ['y'] = -604.13, ['z'] = 43.3, ['h'] = 291.33, ['perm'] = "toogleHP.permissao"},
	{ ['id'] = 3, ['x'] = -203.88, ['y'] = -1331.16, ['z'] = 34.9, ['h'] = 291.33, ['perm'] = "policia.permissao" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR EM SERVIÇO --
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for _,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 5.5 then
				DrawMarker(21,v.x,v.y,v.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.5 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ENTRAR OU SAIR DE SERVIÇO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and func.checkPermission(v.perm) and not IsPedInAnyVehicle(ped) then
						func.toogleBlip()
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- drawTxt
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end