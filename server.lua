ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[

    Creato da LuisDj#7467
    Powered by EliteNetwork
    www.elitenetwork.it

    Vietata la diffusione senza autorizzazione da LuisDj#7467

]]

function getIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    if result[1] ~= nil then
        local identity = result[1]
        return identity
    else
        return nil
    end
end


ESX.RegisterServerCallback('esx_phone:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local quanto = xPlayer.getInventoryItem(item).count
    cb(quanto)
end)

RegisterServerEvent('esx_distintivo:VerificaItem')
AddEventHandler('esx_distintivo:VerificaItem', function()
	local XPlayer = ESX.GetPlayerFromId(source)

	local quanto = XPlayer.getInventoryItem('distintivo').count
	if quanto > 1 then
		XPlayer.removeInventoryItem('distintivo', 1)

	elseif quanto < 1 then
		XPlayer.addInventoryItem('distintivo', 1)
	end
end)

ESX.RegisterUsableItem('distintivo', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local job = xPlayer.job
	local name = getIdentity(source)
	TriggerClientEvent('esx:Visualizza', -1,_source, '~h~'..name.firstname..' '..name.lastname, 'Distintivo LSPD' , 'Grado: ~b~'..job.grade_label)
end)
