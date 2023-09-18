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

    local ped = CreatePed(4, hash, Config.Coords.x, Config.Coords.y, Config.Coords.z, Config.Coords.h, false, true)
    SetEntityHeading(ped, pos.h)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,Config.Ped.animation.anim,Config.Ped.animation.dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
end)

