if GetLocale() ~= "zhTW" then return end
local L

---------------------------
--  Ra'wani Kanae/Frida Ironbellows (Both) --
-- Same exact enoucnter, diff names
---------------------------
--L= DBM:GetModLocalization(2344)--Ra'wani Kanae (Alliance)

--L= DBM:GetModLocalization(2333)--Frida Ironbellows (Horde)

---------------------------
--  King Grong/Grong the Revenant (Both) --
---------------------------
--L= DBM:GetModLocalization(2325)--King Grong (Horde)

--L= DBM:GetModLocalization(2340)--Grong the Revenant (Alliance)

---------------------------
--  Grimfang and Firecaller/Flamefist and the Illuminated (Both) --
-- Same exact enoucnter, diff names
---------------------------
--L= DBM:GetModLocalization(2323)--Grimfang and Firecaller (Alliance)

--L= DBM:GetModLocalization(2341)--Flamefist and the Illuminated (Horde)

---------------------------
--  Opulence (Alliance) --
---------------------------
L= DBM:GetModLocalization(2342)

L:SetMiscLocalization({
	Bulwark =	"壁壘",
	Hand	=	"手"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"你要是這麼想找死，就應該早點來找我！",
	BwonsamdiWrath2 =	"你們遲早…都會像我臣服！",
	Bird			 =	"大鳥"
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "為你沒進場也顯示換階段警告(計時器會持續顯示無論此選項是否選取)"
})

---------------------------
-- High Tinker Mekkatorgue (Horde) --
---------------------------
--L= DBM:GetModLocalization(2332)

---------------------------
--  Sea Priest Blockade (Horde) --
---------------------------
--L= DBM:GetModLocalization(2337)

---------------------------
--  Jaina Proudmoore (Horde) --
---------------------------
L= DBM:GetModLocalization(2343)

L:SetOptionLocalization({
	ShowOnlySummary2	= "隱藏玩家名稱在反距離監控而且只顯示總結訊息(附近玩家數量)",
	InterruptBehavior	= "設置水元素中斷行為 (如果你是團隊隊長會覆蓋所有其他人的設定)",
	Three				= "3人輪流",--Default
	Four				= "4人輪流",
	Five				= "5人輪流",
	SetWeather			= "當開戰時自動地把天氣效果降到最低戰鬥結束後還原設定",
})

L:SetMiscLocalization({
	Port			=	"左舷側",
	Starboard		=	"右舷側",
	Freezing		=	"凍結在%s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"達薩亞洛小怪"
})
