--每日求签
--作者:安研色Shiki
--版本:v2.0
--内含指令:求签
--本文件仅供学习交流之用，灵签搬运自网络，不代表作者观念
msg_order = {}
index_deck = {
    [""] = "地藏王菩萨灵签",
    ["地藏王菩萨灵签"] = "地藏王菩萨灵签",
    ["地藏王菩萨"] = "地藏王菩萨灵签",
    ["地藏王"] = "地藏王菩萨灵签",
    ["月老灵签"] = "月老灵签",
    ["月老"] = "月老灵签",
    ["浅草寺观音签"] = "浅草寺观音签",
    ["浅草寺"] = "浅草寺观音签",
    ["城隍爷"] = "城隍爷灵签",
    ["财神"] = "财神爷灵签",
    ["财神爷"] = "财神爷灵签",
    ["财神爷灵签"] = "财神爷灵签",
    ["城隍爷灵签"] = "城隍爷灵签",
}

function draw_today(msg)
    local deck_key = string.match(msg.fromQQ,"^[%s]*([^%s]*)[%s]*(.-)$",#("求签")+1) or "月老"
    local deck_name = index_deck[deck_key]
    if(not deck_name)then
        return "{self}不知道{nick}要求签的"..deck_key.."呢……"
    end
    local target = loadLua("求签/"..deck_name)
    if(not target)then
        return "咦……{self}"..deck_name.."的签好像找不到了……"
    end
    --内置求签函数
    if(target.getDraw)then
        return target.getDraw(msg)
    end
    local draw_index = getUserToday(msg.fromQQ,"Draw_"..deck_name)
    if(draw_index > 0 and target.main[draw_index])then
        return "{self}今日为{nick}抽取的"..deck_name.."是——\n"..target.main[draw_index]
    end
    draw_index = ranint(1,#target.main)
    setUserToday(msg.fromQQ,"Draw_"..deck_name,draw_index)
    return "{self}为{nick}抽取今日的"..deck_name.."：\n"..target.main[draw_index]
end
msg_order["求签"] = "draw_today"