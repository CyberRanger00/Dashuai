--.Ding打卡脚本~给你的骰娘装上这个，就可以实现每日打卡功能了！
--.Ding打卡 .DingData查看打卡数据
--作者 MSCxar0293
--版本 v1.0
--更新日期 20210711

msg_order = {}

function checkDaily(msg)
local deck_key,deck_key2,deck_key3 = string.match(msg.fromQQ,"^[%s]*([^%s]*)[%s]*([^%s]*)(.-)$",#("打卡")+1) or "摸鱼"

if(deck_key)then
  print(msg.fromQQ)
  print(deck_key,deck_key2,deck_key3)
end

local userTotalCheck = getUserConf(msg.fromQQ,"总打卡次数",0)
local userComboCheck = getUserConf(msg.fromQQ,"连续打卡",0)
local userCheckOne = getUserConf(msg.fromQQ,"打卡时间",0)
local userTargerCheck = getUserConf(msg.fromQQ,deck_key,0)
local date=os.date("%H%M");
local discount=date - userCheckOne

--限制今日打卡次数为1
local ding_limit = 100
local today_ding = getUserToday(msg.fromQQ,"dingtimes",0)
    if(today_ding>=ding_limit)then
        return "{nick}今日已经打卡过了"..deck_key
    end
    today_ding = today_ding + 1
    setUserToday(msg.fromQQ, "dingtimes", today_ding)

if(userTotalCheck == 0) then
--第一次打卡者的特殊处理
 setUserConf(msg.fromQQ, "打卡时间", date)
 setUserConf(msg.fromQQ, "连续打卡", getUserConf(msg.fromQQ, "连续打卡", 0)+1)
 setUserConf(msg.fromQQ, "总打卡次数", getUserConf(msg.fromQQ, "总打卡次数", 0)+1)
 setUserConf(msg.fromQQ, deck_key, getUserConf(msg.fromQQ, deck_key, 0)+1)
 local userTotalCheck = getUserConf(msg.fromQQ,"总打卡次数",0)
 local userComboCheck = getUserConf(msg.fromQQ,"连续打卡",0)
 
    return "叮~\n{nick}\n您已累计打卡"..userTotalCheck.."天~\n连续打卡"..userComboCheck.."天~\n明天也不要忘了打卡哟~"..deck_key

 else if(discount < 0)then
--连续打卡中断
  setUserConf(msg.fromQQ, "打卡时间", date)
  setUserConf(msg.fromQQ, "连续打卡", 1)
  setUserConf(msg.fromQQ, "总打卡次数", getUserConf(msg.fromQQ, "总打卡次数", 0)+1)
  setUserConf(msg.fromQQ, deck_key, getUserConf(msg.fromQQ, deck_key, 0)+1)
  local userTotalCheck = getUserConf(msg.fromQQ,"总打卡次数",0)
 local userComboCheck = getUserConf(msg.fromQQ,"连续打卡",0)
    return "叮~\n{nick}今日打卡成功~\n您已累计打卡"..userTotalCheck.."天~\n连续打卡"..userComboCheck.."天~\n明天也不要忘了打卡哟~"..deck_key

  else
--正常连续打卡的情况
   setUserConf(msg.fromQQ, "打卡时间", date)
   setUserConf(msg.fromQQ, "连续打卡", getUserConf(msg.fromQQ, "连续打卡", 0)+1)
   setUserConf(msg.fromQQ, "总打卡次数", getUserConf(msg.fromQQ, "总打卡次数", 0)+1)
   setUserConf(msg.fromQQ, deck_key, getUserConf(msg.fromQQ, deck_key, 0)+1)
   local userTotalCheck = getUserConf(msg.fromQQ,"总打卡次数",0)
   local userComboCheck = getUserConf(msg.fromQQ,"连续打卡",0)
   local userTargerCheck = getUserConf(msg.fromQQ,deck_key,0)
    return "叮~\n{nick}今日打卡成功~\n您已累计打卡"..userTotalCheck.."天~\n连续打卡"..userComboCheck.."天~\n明天也不要忘了打卡哟~"..deck_key

  end
 end
end

msg_order["打卡"] = "checkDaily"

--以下为查询打卡信息
function dingdata(msg)
local deck_key = string.match(msg.fromQQ,"^[%s]*([^%s]*)[%s]*(.-)$",#("打卡")+1) or "摸鱼"
local userTargerCheck = getUserConf(msg.fromQQ,deck_key,0)
local userTotalCheck = getUserConf(msg.fromQQ,"总打卡次数",0)
local userComboCheck = getUserConf(msg.fromQQ,"连续打卡",0)
local userCheckOne = getUserConf(msg.fromQQ,"打卡时间",0)
  return "{nick}\n已经累计打卡"..userTotalCheck.."天，\n连续打卡"..userComboCheck.."天了哦~"..userTargerCheck
end

msg_order["打卡状态"] = "dingdata"