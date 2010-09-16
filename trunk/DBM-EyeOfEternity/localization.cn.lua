-- author: callmejames @《凤凰之翼》 一区藏宝海湾
-- commit by: yaroot <yaroot AT gmail.com>


if GetLocale() ~= "zhCN" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name 			= "玛里苟斯"
})

L:SetWarningLocalization({
	WarningSpark		= "能量火花 出现了",
	WarningBreathSoon	= "奥术吐息 即将到来",
	WarningBreath		= "奥术吐息"
})

L:SetTimerLocalization({
	TimerSpark		= "下一次 能量火花",
	TimerBreath		= "下一次 奥术吐息"
})

L:SetOptionLocalization({
	WarningSpark		= "为能量火花显示警报",
	WarningBreathSoon	= "为奥术吐息显示预先警报",
	WarningBreath		= "为奥术吐息显示警报",
	TimerSpark		= "为下一次 能量火花显示计时条",
	TimerBreath		= "为下一次 奥术吐息显示计时条"
})

L:SetMiscLocalization({
	YellPull		= "我的耐心到此为止了。我要亲自消灭你们！",
	EmoteSpark		= "附近的裂隙中冒出了一团能量火花！",
	YellPhase2		= "我原本只是想尽快结束你们的生命",
	EmoteBreath		= "%s深深地吸了一口气。",
	YellBreath		= "在我的龙息之下，一切都将荡然无存！",
	YellPhase3		= "现在你们幕后的主使终于出现了"
})
