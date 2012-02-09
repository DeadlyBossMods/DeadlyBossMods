-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 2/8/2012

if GetLocale() ~= "zhCN"  then return end

local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s：%s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCD		= "克卓莫模拟%s",--Universal single local timer used for all of his mimick timers
})

L:SetOptionLocalization({
	KohcromWarning	= "警报：$journal:4262模拟技能",
	KohcromCD		= "计时条：下一次$journal:4262模拟技能",
	RangeFrame		= "距离监视器（5码）：应对成就需求"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShadowYell			= "当你受到$spell:104600影响时时大喊（英雄难度）",
	CustomRangeFrame	= "距离监视器选项（英雄难度）",
	Never				= "关闭",
	Normal				= "普通距离监视",
	DynamicPhase2		= "第2阶段根据状态动态监视",
	DynamicAlways		= "总是根据状态动态监视"
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."--Start translating the yell he does for Void of the Unmaking cast, the latest logs from DS indicate blizz removed the UNIT_SPELLCAST_SUCCESS event that detected casts. sigh.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "%s吸收了%s"
})

L:SetTimerLocalization({
	timerOozesActive	= "软泥怪可攻击"
})

L:SetOptionLocalization({
	warnOozesHit		= "警报：软泥怪种类",
	timerOozesActive	= "计时条：软泥怪可攻击",
	RangeFrame			= "距离监视器（4码）：应对$spell:104898（普通和英雄难度）"
})

L:SetMiscLocalization({
	Black			= "|cFF424242黑色|r",
	Purple			= "|cFF9932CD紫色|r",
	Red				= "|cFFFF0404红色|r",
	Green			= "|cFF088A08绿色|r",
	Blue			= "|cFF0080FF蓝色|r",
	Yellow			= "|cFFFFA901黄色|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s：剩余%d",
	warnFrostTombCast		= "%s - 8秒后施放"
})

L:SetTimerLocalization({
	TimerSpecial			= "第一次特殊技能"
})

L:SetOptionLocalization({
	WarnPillars				= "警报：$journal:3919或$journal:4069剩余数量", -- bad grammer?
	TimerSpecial			= "计时条：第一次特殊技能施放",
	RangeFrame				= "距离监视器（3码）：应对$spell:105269 |（10码）：应对$journal:4327",
	AnnounceFrostTombIcons	= "向团队频道通报$spell:104451目标的团队标记（需要团队领袖权限）",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325),
	SpecialCount			= "倒计时声音警报：$spell:105256或$spell:105465",
	SetBubbles				= "在$spell:104451阶段自动关闭聊天气泡（战斗结束后自动恢复）"
})

L:SetMiscLocalization({
	TombIconSet				= "寒冰之墓标记{rt%d} -> %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%d) - 5秒后施放"--spellname Count
})

L:SetTimerLocalization({
	TimerCombatStart	= "战斗即将开始",
	timerRaidCDs		= "%s冷却：%s"--spellname CD Castername
})

L:SetOptionLocalization({
	TimerCombatStart	= "计时条：战斗即将开始",
	ResetHoTCounter		= "重新开始目光审判计数器",--$spell doesn't work in this function apparently so use typed spellname for now.
	Never				= "从不",
	Reset3				= "每3/2次（英雄/普通难度）重置一次",
	Reset3Always		= "总是每3次进行重置",
	SpecWarnHoTN		= "特殊警报：目光审判施放5秒前（仅针对每3次重置）",
	One					= "1 (如 1 4 7)",
	Two					= "2 (如 2 5)",
	Three				= "3 (如 3 6)",
	ShowRaidCDs			= "计时条：团队减伤技能冷却（测试功能）",
	ShowRaidCDsSelf		= "团队减伤技能冷却计时条仅显示自身技能\n（需要开启团队减伤技能冷却计时条）"
})

L:SetMiscLocalization({
	Pull				= "一股破坏平衡的力量正在接近。它的混乱灼烧着我的心智！"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "暮光精英！"
})

L:SetTimerLocalization({
	TimerCombatStart	= "战斗即将开始",
	TimerAdd			= "下一波暮光精英"
})

L:SetOptionLocalization({
	TimerCombatStart	= "计时条：战斗即将开始",
	TimerAdd			= "计时条：下一波暮光精英",
	SpecWarnElites		= "特殊警报：新的暮光精英出现",
	SetTextures			= "在第1阶段自动禁用材质投射（第2阶段自动恢复）"
})

L:SetMiscLocalization({
	SapperEmote			= "一条幼龙俯冲下来，往甲板上投放了一个暮光工兵！",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095",
	GorionaRetreat		= "痛苦地尖叫并退入了云海的漩涡中"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "小心翻身！"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTendril			= "特殊警报：当你没有$spell:109454效果时",
	InfoFrame				= "信息框：没有$spell:109454效果的玩家",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459),
	ShowShieldInfo			= "首领生命值信息框：应对$spell:105479"
})

L:SetMiscLocalization({
	Pull			= "看那些装甲！他正在解体！摧毁那些装甲，我们就能给他最后一击！",
	NoDebuff		= "没有%s",
	PlasmaTarget	= "灼热血浆：%s",
	DRoll			= "侧翻滚！",
	DLevels			= "保持平衡" -- 保持平衡
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame			= "距离监视器（根据状态动态变化）：应对$spell:108649（英雄难度）",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "你们什么都没做到。我要撕碎你们的世界。"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"巨龙之魂小怪"
})

L:SetWarningLocalization({
	DrakesLeft			= "暮光突袭者剩余：%d"
})

L:SetTimerLocalization({
	TimerDrakes			= "%s"--spellname from mod
})

L:SetOptionLocalization({
	DrakesLeft			= "警报：暮光突袭者剩余数量",
	TimerDrakes			= "计时条：暮光突袭者何时$spell:109904",
})

L:SetMiscLocalization({
	EoEEvent			= "It is no use, the power of the Dragon Soul is too great",--Partial
	UltraxionTrash		= "重逢真令我高兴，阿莱克斯塔萨。分开之后，我可是一直很忙。",
})