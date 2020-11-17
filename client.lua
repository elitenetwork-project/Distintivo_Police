ESX                           = nil
local PlayerData                = {}
local PlayerLoaded = false

--[[

    Creato da LuisDj#7467
    Powered by EliteNetwork
    www.elitenetwork.it

    Vietata la diffusione senza autorizzazione da LuisDj#7467

]]

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:Visualizza')
AddEventHandler('esx:Visualizza', function(id, imie, data, dodatek)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(pid))
    if pid == myId then
        Notifica(imie, data, dodatek, mugshotStr, 8, 80)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 20.00 then
        Notifica(imie, data, dodatek, mugshotStr, 8, 80)
    end
    UnregisterPedheadshot(mugshot)
end)

CreateThread(function()
    while true do 
        Citizen.Wait(5000)
        if ESX.PlayerData.job.name == "police" then
            TriggerServerEvent('esx_distintivo:VerificaItem', GetPlayerPed(-1))
        end
    end
end)

function Notifica(title, subject, msg, icon, iconType, color)
    SetNotificationTextEntry('STRING')
    SetNotificationBackgroundColor(color)
	AddTextComponentString(msg)
	SetNotificationMessage(icon, icon, false, iconType, title, subject)
	DrawNotification(false, false)
end