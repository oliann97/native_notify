local notificationTypes = {
    ["success"] = {
        icon = 1,
        flash = false
    },
    ["error"] = {
        icon = 2,
        flash = true
    },
    ["info"] = {
        icon = 3,
        flash = false
    },
    ["warning"] = {
        icon = 4,
        flash = true
    },
    ["police"] = {
        icon = 5,
        flash = true
    },
    ["phone"] = {
        icon = 6,
        flash = false
    }
}

RegisterNetEvent('native_notify:showNotification')
AddEventHandler('native_notify:showNotification', function(data)
    ShowNotification(data)
end)

RegisterNetEvent('native_notify:showNotificationToPlayer')
AddEventHandler('native_notify:showNotificationToPlayer', function(playerId, data)
    if not playerId or playerId == GetPlayerServerId(PlayerId()) then
        ShowNotification(data)
    end
end)

function ShowNotification(data)
    if not data.message then
        return
    end
    
    local type = data.type or 'info'
    if not notificationTypes[type] then
        type = 'info'
    end
    
    local icon = data.icon or notificationTypes[type].icon
    local flash = data.flash or notificationTypes[type].flash
    local title = data.title or ''
    local subtitle = data.subtitle or ''
    local duration = data.duration or 5000
    
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(data.message)
    
    local notificationId
    if data.picture then
        notificationId = DrawNotificationWithPicture(data.picture, data.title, data.subtitle)
    elseif title ~= '' then
        SetNotificationMessage('CHAR_DEFAULT', 'CHAR_DEFAULT', flash, icon, title, subtitle)
        notificationId = DrawNotification(false, true)
    else
        notificationId = DrawNotification(false, flash)
    end
    
    Citizen.SetTimeout(duration, function()
        RemoveNotification(notificationId)
    end)
    
    return notificationId
end

function DrawNotificationWithPicture(picture, title, subtitle)
    local txd = "CHAR_BLANK_ENTRY"
    
    if picture == "CHAR_ALL_PLAYERS_CONF" or
       picture == "CHAR_AMMUNATION" or
       picture == "CHAR_BANK_BOL" or
       picture == "CHAR_BANK_FLEECA" or
       picture == "CHAR_BANK_MAZE" or
       picture == "CHAR_BUGSTARS" or
       picture == "CHAR_CALL911" or
       picture == "CHAR_CHAT_CALL" or
       picture == "CHAR_CHEF" or
       picture == "CHAR_CHOP" or
       picture == "CHAR_CREDIT_INFO" or
       picture == "CHAR_DEFAULT" or
       picture == "CHAR_DETONATEPHONE" or
       picture == "CHAR_FILMNOIR" or
       picture == "CHAR_LIFEINVADER" or
       picture == "CHAR_LS_CUSTOMS" or
       picture == "CHAR_LS_TOURIST_BOARD" or
       picture == "CHAR_LESTER" or
       picture == "CHAR_LESTER_DEATHWISH" or
       picture == "CHAR_MARTIN" or
       picture == "CHAR_MECHANIC" or
       picture == "CHAR_MICHAEL" or
       picture == "CHAR_MP_ARMY_CONTACT" or
       picture == "CHAR_MP_BRUCIE" or
       picture == "CHAR_MP_FIB_CONTACT" or
       picture == "CHAR_MP_FM_CONTACT" or
       picture == "CHAR_MP_GERALD" or
       picture == "CHAR_MP_JULIO" or
       picture == "CHAR_MP_MECHANIC" or
       picture == "CHAR_MP_MERRYWEATHER" or
       picture == "CHAR_MP_MEX_BOSS" or
       picture == "CHAR_MP_MEX_DOCKS" or
       picture == "CHAR_MP_MEX_LT" or
       picture == "CHAR_MP_MORS_MUTUAL" or
       picture == "CHAR_MP_PROF_BOSS" or
       picture == "CHAR_MP_RAY_LAVOY" or
       picture == "CHAR_MP_ROBERTO" or
       picture == "CHAR_MP_SNITCH" or
       picture == "CHAR_MP_STRETCH" or
       picture == "CHAR_MP_STRIPCLUB_PR" or
       picture == "CHAR_RON" or
       picture == "CHAR_SIMEON" or
       picture == "CHAR_SOCIAL_CLUB" or
       picture == "CHAR_STEVE" or
       picture == "CHAR_STEVE_MIKE_CONF" or
       picture == "CHAR_STEVE_TREV_CONF" or
       picture == "CHAR_TAXI" or
       picture == "CHAR_TREVOR" or
       picture == "CHAR_WADE" then
        txd = picture
    end
    
    if title and title ~= '' then
        subtitle = subtitle or ""
        return SetNotificationMessage(txd, txd, true, 1, title, subtitle)
    else
        return SetNotificationMessage(txd, txd, false, 1, GetLabelText("HUD_CASH_ITEM_STOLEN"), "")
    end
end

exports('ShowNotification', ShowNotification)

RegisterCommand('testnotify', function(source, args, rawCommand)
    local type = args[1] or 'info'
    local message = args[2] or '这是一条测试通知'
    local title = args[3] or ''
    
    ShowNotification({
        type = type,
        message = message,
        title = title
    })
end)

RegisterCommand('testpicnotify', function(source, args, rawCommand)
    local picture = args[1] or 'CHAR_LESTER'
    local message = args[2] or '这是一条带图片的测试通知'
    local title = args[3] or '通知标题'
    local subtitle = args[4] or ''
    
    ShowNotification({
        picture = picture,
        message = message,
        title = title,
        subtitle = subtitle
    })
end)

RegisterCommand('testnotifyy', function(source, args, rawCommand)
    ShowNotification({
        picture = 'CHAR_LS_TOURIST_BOARD',
        message = '我们绝不容忍在公共交通工具上的恐怖行为！',
        title = '洛圣都交通',
        subtitle = '旅游信息'
    })
end) 