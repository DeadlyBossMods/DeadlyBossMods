local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetWarningLocalization({
	SpecialLocust		= "Locust Swarm!",
	WarningLocustSoon	= "Locust Swarm in 15 sec",
	WarningLocustNow	= "Locust Swarm!",
	WarningLocustFaded	= "Locust Swarm faded"
})

L:SetTimerLocalization({
	TimerLocustIn	= "Locust Swarm", 
	TimerLocustFade = "Locust Swarm active"
})

L:SetOptionLocalization({
	SpecialLocust		= "Show special warning for Locust Swarm",
	WarningLocustSoon	= "Show Locust Swarm pre-warning",
	WarningLocustNow	= "Show Locust Swarm warning",
	WarningLocustFaded	= "Show Locust Swarm fade warning",
	TimerLocustIn		= "Show Locust Swarm timer", 
	TimerLocustFade 	= "Show Locust Swarm timer"
})


----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Grand Widow Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceActive	= "Widow's Embrace active",
	WarningEmbraceExpire	= "Widow's Embrace ends in 5 sec",
	WarningEmbraceExpired	= "Widow's Embrace faded"
})

L:SetTimerLocalization({
	TimerEmbrace = "Embrace active"
})


---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "Maexxna"
})

L:SetWarningLocalization({
	WarningWebWrap		= "Web Wrap: >%s<",
	WarningWebSpraySoon	= "Web Spray in 5 sec",
	WarningWebSprayNow	= "Web Spray!",
	WarningSpidersSoon	= "Spiders in 5 sec",
	WarningSpidersNow	= "Spiders spawned!"
})

L:SetTimerLocalization({
	TimerWebSpray	= "Web Spray",
	TimerSpider		= "Spiders"
})

L:SetOptionLocalization({
	WarningWebWrap		= "Announce Web Wrap targets",
	WarningWebSpraySoon	= "Show Web Spray pre-warning",
	WarningWebSprayNow	= "Show Web Spray warning",
	WarningSpidersSoon	= "Show Spider pre-warning",
	WarningSpidersNow	= "Show Spider warning",
	TimerWebSpray		= "Show Web Spray timer",
	TimerSpider			= "Show Spider timer"
})


------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Noth the Plaguebringer"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleported!",
	WarningTeleportSoon	= "Teleport in 20 sec",
	WarningCurse		= "Curse!"
})

L:SetTimerLocalization({
	TimerTeleport		= "Teleport",
	TimerTeleportBack	= "Teleport back"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Heigan the Unclean"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleported!",
	WarningTeleportSoon	= "Teleport in %d sec",
})

L:SetTimerLocalization({
	TimerTeleport		= "Teleport",
})


----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Loatheb"
})

L:SetWarningLocalization({
	WarningSporeNow		= "Spore spawned!",
	WarningSporeSoon	= "Spore in 5 sec",
	WarningDoomNow		= "Doom #%d",
	WarningHealSoon		= "Healing possible in 3 sec",
	WarningHealNow		= "Heal now!"
})
--Inevitable Doom
L:SetTimerLocalization({
	TimerDoom			= "Doom #%d",
	TimerSpore			= "Next Spore",
	TimerAura			= "Necrotic Aura"
})



-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Patchwerk"
})

L:SetOptionLocalization({
	WarningHateful = "Announce Hateful Strikes to raid chat"
})

L:SetMiscLocalization({
	yell1 = "Patchwerk want to play!",
	yell2 = "Kel'thuzad make Patchwerk his avatar of war!",
	HatefulStrike = "Hateful Strike --> >%s< [%s]"
})

--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Gothik"
})

L:SetTimerLocalization({
	TimerWave	= "Wave #%d",
	TimerPhase2	= "Phase 2"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Wave %d: %s in 3 sec",
	WarningWaveNow		= "Wave %d: %s spawned",
	WarningRiderDown	= "Rider down",
	WarningKnightDown	= "Knight down",
})

L:SetMiscLocalization({
	yell			= "Foolishly you have sought your own demise.",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s and %d %s",
	WarningWave3	= "%d %s, %d %s and %d %s",
	Trainee			= "Trainee",
	Knight			= "Knight",
	Rider			= "Rider",
})

----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")
L:SetGeneralLocalization({
	name = "Four Horsemen"
})

L:SetTimerLocalization({
	TimerMark = "Mark %d"
})

L:SetWarningLocalization({
	WarningMarkSoon		= "Mark %d in 4 sec",
	WarningMarkNow		= "Mark %d!",
})

--[[
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Grand Widow Faerlina"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})
]]--
