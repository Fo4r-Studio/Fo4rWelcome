ESX = exports['es_extended']:getSharedObject()

local isopen = false

Citizen.CreateThread(function()

    if Config.Ped then
        local hash = GetHashKey(Config.Ped.model)

        RequestModel(hash)
        while not HasModelLoaded(hash) do
        Wait(1)
        end

        RequestAnimDict(Config.Ped.animation.anim)
        while not HasAnimDictLoaded(Config.Ped.animation.anim) do
        Wait(1)
        end

        local ped = CreatePed(4, hash, Config.Coords.x, Config.Coords.y, Config.Coords.z-1, Config.Coords.h, false, true)
        SetEntityHeading(ped, Config.Coords.h)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped,Config.Ped.animation.anim,Config.Ped.animation.dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    else
        DeleteEntity(ped)
        if DoesEntityExist(ped) then
            ClearPedTasksImmediately(ped)
            DeleteEntity(ped)
        end
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pedc = GetEntityCoords(ped)
        if #(pedc - vec3(Config.Coords.x, Config.Coords.y, Config.Coords.z)) < 3 and not isopen then
            sleep = 0
            ESX.ShowFloatingHelpNotification(Config.Labels.Press, vector3(Config.Coords.x, Config.Coords.y, Config.Coords.z))
            if IsControlPressed(0, 38) then
                openmenu()
                isopen = true
            end
        end
        Wait(sleep)
    end
end)

function openmenu()
    isopen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'showInterface',
        creator = Config.EnableCreatorCode,
        svname = Config.Labels.ServerName,
    })
end

RegisterNUICallback('closew', function(data, cb)
    isopen = false
	SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('initialreward', function (data, cb)
    ESX.TriggerServerCallback('fo4r_welcome:checkreward', function(pos)
        if pos == 0 then
            SendNUIMessage({
                action = 'checkreward',
                posible = true,
            })
            TriggerServerEvent('fo4r_welcome:addreward')
        else
            SendNUIMessage({
                action = 'checkreward',
                posible = false,
            })
        end
    end)
end)

RegisterNUICallback('checkcreatorcode', function (data, cb)
    ESX.TriggerServerCallback('fo4r_welcome:checkcreatorcode', function(pos)
        if pos == 0 then
            SendNUIMessage({
                action = 'checkcreatorcode',
                posiblec = true,
            })
        else
            SendNUIMessage({
                action = 'checkcreatorcode',
                posiblec = false,
            })
        end
    end)
end)

RegisterNUICallback('creatorcode', function(data, cb)
	if data.valor ~= "" then
		for k, v in ipairs(Config.CreatorCodes) do
			if data.valor == v then
				TriggerServerEvent('fo4r_welcome:creatorrewards', data.valor)
			end
		end
	else
		ESX.ShowNotification("El codigo no es valido")
	end
end)

RegisterNetEvent('fo4r_welcome:registerownercar')
AddEventHandler('fo4r_welcome:registerownercar', function(name)
	ESX.Game.SpawnVehicle(name, vec3(Config.FirstReward.CarCoordsSpawn.x, Config.FirstReward.CarCoordsSpawn.y, Config.FirstReward.CarCoordsSpawn.z), Config.FirstReward.CarCoordsSpawn.h, function(car)
		TaskWarpPedIntoVehicle(PlayerPedId(),car, -1)
        SetVehicleNumberPlateText(car, plategenerator())
		TriggerServerEvent('fo4r_welcome:givecar', ESX.Game.GetVehicleProperties(car))
	end)
end)