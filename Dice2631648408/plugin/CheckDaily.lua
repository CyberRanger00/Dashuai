msg_order = {}

function checkDaily(msg)
    local deck_key = string.match(msg.fromMsg, "^[%s]*([^%s]*)[%s]*([^%s]*)(.-)$", #("打卡") + 1) or "摸鱼"
    if (deck_key == "") then
        deck_key = "摸鱼"
    end
    local userTotalCheck = getUserConf(msg.fromQQ, "总打卡次数", 0)
    local userComboCheck = getUserConf(msg.fromQQ, "连续打卡", 0)
    local userCheckOne = getUserConf(msg.fromQQ, "打卡时间", 0)
    local userTargerCheck = getUserConf(msg.fromQQ, deck_key, 0)
    local date = os.date("%H%M");
    local discount = date - userCheckOne

    -- 限制今日打卡次数为3
    local ding_limit = 3
    local today_ding = getUserToday(msg.fromQQ,"dingtimes",0)
    if (today_ding >= ding_limit) then
        return "{nick}今日已经来司令部报到过{nick}的" .. deck_key .. "行为了"
    end
    today_ding = today_ding + 1
    setUserToday(msg.fromQQ, "dingtimes", today_ding)

    if (userTotalCheck == 0) then
        -- 第一次打卡者的特殊处理
        setUserConf(msg.fromQQ, "打卡时间", date)
        setUserConf(msg.fromQQ, "连续打卡", getUserConf(msg.fromQQ, "连续打卡", 0) + 1)
        setUserConf(msg.fromQQ, "总打卡次数", getUserConf(msg.fromQQ, "总打卡次数", 0) + 1)
        setUserConf(msg.fromQQ, deck_key, getUserConf(msg.fromQQ, deck_key, 0) + 1)
        local userTotalCheck = getUserConf(msg.fromQQ, "总打卡次数", 0)
        local userComboCheck = getUserConf(msg.fromQQ, "连续打卡", 0)
        local userTargerCheck = getUserConf(msg.fromQQ, deck_key, 0)
        return "我已经吩咐文书给{nick}记录了\n你已经连续 " .. deck_key .. userTargerCheck ..
                   " 天了\n这是{nick}第" .. userTotalCheck ..
                   "天报到\n明天也要记得来司令部打招呼啊\n哦对了，这是你连续报到的第" ..
                   userComboCheck .. "天，再接再厉！"

    else
        if (discount < 0) then
            -- 连续打卡中断
            setUserConf(msg.fromQQ, "打卡时间", date)
            setUserConf(msg.fromQQ, "连续打卡", 1)
            setUserConf(msg.fromQQ, "总打卡次数", getUserConf(msg.fromQQ, "总打卡次数", 0) + 1)
            setUserConf(msg.fromQQ, deck_key, getUserConf(msg.fromQQ, deck_key, 0) + 1)
            local userTotalCheck = getUserConf(msg.fromQQ, "总打卡次数", 0)
            local userComboCheck = getUserConf(msg.fromQQ, "连续打卡", 0)
            local userTargerCheck = getUserConf(msg.fromQQ, deck_key, 0)
            return
                "前几天没看到你来啊......算啦\n我已经吩咐文书给{nick}记录了\n你已经连续 " ..
                    deck_key .. userTargerCheck .. " 天了\n这是{nick}第" .. userTotalCheck ..
                    "天报到\n明天也要记得来司令部打招呼啊\n哦对了，这是你连续报到的第" ..
                    userComboCheck .. "天，再接再厉！"

            -- 正常连续打卡的情况
        else 
            if(today_ding < 1)then
                setUserConf(msg.fromQQ, "打卡时间", date)
                setUserConf(msg.fromQQ, "连续打卡", getUserConf(msg.fromQQ, "连续打卡", 0) + 1)
                setUserConf(msg.fromQQ, "总打卡次数", getUserConf(msg.fromQQ, "总打卡次数", 0) + 1)
                setUserConf(msg.fromQQ, deck_key, getUserConf(msg.fromQQ, deck_key, 0) + 1)
                local userTotalCheck = getUserConf(msg.fromQQ, "总打卡次数", 0)
                local userComboCheck = getUserConf(msg.fromQQ, "连续打卡", 0)
                local userTargerCheck = getUserConf(msg.fromQQ, deck_key, 0)
                return "我已经吩咐文书给{nick}记录了\n你已经连续 " .. deck_key .. userTargerCheck ..
                           " 天了\n这是{nick}第" .. userTotalCheck ..
                           "天报到\n明天也要记得来司令部打招呼啊\n哦对了，这是你连续报到的第" ..
                           userComboCheck .. "天，再接再厉！"
            end
            end
        end

        if (today_ding > 1) then
            setUserConf(msg.fromQQ, deck_key, getUserConf(msg.fromQQ, deck_key, 0) + 1)
            local userTargerCheck = getUserConf(msg.fromQQ, deck_key, 0)
            return "我记得你今天来报到过了啊......哦,是为了来报告" .. deck_key ..
                       "行为吗，记下了\n这是你累计第" .. userTargerCheck .. "次" .. deck_key
        end

    
end

msg_order["打卡"] = "checkDaily"

-- 以下为查询打卡信息
function dingdata(msg)
    local deck_key = string.match(msg.fromMsg, "^[%s]*([^%s]*)[%s]*(.-)$", #("打卡状态") + 1) or "摸鱼"

    if (deck_key == "") then
        deck_key = "摸鱼"
    end
    local userTargerCheck = getUserConf(msg.fromQQ, deck_key, 0)
    local userTotalCheck = getUserConf(msg.fromQQ, "总打卡次数", 0)
    local userComboCheck = getUserConf(msg.fromQQ, "连续打卡", 0)
    local userCheckOne = getUserConf(msg.fromQQ, "打卡时间", 0)
    return "{nick}\n已经累计打卡" .. userTotalCheck .. "天，\n连续打卡" .. userComboCheck ..
               "天了哦~ \n{nick}累计" .. deck_key .. "的次数是" .. userTargerCheck 

end

msg_order["打卡状态"] = "dingdata"
