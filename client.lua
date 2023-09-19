<<<<<<< HEAD
ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
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
end) 

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pedc = GetEntityCoords(ped)
        if #(pedc - vec3(Config.Coords.x, Config.Coords.y, Config.Coords.z)) < 3 then
            sleep = 0
            ESX.ShowFloatingHelpNotification(Config.Labels.Press, vector3(Config.Coords.x, Config.Coords.y, Config.Coords.z))
            if IsControlPressed(0, 38) then
                openmenu()
            end
        end
        Wait(sleep)
    end
end)

function openmenu()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'showInterface',
        creator = Config.EnableCreatorCode,
    })
end

RegisterNUICallback('closew', function(data, cb)
	SetNuiFocus(false, false)
  cb('ok')
end)

RegisterNUICallback('initialreward', function (data, cd)
    
end)

RegisterNUICallback('creatorcode', function(data, cb)
	if data.valor ~= "" then
		for k, v in ipairs(Config.CreatorCodes) do
			if data.valor == v then
				print("1")
			end
		end
	else
		print("2")
	end
end)
=======
ESX = exports['es_extended']:getSharedObject()
>>>>>>> a210e692abe1659e62c3b4cba0df3327902e05be
