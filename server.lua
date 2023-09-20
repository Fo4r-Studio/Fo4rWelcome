ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('fo4r_welcome:addreward')
AddEventHandler('fo4r_welcome:addreward', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.FirstReward.items then
        for _, item in pairs(Config.FirstReward.items) do
            xPlayer.addInventoryItem(item.item, item.count)
        end
    end

    if Config.FirstReward.money then
        for _, money in pairs(Config.FirstReward.money) do
            xPlayer.addAccountMoney(money.account, money.count)
        end
    end

    if Config.FirstReward.Carname then
        giveVehicle(source, xPlayer.identifier, Config.FirstReward.Carname)
    end

    for k , v in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(v , 'discord:') then
            discordID = "<@" .. string.sub(v,9,string.len(v)) .. ">"    
        elseif string.match(v , 'steam:') then
            steamhex = v
        end
    end
    sendDiscordLog(15086124, 'Welcome Reward',  'USER: ['..source..']'..GetPlayerName(source)..'\n'..'Discord: '..discordID..'\n'..'Identifier: '..xPlayer.identifier..'\n'..'**'..Config.Labels.Webhook1..'**', "Fo4r Studios")
    removereward(xPlayer.identifier)
end)

RegisterServerEvent('fo4r_welcome:creatorrewards')
AddEventHandler('fo4r_welcome:creatorrewards', function(code, data)
    local xPlayer = ESX.GetPlayerFromId(source)

    if data.items then
        for _, item in pairs(data.items) do
            xPlayer.addInventoryItem(item.item, item.count)
        end
    end

    if data.money then
        for _, money in pairs(data.money) do
            xPlayer.addAccountMoney(money.account, money.count)
        end
    end

    if data.Carname then
        giveVehicle(source, xPlayer.identifier, data.Carname)
    end

    for k , v in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(v , 'discord:') then
            discordID = "<@" .. string.sub(v,9,string.len(v)) .. ">"    
        elseif string.match(v , 'steam:') then
            steamhex = v
        end
    end
    sendDiscordLog(3093151, 'Creator Code',  'USER: ['..source..']'..GetPlayerName(source)..'\n'..'Discord: '..discordID..'\n'..'Identifier: '..xPlayer.identifier..'\n'..Config.Labels.Webhook2..'**'..code..'**', "Fo4r Studios")
    removecodcreator(xPlayer.identifier)
end)

RegisterServerEvent('fo4r_welcome:givecar', function(data)
	local xPlayer <const> = ESX.GetPlayerFromId(source)
	exports.oxmysql:query('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = data.plate,
		['@vehicle'] = json.encode(data)
	}, function() end)
	xPlayer.showNotification(Config.Labels.WelcomeMessage)
end)

function removereward(identifier)
    local result = exports.oxmysql:query("UPDATE users SET reward = 1 WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
end

function removecodcreator(identifier)
    local result = exports.oxmysql:query("UPDATE users SET cod_creator = 1 WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
end

function giveVehicle(_source, owner, vehicleName)
    TriggerClientEvent('fo4r_welcome:registerownercar', _source, vehicleName)
end

ESX.RegisterServerCallback('fo4r_welcome:checkreward', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    exports.oxmysql:scalar('SELECT `reward` FROM `users` WHERE `identifier` = ?', {
        identifier
    }, function(reward)
        cb(reward)
    end)
end)

ESX.RegisterServerCallback('fo4r_welcome:checkcreatorcode', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    exports.oxmysql:scalar('SELECT `cod_creator` FROM `users` WHERE `identifier` = ?', {
        identifier
    }, function(cod_creator)
        cb(cod_creator)
    end)
end)

function sendDiscordLog(color, name, message, footer)
    local embed = {
        {
            ['color']       = color,
            ['title']       = '**'..name..'**',
            ['description'] = message,
            ['footer']      = {
                ['text']    = footer,
            },
        }
    }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end