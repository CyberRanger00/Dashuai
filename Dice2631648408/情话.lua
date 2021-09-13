---土味情话
---作者：000
---内涵指令：土味情话
---本文件仅供学习交流之用，情话搬运自网络，不代表作者观点
msg_order = {}
index_deck = {
    ["爱我"] = "情话",
    ["哄哄我"] = "情话",
    ["土味情话"] = "大帅情话",
    ["情话"] = "情话",
    ["大帅"] = "大帅"
}

function CheckInDeck(Info)
    for i, v in ipairs(index_deck ) do
        print("i".."v")
        if string.find(Info,v ) then
            print("1")
            return true
        end
    end
    print("12")
    return false
end


function SayingTheLove(msg)
    local DeckName = "情话"
     local KeyWord1,KeyWord2 = string.match(msg,"^[%s]*([^%s]*)[%s]*([^%s]*)[%s]*(.-)",0) 
     if( string.find(KeyWord1,"土味情话") or string.find(KeyWord2, "土味情话") ) then 
        local draw_index = ranint(1,#LovingWords.main)
        return "要{self}讲这个啊（挠头)......怪不好意思的......（清嗓子）:\n\n"..LovingWords.main[draw_index]
     end

    if( (string.find(KeyWord1,"大帅") or string.find(KeyWord2, "大帅")) and (CheckInDeck(KeyWord1) or CheckInDeck(KeyWord2)) ) then 
        local draw_index = ranint(1,#LovingWords.main)
        return "这个{self}擅长！听{self}说一段啊:\n"..LovingWords.main[draw_index]
        end

end

SayingTheLove("大帅情话")
msg_order["大"] = "SayingTheLove"