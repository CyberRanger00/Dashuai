
msg_order = {}
index_deck = {
    [""] = "打油诗",

    ["打油诗"] = "打油诗",

    ["写诗"] = "打油诗",

}

function Write_today(msg)
    local deck_key = string.match(msg.fromMsg,"^[%s]*([^%s]*)[%s]*(.-)$",#("写诗")+1) or "打油诗"
    local deck_name = index_deck[deck_key]
    if(not deck_name)then
        return "{self}不知道{nick}想要我写个啥"..deck_key
    end
    local target = loadLua("写诗/"..deck_name)
    if(not target)then
        return "啧……{self}的"..deck_name.."灵感没有了"
    end
    --内置求签函数s

    local draw_index = getUserToday(msg.fromQQ,"Draw_"..deck_name)
    if(draw_index > 0 and target.main[draw_index])then
        return "{self}今日赏脸给{nick}写的是——\n"..target.main[draw_index]
    end
    draw_index = ranint(1,17)
    setUserToday(msg.fromQQ,"Draw_"..deck_name,draw_index)
    return "{self}给{nick}赏脸，作诗如下！".."：\n"..target.main[draw_index]
end
msg_order["写诗"] = "Write_today"