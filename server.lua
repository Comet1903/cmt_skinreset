--TODO: Discord Logs

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("skin", function(source, args)
    if tonumber(args[1]) == source or args[1] == nil then
        TriggerClientEvent("esx:showNotification", source, "Du hast einen Skinreset von " .. GetPlayerName(source) .. " bekommen!", "RZR | Support")
        TriggerClientEvent('esx_skin:openSaveableMenu', source)

    elseif tonumber(args[1]) ~= source then
        TriggerClientEvent("esx:showNotification", source, "Du gibst " .. GetPlayerName(args[1]) .. " einen Skinreset!", "RZR | Support")
        TriggerClientEvent("esx:showNotification", args[1], "Du hast einen Skinreset von " .. GetPlayerName(source) .. " bekommen!", "RZR | Support")

        TriggerClientEvent('esx_skin:openSaveableMenu', args[1])
    else
        TriggerClientEvent("esx:showNotification", source, "Kein Spieler gefunden", "RZR | Skinreset")
    end
end, true)


ESX.RegisterServerCallback('cmt_skinreset:canResetSkin', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= Config.price then
        xPlayer.removeMoney(Config.price)
        cb(true)
    else
        cb(false)
    end
end)    
