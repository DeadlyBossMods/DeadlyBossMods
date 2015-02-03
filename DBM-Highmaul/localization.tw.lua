if GetLocale() ~= "zhTW" then return end
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
	pillarSpawn	= "起來吧，群山！"
})

------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

L:SetOptionLocalization({
	InterruptCounter	= "重數衰減打算計數",
	Two					= "在兩次打斷後",
	Three				= "在三次打斷後",
	Four				= "在四次打斷後"
})

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial	= "為菲莫斯的技能冷卻播放倒數音效",
	PolSpecial		= "為博爾的技能冷卻播放倒數音效",
	PhemosSpecialVoice	= "為菲莫斯的技能播放語音包音效",
	PolSpecialVoice		= "為博爾的技能播放語音包音效"
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)

L:SetWarningLocalization({
	specWarnExpelMagicFelFades	= "魔化結束於五秒內 - 回到原位"
})

L:SetOptionLocalization({
	specWarnExpelMagicFelFades	= "為$spell:172895消退顯示回到原位的特別警告"
})

L:SetMiscLocalization({
	supressionTarget1	= "我要擊垮你們！",
	supressionTarget2	= "閉嘴！",
	supressionTarget3	= "安靜！",
	supressionTarget4	= "我要把你撕成兩半！"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

L:SetTimerLocalization({
	timerNightTwistedCD		= "下一次夜狂信徒"
})

L:SetOptionLocalization({
	GazeYellType		= "設定瘋狂之眼的大喊方式",
	Countdown			= "倒數直到消失",
	Stacks				= "堆疊層數",
	timerNightTwistedCD	= "為下一次夜狂信徒顯示計時器"
})

L:SetMiscLocalization({
	BrandedYell			= "烙印(%d層)%d碼",
	GazeYell			= "凝視結束於%d秒內",
	GazeYell2			= "%s中了凝視(%d)",
	PlayerDebuffs		= "最接近的瘋狂之眼"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"天槌小怪"
})
