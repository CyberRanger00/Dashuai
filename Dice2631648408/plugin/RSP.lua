--一个石头剪刀布脚本 写这个是因为懒得.deck（
--作者 MSCxar0293
--版本 v1.1
--更新日期 20210727
msg_order = {}
--备忘录：1是剪刀2是石头3是布
self_win = "\n老子赢啦，喝！"
self_lose = "\n老子输了？！你没tm耍诈吧？"
self_fair = "\n啧，有点水平！再来！"



function sci(msg)
local self_choice = ranint(1, 3)
  if(self_choice == 1)then
      return "{self}出剪刀！"..self_fair
  elseif(self_choice == 2)then
      return "{self}出石头！"..self_win
  elseif(self_choice == 3)then
      return "{self}出布！"..self_lose
 end
end

msg_order["剪刀"] = "sci"



function rock(msg)
local self_choice = ranint(1, 3)
  if(self_choice == 1)then
      return "{self}出剪刀！"..self_lose
  elseif(self_choice == 2)then
      return "{self}出石头！"..self_fair
  elseif(self_choice == 3)then
      return "{self}出布！"..self_win
 end
end

msg_order["石头"] = "rock"

function pie(msg)
local self_choice = ranint(1, 3)
  if(self_choice == 1)then
      return "{self}出剪刀！"..self_win
  elseif(self_choice == 2)then
      return "{self}出石头！"..self_lose
  elseif(self_choice == 3)then
      return "{self}出布！"..self_fair
 end
end

msg_order["布"] = "pie"  



function rspInfo(msg)
  return "要和老子猜拳？~\n发送 石头/剪刀/布 来和{self}比划比划吧~"
end
  
msg_order["来猜拳"] = "rspInfo"