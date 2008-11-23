
if GetLocale() ~= "frFR" then return end
if type(DBM_BMS_Translations) ~= "table" then DBM_BMS_Translations = {} end

local L = DBM_BMS_Translations
-- BossMod studio
L.TabCategory_BossModStudio = "Boss Mod Studio"
L.TabCategory_Triggers = "Déclencheurs et Evénements"
L.AreaHead_CreateBossMod = "Informations principales de se nouveau BossMod"
L.BossName = "Nom du BossMod - Exemple 'Hogger'"
L.BossID = "Creature ID"
L.BossLookup = "Prendre ID de la Cible"

L.AreaHead_Pull = "Pull / Combat Detection"
L.CombatFromYell = "Combat commençant avec un Cri"
L.CombatAutoDetect = "Detection Automatique de Combat "
L.BossPullYell = "Cri du Boss au pull"
L.BossEnrages = "Boss en frénésie "
L.BossEnrageBar = "Afficher Barre Frénésie"
L.BossEnrageAnnounce = "Annoncer Frénésie au Raid"

L.Min = "Min"
L.Sec = "Sec"

L.AreaHead_TriggerCreate = "Créer un Evénement Déclencheur au Boss "
L.Describe_TriggerCreate = [[Triggers can be created to handle events in bossfights. If the Boss yell some stuff or use one of his abilitys you need to catch and use them. As an example, the boss gains Shieldwall and you want to start a Bar when this occur, you simply have to choose BossBuffs or Debuffs and type in an Name for this event like "Shieldwall"]]

L.Trigger_Typ = "Evénement pouvant étre déclencheur"
L.Trigger_Name = "Nom du déclencheur (Description)"
L.Trigger_Typ_Spell = "Sort ou Style"
L.Trigger_Typ_Buff = "Buff ou Debuff"
L.Trigger_Typ_Yell = "Cri ou Emote"
L.Trigger_Typ_Time = "Time based"
L.Trigger_Typ_Hp = "HitPoint Based"
L.Trigger_Create_Bttn = "créer déclencheur"
L.Trigger_Delete_Bttn = "supprimer déclencheur"

L.EventYellText = "Crier/Dire/Emote qui peuvent appeler l'evenement"
L.EventTimeBased = "Déclencher aprés X secondes"
L.EventHpBased = "Déclencher sur X pourcentages de Vie"
L.EventSpellID = "Spell ID"
L.EventAnnounce = "Annonce"
L.EventAnnounceText = "Message à annoncé"
L.EventSpecialWarn = "Afficher une Alerte Spéciale"
L.EventSpecialWarn_OnlyMe = "Seulement si je suis affecté"
L.EventStartBar = "Commencer un timer"
L.EventWarnEnd = "Afficher alerte avant la fin du timer"
L.EventWarnMsg = "Message d'Alerte"
L.EventSetIcon = "Définir une Icone sur la Cible (sur le cri %t du texte)"


