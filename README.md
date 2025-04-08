# 原生通知系统 (Native Notify)

这是一个为FiveM服务器设计的原生通知系统，使用GTA5的原生通知功能

## 特点

- 使用GTA5原生通知系统
- 支持多种通知类型: 成功、错误、信息、警告、警察、电话
- 支持带图标和带图片的通知
- 支持标题和副标题显示
- 可以向所有玩家、特定玩家或特定区域玩家发送通知
- 包含客户端和服务器端API
- 支持通知自动消失

## 安装

1. 将此资源放置在服务器的`resources`目录下
2. 将以下行添加到`server.cfg`中:
```
ensure native_notify
```

## 使用方法

### 客户端使用示例

```lua
-- 简单通知
exports['native_notify']:ShowNotification({
    type = 'info',  -- 可选值: success, error, info, warning, police, phone
    message = '这是一条通知消息',
    duration = 5000  -- 可选，默认5000毫秒
})

-- 带标题的通知
exports['native_notify']:ShowNotification({
    type = 'warning',
    message = '这是一条带标题的通知',
    title = '警告标题'
})

-- 带标题和副标题的通知
exports['native_notify']:ShowNotification({
    type = 'error',
    message = '这是一条带标题和副标题的通知',
    title = '错误提示',
    subtitle = '额外信息'
})

-- 带图片的通知
exports['native_notify']:ShowNotification({
    picture = 'CHAR_LESTER',  -- 使用游戏内预设图片
    message = '这是一条带图片的通知',
    title = '莱斯特',  -- 可选标题
    subtitle = '任务信息'  -- 可选副标题
})

-- 例子
exports['native_notify']:ShowNotification({
    picture = 'CHAR_LS_TOURIST_BOARD',
    message = '我们绝不容忍在公共交通工具上的恐怖行为！',
    title = '洛圣都交通',
    subtitle = '旅游信息'
})

![通知示例](https://r2.fivemanage.com/o0SQp9T24AoAbL1nduWW2/native_notify.jpg)
```

### 服务器端使用示例

```lua
-- 向所有玩家发送通知
exports['native_notify']:SendNotificationToAll({
    type = 'success',
    message = '这是发送给所有玩家的通知',
    title = '系统通知',
    subtitle = '重要信息'
})

-- 向特定玩家发送通知
exports['native_notify']:SendNotificationToPlayer(playerId, {
    type = 'error',
    message = '这是发送给特定玩家的通知',
    title = '错误',
    subtitle = '请注意'
})

-- 向特定区域的玩家发送通知
local coords = vector3(123.4, 567.8, 90.1)
local radius = 50.0
exports['native_notify']:SendNotificationToArea(coords, radius, {
    type = 'warning',
    message = '这是发送给区域内玩家的通知',
    title = '区域警告',
    subtitle = '安全提示'
})
```

### 通知参数说明

| 参数 | 类型 | 描述 | 默认值 |
| --- | --- | --- | --- |
| `type` | string | 通知类型 | 'info' |
| `message` | string | 通知内容 | 必填 |
| `title` | string | 通知标题 | '' |
| `subtitle` | string | 通知副标题 | '' |
| `duration` | number | 显示时长(毫秒) | 5000 |
| `picture` | string | 通知图片名称 | 无 |
| `flash` | boolean | 是否闪烁 | 根据类型不同 |

### 可用的通知图片

- CHAR_ALL_PLAYERS_CONF
- CHAR_AMMUNATION
- CHAR_BANK_BOL
- CHAR_BANK_FLEECA
- CHAR_BANK_MAZE
- CHAR_BUGSTARS
- CHAR_CALL911
- CHAR_CHAT_CALL
- CHAR_CHEF
- CHAR_CHOP
- CHAR_CREDIT_INFO
- CHAR_DEFAULT
- CHAR_DETONATEPHONE
- CHAR_FILMNOIR
- CHAR_LIFEINVADER
- CHAR_LS_CUSTOMS
- CHAR_LS_TOURIST_BOARD
- CHAR_LESTER
- CHAR_LESTER_DEATHWISH
- CHAR_MARTIN
- CHAR_MECHANIC
- CHAR_MICHAEL
- 以及更多游戏内预设图片

## 聊天命令

- `/testnotify [类型] [消息] [标题]` - 测试不同类型的通知 (客户端)
- `/testpicnotify [图片] [消息] [标题] [副标题]` - 测试带图片的通知 (客户端)
- `/testnotifyy` - 测试Los Santos Transit通知 (客户端，复制图片中的样式)
- `/servernotify [玩家ID] [类型] [消息] [标题] [副标题]` - 从服务器发送通知 (仅限管理员)

## 许可证

MIT 
