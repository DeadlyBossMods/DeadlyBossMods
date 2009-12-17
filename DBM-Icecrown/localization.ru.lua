if GetLocale() ~= "ruRU" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Треш-мобы"
}

L:SetWarningLocalization{
	SpecWarnDisruptingShout	= "Разрушительный крик - остановите чтение заклинаний",
	SpecWarnDarkReckoning	= "Мрачный итог - отбегите!"
}

L:SetOptionLocalization{
	SpecWarnDisruptingShout	= "Спец-предупреждение для заклинания $spell:71022",
	SpecWarnDarkReckoning	= "Спец-предупреждение, когда на вас $spell:69483",
	SetIconOnDarkReckoning	= "Устанавливать метки на цели заклинания $spell:69483"
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Лорд Ребрад"
}

L:SetTimerLocalization{
	achievementBoned	= "Время до освобождения"
}

L:SetWarningLocalization{
	WarnImpale			= "Прокалывание: >%s<",
	SpecWarnWhirlwind	= "Вихрь - бегите",
	SpecWarnColdflame	= "Холодное пламя - отбегите"
}

L:SetOptionLocalization{
	WarnImpale			= "Анонсировать проткнутые цели",
	SpecWarnWhirlwind	= "Спец-предупреждение для $spell:69076",
	SpecWarnColdflame	= "Спец-предупреждение, при получении урона от $spell:70825",
	achievementBoned	= "Отсчет времени для достижения Косточка попалась",
	SetIconOnImpale		= "Маркировать игроков, насаженных на шип"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Леди Смертный Шепот"
}

L:SetTimerLocalization{
	TimerAdds	= "Призыв помощников"
}

L:SetWarningLocalization{
	WarnReanimating				= "Помощник трансформируется",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance		= "%s на |3-5(>%s<) (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	SpecWarnDeathDecay			= "Смерть и разложение - бегите!",
	SpecWarnCurseTorpor			= "Проклятие оцепенения на вас!",
	SpecWarnTouchInsignificance	= "Прикосновение незначительности (%d)",
	WarnAddsSoon				= "Скоро призыв помощников"
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Предупреждать заранее о призыве помощников",
	WarnTouchInsignificance		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),		-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	WarnReanimating				= "Предупреждать, при трансформации помощника",											-- Reanimated Adherent/Fanatic spawning
	SpecWarnTouchInsignificance	= "Спец-предупреждение, когда на вас 3 стака $spell:71204",
	SpecWarnDeathDecay			= "Спец-предупреждение, когда вы стоите в луже $spell:72108",
	SpecWarnCurseTorpor			= "Спец-предупреждение, когда на вас $spell:71237",
	TimerAdds					= "Отсчет времени до призыва помощников",
	SetIconOnDominateMind		= "Устанавливать метки на игроков, взятых под $spell:71289",
	SetIconOnDeformedFanatic	= "Устанавливать метки на цели заклинания $spell:70900 \n(череп)",
	SetIconOnEmpoweredAdherent	= "Устанавливать метки на цели заклинания $spell:70901 \n(крест)"
}

L:SetMiscLocalization{
	YellPull				= "Как вы смеете ступать в эти священные покои? Это место станет вашей могилой!",
	YellReanimatedFanatic	= "Восстань и обрети истинную форму!"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Воздушный бой"
}

L:SetWarningLocalization{
	WarnBattleFury	= "%s (%d)",
	WarnAddsSoon	= "Скоро призыв помощников"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "Battle Fury"),
	TimerCombatStart	= "Отсчет времени до начала боя",
	WarnAddsSoon		= "Заранее предупреждать о призыве помощников",
	TimerAdds			= "Отсчет времени до новых помощников"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Начало боя",
	TimerAdds			= "Призыв помощников"
}

L:SetMiscLocalization{
	PullAlliance	= "Запускайте двигатели! Летим навстречу судьбе.",
	KillAlliance	= "Ну не говорите потом, что я не предупреждал. В атаку, братья и сестры!",
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy! LOK'TAR OGAR!!",
	KillHorde		= "The Alliance falter. Onward to the Lich King!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Саурфанг Смертоносный"
}

L:SetWarningLocalization{
	warnFrenzySoon		= "Скоро Бешенство",
	specwarnRuneofBlood	= "Руна крови на |3-5(%s)"
}

L:SetOptionLocalization{
	warnFrenzySoon		= "Предупреждать о скором Бешенстве (на ~33%)",
	specwarnRuneofBlood	= "Спец-предупреждение для $spell:72410",
	RangeFrame			= "Показывать окно допустимой дистанции (11 м)"
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Тухлопуз"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Гниломорд"
}

L:SetWarningLocalization{
	SpecWarnStickyOoze			= "Липкая жижа - бегите",
	SpecWarnRadiatingOoze		= "Radiating Ooze",
	SpecWarnMutatedInfection	= "Mutated Infection on you"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes	= "Next Poison Slime Pipes"
}

L:SetOptionLocalization{
	SpecWarnStickyOoze			= "Спец-предупреждение для Липкой жижи",
	SpecWarnRadiatingOoze		= "Show special warning for Radiating Ooze",
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	SpecWarnMutatedInfection 	= "Show special warning when you are affected by Mutated Infection",
	InfectionIcon				= "Set icons on Mutated Infection targets",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning"
}

L:SetMiscLocalization{
	YellSlimePipes	= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Профессор Мерзоцид"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	YellPull	= "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Совет Кровавых принцев"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Switch target to: %s",		-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon	= "Target switch soon",			-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnResonance		= "Теневой резонанс - бегите"
}

L:SetTimerLocalization{
	TimerTargetSwitch	= "Possible target switch"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Show warning to switch targets",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Show pre-warning to switch targets",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Show timer for target switch cooldown",
	SpecWarnResonance		= "Show special warning when a Dark Nucleus is following you"	-- If it follows you, you have to move to the tank
}

L:SetMiscLocalization{
	Keleseth	= "Принц Келесет",
	Taldaram	= "Принц Талдарам",
	Valanar		= "Принц Валанар"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Кровавая королева Лана'тель"
}

L:SetWarningLocalization{
	SpecWarnPactDarkfallen	= "Pact of the Darkfallen on you"
}

L:SetOptionLocalization{
	SpecWarnPactDarkfallen	= "Show special warning when you are affected by Pact of the Darkfallen"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Валитрия Сноходица"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Синдрагоса"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Воздушная фаза",
	TimerNextGroundphase	= "Наземная фаза"
}

L:SetWarningLocalization{
	WarnAirphase			= "Воздушная фаза",
	SpecWarnBlisteringCold	= "Blistering Cold - Run away",
	SpecWarnFrostBeacon		= "Frost Beacon on you",
	WarnGroundphaseSoon		= "Синдрагоса приземляется",
	SpecWarnUnchainedMagic	= "Unchained Magic on you"
}

L:SetOptionLocalization{
	WarnAirphase			= "Предупреждать о воздушной фазе",
	SpecWarnBlisteringCold	= "Show special warning for Blistering Cold",
	SpecWarnFrostBeacon		= "Show special warning when you are affected by Frost Beacon",
	WarnGroundphaseSoon		= "Заранее предупреждать о наземной фазе",
	TimerNextAirphase		= "Отсчет времени до воздушной фазы",
	TimerNextGroundphase	= "Отсчет времени до наземной фазы",
	SpecWarnUnchainedMagic	= "Show special warning when you are affected by Unchained Magic"
}

L:SetMiscLocalization{
	YellAirphase	= "Your incursion ends here! None shall survive!",
	YellPull		= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "Король-лич"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

