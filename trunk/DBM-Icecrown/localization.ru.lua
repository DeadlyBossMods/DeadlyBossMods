if GetLocale() ~= "ruRU" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "Лорд Ребрад"
})

L:SetWarningLocalization({
	warnImpale			= "Прокалывание: >%S<",
	specWarnWhirlwind		= "Вихрь - бегите",
	specWarnColdflame		= "Холодное пламя - отбегите"
})

L:SetOptionLocalization({
	warnImpale			= "Предупредить о проткнутой цели",
	specWarnWhirlwind		= "Спец-предупреждение для Вихря",
	specWarnColdflame		= "Спец-предупреждение, когда вы получаете урон от Холодного пламени",
	PlaySoundOnWhirlwind		= "Звуковой сигнал при Вихре"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "Леди Смертный Шёпот"
})

L:SetTimerLocalization({
	TimerAdds			= "Призыв помощников"
})

L:SetWarningLocalization({
	WarnAddsSoon			= "Скоро призыв помощников",
	WarnAdherent			= "Cult Adherent transforming",
	SpecWarnDeathDecay		= "Смерть и разложение - бегите",
	SpecWarnCurseTorpor		= "Curse of Torpor on you"
})

L:SetOptionLocalization({
	WarnAddsSoon			= "Предупреждать заранее о призыве помощников",
	WarnAdherent			= "Show warning for Cult Adherent transformation",	-- Cult Adherent -> Reanimated Adherent transformation iirc
	SpecWarnDeathDecay		= "Спец-предупреждение, когда вы под воздействем эффекта Смерти и разложения",
	SpecWarnCurseTorpor		= "Show special warning when you are affected by Curse of Torpor",
	TimerAdds			= "Отсчет времени до призыва помощников",
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),		-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
})

L:SetMiscLocalization({
	YellAdds				= "Arise, and exult in your pure form!",
	YellPull				= "What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!",
	YellAdherent			= "Loyal adherent, I release you from the curse of flesh!",
	YellEmbrace				= "Embrace the darkness... darkness eternal.",
	YellBlessing			= "Take this blessing and show these intruders a taste of the Master's power!"
})

------------------------
--  The Deathbringer  --
------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization({
	name = "Смертеносец"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "Воздушное Сражение"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "Тухлопуз"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "Гниломорд"
})

L:SetWarningLocalization({
	SpecWarnStickyOoze		= "Липкая жижа - бегите",
	SpecWarnRadiatingOoze		= "Radiating Ooze",
	SpecWarnMutatedInfection 	= "Mutated Infection on you"
})

L:SetTimerLocalization({
	NextPoisonSlimePipes		= "Next Poison Slime Pipes"
})

L:SetOptionLocalization({
	SpecWarnStickyOoze		= "Спец-предупреждение для Липкой жижи",
	SpecWarnRadiatingOoze		= "Show special warning for Radiating Ooze",
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	SpecWarnMutatedInfection 	= "Show special warning when you are affected by Mutated Infection",
	InfectionIcon				= "Set icons on Mutated Infection targets",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning"
})

L:SetMiscLocalization({
	YellSlimePipes		= "Хорошие новости, для всех!"	-- Good news, everyone! I've fixed the poison slime pipes!
})

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "Профессор Мерзоцид"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellPull	= "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!"
})

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization({
	name = "Совет Принцев Крови"
})

L:SetWarningLocalization({
	WarnTargetSwitch		= "Switch target to: %s",		-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon	= "Target switch soon",			-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnResonance		= "Теневой резонанс - бегите"
})

L:SetTimerLocalization({
	TimerTargetSwitch		= "Possible target switch"
})

L:SetOptionLocalization({
	WarnTargetSwitch		= "Show warning to switch targets",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Show pre-warning to switch targets",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Show timer for target switch cooldown",
	SpecWarnResonance		= "Show special warning when a Dark Nucleus is following you"	-- If it follows you, you have to move to the tank
})

L:SetMiscLocalization({
	Keleseth				= "Принц Келесет",
	Taldaram				= "Принц Талдарам",
	Valanar					= "Принц Валанар"
})

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization({
	name = "Королева Лана'Тель"
})

L:SetWarningLocalization({
	SpecWarnPactDarkfallen	= "Pact of the Darkfallen on you"
})

L:SetOptionLocalization({
	SpecWarnPactDarkfallen	= "Show special warning when you are affected by Pact of the Darkfallen"
})

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization({
	name = "Валитрия Сновидица"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization({
	name = "Синдрагоса"
})

L:SetTimerLocalization({
	TimerNextAirphase 		= "Воздушная фаза",
	TimerNextGroundphase		= "Наземная фаза"
})

L:SetWarningLocalization({
	WarnAirphase			= "Воздушная фаза",
	SpecWarnBlisteringCold	= "Blisstering Cold - run out",
	SpecWarnFrostBeacon		= "Frost beacon on you",
	WarnGroundphaseSoon		= "Синдрагоса приземляется",
	SpecWarnUnchainedMagic	= "Unchained Magic on you"
})

L:SetOptionLocalization({
	WarnAirphase			= "Предупредить о воздушной фазе",
	WarnBlisteringCold		= "Show warning for Blistering Cold",
	SpecWarnBlisteringCold	= "Show special warning for Blistering Cold",
	SpecWarnFrostBeacon		= "Show special warning for Frost Beacon",
	WarnGroundphaseSoon		= "Предупредить зарание о наземной фазе",
	TimerNextAirphase		= "Отсчет времени до воздушной фазы",
	TimerNextGroundphase		= "Отсчет времени до наземной фазы",
	SpecWarnUnchainedMagic	= "Show special warning when you are affected by Unchained Magic"
})

L:SetMiscLocalization({
	YellAirphase			= "Your incursion ends here! None shall survive!",
	YellPull				= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
})

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "Король-Лич"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

