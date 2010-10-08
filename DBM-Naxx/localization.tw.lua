if GetLocale() ~= "zhTW" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name 				= "阿努比瑞克漢"
})

L:SetWarningLocalization({
	SpecialLocust			= "蝗蟲風暴",
	WarningLocustFaded		= "蝗蟲風暴結束"
})

L:SetOptionLocalization({
	SpecialLocust			= "為蝗蟲風暴顯示特別警告",
	WarningLocustFaded		= "當蝗蟲風暴結束時顯示警告",
	ArachnophobiaTimer		= "為蜘蛛恐懼症 (成就)顯示計時器"
})

L:SetMiscLocalization({
	ArachnophobiaTimer		= "蜘蛛恐懼症"
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name 				= "大寡婦費琳娜"
})

L:SetWarningLocalization({
	WarningEmbraceExpire		= "寡婦之擁5秒後結束",
	WarningEmbraceExpired		= "寡婦之擁結束"
})

L:SetOptionLocalization({
	WarningEmbraceExpire		= "為寡婦之擁結束顯示預先警告",
	WarningEmbraceExpired		= "為寡婦之擁結束顯示警告"
})

---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name 				= "梅克絲娜"
})

L:SetWarningLocalization({
	WarningSpidersSoon		= "梅克絲娜之子 5秒後出現",
	WarningSpidersNow		= "梅克絲娜之子出現了"
})

L:SetTimerLocalization({
	TimerSpider			= "下一次 梅克絲娜之子"
})

L:SetOptionLocalization({
	WarningSpidersSoon		= "為梅克絲娜之子顯示預先警告",
	WarningSpidersNow		= "為梅克絲娜之子顯示警告",
	TimerSpider			= "為下一次梅克絲娜之子顯示計時器"
})

L:SetMiscLocalization({
	YellWebWrap			= "我被纏繞住了! 救我!",
	ArachnophobiaTimer		= "蜘蛛恐懼症"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name 				= "『瘟疫使者』諾斯"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "傳送",
	WarningTeleportSoon		= "20秒後 傳送"
})

L:SetTimerLocalization({
	TimerTeleport			= "傳送",
	TimerTeleportBack		= "傳送回來"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "為傳送顯示警告",
	WarningTeleportSoon		= "為傳送顯示預先警告",
	TimerTeleport			= "為傳送顯示計時器",
	TimerTeleportBack		= "為傳送回來顯示計時器"
})

--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name 				= "『不潔者』海根"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "傳送",
	WarningTeleportSoon		= "%d秒後 傳送"
})

L:SetTimerLocalization({
	TimerTeleport			= "傳送"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "為傳送顯示警告",
	WarningTeleportSoon		= "為傳送顯示預先警告",
	TimerTeleport			= "為傳送顯示計時器",
	TimerTeleportBack		= "為傳送回來顯示計時器"
})

---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name 				= "憎恨者"
})

L:SetMiscLocalization({
	LoathebSpore			= "孢子"
})
L:SetWarningLocalization({
	WarningHealSoon			= "3秒後可以治療",
	WarningHealNow			= "現在治療",
	KillSpore			= "你殺死了一個孢子!!!"
})

L:SetOptionLocalization({
	WarningHealSoon			= "為3秒後可以治療顯示預先警告",
	WarningHealNow			= "為現在治療顯示警告",
	SporeDamageAlert		= "在團隊中提示誰殺死了孢子並發送密語給兇手\n(需要團隊隊長或助理權限)"
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name 				= "縫補者"
})

L:SetOptionLocalization({
	WarningHateful 			= "公佈憎恨打擊的目標到團隊頻道\n(需要團隊隊長或助理權限)"
})

L:SetMiscLocalization({
	yell1 				= "縫補者要跟你玩!",
	yell2 				= "科爾蘇加德讓縫補者成為戰爭的化身!",
	HatefulStrike 			= "憎恨打擊 --> %s [%s]"
})

-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name 				= "葛羅巴斯"
})

L:SetOptionLocalization({
	SpecialWarningInjection		= "當你中了突變注射時顯示特別警告"
})

L:SetWarningLocalization({
	SpecialWarningInjection		= "你中了突變注射 - 快跑開"
})

L:SetTimerLocalization({
})

-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name 				= "古魯斯"
})

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name 				= "泰迪斯"
})

L:SetMiscLocalization({
	Yell				= "斯塔拉格要碾碎你!",
	Emote				= "%s超過負荷!",
	Emote2				= "泰斯拉線圈超過負荷!",
	Boss1 				= "伏晨",
	Boss2 				= "斯塔拉格",
	Charge1 			= "負極",
	Charge2 			= "正極"
})

L:SetOptionLocalization({
	WarningChargeChanged		= "當你的極性改變時顯示特別警告",
	WarningChargeNotChanged		= "當你的極性沒有改變時顯示特別警告",
	ArrowsEnabled			= "顯示箭頭 (正常 \"二邊\" 站位打法)",
	ArrowsRightLeft			= "顯示左/右箭頭 給 \"四角\" 站位打法 (如果極性改變顯示左箭頭, 沒變顯示左箭頭)",
	ArrowsInverse			= "顯示倒轉的 \"四角\" 站位打法 (如果極性改變顯示左箭頭, 沒變顯示右箭頭)",
})

L:SetWarningLocalization({
	WarningChargeChanged		= "極性變為%s",
	WarningChargeNotChanged		= "極性沒有改變"
})

L:SetOptionCatLocalization({
	Arrows				= "箭頭"
})

----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name 				= "講師拉祖維斯"
})

L:SetMiscLocalization({
	Yell1 				= "絕不留情!",
	Yell2 				= "練習時間到此為止!都拿出真本事來!",
	Yell3 				= "照我教你的做!",
	Yell4 				= "絆腿……有什麼問題嗎?"
})

L:SetOptionLocalization({
	WarningShieldWallSoon		= "為盾牆結束顯示預先警告"
})

L:SetWarningLocalization({
	WarningShieldWallSoon		= "5秒後 盾牆結束"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name 				= "『收割者』高希"
})

L:SetOptionLocalization({
	TimerWave			= "為下一波顯示計時器",
	TimerPhase2			= "為第二階段顯示計時器",
	WarningWaveSoon			= "為波數顯示預先警告",
	WarningWaveSpawned		= "為波數出現顯示警告",
	WarningRiderDown		= "當無情的騎兵死亡時顯示警告",
	WarningKnightDown		= "當無情的死亡騎士死亡時顯示警告"
})

L:SetTimerLocalization({
	TimerWave			= "第 %d 波",
	TimerPhase2			= "第2階段"
})

L:SetWarningLocalization({
	WarningWaveSoon			= "3秒後 第%d波: %s",
	WarningWaveSpawned		= "第%d波: %s 出現了",
	WarningRiderDown		= "騎兵已死亡",
	WarningKnightDown		= "死亡騎士已死亡",
	WarningPhase2			= "第二階段"
})

L:SetMiscLocalization({
	yell				= "你們這些蠢貨已經主動步入了陷阱。",
	WarningWave1			= "%d %s",
	WarningWave2			= "%d %s 和 %d %s",
	WarningWave3			= "%d %s, %d %s 和 %d %s",
	Trainee				= "受訓員",
	Knight				= "死亡騎士",
	Rider				= "騎兵"
})

---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name 				= "四騎士"
})

L:SetOptionLocalization({
	WarningMarkSoon			= "為印記顯示預先警告",
	WarningMarkNow			= "為印記顯示警告",
	SpecialWarningMarkOnPlayer	= "當你印記堆疊多於四層時顯示特別警告"
})

L:SetTimerLocalization({
})

L:SetWarningLocalization({
	WarningMarkSoon			= "3秒後 印記 %d",
	WarningMarkNow			= "印記 #%d",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetMiscLocalization({
	Korthazz			= "寇斯艾茲族長",
	Rivendare			= "瑞文戴爾男爵",
	Blaumeux			= "布洛莫斯女士",
	Zeliek				= "札里克爵士"
})

-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name 				= "薩菲隆"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon		= "為空中階段顯示預先警告",
	WarningAirPhaseNow		= "提示空中階段",
	WarningLanded			= "提示地上階段",
	TimerAir			= "為空中階段顯示計時器",
	TimerLanding			= "為降落顯示計時器",
	TimerIceBlast			= "為冰息術顯示計時器",
	WarningDeepBreath		= "為冰息術顯示特別警告",
	WarningIceblock			= "當你中了冰箱時大喊",
})

L:SetMiscLocalization({
	EmoteBreath			= "%s深深地吸了一口氣。",
	WarningYellIceblock		= "我是冰塊!"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon		= "10秒後 空中階段",
	WarningAirPhaseNow		= "空中階段",
	WarningLanded			= "薩菲隆降落了",
	WarningDeepBreath		= "冰息術"
})

L:SetTimerLocalization({
	TimerAir			= "空中階段",
	TimerLanding			= "降落",
	TimerIceBlast			= "冰息術"	
})

------------------
--  Kel'Thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name 				= "科爾蘇加德"
})

L:SetOptionLocalization({
	TimerPhase2			= "為第二階段顯示計時器",
	specwarnP2Soon			= "為科爾蘇加德攻擊前10秒顯示特別警告",
	warnAddsSoon			= "為寒冰皇冠守護者顯示預先警告",
	SetIconOnMC			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(28410),
	SetIconOnManaBomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(27819),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(27808),
	ShowRange			= "當第二階段開始時顯示距離監視框"
})

L:SetMiscLocalization({
	Yell 				= "僕從們，侍衛們，隸屬於黑暗與寒冷的戰士們!聽從科爾蘇加德的召喚!"
})

L:SetWarningLocalization({
	specwarnP2Soon			= "10秒後科爾蘇加德開始攻擊",
	warnAddsSoon			= "寒冰皇冠守護者即將出現"
})

L:SetTimerLocalization({
	TimerPhase2			= "第二階段"
})