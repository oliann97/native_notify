function SendNotificationToAll(data)
    TriggerClientEvent('native_notify:showNotification', -1, data)
end

function SendNotificationToPlayer(playerId, data)
    TriggerClientEvent('native_notify:showNotification', playerId, data)
end

function SendNotificationToArea(coords, radius, data)
    for _, playerId in ipairs(GetAllPlayers()) do
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)
        
        if #(playerCoords - coords) <= radius then
            TriggerClientEvent('native_notify:showNotification', playerId, data)
        end
    end
end

function GetAllPlayers()
    local players = {}
    
    for i = 0, 255 do
        if GetPlayerName(i) ~= "" then
            table.insert(players, i)
        end
    end
    
    return players
end

exports('SendNotificationToAll', SendNotificationToAll)
exports('SendNotificationToPlayer', SendNotificationToPlayer)
exports('SendNotificationToArea', SendNotificationToArea)

RegisterCommand('servernotify', function(source, args, rawCommand)
    local playerId = tonumber(args[1])
    local type = args[2] or 'info'
    local message = args[3] or '这是一条服务器通知'
    local title = args[4] or ''
    local subtitle = args[5] or ''
    
    if not playerId or playerId == 0 then
        SendNotificationToAll({
            type = type,
            message = message,
            title = title,
            subtitle = subtitle
        })
    else
        SendNotificationToPlayer(playerId, {
            type = type,
            message = message,
            title = title,
            subtitle = subtitle
        })
    end
end, true)
