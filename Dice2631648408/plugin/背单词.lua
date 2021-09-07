msg_order = {}

function wordsInfo(msg)
    return
        "想学洋文了？~\n 发送抽取三个单词/抽取五个单词/抽取十个单词来看看自己单词记得咋样吧~"
end

msg_order["背单词"] = "wordsInfo"

function DrawWords3(msg)
    local words = loadLua("背单词/托福词汇")
    if (not words) then
        return "老子不会。"
    end
    local Draw_index1 = ranint(1, #words.main)
    local Draw_index2 = ranint(1, #words.main)
    local Draw_index3 = ranint(1, #words.main)
    return "{self}给{nick}抽取的单词有:\n" ..words.main[Draw_index1] .."\n".. words.main[Draw_index2] .."\n".. words.main[Draw_index3].."\n记不得了？啧，回复“查询词义 + 单词”可以找到具体的词义"
end
msg_order["抽取三个单词"] = "DrawWords3"

function DrawWords5(msg)
    local words = loadLua("背单词/托福词汇")
    if (not words) then
        return "老子不会。"
    end
    local Draw_index1 = ranint(1, #words.main)
    local Draw_index2 = ranint(1, #words.main)
    local Draw_index3 = ranint(1, #words.main)
    local Draw_index4 = ranint(1, #words.main)
    local Draw_index5 = ranint(1, #words.main)
    return "{self}给{nick}抽取的单词有:\n" ..words.main[Draw_index1] .."\n".. words.main[Draw_index2] .."\n".. words.main[Draw_index3].."\n"..words.main[Draw_index4].."\n"..words.main[Draw_index5].."\n记不得了？啧，回复“查询词义 + 单词”可以找到具体的词义"
end

msg_order["抽取五个单词"] = "DrawWords5"

function DrawWords10(msg)
    local words = loadLua("背单词/托福词汇")
    if (not words) then
        return "老子不会。"
    end
    local Draw_index1 = ranint(1, #words.main)
    local Draw_index2 = ranint(1, #words.main)
    local Draw_index3 = ranint(1, #words.main)
    local Draw_index4 = ranint(1, #words.main)
    local Draw_index5 = ranint(1, #words.main)
    local Draw_index6 = ranint(1, #words.main)
    local Draw_index7 = ranint(1, #words.main)
    local Draw_index8 = ranint(1, #words.main)
    local Draw_index9 = ranint(1, #words.main)
    local Draw_index10 = ranint(1, #words.main)
    return "{self}给{nick}抽取的单词有:\n" ..words.main[Draw_index1] .."\n".. words.main[Draw_index2] .."\n".. words.main[Draw_index3].."\n"..words.main[Draw_index4].."\n"..words.main[Draw_index5].."\n"..words.main[Draw_index6] .."\n".. words.main[Draw_index7] .."\n".. words.main[Draw_index8].."\n"..words.main[Draw_index9].."\n"..words.main[Draw_index10].."\n记不得了？啧，回复“查询词义 + 单词”可以找到具体的词义"
end
msg_order["抽取十个单词"] = "DrawWords10"

function IDK(msg)
	local key = string.match(msg.fromMsg,"^[%s]*([^%s]*)[%s]*(.-)$",#("查询词义")+1) or ""
    return "点击查询：https://translate.google.cn/?sl=en&tl=zh-CN&text="..key.."&op=translate"
end

msg_order["查询词义"] = "IDK"
