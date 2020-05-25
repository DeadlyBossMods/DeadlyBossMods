-- Last update by GlitterStorm @ Azralon on Feb,28th,2015
if GetLocale() ~= "ptBR" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

L.HOW_TO_USE_MOD					= "Bem vindo ao DBM. Digite /dbm help para obter uma lista dos comandos disponíveis. Para acessar as opções, digite /dbm no seu chat para começar a configuração. Carregue zonas específicas manualmente para configurar opções específicas de cada chefe para o seu gosto pessoal. O DBM tenta fazer isso automaticamente para você, observando sua spec na primeira vez que é executado. De qualquer forma, você pode querer habilitar outras opções."

L.LOAD_MOD_ERROR					= "Erro ao carregar módulo %s: %s "
L.LOAD_MOD_SUCCESS					= "Módulo '%s' carregado. Para mais opções, digite /dbm ou /dbm help no chat"
L.LOAD_MOD_COMBAT					= "Carregamento de '%s' adiado até que você saia de combate"
L.LOAD_GUI_ERROR					= "Não foi possível carregar interface gráfica: %s"
L.LOAD_GUI_COMBAT					= "A interface gráfica não pode ser carregada em combate e será assim que você o sair. Quando estiver carregada, você poderá chama-la em combate."
L.BAD_LOAD							= "DBM detectou que a sua mod desta área falhou ao tentar carregar por completo por estar em combate. Use o comando /reloadui assim que sair de combate para corrigir o problema."
L.LOAD_MOD_VER_MISMATCH				= "%s não foi carregado por não cumprir os requerimentos. Uma atualização da mod é necessária. Obrigado."

L.DYNAMIC_DIFFICULTY_CLUMP			= "DBM desabilitou o quadro de alcance dinâmico nesta luta, por falta de informação sobre o numero de jogadores à ficarem amontoados para um grupo desse tamanho."

L.DYNAMIC_ADD_COUNT					= "DBM desabilitou aviso da contagem de adds nesta luta, por falta de informação da quantidade de adds para um grupo deste tamanho."
L.DYNAMIC_MULTIPLE					= "DBM desabilitou varias funções desta luta por causa da falta de informação sobre certas mecânicas para um grupo deste tamanho."

L.LOOT_SPEC_REMINDER				= "A sua especialização atual é %s. A sua escolha atual de loot é %s."

L.BIGWIGS_ICON_CONFLICT				= "DBM detectou que você tem ícones habilitados tanto no BigWigs quanto no DBM. Por favor desabilite um dos dois para evitar conflitos com o líder da raid"

L.MOD_AVAILABLE						= "%s esta disponível para este conteúdo. Esta disponível em |HDBM:forums|h|cff3588ffdeadlybossmods.com|r. Está mensagem só será exibida uma vez."

L.COMBAT_STARTED					= "%s na mira. Boa sorte e divirta-se! :)"

L.COMBAT_STARTED_IN_PROGRESS		= "Entrando em uma luta em progresso contra %s. Boa sorte e divirta-se! :)"
L.GUILD_COMBAT_STARTED				= "%s engrenou em combate com a Guild"
L.SCENARIO_STARTED					= "%s começou. Boa sorte e divirta-se! :)"
L.SCENARIO_STARTED_IN_PROGRESS		= "Juntando-se à %s em progresso. Boa sorte e divirta-se! :)"
L.BOSS_DOWN							= "%s derrotado após %s!"
L.BOSS_DOWN_I						= "%s derrotado! você tem %d vitorias no total."
L.BOSS_DOWN_L						= "%s derrotado após %s! Sua última vitória levou %s, sua vitória mais rápida %s. Você tem um total de %d vitórias."
L.BOSS_DOWN_NR						= "%s derrotado após %s! Esse é um novo recorde! (Recorde antigo era %s). Você tem um total de %d vitórias."
L.GUILD_BOSS_DOWN					= "%s foi derrotado pela guild após %s!"
L.SCENARIO_COMPLETE					= "%s completado após %s!"
L.SCENARIO_COMPLETE_I				= "%s completado! Você tem %d vitórias no total."
L.SCENARIO_COMPLETE_L				= "%s completado após %s! A sua ultima vitória demorou %s e a mais rápida %s. Você tem %d vitórias no total."
L.SCENARIO_COMPLETE_NR				= "%s completado após %s! Esse é o seu novo recorde! (Ultimo recorde era %s). Você tem %d vitórias no total."
L.COMBAT_ENDED_AT					= "Combate contra %s (%s) encerrado após %s."
L.COMBAT_ENDED_AT_LONG				= "Combate contra %s (%s) encerrado após %s. Você tem um total de %d derrotas nessa dificuldade."
L.GUILD_COMBAT_ENDED_AT				= "Guild foi derrotada por %s (%s) após %s."
L.SCENARIO_ENDED_AT					= "%s finalizado após %s."
L.SCENARIO_ENDED_AT_LONG			= "%s finalizado após %s. Você tem %d de vitórias parciais nessa dificuldade."
L.COMBAT_STATE_RECOVERED			= "Luta contra %s começou %s atrás, reajustando cronógrafos..."
L.TRANSCRIPTOR_LOG_START			= "Gravação do Transcritor começou."
L.TRANSCRIPTOR_LOG_END				= "Gravação do Transcritor finalizado."

L.PROFILE_NOT_FOUND					= "<DBM> Seu perfil atual esta corrompido. DBM carregara o perfil 'padrão/default'."
L.PROFILE_CREATED					= "'%s' perfil criado."
L.PROFILE_CREATE_ERROR				= "Falha ao criar perfil. nome de perfil invalido."
L.PROFILE_CREATE_ERROR_D			= "Falha ao criar perfil. '%s' perfil já existe."
L.PROFILE_APPLIED					= "'%s' perfil aplicado."
L.PROFILE_APPLY_ERROR				= "Falha ao aplicar perfil. '%s' perfil não existe."
L.PROFILE_COPIED					= "'%s' perfil copiado."
L.PROFILE_COPY_ERROR				= "Falha ao copiar perfil. '%s' perfil não existe."
L.PROFILE_COPY_ERROR_SELF			= "Falha ao copiar perfil, não é possível copiar a si mesmo."
L.PROFILE_DELETED					= "'%s' perfil deletado. Perfil 'padrão/default' será aplicado."
L.PROFILE_DELETE_ERROR				= "Falha ao deletar perfil. '%s' perfil não existe."
L.PROFILE_CANNOT_DELETE				= "Não é possível deletar o perfil 'padrão/Default'."
L.MPROFILE_COPY_SUCCESS				= "%s's (%d spec) preferencias da mod foram copiadas."
L.MPROFILE_COPY_SELF_ERROR			= "Não é possível copiar às preferencias do char para ele mesmo"
L.MPROFILE_COPY_S_ERROR				= "Origem esta corrompida. Preferencias não foram copias ou foram copiadas parcialmente. Falha ao copiar."
L.MPROFILE_COPYS_SUCCESS			= "%s's (%d spec) preferencias de sons da mod foram copiadas."
L.MPROFILE_COPYS_SELF_ERROR			= "Não é possível copiar as preferencias de sons do char para ele mesmo"
L.MPROFILE_COPYS_S_ERROR			= "Origem esta corrompida. Preferencias de sons não foram copiadas ou foram copiadas parcialmente. Falha ao copiar."
L.MPROFILE_DELETE_SUCCESS			= "%s's (%d spec) preferencias da mod deletadas."
L.MPROFILE_DELETE_SELF_ERROR		= "Não é possível deletar preferencias que estão em uso."
L.MPROFILE_DELETE_S_ERROR			= "Origem esta corrompida. Preferencias não foram deletadas ou foram deletadas parcialmente. Falha ao deletar."

L.ALLMOD_DEFAULT_LOADED				= "Foram carregadas preferencias padrões para todas as mods desta area."
L.ALLMOD_STATS_RESETED				= "Todas as estatísticas da mod foram apagadas."
L.MOD_DEFAULT_LOADED				= "Foram carregadas opções padrão para esta luta."

L.WORLDBOSS_ENGAGED					= "%s foi possivelmente puxado no seu reino %s por cento de vida. (Enviado por %s)"
L.WORLDBOSS_DEFEATED				= "%s foi possivelmente derrotado no seu reino (Enviado por %s)."

L.TIMER_FORMAT_SECS					= "%.2f |4segundo:segundos;"
L.TIMER_FORMAT_MINS					= "%d |4minuto:minutos;"
L.TIMER_FORMAT						= "%d |4minuto:minutos; e %.2f |4segundo:segundos;"

L.MIN								= "min"
L.MIN_FMT							= "%d min"
L.SEC								= "seg"
L.SEC_FMT							= "%s seg"
L.DEAD								= "morto"
L.OK								= "Ok"

L.GENERIC_WARNING_OTHERS			= "e mais um"
L.GENERIC_WARNING_OTHERS2			= "e %d outros"
L.GENERIC_WARNING_BERSERK			= "Frenético em %s %s"
L.GENERIC_TIMER_BERSERK				= "Frenético"
L.OPTION_TIMER_BERSERK				= "Exibir cronógrafo para $spell:26662"
L.GENERIC_TIMER_COMBAT				= "Combate começou"
L.OPTION_TIMER_COMBAT				= "Exibir cronógrafo para começo do combate"

L.OPTION_CATEGORY_TIMERS			= "Barras"
L.OPTION_CATEGORY_WARNINGS			= "Categoria de anúncios"
L.OPTION_CATEGORY_WARNINGS_YOU		= "Anúncios pessoais"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "Anúncios de alvo"
L.OPTION_CATEGORY_WARNINGS_ROLE		= "Anúncios de função"
L.OPTION_CATEGORY_SOUNDS			= "Sons"

L.AUTO_RESPONDED					= "Respondido automaticamente"
L.STATUS_WHISPER					= "%s: %s, %d/%d pessoas vivas"
--Chefes
L.AUTO_RESPOND_WHISPER				= "%s está ocupado lutando contra %s (%s, %d/%d pessoas vivas)"
L.WHISPER_COMBAT_END_KILL			= "%s derrotou %s!"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s derrotou %s! Eles tem um total de %d vitórias."
L.WHISPER_COMBAT_END_WIPE_AT		= "%s foi derrotado por %s em %s"
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s foi derrotado por %s em %s. Eles tem um total de %d derrotas nessa dificuldade."
--Cenários (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO		= "%s esta ocupado em %s (%d/%d pessoas vivas)"
L.WHISPER_SCENARIO_END_KILL			= "%s foi completado %s!"
L.WHISPER_SCENARIO_END_KILL_STATS	= "%s foi completado %s! Eles tem um total de %d vitórias."
L.WHISPER_SCENARIO_END_WIPE			= "%s não foi completado %s"
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s não foi completado %s. Eles tem um total de %d vitórias parciais nesta dificuldade."

L.VERSIONCHECK_HEADER				= "Deadly Boss Mods - Versões"
L.VERSIONCHECK_ENTRY				= "%s: %s (%s)"
L.VERSIONCHECK_ENTRY_TWO			= "%s: %s (%s) & %s (%s)"--Two Boss mods
L.VERSIONCHECK_ENTRY_NO_DBM			= "%s: DBM não instalado"
L.VERSIONCHECK_FOOTER				= "Encontrados %d jogadores com DBM & %d jogadores com Bigwigs"
L.VERSIONCHECK_OUTDATED				= "Os seguintes %d jogadores estão com versões desatualizadas de boss mods: %s"
L.YOUR_VERSION_OUTDATED				= "Sua versão do Deadly Boss Mods está desatualizada. Por favor, acesse www.deadlybossmods.com para baixar a versão mais recente."
L.VOICE_PACK_OUTDATED				= "O pacote de vozes do seu DBM pode estar sem alguns dos sons suportados por esta versão do DBM. Filtro de aviso especial sonoro foi desativado. Por favor baixe a versão mais recente do pacote de vozes ou contate o autor para um pacote que contenha os sons aqui referidos."
L.VOICE_MISSING						= "Você tinha um pacote de vozes DBM selecionado que não pode ser encontrado. Sua seleção foi restaurada para 'Nenhum/None'. Caso seja um erro, certifique-se que o pacote esta instalado corretamente e habilitado em addons."
L.VOICE_COUNT_MISSING				= "Voz de contagem regressiva %d esta selecionada para um pacote de voz que não pode ser encontrado. Foi restaurada a configuração padrão."

L.UPDATEREMINDER_HEADER				= "Sua versão do Deadly Boss Mods está desatualizada.\n A versão %s (%s) está disponível para baixar no site da curse, WoWI ou aqui:"
L.UPDATEREMINDER_HEADER_ALPHA		= "A sua versão alpha do DBM está desatualizada.\n Você esta pelo menos %d versões de testes para trás. É recomendado que os usuários do DBM utilizem a versão mais recente do alpha ou a mais recente das versões estáveis. Versões alphas desatualizadas podem resultar em faltas de algumas funcionalidades ou totalmente inoperante."
L.UPDATEREMINDER_FOOTER				= "Pressione Ctrl+C para copiar o link de download para a área de transferência."
L.UPDATEREMINDER_FOOTER_GENERIC		= "Pressione Ctrl+C para copiar o link de download para a área de transferência."
L.UPDATEREMINDER_DISABLE			= "AVISO: O seu DBM foi desativado por estar drasticamente desatualizado (pelo menos %d revisões), atualize para utilizar novamente. Isso garante que versões antigas ou códigos incompatíveis não arruínem à experiência de jogo para você ou para os membros da raid."
L.UPDATEREMINDER_HOTFIX				= "A sua versão do DBM contem temporizadores ou avisos incorretos para este chefe. Isso foi corrigido em uma versão mais recente ( ou alpha caso não exista versão estável mais recente disponível)"
L.UPDATEREMINDER_HOTFIX_ALPHA		= L.UPDATEREMINDER_HOTFIX--TEMP, FIX ME!
L.UPDATEREMINDER_MAJORPATCH			= "AVISO: O seu DBM foi desativado por estar drasticamente desatualizado (pelo menos %d revisões), atualize para utilizar novamente. Isso garante que versões antigas ou códigos incompatíveis não arruínem à experiência de jogo para você ou para os membros da raid. Certifique-se de baixar a versão mais recente em deadlybossmods.com ou curse o mais breve possível."
L.UPDATEREMINDER_TESTVERSION		= "AVISO: Você esta usando uma versão do DBM que não foi criada para esta versão do jogo. Por favor, certifique-se de baixar a versão correta em deadlybossmods.com ou curse."
L.VEM								= "AVISO: Você esta usando DBM e Voice Encounter Mods. DBM não funcionara corretamente nesta configuração e portanto não será carregada."
L.OUTDATEDPROFILES						= "AVISO: DBM-Profiles não é compatível com esta versão de DBM. Deve ser removida antes de DBM continuar para evitar conflitos."
L.UPDATE_REQUIRES_RELAUNCH			= "AVISO: Esta versão de DBM não funcionara corretamente até que você recomece o jogo por completo. Esta atualização contem novos arquivos ou mudanças no .toc que não podem ser carregadas via ReloadUI. Você pode encontrar funcionalidades quebradas ou erros caso continue sem recomeçar o jogo por completo."

L.UPDATEREMINDER_NOTAGAIN			= "Exibir pop-up quando houver uma nova versão disponível"

L.MOVABLE_BAR						= "Arraste-me!"

L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h te enviou um cronógrafo do DBM: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancelar esse cronógrafo]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorar cronógrafos de %1$s]|r|h"
L.PIZZA_CONFIRM_IGNORE				= "Você tem certeza de que realmente deseja ignorar cronógrafos de %s até o fim desta sessão?"
L.PIZZA_ERROR_USAGE					= "Uso: /dbm [broadcast] timer <tempo> <texto>"

--L.MINIMAP_TOOLTIP_HEADER (Same as English locales)
L.MINIMAP_TOOLTIP_FOOTER			= "Use shift+click ou clique com o botão direito para mover\nUse alt+shift+click para arrastar livremente"

L.RANGECHECK_HEADER					= "Medir distância: (%d m)"
L.RANGECHECK_SETRANGE				= "Definir distância"
L.RANGECHECK_SETTHRESHOLD			= "Definir limite para jogador"
L.RANGECHECK_SOUNDS					= "Sons"
L.RANGECHECK_SOUND_OPTION_1			= "Soar quando um jogador entrar na distância"
L.RANGECHECK_SOUND_OPTION_2			= "Soar quando mais de um jogador entrar na distância"
L.RANGECHECK_SOUND_0				= "Sem som"
L.RANGECHECK_SOUND_1				= "Som padrão"
L.RANGECHECK_SOUND_2				= "Bip irritante"
L.RANGECHECK_HIDE					= "Esconder"
L.RANGECHECK_SETRANGE_TO			= "%d m"
L.RANGECHECK_LOCK					= "Travar posição"
L.RANGECHECK_OPTION_FRAMES			= "Quadros"
L.RANGECHECK_OPTION_RADAR			= "Mostrar quadro do radar"
L.RANGECHECK_OPTION_TEXT			= "Mostrar quadro de texto"
L.RANGECHECK_OPTION_BOTH			= "Mostrar ambos"
L.RANGERADAR_HEADER					= "Radar (%d m)"

L.INFOFRAME_LOCK					= "Travar posição"
L.INFOFRAME_HIDE					= "Esconder"
L.INFOFRAME_SHOW_SELF				= "Sempre exibir seu poder"		-- Always show your own power value even if you are below the threshold

L.LFG_INVITE						= "Aceitar convite"

L.SLASHCMD_HELP						= {
	"Comandos disponíveis:",
	"/dbm unlock: Exibe uma barra de cronógrafo móvel. (ou: move).",
	"/range <number> or /distance <number>: Shows range frame. /rrange or /rdistance to reverse colors.",--Translate
	"/dbm timer: Starts a custom DBM timer, see '/dbm timer' for details.",--Translate
	"/dbm arrow: Exibe a seta do DBM, veja /dbm arrow help para detalhes.",
	"/dbm hud: Shows the DBM hud, see '/dbm hud' for details.",--Translate
	"/dbm help2: Shows raid management slash commands."--Translate
}
L.SLASHCMD_HELP2					= {
	"Comandos disponíveis:",
	"/dbm version: Realiza uma checagem de versão de toda a raid. (ou: ver).",
	"/dbm version2: Realiza uma checagem de versão de toda a raid e sussurra para avisando os membros que estão desatualizados (alias: ver2).",
	"/dbm break <min>: Inicia um cronógrafo de intervalo de <min> minutos. Dá a todos os integrantes da raid um cronógrafo de intervalo (requer status de líder/guia).",
	"/dbm pull <seg>: Dispara um cronógrafo para iniciar a luta em <seg> segundos. Dá a todos os integrantes da raid um cronógrafo para iniciar a luta (requer status de líder/guia).",
	"/dbm lockout: Pergunta a todos os membros da raid, por seus vínculos de raid (ou: lockouts, ids) (requer status de líder/guia).."
}
--Translate all of these
L.TIMER_USAGE						= {
	"DBM timer commands:",
	"/dbm timer <time> <text>: Starts a <x> second DBM Timer with the name <text>.",
	"/dbm ltimer <time> <text>: Starts a timer that also automatically loops until canceled.",
	"('Broadcast' in front of any timer also shares it with raid if leader/promoted)",
	"/dbm timer endloop: Stops any looping ltimer."
}

L.ERROR_NO_PERMISSION				= "Você não tem as permissões necessárias para fazer isso."

L.ALLIANCE							= "Aliança"
L.HORDE								= "Horda"

L.UNKNOWN							= "desconhecido"
L.LEFT								= "Esquerda"
L.RIGHT								= "Direita"
L.BACK								= "Atrás"
L.FRONT								= "A frente"
L.INTERMISSION						= "Intermissão"--No blizz global for this, and will probably be used in most end tier fights with intermission phases

L.BREAK_START						= "Intervalo começando agora -- você tem %s!"
L.BREAK_MIN							= "Intervalo encerra-se em %s minuto(s)!"
L.BREAK_SEC							= "Intervalo encerra-se em %s segundos!"
L.TIMER_BREAK						= "Intervalo!"
L.ANNOUNCE_BREAK_OVER				= "O intervalo acabou"

L.TIMER_PULL						= "Puxando em"
L.ANNOUNCE_PULL						= "Puxando em %d seg"
L.ANNOUNCE_PULL_NOW					= "Puxando agora!"

L.ACHIEVEMENT_TIMER_SPEED_KILL		= "Vitória mais rápida."

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS.target			= "%s: >%%s<"
L.AUTO_TIMER_TEXTS.cast				= "%s"
L.AUTO_TIMER_TEXTS.active			= "%s acaba" --Buff/Debuff/event on boss
L.AUTO_TIMER_TEXTS.fades			= "%s desvanece" --Buff/Debuff on players
L.AUTO_TIMER_TEXTS.cd				= "%s recarrega"
L.AUTO_TIMER_TEXTS.cdcount			= "%s recarrega (%%s)"
L.AUTO_TIMER_TEXTS.cdsource			= "%s recarrega: >%%s<"
L.AUTO_TIMER_TEXTS.next				= "Próx. %s"
L.AUTO_TIMER_TEXTS.nextcount		= "Próx. %s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource		= "Próx %s: >%%s<"
L.AUTO_TIMER_TEXTS.achievement		= "%s"

L.AUTO_TIMER_OPTIONS.target			= "Exibir cronógrafo para a penalidade $spell:%s"
L.AUTO_TIMER_OPTIONS.cast			= "Exibir cronógrafo para lançar $spell:%s"
L.AUTO_TIMER_OPTIONS.active			= "Exibir cronógrafo para a duração de $spell:%s"
L.AUTO_TIMER_OPTIONS.fades			= "Exibir cronógrafo para quando $spell:%s desvanecerá dos jogadores"
L.AUTO_TIMER_OPTIONS.cd				= "Exibir cronógrafo para recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdcount		= "Exibir cronógrafo para recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdsource		= "Exibir cronógrafo para recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.next			= "Exibir cronógrafo para o próximo $spell:%s"
L.AUTO_TIMER_OPTIONS.nextcount		= "Exibir cronógrafo para o próximo $spell:%s"
L.AUTO_TIMER_OPTIONS.nextsource		= "Exibir cronógrafo para o próximo $spell:%s"
L.AUTO_TIMER_OPTIONS.achievement	= "Exibir cronógrafo para %s"

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS.target		= "%s em >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) em >%%s<"
L.AUTO_ANNOUNCE_TEXTS.spell			= "%s"
L.AUTO_ANNOUNCE_TEXTS.adds			= "%s restantes: %%d"
L.AUTO_ANNOUNCE_TEXTS.cast			= "Lançando %s: %.1f seg"
L.AUTO_ANNOUNCE_TEXTS.soon			= "%s em breve"
L.AUTO_ANNOUNCE_TEXTS.prewarn		= "%s em %s"
L.AUTO_ANNOUNCE_TEXTS.stage			= "Fase %s"
L.AUTO_ANNOUNCE_TEXTS.prestage		= "Fase %s em breve"
L.AUTO_ANNOUNCE_TEXTS.count			= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack			= "%s em >%%s< (%%d)"

local prewarnOption					= "Exibir aviso antecipado para $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.target		= "Anunciar alvos de $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.targetcount	= "Anunciar alvos de $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.spell		= "Exibir aviso para $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.adds		= "Announce how many $spell:%s remain"
L.AUTO_ANNOUNCE_OPTIONS.cast		= "Exibir aviso quando $spell:%s está sendo lançado"
L.AUTO_ANNOUNCE_OPTIONS.soon		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.prewarn		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.stage		= "Anunciar Fase %s"
L.AUTO_ANNOUNCE_OPTIONS.prestage	= "Mostrar aviso antecipado para a Fase %s"
L.AUTO_ANNOUNCE_OPTIONS.count		= "Exibir aviso para $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.stack		= "Anunciar empilhamento de $spell:%s"

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS.spell 		= "Exibir aviso especial para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dispel 	= "Exibir aviso especial para remover/roubar $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interrupt	= "Exibir aviso especial para interromper $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.you 		= "Exibir aviso especial quando você é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youcount 	= L.AUTO_SPEC_WARN_OPTIONS.you--FIXME, Translate needed
L.AUTO_SPEC_WARN_OPTIONS.target 	= "Exibir aviso especial quando alguém é afetador por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.close 		= "Exibir aviso especial quando alguém próximo de você é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.move 		= "Exibir aviso especial quando você é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodge 		= L.AUTO_SPEC_WARN_OPTIONS.move--FIXME (this is a temp until localized properly as a dodge warning)
L.AUTO_SPEC_WARN_OPTIONS.run 		= "Exibir aviso especial para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.cast 		= "Exibir aviso especial para o lançamento de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack 		= "Exibir aviso especial para pilha >=%d de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switch		= "Exibir aviso especial para mudar de alvo para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switchcount = L.AUTO_SPEC_WARN_OPTIONS.switch--FIXME, Translate needed
L.AUTO_SPEC_WARN_OPTIONS.interruptcount = L.AUTO_SPEC_WARN_OPTIONS.interrupt--FIXME, Translate needed

L.AUTO_SPEC_WARN_TEXTS.spell		= "%s!"
L.AUTO_SPEC_WARN_TEXTS.dispel		= "%s em >%%s< - remova agora"
L.AUTO_SPEC_WARN_TEXTS.interrupt	= "%s - interrompa >%%s<"
L.AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - interrompa >%%s< (%%d)"
L.AUTO_SPEC_WARN_TEXTS.you			= "%s em você"
L.AUTO_SPEC_WARN_TEXTS.youcount		= "%s (%%s) em você"
L.AUTO_SPEC_WARN_TEXTS.target		= "%s em >%%s<"
L.AUTO_SPEC_WARN_TEXTS.close		= "%s em >%%s< perto de você"
L.AUTO_SPEC_WARN_TEXTS.move			= "%s - saia de perto"
L.AUTO_SPEC_WARN_TEXTS.dodge 		= L.AUTO_SPEC_WARN_TEXTS.move--FIXME (this is a temp until localized properly as a dodge warning)
L.AUTO_SPEC_WARN_TEXTS.jump			= "%s - salte"
L.AUTO_SPEC_WARN_TEXTS.run			= "%s - corra para longe"
L.AUTO_SPEC_WARN_TEXTS.cast			= "%s - pare de lançar"
L.AUTO_SPEC_WARN_TEXTS.stack		= "%s (%%d)"
L.AUTO_SPEC_WARN_TEXTS.switch		= "%s - mude de alvo"
L.AUTO_SPEC_WARN_TEXTS.switchcount	= "%s - mude de alvo (%%s)"


L.AUTO_ICONS_OPTION_TEXT			= "Colocar ícones nos alvos de $spell:%s"
L.AUTO_ICONS_OPTION_TEXT2			= "Set icons on $spell:%s"
L.AUTO_YELL_OPTION_TEXT.yell		= "Gritar quando você é afetado por $spell:%s"
L.AUTO_YELL_ANNOUNCE_TEXT.yell		= "%s em " .. UnitName("player") .. "!"


-- New special warnings
L.MOVE_SPECIAL_WARNING_BAR			= "Aviso especial móvel"
L.MOVE_SPECIAL_WARNING_TEXT			= "Aviso especial"


L.RANGE_CHECK_ZONE_UNSUPPORTED		= "Medição de distância de %d metros não suportada nessa zona.\nAs distâncias suportadas são 10, 11, 15 e 28 metros."

L.ARROW_MOVABLE						= "Seta móvel"
L.ARROW_ERROR_USAGE					= {
	"Uso da seta do DBM:",
	"/dbm arrow <x> <y>  cria uma seta que aponta para um local específico (0 < x/y < 100)",
	"/dbm arrow <jogador>  cria uma seta que aponta para um jogador específico no seu grupo",
	"/dbm arrow hide  esconde a seta",
	"/dbm arrow move  torna móvel a seta"
}

L.SPEED_KILL_TIMER_TEXT				= "Vitória em tempo recorde"

L.REQ_INSTANCE_ID_PERMISSION		= "%s solicitou suas IDs de instância e progresso atuais.\nVocê deseja enviar essa informação para %s? Ele(a) poderá requisitar essa informação durante a sessão atual (i. e. até que você reconecte)."
L.ERROR_NO_RAID						= "Você precisa estar em um grupo de raide para utilizar essa funcionalidade."
L.INSTANCE_INFO_REQUESTED			= "Enviadas requisições de vínculos de raid para o grupo.\nPor favor, note que a permissão dos usuários será solicitada antes de os dados serem enviados para você, portanto pode levar um minuto para que você receba todas as respostas."
L.INSTANCE_INFO_STATUS_UPDATE		= "Recebidas respostas de %d jogadores de um total de %d usuários do DBM: %d enviaram os dados, %d negaram a solicitação. Esperando mais %d segundos pelas respostas restantes..."
L.INSTANCE_INFO_ALL_RESPONSES		= "Recebidas respostas de tosos os membros da raid"
L.INSTANCE_INFO_DETAIL_DEBUG		= "Sender: %s ResultType: %s InstanceName: %s InstanceID: %s Difficulty: %d Size: %d Progress: %s"
L.INSTANCE_INFO_DETAIL_HEADER		= "%s, dificuldade %s:"
L.INSTANCE_INFO_DETAIL_INSTANCE		= "    ID %s, progresso %d: %s"
L.INSTANCE_INFO_DETAIL_INSTANCE2	= "    progresso %d: %s"
L.INSTANCE_INFO_STATS_DENIED		= "Negou a solicitação: %s"
L.INSTANCE_INFO_STATS_AWAY			= "Ausente: %s"
L.INSTANCE_INFO_STATS_NO_RESPONSE	= "Não possui uma versão recente do DBM instalada: %s"
L.INSTANCE_INFO_RESULTS				= "Resultados da busca por  IDs de raid. Note que instâncias podem aparecer mais de uma vez, se houver jogadores com clientes de WoW em outra língua."
L.INSTANCE_INFO_SHOW_RESULTS		= "Jogadores que ainda não responderam: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Exibir resultados agora]|r|h"
