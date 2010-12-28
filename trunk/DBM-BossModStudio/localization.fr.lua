
if GetLocale() ~= "frFR" then return end
if type(DBM_BMS_Translations) ~= "table" then DBM_BMS_Translations = {} end

local L = DBM_BMS_Translations

-- BossMod studio, Last update: 12/28/2010 (by Sasmira)

L.TabCategory_BossModStudio = "Boss Mod Studio"
L.TabCategory_Triggers = "Déclencheurs et Evénements"
L.AreaHead_CreateBossMod = "Informations principales de ce nouveau BossMod"
L.BossName = "Nom du BossMod - Exemple 'Hogger'"
L.BossID = "ID créature"
L.BossLookup = "Prendre ID de la Cible"

L.AreaHead_Pull = "Pull / Combat Détection"
L.CombatFromYell = "Combat commençant avec un Cri"
L.CombatAutoDetect = "Détection Automatique du Combat"
L.BossPullYell = "Cri du Boss au pull"
L.BossEnrages = "Boss en frénésie"
L.BossEnrageBar = "Afficher Barre Frénésie"
L.BossEnrageAnnounce = "Annoncer Frénésie au Raid"

L.Min = "Min"
L.Sec = "Sec"

L.AreaHead_TriggerCreate = "Créer un Evénement Déclencheur au Boss "
L.Describe_TriggerCreate = [[Triggers can be created to handle events in bossfights. If the Boss yell some stuff or use one of his abilitys you need to catch and use them. As an example, the boss gains Shieldwall and you want to start a Bar when this occur, you simply have to choose BossBuffs or Debuffs and type in an Name for this event like "Shieldwall"]]

L.Trigger_Typ = "Evénement pouvant être déclencheur"
L.Trigger_Name = "Nom du déclencheur (Description)"
L.Trigger_Typ_Spell = "Sort ou Style"
L.Trigger_Typ_Buff = "Buff ou Debuff"
L.Trigger_Typ_Yell = "Cri ou Emote"
L.Trigger_Typ_Time = "En fonction du temps"
L.Trigger_Typ_Hp = "En fonction des Points de Vie"
L.Trigger_Create_Bttn = "créer déclencheur"
L.Trigger_Delete_Bttn = "supprimer déclencheur"

L.EventYellText = "Crier/Dire/Emote qui peuvent appeler l'événement"
L.EventTimeBased = "Déclencher après X secondes"
L.EventHpBased = "Déclencher sur X pourcentages de Vie"
L.EventSpellID = "ID du sort"
L.EventAnnounce = "Annonce"
L.EventAnnounceText = "Message à annoncer"
L.EventSpecialWarn = "Voir: Alerte Spéciale"
L.EventSpecialWarn_OnlyMe = "Seulement si je suis affecté"
L.EventStartBar = "Commencer un timer"
L.EventWarnEnd = "Afficher alerte avant la fin du timer"
L.EventWarnMsg = "Message d'Alerte"
L.EventSetIcon = "Définir un icône sur la Cible (sur le cri %t du texte)"


