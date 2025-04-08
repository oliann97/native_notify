# 原生通知系统 (Native Notify)

这是一个为FiveM服务器设计的原生通知系统，使用GTA5的原生通知功能，支持多种类型的通知、自定义图片和更多功能。

## 目录

- [特点](#特点)
- [安装](#安装)
- [使用方法](#使用方法)
  - [客户端使用示例](#客户端使用示例)
  - [服务器端使用示例](#服务器端使用示例)
  - [通知参数说明](#通知参数说明)
  - [可用的通知图片](#可用的通知图片)
- [聊天命令](#聊天命令)
- [高级功能](#高级功能)
  - [URL图片加载](#url图片加载)
  - [区域通知](#区域通知)
  - [自定义持续时间](#自定义持续时间)
- [常见问题](#常见问题)
- [注意事项](#注意事项)
- [许可证](#许可证)

## 特点

- 使用GTA5原生通知系统
- 支持多种通知类型: 成功、错误、信息、警告、警察、电话
- 支持带图标和带图片的通知
- 支持标题和副标题显示
- 支持使用URL自定义图片，加载您自己的图片
- 支持不同的闪烁效果
- 可以向所有玩家、特定玩家或特定区域玩家发送通知
- 包含客户端和服务器端API
- 支持通知自动消失和自定义显示时长
- 轻量级，对服务器性能影响小

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

-- 使用URL自定义图片的通知
exports['native_notify']:ShowNotification({
    url = 'https://r2.fivemanage.com/o0SQp9T24AoAbL1nduWW2/fivem.png',  -- 图片URL
    message = '这是一条使用自定义图片的通知',
    title = '自定义图片',
    subtitle = '从URL加载'
})

-- 例子
exports['native_notify']:ShowNotification({
    picture = 'CHAR_LS_TOURIST_BOARD',
    message = '我们绝不容忍在公共交通工具上的恐怖行为！',
    title = '洛圣都交通',
    subtitle = '旅游信息'
})

```
![通知示例](https://r2.fivemanage.com/o0SQp9T24AoAbL1nduWW2/native_notify.jpg)
![URL通知示例](https://r2.fivemanage.com/o0SQp9T24AoAbL1nduWW2/native_notify_url.png)
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

-- 发送带URL图片的通知（服务器端）
exports['native_notify']:SendNotificationToAll({
    url = 'https://r2.fivemanage.com/o0SQp9T24AoAbL1nduWW2/fivem.png',
    message = '这是一条来自服务器的图片通知',
    title = '服务器通知',
    subtitle = '重要事项'
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
| `url` | string | 自定义图片URL | 无 |
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
- `/testurlnotify [URL] [消息] [标题] [副标题]` - 测试带URL图片的通知 (客户端)
- `/servernotify [玩家ID] [类型] [消息] [标题] [副标题]` - 从服务器发送通知 (仅限管理员)

## 高级功能

### URL图片加载

您可以通过提供URL参数加载自定义图片：

```lua
exports['native_notify']:ShowNotification({
    url = 'https://r2.fivemanage.com/o0SQp9T24AoAbL1nduWW2/fivem.png',
    message = '这是一条带自定义图片的通知',
    title = '自定义图片',
    subtitle = '详细信息'
})
```

系统使用FiveM的DUI (DirectX UI) 系统来加载和显示URL图片，支持大多数常见图片格式。为了获得最佳效果，建议使用尺寸为512x512像素的正方形图片，这样能够确保图片完全填满通知区域且显示清晰。

### 区域通知

区域通知功能允许您只向特定区域内的玩家发送通知：

```lua
local coords = vector3(123.4, 567.8, 90.1)  -- 通知中心坐标
local radius = 50.0  -- 通知范围（单位：米）

exports['native_notify']:SendNotificationToArea(coords, radius, {
    type = 'warning',
    message = '附近发现可疑活动',
    title = '区域警告',
    subtitle = '请小心'
})
```

这对于创建位置相关的事件和通知非常有用，比如区域警报、天气警告或区域活动通知。

### 自定义持续时间

您可以自定义通知显示的时长（以毫秒为单位）：

```lua
exports['native_notify']:ShowNotification({
    type = 'info',
    message = '这条通知将显示10秒',
    duration = 10000  -- 10秒
})
```

## 常见问题

**问题**: URL图片不显示？  
**解答**: 确保URL直接指向图片文件，而不是网页。某些图片托管服务可能不允许跨域访问(CORS限制)，建议使用Imgur、fivemanage或其他支持跨域的图片托管服务。

**问题**: 如何在其他资源中使用这个通知系统？  
**解答**: 确保在您的server.cfg中正确加载了native_notify资源，然后在其他资源中使用exports调用通知函数：
```lua
exports['native_notify']:ShowNotification({
    message = '这是从其他资源发送的通知'
})
```

**问题**: 区域通知不工作？  
**解答**: 请确保坐标格式正确(vector3)，并且半径值合理。过大的半径可能导致性能问题。

## 注意事项

1. URL图片功能使用FiveM的DUI（DirectX UI）系统加载图片
2. 确保您的URL是直接指向图片的链接，而不是网页链接
3. 支持的图片格式包括：JPG、PNG、GIF等常见格式
4. 某些图片可能因为CORS（跨域资源共享）限制而无法加载
5. 图片尺寸建议使用512x512像素的正方形图片，这样能够确保图片完全填满通知区域
6. 如果URL图片加载失败，将使用默认图片
7. 为了资源优化，系统会在通知显示10秒后自动清理DUI资源
8. 通知持续时间太长可能会导致玩家屏幕上显示过多通知

## 许可证

MIT 

## 贡献

欢迎提交问题和改进建议。如有任何问题，请联系作者。 
