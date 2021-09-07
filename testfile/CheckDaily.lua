--.Ding打卡脚本~给你的骰娘装上这个，就可以实现每日打卡功能了！
--.Ding打卡 .DingData查看打卡数据
--作者 MSCxar0293
--版本 v1.0
--更新日期 20210711

msg_order = {}

function Target(msg)
  local deck_key = string.match(msg,"^[%s]*([^%s]*)[%s]*(.-)$",#("打卡")+1) or "摸鱼"
  print(deck_key)
end

function checkDaily(msg)
local userTotalCheck = getUserConf(msg,"总打卡次数",0)
local userComboCheck = getUserConf(msg,"连续打卡",0)
local userCheckOne = getUserConf(msg,"打卡时间",0)
local date=os.date("%H%M");
local discount=date - userCheckOne

--限制今日打卡次数为1
local ding_limit = 1
local today_ding = getUserToday(msg,"dingtimes",0)
    if(today_ding>=ding_limit)then
        return "{nick}今天已经到司令部报过到了~"
    end
    today_ding = today_ding + 1
    setUserToday(msg, "dingtimes", today_ding)

if(userTotalCheck == 0) then
--第一次打卡者的特殊处理
 setUserConf(msg, "打卡时间", date)
 setUserConf(msg, "连续打卡", getUserConf(msg, "连续打卡", 0)+1)
 setUserConf(msg, "总打卡次数", getUserConf(msg, "总打卡次数", 0)+1)
 local userTotalCheck = getUserConf(msg,"总打卡次数",0)
 local userComboCheck = getUserConf(msg,"连续打卡",0)
 local userTargetCheck = getUserConf(msg,deck_key,0)
    return "叮~\n{nick}今日打卡成功\n你已累计打卡"..userTotalCheck.."天~\n连续打卡"..userComboCheck.."天~\n明天也记得按时报到。"..userTargetCheck

 else if(discount < 0)then
--连续打卡中断
  setUserConf(msg, "打卡时间", date)
  setUserConf(msg, "连续打卡", 1)
  setUserConf(msg, "总打卡次数", getUserConf(msg, "总打卡次数", 0)+1)
  local userTotalCheck = getUserConf(msg,"总打卡次数",0)
  local userComboCheck = getUserConf(msg,"连续打卡",0)
  local userTargetCheck = getUserConf(msg,deck_key,0)
    return "叮~\n{nick}今日打卡成功~\n您已累计打卡"..userTotalCheck.."天~\n连续打卡"..userComboCheck.."天~\n明天也记得按时报到。"..userTargetCheck

  else
--正常连续打卡的情况
   setUserConf(msg, "打卡时间", date)
   setUserConf(msg, "连续打卡", getUserConf(msg, "连续打卡", 0)+1)
   setUserConf(msg, "总打卡次数", getUserConf(msg, "总打卡次数", 0)+1)
   local userTotalCheck = getUserConf(msg,"总打卡次数",0)
   local userComboCheck = getUserConf(msg,"连续打卡",0)
   local userTargetCheck = getUserConf(msg,deck_key,0)
    return "叮~\n{nick}今日打卡成功~\n您已累计打卡"..userTotalCheck.."天~\n连续打卡"..userComboCheck.."天~\n明天也记得按时报到。"..userTargetCheck

  end
 end
end

msg_order["打卡"] = "checkDaily"

--以下为查询打卡信息
function dingdata(msg)
local userTotalCheck = getUserConf(msg,"总打卡次数",0)
local userComboCheck = getUserConf(msg,"连续打卡",0)
local userCheckOne = getUserConf(msg,"打卡时间",0)
  return "{nick}已经累计打卡"..userTotalCheck.."天，\n连续打卡"..userComboCheck.."天了哦~"
end


msg_order["打卡状态"] = "dingdata"
Target("打卡 学习")