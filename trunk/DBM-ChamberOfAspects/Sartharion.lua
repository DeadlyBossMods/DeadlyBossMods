local mod = DBM:NewMod("Sartharion", "DBM-ChamberOfAspects")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28860)
mod:SetZone()

--
--
--12/5 21:49:29.754  SPELL_AURA_APPLIED,0xF130007798000E39,"Flame Tsunami",0xa48,0x00000000016EA8FE,"Clöd",0x514,57491,"Flame Tsunami",0x4,DEBUFF
--12/5 22:09:05.416  SPELL_DAMAGE,0xF1300077B1001071,"Twilight Fissure",0xa48,0x0000000000D574BA,"Takamata",0x514,59128,"Void Blast",0x20,20296,3667,32,0,0,0,nil,nil,nil
--
--

mod:RegisterCombat("combat", 28860, 30449, 30452, 30451)

mod:SetBossHealthInfo(
	28860, "Sartharion",
	30452, "Tenebron",
	30451, "Shadron",
	30449, "Vesperon"
)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE"
)

mod:AddBoolOption("PlaySoundOnFireWall", true, "announce")

local timerTenebron	= mod:NewTimer(30, "TimerTenebron")
local timerShadron	= mod:NewTimer(80, "TimerShadron")
local timerVesperon	= mod:NewTimer(120, "TimerVesperon")

local warnTenebron	= mod:NewAnnounce("WarningTenebron", 2, nil, false)
local warnShadron	= mod:NewAnnounce("WarningShadron", 2, nil, false)
local warnVesperon	= mod:NewAnnounce("WarningVesperon", 2, nil, false)

local warnFireWall	= mod:NewSpecialWarning("WarningFireWall")
local warnVesperonPortal = mod:NewSpecialWarning("WarningVesperonPortal", false)
local warnTenebronPortal = mod:NewSpecialWarning("WarningTenebronPortal", false)
local warnShadronPortal = mod:NewSpecialWarning("WarningShadronPortal", false)

local timerWall         = mod:NewTimer(30, "TimerWall", 43113)  

local dumbpeople = {}
local lastvoids = {}
local lastfire = {}

thisiswipe = true
local enable_dumbppl = false

function mod:OnSync(event)
	if event == "FireWall" then
		warnFireWall:Show()
		
		if self.Options.PlaySoundOnFireWall then
			PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav")
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end

	elseif event == "VesperonPortal" then
		warnVesperonPortal:Show()

	elseif event == "TenebronPortal" then
		warnTenebronPortal:Show()

	elseif event == "ShadronPortal" then
		warnShadronPortal:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, mob)
	if msg == "The lava surrounding %s churns!" then
		self:SendSync("FireWall")
		timerWall:Start()

	elseif msg == "%s begins to open a Twilight Portal!" then
		if mob == "Vesperon" then
			self:SendSync("VesperonPortal")
		elseif mob == "Tenebron" then
			self:SendSync("TenebronPortal")
		elseif mob == "Shadron" then
			self:SendSync("ShadronPortal")
		end
	end
end

mod.CHAT_MSG_MONSTER_EMOTE = mod.CHAT_MSG_RAID_BOSS_EMOTE

function mod:OnCombatStart(delay)
	timerTenebron:Start()
	timerShadron:Start()
	timerVesperon:Start()

	warnTenebron:Schedule(25)
	warnShadron:Schedule(70)
	warnVesperon:Schedule(115)

	if enable_dumbppl then
		table.wipe(lastvoids)
		table.wipe(lastfire)
		thisiswipe = false 
	end
end

function mod:OnCombatEnd(wipe)
	
	if not enable_dumbppl then return end

	local voids = ""
	for k,v in pairs(lastvoids) do
		voids = voids.." "..k.."("..v..")"
	end
	SendChatMessage("Overall Voids:"..voids, "RAID")
	
	local fire = ""
	for k,v in pairs(lastfire) do
		fire = fire.." "..k.."("..v..")"
	end
	SendChatMessage("Overall Fire:"..fire, "RAID")

	local mostdumbppl = ""
	for k,v in pairs(dumbpeople) do
		mostdumbppl = mostdumbppl.." "..k.."("..v..")"
	end
	SendChatMessage("Overall FAILED:"..mostdumbppl, "RAID")
	
end

function mod:SPELL_AURA_APPLIED(args)
	if enable_dumbppl and args.spellId == 57491 and not thisiswipe and DBM:GetRaidUnitId(args.destName) ~= "none" then
		lastfire[args.destName] = (lastfire[args.destName] or 0) + 1
		dumbpeople[args.destName] = (dumbpeople[args.destName] or 0) + 1
		--DBM:AddMsg("Zu doof zu moven: "..args.destName)
		SendChatMessage("FireWall:"..args.destName, "RAID")
	end
end

function mod:SPELL_DAMAGE(args)
	if enable_dumbppl and args.spellId == 59128 and not thisiswipe and DBM:GetRaidUnitId(args.destName) ~= "none" then
		lastvoids[args.destName] = (lastvoids[args.destName] or 0) + 1
		dumbpeople[args.destName] = (dumbpeople[args.destName] or 0) + 1
		--DBM:AddMsg("Void Blast on "..args.destName)
		SendChatMessage("VoidBlast:"..args.destName, "RAID")
	end	
end


