-- author: callmejames @《凤凰之翼》 一区藏宝海湾
-- commit by: yaroot <yaroot AT gmail.com>


if GetLocale() ~= "zhCN" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name 			= "奥妮克希亚"
}

L:SetWarningLocalization{
	WarnWhelpsSoon		= "奥妮克希亚雏龙 即将出现",
	WarnPhase2Soon		= "第2阶段 即将到来",
	WarnPhase3Soon		= "第3阶段 即将到来"
}

L:SetTimerLocalization{
	TimerWhelps 		= "奥妮克希亚雏龙"
}

L:SetOptionLocalization{
	TimerWhelps		= "为奥妮克希亚雏龙显示计时条",
	WarnWhelpsSoon		= "为奥妮克希亚雏龙显示提前警报",
	SoundWTF		= "为经典传奇式奥妮克希亚副本播放一些有趣的音效",
	WarnPhase2Soon		= "为第2阶段显示提前警报 (大约在67%)",
	WarnPhase3Soon		= "为第3阶段显示提前警报 (大约在41%)"
}

L:SetMiscLocalization{
	YellP2 			= "这毫无意义的行动让我很厌烦。我会从上空把你们都烧成灰！",
	YellP3 			= "看起来需要再给你一次教训，凡人！"
}
