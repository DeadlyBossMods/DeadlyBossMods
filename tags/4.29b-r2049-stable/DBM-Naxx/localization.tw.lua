if GetLocale() ~= "zhTW" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "阿努比瑞克漢"
})

L:SetWarningLocalization({
	SpecialLocust			= "蝗蟲風暴",
	WarningLocustSoon		= "15秒後 蝗蟲風暴",
	WarningLocustNow		= "蝗蟲風暴",
	WarningLocustFaded		= "蝗蟲風暴結束"
})

L:SetTimerLocalization({
	TimerLocustIn			= "蝗蟲風暴", 
	TimerLocustFade 		= "蝗蟲風暴啟動"
})

L:SetOptionLocalization({
	SpecialLocust			= "為蝗蟲風暴顯示特別警告",
	WarningLocustSoon		= "為蝗蟲風暴顯示預先警告",
	WarningLocustNow		= "為蝗蟲風暴顯示警告",
	WarningLocustFaded		= "當蝗蟲風暴結束時顯示警告",
	TimerLocustIn			= "為蝗蟲風暴顯示計時器", 
	TimerLocustFade 		= "為蝗蟲風暴結束顯示計時器"
})


----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "大寡婦費琳娜"
})

L:SetWarningLocalization({
	WarningEmbraceActive		= "寡婦之擁啟動",
	WarningEmbraceExpire		= "寡婦之擁5秒後結束",
	WarningEmbraceExpired		= "寡婦之擁結束",
	WarningEnrageSoon		= "5秒後 狂亂",
	WarningEnrageNow		= "狂亂"
})

L:SetTimerLocalization({
	TimerEmbrace			= "寡婦之擁啟動",
	TimerEnrage			= "狂亂",
})

L:SetOptionLocalization({
	TimerEmbrace			= "為寡婦之擁顯示計時器",
	WarningEmbraceActive		= "為寡婦之擁顯示警告",
	WarningEmbraceExpire		= "當寡婦之擁結束時顯示警告",
	WarningEmbraceExpired		= "當寡婦之擁即將結束時顯示警告",
	WarningEnrageSoon		= "為即將狂亂顯示警告",
	WarningEnrageNow		= "為狂亂顯示警告",
	TimerEnrage			= "為狂亂顯示計時器",
})


---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "梅克絲娜"
})

L:SetWarningLocalization({
	WarningWebWrap			= "纏繞之網: >%s<",
	WarningWebSpraySoon		= "5秒後 撒網(暈)",
	WarningWebSprayNow		= "撒網",
	WarningSpidersSoon		= "梅克絲娜之子 5秒後出現",
	WarningSpidersNow		= "梅克絲娜之子出現了"
})

L:SetTimerLocalization({
	TimerWebSpray			= "撒網",
	TimerSpider			= "梅克絲娜之子"
})

L:SetOptionLocalization({
	WarningWebWrap			= "提示纏繞之網的目標",
	WarningWebSpraySoon		= "為撒網顯示預先警告",
	WarningWebSprayNow		= "為撒網顯示警告",
	WarningSpidersSoon		= "為梅克絲娜之子顯示預先警告",
	WarningSpidersNow		= "為梅克絲娜之子顯示警告",
	TimerWebSpray			= "為撒網顯示計時器",
	TimerSpider			= "為梅克絲娜之子顯示計時器"
})

L:SetMiscLocalization({
	YellWebWrap			= "我被纏繞住了! 救我!"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "『瘟疫使者』諾斯"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "傳送",
	WarningTeleportSoon		= "20秒後 傳送",
	WarningCurse			= "詛咒"
})

L:SetTimerLocalization({
	TimerTeleport			= "傳送",
	TimerTeleportBack		= "傳送回來"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "為傳送顯示警告",
	WarningTeleportSoon		= "為傳送顯示預先警告",
	WarningCurse			= "為詛咒顯示警告",
	TimerTeleport			= "為傳送顯示計時器",
	TimerTeleportBack		= "為傳送回來顯示計時器"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "『不潔者』海根"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "傳送",
	WarningTeleportSoon		= "%d秒後 傳送",
})

L:SetTimerLocalization({
	TimerTeleport			= "傳送",
})

L:SetOptionLocalization({
	WarningTeleportNow		= "為傳送顯示警告",
	WarningTeleportSoon		= "為傳送顯示預先警告",
	WarningCurse			= "為詛咒顯示警告",
	TimerTeleport			= "為傳送顯示計時器",
	TimerTeleportBack		= "為傳送回來顯示計時器"
})


---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "憎恨者"
})

L:SetWarningLocalization({
	WarningSporeNow			= "孢子出現了",
	WarningSporeSoon		= "5秒後 孢子",
	WarningDoomNow			= "無可避免的末日 #%d",
	WarningHealSoon			= "3秒後可以治療",
	WarningHealNow			= "現在治療"
})

L:SetTimerLocalization({
	TimerDoom			= "無可避免的末日 #%d",
	TimerSpore			= "下一個 孢子",
	TimerAura			= "亡域光環"
})

L:SetOptionLocalization({
	WarningSporeNow			= "為孢子顯示警告",
	WarningSporeSoon		= "為孢子顯示預先警告",
	WarningDoomNow			= "為無可避免的末日顯示警告",
	WarningHealSoon			= "為\"3秒後可以治療\"顯示預先警告",
	WarningHealNow			= "為\"現在治療\"顯示警告",
	TimerDoom			= "為無可避免的末日顯示計時器",
	TimerSpore			= "為孢子顯示計時器",
	TimerAura			= "為亡域光環顯示計時器"
})



-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "縫補者"
})

L:SetOptionLocalization({
	WarningHateful 			= "通告憎恨打擊到團隊頻道\n(需要團隊隊長或助理權限)"
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
	name = "葛羅巴斯"
})

L:SetOptionLocalization({
	WarningInjection		= "為突變注射顯示警告",
	SpecialWarningInjection		= "當你中了突變注射時顯示特別警告"
})

L:SetWarningLocalization({
	WarningInjection		= "突變注射: >%s<",
	SpecialWarningInjection		= "你中了突變注射 - 快跑開"
})

L:SetTimerLocalization({
})


-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "古魯斯"
})

L:SetOptionLocalization({
	WarningDecimateNow		= "為殘殺顯示警告",
	WarningDecimateSoon		= "為殘殺顯示預先警告",
	TimerDecimate			= "為殘殺顯示計時器"
})

L:SetWarningLocalization({
	WarningDecimateNow		= "殘殺",
	WarningDecimateSoon		= "10秒後 殘殺"
})

L:SetTimerLocalization({
	TimerDecimate			= "殘殺冷卻"
})


----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "泰迪斯"
})

L:SetMiscLocalization({
	Yell				= "斯塔拉格要碾碎你!",
	Emote				= "%s超過負荷!", -- ?
	Emote2				= "泰斯拉線圈超過負荷!", -- ?
	Boss1 = "伏晨",
	Boss2 = "斯塔拉格",
	Charge1 = "負極",
	Charge2 = "正極",
})

L:SetOptionLocalization({
	WarningShiftCasting		= "為極性轉換顯示警告",
	WarningChargeChanged		= "當你的極性改變時顯示特別警告",
	WarningChargeNotChanged		= "當你的極性沒有改變時顯示特別警告",
	TimerShiftCast			= "為施放極性轉換顯示計時器",
	TimerNextShift			= "為極性轉換顯示冷卻計時器",
	ArrowsEnabled			= "顯示箭頭 (正常 \"二邊\" 站位打法)",
	ArrowsRightLeft			= "顯示左/右箭頭 給 \"四角\" 站位打法 (如果極性改變顯示左箭頭, 沒變顯示左箭頭)",
	ArrowsInverse			= "顯示倒轉的 \"四角\" 站位打法 (如果極性改變顯示左箭頭, 沒變顯示右箭頭)",
	WarningThrow			= "為投擲坦克顯示警告",
	WarningThrowSoon		= "為投擲坦克顯示預先警告",
	TimerThrow			= "為投擲坦克顯示計時器"
})

L:SetWarningLocalization({
	WarningShiftCasting		= "5秒後 極性轉換",
	WarningChargeChanged		= "極性變為%s",
	WarningChargeNotChanged		= "極性沒有改變",
	WarningThrow			= "投擲坦克",
	WarningThrowSoon		= "3秒後 投擲坦克"
})

L:SetTimerLocalization({
	TimerShiftCast			= "施放極性轉換",
	TimerNextShift			= "下一次 極性轉換",
	TimerThrow			= "投擲坦克"
})

L:SetOptionCatLocalization({
	Arrows				= "箭頭",
})


----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "講師拉祖維斯"
})

L:SetMiscLocalization({
	Yell1 				= "絕不留情!",
	Yell2 				= "練習時間到此為止!都拿出真本事來!",
	Yell3 				= "照我教你的做!",
	Yell4 				= "絆腿……有什麼問題嗎?"
})

L:SetOptionLocalization({
	WarningShoutNow			= "為混亂怒吼顯示警告",
	WarningShoutSoon		= "為混亂怒吼顯示預先警告",
	TimerShout			= "為混亂怒吼顯示計時器",
	WarningShieldWallSoon		= "為盾牆結束顯示警告",
	TimerShieldWall			= "為盾牆顯示計時器",
	TimerTaunt			= "為嘲諷顯示計時器"
})

L:SetWarningLocalization({
	WarningShoutNow			= "混亂怒吼",
	WarningShoutSoon		= "5秒後 混亂怒吼",
	WarningShieldWallSoon		= "5秒後 盾牆結束"
})

L:SetTimerLocalization({
	TimerShout			= "混亂怒吼",
	TimerTaunt			= "嘲諷",
	TimerShieldWall			= "盾牆"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "『收割者』高希"
})

L:SetOptionLocalization({
	TimerWave			= "為波數顯示計時器",
	TimerPhase2			= "為第二階段顯示計時器",
	WarningWaveSoon			= "為波數顯示預先警告",
	WarningWaveSpawned		= "為波數出現顯示警告",
	WarningRiderDown		= "當無情的騎兵死亡時顯示警告",
	WarningKnightDown		= "當無情的死亡騎士死亡時顯示警告",
	WarningPhase2			= "為第二階段顯示警告"
})

L:SetTimerLocalization({
	TimerWave			= "第 #%d 波",
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
	Rider				= "騎兵",
})


---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "四騎士"
})

L:SetOptionLocalization({
	TimerMark			= "為印記顯示計時器",
	WarningMarkSoon			= "為印記顯示預先警告",
	WarningMarkNow			= "為印記顯示警告",
	SpecialWarningMarkOnPlayer	= "當你印記疊加大於四時顯示特別警告"
})

L:SetTimerLocalization({
	TimerMark 			= "印記 %d"
})

L:SetWarningLocalization({
	WarningMarkSoon			= "3秒後 印記 %d",
	WarningMarkNow			= "印記 #%d",
	SpecialWarningMarkOnPlayer	= "%s: %s",
})

L:SetMiscLocalization({
	Korthazz			= "寇斯艾茲族長",
	Rivendare			= "瑞文戴爾男爵",
	Blaumeux			= "布洛莫斯女士",
	Zeliek				= "札里克爵士",
})


-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "薩菲隆"
})

L:SetOptionLocalization({
	WarningDrainLifeNow		= "為生命吸取顯示警告",
	WarningDrainLifeSoon		= "為生命吸取顯示預先警告",
	WarningAirPhaseSoon		= "為空中階段顯示預先警告",
	WarningAirPhaseNow		= "為空中階段顯示警告",
	WarningLanded			= "為地上階段顯示警告",
	TimerDrainLifeCD		= "為生命吸取顯示計時器",
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
	WarningDrainLifeNow		= "生命吸取",
	WarningDrainLifeSoon		= "生命吸取 即將到來",
	WarningAirPhaseSoon		= "10秒後 空中階段",
	WarningAirPhaseNow		= "空中階段",
	WarningLanded			= "薩菲隆降落了",
	WarningDeepBreath		= "冰息術",
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "生命吸取冷卻",
	TimerAir			= "空中階段",
	TimerLanding			= "降落",
	TimerIceBlast			= "冰息術"	
})

------------------
--  Kel'Thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "科爾蘇加德"
})

L:SetOptionLocalization({
	BlastTimer			= "為冰霜衝擊顯示計時器 (4秒計時直到該目標死亡)",
	TimerPhase2			= "為第二階段顯示計時器",
	WarningBlastTargets		= "為冰霜衝擊顯示警告",
	WarningPhase2			= "為第二階段顯示警告",
	WarningFissure			= "為暗影裂縫顯示警告",
	WarningMana			= "為爆裂法力顯示警告",
	WarningChainsTargets		= "為科爾蘇加德之鍊(心控)顯示警告",
	specwarnP2Soon 		= "科爾蘇加德攻擊前10秒顯示特別警告",
	ShowRange			= "當第二階段開始時顯示距離監視框"
})

L:SetMiscLocalization({
	Yell 				= "僕從們，侍衛們，隸屬於黑暗與寒冷的戰士們!聽從科爾蘇加德的召喚!"
})

L:SetWarningLocalization({
	WarningBlastTargets		= "冰霜衝擊: >%s<",
	WarningPhase2			= "第二階段",
	WarningFissure			= "暗影裂縫 出現了",
	WarningMana			= "爆裂法力: >%s<",
	WarningChainsTargets		= "科爾蘇加德之鍊(心控): >%s<",
	specwarnP2Soon 		= "10秒後科爾蘇加德開始攻擊"
})

L:SetTimerLocalization({
	TimerPhase2			= "第二階段",
	BlastTimer			= "現在治療"
})
