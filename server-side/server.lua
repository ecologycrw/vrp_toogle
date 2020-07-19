local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()

func = {}
Tunnel.bindInterface("vrp_toogle",func)

local cfg = module("vrp_toogle","cfg/uniformes")
----------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
----------------------------------------------------------------------------------------------------------------------------------------------------
local empregos = {}
local blipscactived = {}
local paisana = {}
local emservico = {}
----------------------------------------------------------------------------------------------------------------------------------------------------
-- INFORME OS GRUPOS PARA ENTRAR/SAIR DE SERVIÇO.
----------------------------------------------------------------------------------------------------------------------------------------------------
local grupos = {
    { profissao = "Paramedico", blips = 1 },
    { profissao = "Policia", blips = 1 },
}
----------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO DE CHECAGEM DAS PERMISSÕES
----------------------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,perm)
end
----------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO DO TOOGLE
----------------------------------------------------------------------------------------------------------------------------------------------------
for k,grupo in ipairs(grupos) do
	local k = 'Paisana'..grupo.profissao
	empregos[grupo] = k
	paisana[k] = grupo
end

for k,servico in ipairs(grupos) do
	local k = servico.profissao
	empregos[servico] = k
	emservico[k] = servico
end

function func.toogleBlip()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local groups = vRP.getUserGroups(user_id)

	for k,_ in pairs(groups) do
		if paisana[k] then
			vRP.removeUserGroup(user_id, k) --
			print(paisana[k].blips)
			if paisana[k].blips == 1 then
				TriggerEvent('eblips:add',{ name = paisana[k], src = source, color = 47 })
			end
			vRP.addUserGroup(user_id, paisana[k].profissao) --
			local custom = cfg.uniformes[tostring(paisana[k].profissao)]
			if custom then
				local old_custom = vRPclient.getCustomization(source)
				local idle_copy = {}
	
				idle_copy = vRP.save_idle_custom(source,old_custom)
				idle_copy.modelhash = nil
	
				for l,w in pairs(custom[old_custom.modelhash]) do
					idle_copy[l] = w
				end
				vRPclient._setCustomization(source,idle_copy)
			end
			TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
			return
		end
	end

	for k,_ in pairs(groups) do
		if emservico[k] then
			TriggerEvent('eblips:remove',source)
			vRP.removeUserGroup(user_id, k) --
			vRPclient.setArmour(source,0)
			vRP.addUserGroup(user_id, 'Paisana'..emservico[k].profissao) --
			TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
			TriggerClientEvent('desligarRadios',source)
			vRP.removeCloak(source)
			return
		end
	end
end
