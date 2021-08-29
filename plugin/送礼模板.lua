--送礼样例脚本
--使用《署名—非商业性使用—相同方式共享 4.0 协议国际版》（CC BY-NC-SA 4.0）进行授权https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode.zh-Hans
--版本低于2.5.1(577)的用户请手动定义selfName = "xxx"(xxx是骰娘称呼)
--作者:安研色Shiki
selfName = getUserConf(getDiceQQ(), "nick", "你") 
favor_title = "好感度"

selfName = "大帅"

rcv_gift_order = "送"..selfName
daily_gift_limit = 3   --单日次数上限
gift_favor_limit = 100 --送礼能达到的好感上限
known_gift_favor = 0 --名单外礼物能提供的好感

gift_list = {   --特殊对待的礼物名
    ["肖战"] = {
        refuse = true, --是否拒收
        favor = -10,  --好感变化
        reply = "谁要这玩意儿啊！你自己留着吧！\f*{self}一把把那玩意儿糊到了{nick}脸上*",
    },
    ["青楼消费券"] = {
        refuse = false, --是否拒收
        favor = 3,  --好感变化
        reply = "嘿嘿，{nick}，好东西啊～和警卫说老子今晚不回家了~",
    },
    ["丁真"] = {
        refuse = true, --是否拒收
        favor = -10,  --好感变化
        reply = "老子平生最看不惯西康人！\f*{self}一把把纯真糊到了{nick}脸上*",
    },
}

function rcv_gift(msg)
    local today_gift = getUserToday(msg.fromQQ,"rcv_gifts")
    if(today_gift >= daily_gift_limit)then
        return "够啦～{nick}送再多礼老子也不会给你升官的"
    end
    setUserToday(msg.fromQQ, "rcv_gifts", today_gift+1)
    local gift = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#rcv_gift_order+1)
    if(gift=="")then
        return "来了？{nick}要送{self}什么？"
    end
    local me = getDiceQQ()
    local self_today_gift = getUserToday(me, "gifts")
    local favor = getUserConf(msg.fromQQ, favor_title, 0)
    local react = gift_list[gift]
    if(react)then
        local add_favor = react.favor or 1
        if(react.favor<0)then
            setUserConf(msg.fromQQ, favor_title, favor + add_favor)
        elseif(ranint(1,gift_favor_limit)>favor)then
            setUserConf(msg.fromQQ, favor_title, math.min(gift_favor_limit,favor + add_favor))
        end
        if(react.refuse)then
            return react.reply
        end
        setUserToday(me, "gifts", self_today_gift+1)
        return react.reply.."\n今日收礼:"..string.format("%d",self_today_gift).."件"
    end
    --local self_total_gift = getUserConf(me, "gifts", 0)+1
    --setUserConf(me, "gifts", self_total_gift)
    if(known_gift_favor > 0 and ranint(1,gift_favor_limit)>favor)then setUserConf(msg.fromQQ, favor_title, favor + known_gift_favor) end
    setUserToday(me, "gifts", self_today_gift+1)
    return "谢谢{nick}送的"..gift.."~\n今日收礼:"..string.format("%d",self_today_gift).."件"
end

msg_order = {
    [rcv_gift_order] = "rcv_gift"
}