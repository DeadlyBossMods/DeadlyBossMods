-- Mini Dragon(projecteurs@gmail.com)
-- Yike Xia
-- Last update: Dec 27, 2014@12193

if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Kargath Bladefist --
---------------
L= DBM:GetModLocalization(1128)

---------------------------
-- The Butcher --
---------------------------
L= DBM:GetModLocalization(971)

---------------------------
-- Tectus, the Living Mountain --
---------------------------
L= DBM:GetModLocalization(1195)

L:SetMiscLocalization({
	pillarSpawn	= "群山，动起来吧！"
})

------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

L:SetOptionLocalization({
	InterruptCounter	= "凋零打断计数器重置",
	Two					= "在两个打断后",
	Three				= "在三个打断后",
	Four				= "在四个打断后"
})

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial	= "为菲莫斯的技能播放倒计时声音",
	PolSpecial		= "为波尔的技能播放倒计时声音",
	PhemosSpecialVoice	= "为菲莫斯的技能播放语音",
	PolSpecialVoice		= "为波尔的技能播放语音"
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)

L:SetWarningLocalization({
	specWarnExpelMagicFelFades	= "邪能5秒后消失 - 返回原位"
})

L:SetOptionLocalization({
	specWarnExpelMagicFelFades	= "为$spell:172895提供返回原位的特殊警报"
})

L:SetMiscLocalization({
	supressionTarget1	= "我要碾碎你！", --Thanks xuesj87@NGA
	supressionTarget2	= "闭嘴！", --Thanks 纸醉金迷°@NGA
	supressionTarget3	= "安静！",
	supressionTarget4	= "我要把你撕成两半！"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

L:SetMiscLocalization({
	BrandedYell			= "%2$s 中了 烙印 (%1$s)!",
	GazeYell			= "凝视于 %d 秒后结束",
	PlayerDebuffs		= "距离最近的疯狂之眼"  --165243
})
-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"悬槌堡小怪"
})
