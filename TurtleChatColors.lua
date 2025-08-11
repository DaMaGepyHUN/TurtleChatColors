-- vanilla 1.12	+ TurtleWoW
--- .hcmessages 60 		turns off all death message below 60
--- alt+0177 = �  (+-)
--- damagepyhun@gmail.com

TurtleChatColorsVer = 1.31
local gspecial = false
local tccGuildBrackets = 1
local CLORANGE = "|cFFEEDD55"
local CDYELLOW = "|cFFC9CC00"
local CGUILD = "|cFF3CE13F"
local CYELLOW = "|cFFFFFF00"
local CGREEN = "|cFF00FF00"
local CDGREEN = "|cFF00BB00"
local CBLUE = "|cFF7070FF"
local CWHITE = "|cFFFFFFFF"
local CORANGE = "|cFFFF8000"
local CBROWN = "|cFFFFB080"
local CPURPLE = "|cFFD060D0"
local CPINK = "|cFFFF80FF"
local CRED = "|cFFFF0000"
local CLRED = "|cFFFF8080"
local CLLRED = "|cFFFFA8A8"
local CLGREEN = "|cFF80FF80"
local CLLGREEN = "|cFFDDFF88"
local CLGRAY = "|cFFC0C0C0"
local CBGRAY = "|cFFC0E0E0"
local CGRAY  = "|cFF888888"
local CDGRAY = "|cFF707070"
local CLBLUE = "|cFF40FFFF"
local CEND = "|r"
local CMYCOLOR = "|cFFFF8060"
local CSTART = CBLUE.."-"..CYELLOW.."-"..CBLUE.."- ";
local TurtleChatColorsHooked = false
local grip = CLRED.." RIP"..CRED.." :("
local gripmsg = false
local grelayer = false
local TurtleChatColors_Names = {};
local TurtleChatColors_Level = {};
local GSnum = 0
local CSV = ""



CSV = "zulgurub=Zul'Gurub,loch modan=LochModan,crescent grove=CrescentGrove,gilneas city=GilneasCity,scarlet monastery=ScarletMonastery,guild base=GuildBase,guild bank=GuildBank,zul gurub=Zul'Gurub"
CSV=CSV..",blackwing lair=BlackwingLair,wailing cavern=WailingCavern,molten core=MoltenCore,dire maul=DireMaul,dm east=DM:east,dm north=DM:north,dm west=DM:west,sunken temple=SunkenTemple"
CSV=CSV..",zul farrak=Zul'Farrak,zul farak=Zul'Farrak,brd princess=BRD:princess,black morass=BlackMorass,blackfathom deep=BlackfathomDeep,razorfen downs=RazorfenDowns,razorfen kraul=RazorfenKraul"
CSV=CSV..",ragefire chasm=RagefireChasm,shadowfang keep=ShadowfangKeep,maraudon princess=Maraudon:princess,mara princess=Mara:princess,full run=Full-run,q run=Quest-run,quest run=Quest-run,arm cath=Cath-Arms"
CSV=CSV..",xp farm=XP-farm,xp run=XP-run,exp run=XP-run,elite quest=Elite-quest,aoe run=AoE-run,aoe farming=AoE-farming,aoe farm=AoE-farm,last spot=last-spot,emp run=Emp-run,emperor run=Emperor-run,jail break=JailBreak"
CSV=CSV..",main tank=MainTank,turtle wow=TurtleWoW,alterac valley=AlteracValley,warsong gulch=WarsongGulch,need mt=Need:MT,need ot=Need:OT,project epoch=project:Epoch,project ascension=project:Ascension"
CSV=CSV..",arcanite transmute=Arcanite-Transmute,pvp=PvP,pve=PvE,wpvp=wPvP,turtle mount=turtle-mount,darkmoon faire=DarkmoonFaire,strat undead=Strat:UD,sm arm=SM:Arm,hateforge quarry=HateforgeQuarry"
CSV=CSV..",vanilla wow=VanillaWoW,ranged dps=ranged-DPS,melee dps=melee-DPS,dmwest=DM:West,dmeast=DM:East,dmnorth=DM:North,cath/arms=Cath-Arms,arathi basin=ArathiBasin,first aid=FirstAid,war mode=WarMode"
CSV=CSV..",feral druid=FeralDruid,resto druid=RestoDruid,combat log=CombatLog,arms sm=SM:Arm,booty bay=BootyBay,lava run=lava-run,kara 10=Kara10,flight path=FlightPath,sw gates=SW:gates,aq 40=AQ40"
CSV=CSV..",princess run=princess-run,maraudon princess run=Maraudon:Princess-run,leveling guild=leveling-Guild,escort quest=escort-quest,guild leader=GuildLeader,guild invite=Guild-invite"
CSV=CSV..",emerald sanctum=EmeraldSanctum,guild charter=Guild-charter,raid times=raid-times"
local cPos,chReplace1,chReplace2 = nil,{},{};  for part in string.gmatch(CSV, "([^,]+)") do cPos=strfind(part,"="); if cPos then table.insert(chReplace1,strsub(part,1,cPos-1)); table.insert(chReplace2,strsub(part,cPos+1)); end end

CSV = "lf,lfm,lfg,lf1m,lf2m,lf3m,lf4m,wtb,wts,wtt,brd,lbrs,ubrs,bwl,zg,zf,dmw,dme,dmn,epl,wpl,stv,sm,hfq,aq,aq20,aq40,mc,dmf,dps"
local chatUP = {}; for part in string.gmatch(CSV, "([^,]+)") do if part~="" then table.insert(chatUP, part) end end-- convert to uppercase before all

CSV = "ES,BB,BM,FARM,QUEST,ARM,AH,IF";
local chLocBig   = {};  for part in string.gmatch(CSV, "([^,]+)") do if part~="" then table.insert(chLocBig, part) end end

CSV = "elites,elite,lochmodan,redridge,wetlands,wetland,gbase,guildbase,gbank,guildbank,dmf,stv,wpl,blackmorass,morass,westfall,arathi,mulgore,hogger"
CSV=CSV..",sw,stormwind,ironforge,darnassus,darna,darn,undercity,uc,thunderbluff,tb,orgrimmar,orgri,org,ogri,sw:gates"
CSV=CSV..",silithus,duskwood,westfall,bootybay,ratchet,everlook,gadgetzan,desolace,elwynn,ashenvale,darkshore,darkshire,lakeshire,tanaris,un'goro"
CSV=CSV..",deadmines,deathmines,deathmine,deadmine,dm,vc,wailingcaverns,wailingcavern,wc,stockades,stockade,crescentgrove,cg,gnomeregan,gnomer,ragefirechasm,rfc,sm:armory"
CSV=CSV..",blackfathomdeeps,blackfathomdeep,blackfathom,bfd,razorfendowns,razorfen,rfd,razorfenkraul,rfk,rr,shadowfangkeep,sfk,swv,stranglethorn,princess-runs,maraudon:princess-runs,atal'hakkar,atal'hakar"
CSV=CSV..",scarletmonastery,sm,graveyard,graveyards,gy,library,lib,cathedral,cath,armory,cath-arms,sm:arms,sm:arm,gilneascity,gilneas,gc,sunkentemple,st,uldaman,ulda,zul'farrak,zulfarrak,zulfarak,zf,maraudon,mara,maraudon:princess,mara:princess"
CSV=CSV..",hfq,hateforgequarry,hateforge,scholomance,scholo,stratholme,strath,strat,ud,strat:ud,live,brm,brd,arena,jed,brd:princess,lbrs,ubrs,rend,diremaul,dm,dme,dm:e,dmn,dm:n,dmw,dm:w,dm:,dm:east,dm:north,dm:west,tribute,trib"
CSV=CSV..",karazhan,kara,kara10,kara20,kara40,zulgurub,zul'gurub,zg,onyxia,ony,nefarian,nefa,hyjal,emeraldsanctum"
CSV=CSV..",moltencore,mc,blackwinglair,bwl,ahn'qiraj,ahnqiraj,aq,aq20,aq40,naxxramas,naxramas,naxx,nax"
local chLocation = {};  for part in string.gmatch(CSV, "([^,]+)") do if part~="" then table.insert(chLocation, part) end end
local CLOCATION = "|cFFEAFFA3" -- LGreen

CSV = "tank,tanks,dps,mt,ot,offtank,maintank,1heal,1tank,1dps,2dps,3dps,escort,healer,healers,heal,healz,heals,fullrun,full-run,last-spot,questrun,quest-run,xp-farm,xp-run,quest-runs,xp-runs,wanted:"
CSV=CSV..",elite-quest,elite-quests,aoe-runs,aoe-run,aoe,aoe-farm,aoe-farming,emp-run,emperor,lotus,eels,petri,middleman,middle-man,7d,emp,xp,jailbreak,reputation,repu,gm,gm's,need:all,caster,congrats,gratz,grats,grat"
CSV=CSV..",enchanter,enchanting,enchants,ench,tailor,alch,alchemist,crafter,questline,lockboxes,lockbox,need:mt,need:ot,transmute,fountain,turtle-mount,arcanite-transmute,jc,jewelcrafter,escort-quest,engineer,leatherworker,lw"
CSV=CSV..",seller,pug,ranged-dps,melee-dps"
local chGreen = {}; for part in string.gmatch(CSV, "([^,]+)") do if part~="" then table.insert(chGreen, part) end end
local CROLEGREEN = "|cFFC0F001" -- YellowyGreen

CSV = "lava,lava-run,lava-runs,hc,hcs,hardcore,hardcores,inferno,immortal,rip,f,wtf,pvp,wpvp,showtooltip,nohelf,:nohelf,afk,dnd,oom,<AFK>,mailbox,pm,pst,w,retail,dkp,dkps,addons,addon,cooking,firstaid"
CSV=CSV..",bg,battleground,battlegrounds,alteracvalley,av,wsg,ab,arathibasin,warsonggulch,warsong,twink,twinks,battlemasters,battlemaster,horde,combatlog,stitches,oops,nvm"
CSV=CSV..",spam,spamming,reported,ignore,ignoring,bot,bots,lunatic,warmode,gank,ganker,gankers,ganking,lag,lags,lagging,disconnect,disconnecting,disconnects,cod,nerfed,bugged"
local chRed = {}; for part in string.gmatch(CSV, "([^,]+)") do if part~="" then table.insert(chRed, part) end end
local CLIGHTRED = "|cFFFF9999" -- LRed

CSV = "lf,lfg,lfm,lf1,lf2,lf3,lf4,lf1m,lf2m,lf3m,lf4m,lf5m,lfw,eu,na,en,group,que,queue,opening,alliance,selling,vanillawow,port,portal,fp,flightpath,flightpaths,bigwigs,bigwig,trainer,trainers,discord,ascension,epoch"
CSV=CSV..",summon,summons,sum,summ,summoning,recruiting"
local chBlue = {}; for part in string.gmatch(CSV, "([^,]+)") do if part~="" then table.insert(chBlue, part) end end
local CLFMBLUE = "|cFF66DDFF" -- Blue

CSV = "wts,wtb,wtt,twow,guild,guildleader,leveling-guild,tent,tents,pve,macro,macros,google,wiki,attune,attunement,attu,SR,ambershire,nordanaar,vendor,vendors,bijou,bijous,raiding,raiders,gardening,rmt,turtlewow"
CSV=CSV..",guild-charter,raid-times"
local chLGreen = {}; for part in string.gmatch(CSV, "([^,]+)") do if part~="" then table.insert(chLGreen, part) end end
local CWTSGREEN = "|cFF80FF80" -- Green




local acc1alts = {"Damagepy","Gepygnum","Gepybankhc","Frostgepy","Catmedic","Gungnumgepy","Gepy","Hotmedic","Gepybank","__"}
local acc2alts = {"Coldgepy","Gnumage","Gepymage","Dragontamer","Gungepy","Magepy","Hungepy","Chillgepy","Minigepy","Gepygepy","__"}
local acc3alts = {"Holymedic","Gepygepy","Treemedic","__"}
local ketoalts = {"___","Bowenjoyer","Bucklepusher","Greenmarine","Hcengbanksix","Hcmedic","Hcmetal","Hcportals","Hctextiles","Ketotemic","Ketotemstan","Proxywar","Wandpusher","Wandzugger","___","___","___","___","___","___","___","___","___"}
		
function gkiir(kirtxt) if kirtxt then DEFAULT_CHAT_FRAME:AddMessage(CSTART..CMYCOLOR..kirtxt..CEND); end end
function DCFmsg(dcftxt) if dcftxt then DEFAULT_CHAT_FRAME:AddMessage(dcftxt); end end
function CharChain(scc,scn)	local sctxt=""; if scc and scn then for i=1,scn do sctxt=sctxt..scc end end return sctxt end





function TCCHighlightStrs (message)
  if (message ~= "") and (message ~= nil) then
	if string.upper(strsub(message,-2))==":(" then message=strsub(message,1,-2)..CLRED..":("
	elseif string.upper(message)=="GZ" or string.upper(message)=="GZ!" then message=CWTSGREEN..message
	end
	
	-- Replaces in original string, before word-splitting
	local s,e
	local lmessage = strlower(message)
	for tcf = 1,table.getn(chReplace1) do 
		s,e = strfind(lmessage, chReplace1[tcf])
		if s and e then 
			message = strsub(message,1,s-1)..chReplace2[tcf]..strsub(message,e+1);
			s,e = strfind(strlower(message), chReplace1[tcf]) -- again (2x)
			if s and e then message = strsub(message,1,s-1)..chReplace2[tcf]..strsub(message,e+1); end
		end
	end
	
	-- SPLIT: stxt[] / wtxt[]
	local num = 0  -- number of words
	local seps = " .,?!;/()+=@&#*"
	local stxt, wtxt = {},{}
	local sep,word,chr = "","",""				
	if (message ~= "") and (message ~= nil) then
		for i = 1, strlen(message) do
			chr = strsub(message,i,i)
			if IsIn(seps,chr) then	-- separator
				if strlen(word)>0 then
					wtxt[num] = word
					num = num+1
					word = ""
					sep = ""
				end
				sep = sep..chr
			else					-- WORD
				if strlen(sep)>0 or i==1 then 
					if i==1 then num = num+1 end
					stxt[num] = sep
					sep = ""
					word = ""
				end
				word = word..chr
			end
		end
		if strlen(sep)>0 then stxt[num] = sep; num=num-1 
		elseif strlen(word)>0 then wtxt[num] = word; stxt[num+1]="" end
	end	
	
	-- PARSING word-by-word
	for wrd = 1,num do 
		seps = strlower(wtxt[wrd])
		-- UPPERCASE some word 
		for tcf = 1,table.getn(chatUP) do   if seps==chatUP[tcf] then wtxt[wrd]=strupper(wtxt[wrd]); end end
		-- only highlight if exactly the same --> CLOCATION color
		for tcf = 1,table.getn(chLocBig) do   if wtxt[wrd] == chLocBig[tcf] then wtxt[wrd] = CLOCATION..wtxt[wrd].."|r"; seps=""; end end
		-- chLocation --> CLOCATION color
		for tcf = 1,table.getn(chLocation) do   if seps == chLocation[tcf] then wtxt[wrd] = CLOCATION..wtxt[wrd].."|r";	end end
		-- chGreen --> CROLEGREEN color
		for tcf = 1,table.getn(chGreen) do   if seps == chGreen[tcf] then wtxt[wrd] = CROLEGREEN..wtxt[wrd].."|r"; end end
		-- chRed --> CLIGHTRED color
		for tcf = 1,table.getn(chRed) do   if seps == chRed[tcf] then wtxt[wrd] = CLIGHTRED..wtxt[wrd].."|r"; end end
		-- chBlue --> CLFMBLUE color
		for tcf = 1,table.getn(chBlue) do   if seps == chBlue[tcf] then wtxt[wrd] = CLFMBLUE..wtxt[wrd].."|r"; end end
		-- chLGreen --> CWTSGREEN color
		for tcf = 1,table.getn(chLGreen) do   if seps == chLGreen[tcf] then wtxt[wrd] = CWTSGREEN..wtxt[wrd].."|r"; end end
		-- Classes
		if seps=="mage" or seps=="mages" or seps=="frostmage" or seps=="frostmages" then wtxt[wrd] = "|cff69ccf0"..wtxt[wrd].."|r"; end
		if seps=="warlock" or seps=="warlocks" then wtxt[wrd] = "|cff9482c9"..wtxt[wrd].."|r"; end
		if seps=="priest" or seps=="priests" or seps=="holypriests" then wtxt[wrd] = "|cffffffff"..wtxt[wrd].."|r"; end
		if seps=="druid" or seps=="druids" or seps=="restodruid" or seps=="feraldruid" or seps=="boomkin" or seps=="boomkins" or seps=="moonkins" or seps=="moonkin" then wtxt[wrd] = "|cffff7d0a"..wtxt[wrd].."|r"; end
		if seps=="shaman" or seps=="shamans" then wtxt[wrd] = "|cff0070de"..wtxt[wrd].."|r"; end
		if seps=="paladin" or seps=="paladins" or seps=="retri" or seps=="retpal" or seps=="retpala" then wtxt[wrd] = "|cfff58cba"..wtxt[wrd].."|r"; end
		if seps=="rogue" or seps=="rogues" or seps=="rouge" then wtxt[wrd] = "|cfffff569"..wtxt[wrd].."|r"; end
		if seps=="hunter" or seps=="hunters" or seps=="huntard" or seps=="hunt" then wtxt[wrd] = "|cffabd473"..wtxt[wrd].."|r"; end
		if seps=="warrior" or seps=="warriors" then wtxt[wrd] = "|cffc79c6e"..wtxt[wrd].."|r"; end
	end
	if wtxt[1] then
		if strsub(strlower(wtxt[1]),1,3)=="wts" or strsub(strlower(wtxt[1]),1,3)=="wtb" then wtxt[1] = CWTSGREEN..strupper(strsub(wtxt[1],1,3)).."|r"..strsub(wtxt[1],4); end end

	-- Merge everything back together
	message = ""; for i = 1,num do message = message..stxt[i]..wtxt[i] end message = message..stxt[num+1]		
	message = string.gsub(message, "%+%-", "\194\177");
	message = string.gsub(message, "%-%+", "\194\177");
	message = string.gsub(message, ":%(", CLRED..":%(|r");
	message = string.gsub(message, "<AFK>", CLRED.."<AFK>|r");
  end 
  return message
end


function IsIn (iitxt, iichr) -- string contains the char?
	if strlen(iichr)>0 and strlen(iitxt)>0 then	
		for iif = 1,strlen(iitxt) do 
			if strsub(iitxt,iif,iif)==strsub(iichr,1,1) then return true end 
		end
	end	
	return false
end




function CheckIfGAnn() -- My personal announcement... if I'm online on both acc, then only one of them will announce to the guild
	local gann = false
	if gspecial then
		local myname = UnitName("player")
		local curacc = 0
		local acc1,acc2,acc3 = false,false,false;
		gann = true		
		for acchk = 1,table.getn(acc1alts) do 
			if acc1alts[acchk]==myname then curacc=1; end
			local _,_,_,_,online = GetGuildMemberInfo(acc1alts[acchk]);	if online then acc1 = acchk; end
		end		
		for acchk = 1,table.getn(acc2alts) do 
			if acc2alts[acchk]==myname then curacc=2; end; 
			local _,_,_,_,online = GetGuildMemberInfo(acc2alts[acchk]);	if online then acc2 = acchk; end
		end
		for acchk = 1,table.getn(acc3alts) do 
			if acc3alts[acchk]==myname then curacc=3; end; 
			local _,_,_,_,online = GetGuildMemberInfo(acc3alts[acchk]);	if online then acc3 = acchk; end
		end
		if curacc==1 then gann=true else gann=false end
		if curacc==2 and (acc1==false) then gann=true else gann=false end
		if curacc==3 and (acc1==false and acc2==false) then gann=true else gann=false end
		--[[
		if acc1 then gkiir("Acc1: "..acc1alts[acc1]) end
		if acc2 then gkiir("Acc2: "..acc2alts[acc2]) end
		gkiir("I am on acc "..curacc)
		if gann then gkiir("GAnn: ON") else gkiir("GAnn: --") end
		]]
	end
	return gann
end

function TurtleChangeGuildChat (message)
	if string.upper(message)=="F :(" or string.upper(message)=="RIP" or string.upper(message)=="F" or string.upper(message)=="FF" then message=CLRED..string.upper(message);
	elseif string.upper(strsub(message,-2))==" F" then message=strsub(message,1,-2)..CLRED.."F";
	elseif string.upper(strsub(message,-4))==" RIP" then message=strsub(message,1,-4)..CLRED..strsub(message,-3);
	elseif string.upper(strsub(message,-5))==" F :(" then message=strsub(message,1,-5)..CLRED.."F :(";
	end
	if strsub(message,1,1)=="+" then message=CDUNG.."+|r"..strsub(message,2); end
	local a,b = string.find(message,"%[")
	local c,d = string.find(message,"%]")
	local e,f = string.find(message,"@")
	local g,h = string.find(message," ")
	if ((a and c and a<3 and b<c) or (e and g and e<3 and f<g)) and (not string.find(message,"cleanchat")) then
		local hName,gname,i
		if (a and c and a<3 and b<c) then hName = strsub(message,b+1,c-1) else hName = strsub(message,f+1,g-1); end
		gname = hName
		gReadRoster();
		i = string.find(gname," "); if i then gname=strsub(gname,1,i-1) end
		i = string.find(gname,"%("); if i then gname=strsub(gname,1,i-1) end
		i = string.find(gname,"/"); if i then gname=strsub(gname,1,i-1) end		
		gname = string.upper(strsub(gname,1,1))..string.lower(strsub(gname,2)) -- first character uppercase, rest lowercase
		local level,hClass = GetGuildMemberInfo(gname)
		local hColor = CLGRAY;
		if level then 
			if not hClass then hClass=""; end
			hColor = TurtleChatColors_GetClassColor(string.upper(hClass));
		end
		if (a and c and a<3 and b<c) then message = "["..hColor..hName.."|r]"..strsub(message,d+1);
									 else message = "@"..hColor..hName.."|r"..strsub(message,h); end
	end
	message = TCCHighlightStrs(message)
	return message
end



function TurtleChangeSystem (message)	-- special characters (must escape with %):   ( ) . % + - * ? [ ^ $
	local wasokk = false;
	local omessage = message;
	if message then	
		local a,b,c,d,e,f,g,h
		local HCstars=1
		local color, level,   hName,hNameLink, hLevel, hClass, hColor,   hKiller, hKillerLvl,  hZone, hNote, oNote, hZoneCut;
		
		if strsub(message,1,9)=="A tragedy" then 
			gReadRoster();
			if not (string.find(message," natural") or string.find(message," burned") or string.find(message," drowned") or string.find(message,"in PvP")) then -- MOB death
			-- A tragedy has occurred. Hardcore/Inferno character XXX (level NN) has fallen to YY1 YY2 (level 37) in ZZZ. May this sacrifice not be forgotten. --
				hLevel=1;
				_,a = string.find(message," character ");
				b,f = string.find(message," %(level ");
				g,_ = string.find(message,"%) has fallen to");
				hName = strsub(message,a+1,b-1);
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				_,a = string.find(message,"fallen to ");
				b,c = string.find(message," %(level ",f);
				d,e = string.find(message,"%) in ");
				h,_ = string.find(message,". May");
				if e and h then hZoneCut = strsub(message,e+1,h-1) end
				if f and g then	hLevel = tonumber(strsub(message,f+1,g-1));	end
				if hLevel==60 or hLevel=="60" then h,_ = string.find(message,". They"); end
				if not h then h="??"; end
				if a and b and c and d then
					hKiller = strsub(message,a+1,b-1);
					hKillerLvl = tonumber(strsub(message,c+1,d-1));
					if not (hKiller and hKillerLvl) then gkiir("ERROR!  hKiller / hKillerLvl = nil") end
					--_,a = string.find(message," at level ");
					--b,_ = string.find(message,". May this");
					--hLevel = tonumber(strsub(message,a+1,b-1));
				else hKiller="??"; hKillerLvl="?"; end
				level,hClass,hZone,hNote,_,oNote = GetGuildMemberInfo(hName)
				if not level then level=hLevel; end
				if not level then _,level = TurtleChatColors_ClassData(string.upper(hName)); if level then gReadRoster(); level,hClass,hZone,hNote,_,oNote = GetGuildMemberInfo(hName); end end -- retry if not in guild
				if level and e and h then -- is in the guild, can get more info (class, location)
					if h~="??" then 
						if not hZone or hZone=="" then hZone = strsub(message,e+1,h-1); end	
					end			
					if not hClass then hClass=""; end
					hColor = TurtleChatColors_GetClassColor(string.upper(hClass))
				else hColor=CLGRAY; hClass=""; hNote=nil; end
				if hZone==nil then hZone=hZoneCut end
				if hZone==nil then hZone="??" elseif string.find(hZone,"\\'") then hZone = string.gsub(hZone, "\\'", "'") end
				if hKillerLvl==nil then gkiir("ERROR! hKillerLvl nil"); hKillerLvl="?" end
				if hLevel==nil then gkiir("ERROR! hLevel nil"); hLevel="?"; HCstars=1; else HCstars = math.floor(hLevel/10) end
				if hKillerLvl=="?" or hLevel=="?" or hLevel<10 then gkiir(CYELLOW..message);
				elseif level and GetGuildMemberInfo(hName)~=nil then -- a guildie
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death".."!"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..": "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."has fallen to:\n";
					message = message.."   "..CharChain(" ",math.floor((HCstars+1)*1.3))..CLLRED..hKiller..CDGRAY.." ("..CLRED..hKillerLvl..CDGRAY..")"..CLORANGE.." @ ".."|cFFAA9999"..hZone
					if oNote then message = message..CGRAY.." ("..oNote..")" end
					if gripmsg then message = message..grip; end
					if hNote then hNote=CGRAY.."("..hNote..")|r "; else hNote="" end 
					if gspecial and hName~=UnitName("player") and CheckIfGAnn() then 
						SendChatMessage("We lost "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r "..hNote..": "..CLLRED..hKiller.."|r "..CLRED..hKillerLvl.."|r @ "..hZone..", F :(","GUILD"); 
						SendChatMessage("Rest In Peace brave "..hClass.."... we hope you go agane :(","WHISPER",nil,hName); 
					end
					wasokk=true;
				else -- not in guild
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..":  "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."<< ";
					message = message..CLLRED..hKiller..CDGRAY.." ("..CLRED..hKillerLvl..CDGRAY..") "..CLORANGE.."@ |cFFAA9999"..hZone
					if gripmsg then message = message..grip; end
					local rtarget="GUILD"; rtarget="hardcore";					
					if gspecial and hName~=UnitName("player") then 
						if string.find(hKiller,"Tunnel Rat") then SendChatMessage("Tunnel rats rule!",rtarget);	end 
					end
					wasokk=true;
				end
			elseif string.find(message,"in PvP") then
			-- A tragedy has occurred. Hardcore character XXX (level NN) has fallen in PvP to XXX (level NN) in ZZZ. May this sacrifice not be forgotten. --
				--omessage = message;
				_,a = string.find(message," character ");
				b,f = string.find(message," %(level ");
				g,_ = string.find(message,"%) has fallen");
				hName = strsub(message,a+1,b-1);
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				_,a = string.find(message,"in PvP to ");
				b,c = string.find(message," %(level ",f);
				d,e = string.find(message,"%) in ");
				h,_ = string.find(message,". May");
				if e and h then hZoneCut = strsub(message,e+1,h-1) end
				if not h then h,_ = string.find(message,". They"); if not h then h="??"; omessage=message; end; end
				if f and g then	hLevel = tonumber(strsub(message,f+1,g-1));	end
				if a and b and c and d then
					hKiller = strsub(message,a+1,b-1);
					kLevel = tonumber(strsub(message,c+1,d-1));
					if not (hKiller and kLevel) then gkiir("ERROR!  hKiller / hLevel = nil"); kLevel=1; end
				else hKiller="??"; kLevel=1; end
				level,hClass,hZone,hNote_,oNote = GetGuildMemberInfo(hName)
				if not level then level=hLevel; end
				if not level then _,level = TurtleChatColors_ClassData(string.upper(hName)); if level then gReadRoster(); level,hClass,hZone,hNote,_,oNote = GetGuildMemberInfo(hName); end end -- retry if not in guild
				if level then -- is in the guild, can get more info (class, location)
					if not hZone or hZone=="" then hZone = strsub(message,e+1,h-1); end					
					if hClass==nil then hClass=""; end
					hColor = TurtleChatColors_GetClassColor( string.upper(hClass) );					
				else hColor=CLGRAY; hClass=""; hNote=nil; end
				if hLevel==nil then gkiir("ERROR! hLevel nil"); hLevel="?"; HCstars=1; else HCstars = math.floor(hLevel/10) end
				if hZone==nil then hZone="??" elseif string.find(hZone,"\\'") then hZone = string.gsub(hZone, "\\'", "'") end
				if hLevel=="?" or hLevel<10 then gkiir(CYELLOW..message);
				elseif level and GetGuildMemberInfo(hName)~=nil then -- a guildie
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death".."!"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..": "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."was killed in "..CLLRED.."PvP"..CLORANGE.." by:\n";
					message = message.."   "..CharChain(" ",math.floor((HCstars+1)*1.3))..CLLRED..hKiller..CGRAY.." ("..CRED..kLevel..CGRAY..") "..CLORANGE.." @ ".."|cFFAA9999"..hZone
					if oNote then message = message..CGRAY.." ("..oNote..")" end
					if gripmsg then message = message..grip; end
					if hNote then hNote=CGRAY.."("..hNote..")|r "; else hNote="" end 
					if gspecial and hName~=UnitName("player") and CheckIfGAnn() then 
						SendChatMessage("We lost "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r "..hNote.."in PvP @ "..hZone..", F :(","GUILD"); 
						SendChatMessage("Rest In Peace brave "..hClass.."... we hope you go agane :(","WHISPER",nil,hName); 
					end
					wasokk=true;
				else -- not in guild
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..":  "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."in "..CLLRED.."PvP"..CLORANGE.." by ";
					message = message..CLLRED..hKiller..CGRAY.." ("..CRED..kLevel..CGRAY..") "..CLORANGE.." @ ".."|cFFAA9999"..hZone
					if gripmsg then message = message..grip; end
					wasokk=true;
				end
			elseif string.find(message,"natural cau") or string.find(message," burned to ") or string.find(message," has drowned") then
			-- A tragedy has occurred. Hardcore character XXX (level NN) died of natural causes in ZZ. May this sacrifice not be forgotten. --
			-- 														   ) has burned to death in ZZ. May
				local hcause = "";
				_,a = string.find(message," character ");
				b,f = string.find(message," %(level ");
				g,_ = string.find(message,"%) died");
				_,e = string.find(message,"causes in ");
				if e then hcause = CLORANGE.."natural causes"
				else
					g,_ = string.find(message,"%) has burned"); 
					_,e = string.find(message,"to death in ");
					if g then hcause = CLRED.."burned"..CLORANGE.." to death"
					else
						g,_ = string.find(message,"%) has drowned"); 
						_,e = string.find(message,"drowned in ");
						if g then hcause = CLBLUE.."drowned"
						end
					end
				end
				h,_ = string.find(message,". May");
				if not h then h,_ = string.find(message,". They"); if not h then h="??"; omessage=message; end; end
				if hLevel==60 or hLevel=="60" then h,_ = string.find(message,". They"); end
				hName = strsub(message,a+1,b-1);
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				if f and g then	hLevel = tonumber(strsub(message,f+1,g-1));	else hLevel=1; end
				level,hClass,hZone,hNote_,oNote = GetGuildMemberInfo(hName)
				if not level then level=hLevel; end
				if not level then _,level = TurtleChatColors_ClassData(string.upper(hName)); if level then gReadRoster(); level,hClass,hZone,hNote,_,oNote = GetGuildMemberInfo(hName); end end -- retry if not in guild
				if level then -- is in the guild, can get more info (class, location)
					if not hZone or hZone=="" then hZone = strsub(message,e+1,h-1); end					
					if not hClass then hClass=""; end
					hColor = TurtleChatColors_GetClassColor( string.upper(hClass) );					
				else hColor=CLGRAY; hClass=""; hNote=nil; end
				if hLevel==nil then gkiir("ERROR! hLevel nil"); hLevel="?"; HCstars=1; else HCstars = math.floor(hLevel/10) end
				if hZone==nil then hZone="??" elseif string.find(hZone,"\\'") then hZone = string.gsub(hZone, "\\'", "'") end
				if hLevel=="?" or hLevel<10 then gkiir(CYELLOW..message);
				elseif level and GetGuildMemberInfo(hName)~=nil then -- a guildie
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death".."!"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..": "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..hcause..CLORANGE.." @ ".."|cFFAA9999"..hZone
					if oNote then message = message..CGRAY.." ("..oNote..")" end
					if gripmsg then message = message..grip; end
					if hNote then hNote=CGRAY.."("..hNote..")|r "; else hNote="" end 
					if gspecial and hName~=UnitName("player") and CheckIfGAnn() then 
						SendChatMessage("We lost "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r "..hNote.."@ "..hZone..", F :(","GUILD"); 
						SendChatMessage("Rest In Peace brave "..hClass.."... we hope you go agane :(","WHISPER",nil,hName); 
					end
					wasokk=true;
				else -- not in guild
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..":  "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..hcause..CLORANGE.." @ ".."|cFFAA9999"..hZone
					if gripmsg then message = message..grip; end
					wasokk=true;
				end
			else -- unknown death cause
				message=omessage
			end 
		-- end of Tragedy :)
		elseif (strsub(message,-8)=="ey face.") and (string.find(message,"Hardcore m")>15) then 
			-- XXX has reached level YYY in Hardcore mode! As they ascend towards immortality, their glory grows! However, so too does the danger they face.
			gReadRoster();
			local e,_ = string.find(message," has reached level ")
			if e then 
				hName = strsub(message,1,e-1)
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				level,hClass,hZone,hNote_,oNote = GetGuildMemberInfo(hName)
				if not level then 
					_,level = TurtleChatColors_ClassData(string.upper(hName));
					if level then gReadRoster(); level,hClass,hZone,hNote,_,oNote = GetGuildMemberInfo(hName); end  -- retry if not in guild
				end
				if level then hColor = TurtleChatColors_GetClassColor( string.upper(hClass) ) else hColor=CLGRAY; hClass=""; hZone=""; hNote=""; end
				_,a = string.find(message,"reached level ");
				b,_ = string.find(message," in Hardcore");
				if a and b then	
					hLevel = tonumber(strsub(message,a+1,b-1)); 
					if not hLevel then gkiir("ERROR!  hLevel = nil"); hLevel=1; end
				else hLevel=1; end
				if hLevel then HCstars = math.floor(hLevel/10) else HCstars=1; end
				if hLevel=="?" or hLevel<10 then gkiir(CYELLOW..message);
				elseif level and GetGuildMemberInfo(hName)~=nil then -- a guildie
					_,_,_,hNote,_,oNote = GetGuildMemberInfo(hName);
					message = "   "..CDGREEN..CharChain("*",HCstars)..hColor..hNameLink..CDGREEN..CharChain("*",HCstars)..CYELLOW.." has reached level "..CDGREEN.."*"..CWHITE..hLevel..CDGREEN.."*"..CYELLOW.." in Hardcore"..CDGREEN.." @ |cFFAA9999"..hZone..CYELLOW.." !";
					if oNote then message = message..CGRAY.." ("..oNote..")" end
					if gspecial and hName~=UnitName("player") and CheckIfGAnn() then 
						if hNote then hNote=CGRAY.." ("..hNote..")|r"; else hNote="" end 
						if hLevel>=50 then SendChatMessage("GRATS on "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r"..hNote..", almost there!","GUILD"); 
						elseif hLevel>=20 then SendChatMessage("Grats on "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r"..hNote.."!","GUILD"); end 
						--else SendChatMessage("Grats!","GUILD"); end
						--SendChatMessage("GZ, "..(60-hLevel).." more to go!","GUILD"); end
					--else gkiir("guildie");
					end
					wasokk=true;
				else -- not in guild
					message = "   "..CDGREEN..CharChain("*",HCstars)..hColor..hNameLink..CDGREEN..CharChain("*",HCstars)..CYELLOW.." has reached level "..CDGREEN.."*"..CWHITE..hLevel..CDGREEN.."*"..CYELLOW.." in Hardcore!"
					wasokk=true;
				end
			else -- unknown death cause
				message=omessage
			end	
		elseif (strsub(message,-9)=="Immortal!") then 
			-- XXX has transcended death and reached level 60 on Hardcore mode without dying once! XXX shall henceforth be known as the Immortal! --
			gReadRoster();
			a,_ = string.find(message," has transc");
			_,b = string.find(message,"reached level ");
			c,_ = string.find(message," on Hardcore");
			if a and b and c then
				hName = strsub(message,1,a-1)
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				hLevel = tonumber(strsub(message,b+1,c-1));
				if not hLevel then gkiir("ERROR!  hLevel = nil"); hLevel=60; end
				level,hClass,hZone,hNote,_,oNote = GetGuildMemberInfo(hName)				
				if not level then _,level = TurtleChatColors_ClassData(string.upper(hName)); if level then gReadRoster(); level,hClass,hZone,hNote,_,oNote = GetGuildMemberInfo(hName); end end -- retry if not in guild
				if hNote then hNote=CGRAY.." ("..hNote..")|r"; else hNote="" end 
				if level then hColor = TurtleChatColors_GetClassColor( string.upper(hClass) ) else hColor=CLGRAY; hClass=""; hZone=""; end
				message = "   "..CDGREEN..CharChain("*",6)..hColor..hNameLink..CDGREEN..CharChain("*",6)..CYELLOW.." has transcended death and reached level "..CDGREEN.."*"..CWHITE..hLevel..CDGREEN.."*"..CYELLOW.." on Hardcore mode without dying once! ";
				message = message..hColor..hName..CLORANGE.." shall henceforth be known as the "..CLGREEN.."IMMORTAL"..CLORANGE.." !";
				if level and gspecial and CheckIfGAnn() then 
					if GetGuildMemberInfo(hName)~=nil and hName~=UnitName("player") then SendChatMessage("Grats "..hColor..hNameLink.."|r"..hNote.." on becoming a "..CLGREEN.."normie|r! "..CRED.."RIP","GUILD"); end
				end
				wasokk=true;
			end 
		elseif (strsub(message,-13)=="no Challenge!") then 
			-- XXX has laughed in the face of death in the Hardcore challenge. XXX has begun the Inferno Challenge! --
			gReadRoster();
			a,_ = string.find(message," has laugh");
			if a then
				hName = strsub(message,1,a-1)
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				level,hClass,hZone,hNote,_,oNote = GetGuildMemberInfo(hName)
				if hNote then hNote=CGRAY.." ("..hNote..")|r"; else hNote="" end 
				if not level then _,level = TurtleChatColors_ClassData(string.upper(hName)); if level then gReadRoster(); level,hClass,hZone = GetGuildMemberInfo(hName); end end -- retry if not in guild
				if level then hColor = TurtleChatColors_GetClassColor( string.upper(hClass) ) else hColor=CLGRAY; hClass=""; hZone=""; end
				message = "   "..CDGREEN..CharChain("*",6)..hColor..hNameLink..CDGREEN..CharChain("*",6)..CYELLOW.." has laughed in the face of death in the "..CLRED.."Hardcore challenge"..CYELLOW..", and has begun the "..CRED.."INFERNO Challenge"..CYELLOW.."!";
				if level and gspecial and CheckIfGAnn() then 
					if GetGuildMemberInfo(hName)~=nil and hName~=UnitName("player") then SendChatMessage("CONGRATULATIONS "..hColor..hNameLink.."|r"..hNote.." on "..CWHITE.."60|r!","GUILD"); end
				end
				wasokk=true;
			end 
        elseif strsub(message,1,7)=="XP gain" then 
			_,a = string.find(message," gain is");
			if a then				
				if strsub(message,-3)=="OFF" then message = strsub(message,1,a)..": "..CLRED.."OFF" else message = strsub(message,1,a)..": "..CGREEN.."ON" end
				message = CYELLOW..message
			end
			showrested(1) -- %
			wasokk=true
		elseif string.find(message,"player") and strsub(message,-5)=="total" then message=nil; wasokk=true;
		elseif string.find(message,"%[") and string.find(message," Level") and string.find(message," - ") then message=nil; wasokk=true;
		else wasokk=true;
			message = CYELLOW..message;
		end	
	end
	if gspecial and omessage and wasokk==false and omessage~="" then DCFmsg("!"..CYELLOW..omessage); end
	return message;
end



function showrested(sr)
	p="player";
	x=UnitXP(p);
	m=UnitXPMax(p);
	r=GetXPExhaustion();  -- /run DEFAULT_CHAT_FRAME:AddMessage( (math.floor((GetXPExhaustion()*1000)/(UnitXPMax("player")*1.5))/10).." percent rested");
	if -1==(r or -1) then t=CLRED.."You are not rested." 
	else t="|cFF9999FFRested: "..CWHITE..(math.floor((r*1000)/(m*1.5))/10)..CGRAY.."%";end;
	if sr then t=t.."            "..CDGRAY.."macro:  "..CLGRAY.."/run showrested()" end
	DCFmsg(CSTART..t..CEND);
	if sr then
		if UnitLevel("player")<5 then DCFmsg(CLRED.."You can't chat until level "..CYELLOW.."5"..CLRED.." !"..CEND); end
	end
end


--MACRO: /run for b=0,4 do if GetBagName(b) then for s=GetContainerNumSlots(b),1,-1 do if GetContainerItemLink(b,s) then if string.find(GetContainerItemLink(b,s),"Dim Torch") then PickupContainerItem(b,s); DeleteCursorItem() end end end end end
function deletetorches() -- Deletes all Torch from the inventory when lvling survival from 1..50
	local gshardbag = -1;
    local gshardslot= 0;
	if endbag==nil then endbag=0 end
    for bag=0,4 do
        if (GetBagName(bag)~=nil) then
            for slot=GetContainerNumSlots(bag),1,-1 do
				if (GetContainerItemLink(bag,slot)) then
			        if (string.find(GetContainerItemLink(bag,slot), "Dim Torch")) then
						PickupContainerItem(bag,slot); DeleteCursorItem()
					end
			    end				
            end
        end
    end
end

function gspec(gsp) -- shows auto F / GZ message with class/location info in guildchat... only for myself! :)
	local gspold=gspecial
	if gsp==nil or gsp then gspecial=true else gspecial=false end
	local gsptxt=CLRED.."OFF"; if gspecial then gsptxt=CGREEN.."ON" end
	if gspold~=gspecial then DCFmsg(CWHITE.."TurtleChatColors"..CYELLOW.." announcements are: "..gsptxt..CEND); end
end 



function gReadRoster()
	local numGuild = GetNumGuildMembers();
	for i = 1, numGuild do
		local name,_,_,level,class = GetGuildRosterInfo(i);
		if( class and name ) then TurtleChatColors_ClassData(name, class, level); end
	end
end

function GetGuildMemberInfo(gname)
	local numGuild = GetNumGuildMembers();
	for i = 1, numGuild do
		local name,_,_,level,class,zone,nnote,onote,online = GetGuildRosterInfo(i); -- online: nil / 1
		if onote=="" then onote=nil end
		if (class and name) then 
			if name == gname then 				
				if nnote=="" then nnote=nil end
				return level,class,zone,nnote,online,onote
			end
		elseif level and name==gname then
				if nnote=="" then nnote=nil end
				return level,class,zone,nnote,online,onote		
		end
	end
	return nil
end

function searchguild(arg) -- Search text in names and notes
	GSnum = 0
	if arg and arg~="" then
		gReadRoster()
		arg = string.lower(arg)
		local numGuild = GetNumGuildMembers();
		if numGuild>0 then
			if arg=="gepy" or arg=="cat" or arg=="catmedic" then DCFmsg(CYELLOW.."Searching for the alts of:  "..CWHITE.."CatMedic / Gepy"..CGRAY.." ...")
			elseif arg=="keto" then DCFmsg(CYELLOW.."Searching for the alts of:  "..CWHITE.."KETO"..CGRAY.." ...")
			else DCFmsg(CYELLOW.."Searching for:  "..CWHITE..string.upper(arg)..CGRAY.." ...") end
			for i = 1, numGuild do
				local name,_,_,level,class,zone,nnote,onote,online = GetGuildRosterInfo(i); -- online: nil / 1
				if (class and name and not online) then 
					if arg=="keto" then
						for acchk = 1,table.getn(ketoalts) do 
							if ketoalts[acchk]==name then GShowGNInfo(name) end
						end	
					elseif arg=="gepy" or arg=="cat" or arg=="catmedic" then
						for acchk = 1,table.getn(acc1alts) do 
							if acc1alts[acchk]==name then GShowGNInfo(name) end
						end								
						for acchk = 1,table.getn(acc2alts) do 
							if acc2alts[acchk]==name then GShowGNInfo(name) end
						end								
						for acchk = 1,table.getn(acc3alts) do 
							if acc3alts[acchk]==name then GShowGNInfo(name) end
						end								
					elseif string.find(string.lower(name),arg) then GShowGNInfo(name)
					elseif nnote~="" and string.find(string.lower(nnote),arg) then GShowGNInfo(name)
					elseif onote~="" and string.find(string.lower(onote),arg) then GShowGNInfo(name)
					end
				end
			end	
			for i = 1, numGuild do
				local name,_,_,level,class,zone,nnote,onote,online = GetGuildRosterInfo(i); -- online: nil / 1
				if (class and name and online) then 
					if arg=="keto" then
						local found = 0
						for acchk = 1,table.getn(ketoalts) do if ketoalts[acchk]==name then found=acchk; end end
						if found > 0 then GShowGNInfo(name) 
						elseif nnote~="" and string.find(string.lower(nnote),arg) then 
							GShowGNInfo(name); 
							DCFmsg(CYELLOW.."New name, add to list!:  "..CWHITE..string.upper(name))
						end
					elseif arg=="gepy" or arg=="cat" or arg=="catmedic" then
						for acchk = 1,table.getn(acc1alts) do 
							if acc1alts[acchk]==name then GShowGNInfo(name) end
						end								
						for acchk = 1,table.getn(acc2alts) do 
							if acc2alts[acchk]==name then GShowGNInfo(name) end
						end								
						for acchk = 1,table.getn(acc3alts) do 
							if acc3alts[acchk]==name then GShowGNInfo(name) end
						end								
					elseif string.find(string.lower(name),arg) then GShowGNInfo(name)
					elseif nnote~="" and string.find(string.lower(nnote),arg) then GShowGNInfo(name)
					elseif onote~="" and string.find(string.lower(onote),arg) then GShowGNInfo(name)
					end
				end
			end	
			if GSnum>0 then DCFmsg(CWHITE..GSnum..CGRAY.." member(s) listed, you can click on a "..CLGRAY.."NAME"..CGRAY.." to whisper!")
			else gkiir(CRED.."No players found!") end
		else gkiir(CRED.."You are not in a GUILD!")
		end
	else gkiir(CLRED.."As parameter, you must specify a TEXT to find!:  /gs alch")
	end
end


function GShowGNInfo(hName)
	if hName then
		local hLevel,hClass,hZone,hNote,online,oNote = GetGuildMemberInfo(hName) -- online: nil / 1
		if level then
			GSnum = GSnum + 1
			local hColor = TurtleChatColors_GetClassColor(string.upper(hClass))
			local hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
			local note = ""
			if hNote and oNote then note = CGRAY.." ("..hNote.."|r"..CLGRAY.." / "..CGRAY..oNote..")|r"
			elseif hNote then note = CGRAY.." ("..hNote..")|r"
			elseif oNote then note = CGRAY.." ("..oNote..")|r" 
			end 
			if online then online=CGRAY.." ("..CWHITE.."Online"..CGRAY..")" else online = CGRAY.." (Offline)" end
			local message="   "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r"..note..CLORANGE.." @ "..CGREEN..hZone..online;
			DCFmsg(message)
		end
	end
end

function TCC_SlashCommandHandler(arg)
	gkiir("/tcc:  '"..arg.."'")
	if arg and arg~="" then
		local _,_,command = string.find(arg,"(%l+)")		
		local param = command
		if (command) then
			if command=="gs" or command=="sg" then gkiir("GS!") end
			gkiir("command = "..command)
		end
	else
		gkiir("TurtleChatColors /tcc commands:")
		gkiir("dt - Deletes all 'Dim Torch' from your bags")
		gkiir("gs <or> sg - Search guildmembers and notes for a text (not case sensitive)")
		gkiir("                   Its the same as for example: /gsearch alch")
	end
end


function GSRC_SlashCommandHandler(argu)
	searchguild(argu) -- Search text in names and notes
end


function TurtleChatColors_OnLoad() 
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	--this:RegisterEvent("CHAT_MSG_SYSTEM"); -- for later: for parsing returned /who (SendWho) queries if can't find the player in the guildroster
	--this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	--this:RegisterEvent("WHO_LIST_UPDATE");	
	SlashCmdList["TCC"] = TCC_SlashCommandHandler; -- "TCC" --> SLASH_TCCn
	SLASH_TCC1 = "/tcc"
	SLASH_TCC2 = "/turtlechatcolors"
	SlashCmdList["GSRC"] = GSRC_SlashCommandHandler; -- "GSRC" --> SLASH_GSRCn
	SLASH_GSRC1 = "/gsearch"
	SLASH_GSRC2 = "/searchguild"
	SLASH_GSRC3 = "/guildsearch"
	SLASH_GSRC4 = "/gsrc"
	SLASH_GSRC5 = "/gsrch"
	SLASH_GSRC6 = "/searchg"
	SLASH_GSRC7 = "/gs"
end

function TurtleChatColors_OnEvent(event)
	if ((event == "PLAYER_ENTERING_WORLD") or (event == "PLAYER_LOGIN")) and (TurtleChatColorsHooked==false) then 
		TurtleChatColorsHooked = true
		TurtleChatColors_OrigChatFrame_OnEvent = ChatFrame_OnEvent;
		ChatFrame_OnEvent = TurtleChatColors_ChatFrame_OnEvent;
	end
	if (event == "VARIABLES_LOADED") then 
		SetWhoToUI(0);
		GuildRoster(); 
	end	
	if (event == "GUILD_ROSTER_UPDATE") then gReadRoster(); end
end


function TurtleChatColors_ChatFrame_OnEvent(event)
-- arg1 is the actual message
-- arg2 is the player name
	if (gspecial) and (event == "CHAT_MSG_LOOT") then -- XXX has selected Need for:  
		local tmessage = arg1
		if string.find(tmessage," has selected Need ") and string.find(tmessage," for:") and gspecial then	
			gReadRoster()
			a,b = string.find(tmessage," has selected Need for: ");
			hName = strsub(tmessage,1,a-1);
			hItem = strsub(tmessage,b+1);
			color,level = TurtleChatColors_ClassData(string.upper(hName));
			tmessage = CYELLOW.."NEED|r:"..hItem..": "..color..string.upper(hName).."|r!";
			this:AddMessage(tmessage);
			return				
		end		
	elseif (event == "CHAT_MSG_SYSTEM") then --kiir("SYS!: "..arg1)
		local sysresult = TurtleChangeSystem(arg1)
		if sysresult==nil or sysresult=="" then return
		else this:AddMessage(sysresult); return
		end
	elseif (event == "CHAT_MSG_CHANNEL") then --text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons
		--kiir("ChannelName:  '"..arg9.."'");
		if arg9=="World" then arg1 = TCCHighlightStrs(arg1)
		elseif strsub(arg9,1,5)=="Trade"   then arg1 = TCCHighlightStrs(arg1)
		elseif strsub(arg9,1,7)=="General" then arg1 = TCCHighlightStrs(arg1)
		elseif strsub(arg9,1,7)=="Looking" then arg1 = TCCHighlightStrs(arg1)
		end
		--kiir(arg4.." / "..arg9) -- channelName channelBaseName
		--[[
		if sysresult~="" then 
			this:AddMessage(sysresult);
			return
		end
		]]
	elseif (event == "CHAT_MSG_HARDCORE") then --text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons
		arg1 = TCCHighlightStrs(arg1)
		--this:AddMessage(arg1); return
	elseif (event == "CHAT_MSG_GUILD") then --text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons
		arg1 = TurtleChangeGuildChat(arg1)
		--this:AddMessage(TurtleChangeGuildChat(arg1)); return
	end
	
	TurtleChatColors_OrigChatFrame_OnEvent(event);
end


function TurtleChatColors_ClassData(arg2, class, level )
	if arg2 then arg2 = string.upper(arg2); end		-- NAME
	if class then class = string.upper(class); end	-- CLASS
	if not TurtleChatColors_Names then TurtleChatColors_Names = {}; end
	if not TurtleChatColors_Level then TurtleChatColors_Level = {}; end
	if not arg2 then return ""; end

	if not class then  -- only name --> return with classcolor, level
		for name, color in TurtleChatColors_Names do
			if name == arg2 then 
				if pfUI and pfUI.chat then if pfUI.chat.classcolor then if pfUI.chat.classcolor~=1 then color=CGUILD; end end end
				return color, TurtleChatColors_Level[arg2]; 
			end
		end
	end
    -- NOT FOUND, have to check if I already have the name there...
    local found;
    for name, color in TurtleChatColors_Names do
		if name == arg2 then 
			if TurtleChatColors_Level[name] == level then
				found = true; 
			end
		end
   	end
	--only get here if I don't find the name in my dbase.
	if not found then
		--if (not class) and arg2 then SendWho("n-\""..string.lower(arg2).."\"") end -- for later: doing a /who for the player and waiting for the answer in "CHAT_MSG_SYSTEM"
		local color = TurtleChatColors_GetClassColor( class );
		--if class then gkiir(arg2.." = "..class) else gkiir(arg2.." = ???") end
		TurtleChatColors_Names[arg2] = color;
		if level then
			TurtleChatColors_Level[arg2] = level
		else
			TurtleChatColors_Level[arg2] = 0
		end
	end
	return "";
end

-- Class-colorz
CB_CLASS_MAGE     =	"MAGE";
CB_CLASS_WARLOCK  =	"WARLOCK";
CB_CLASS_PRIEST   =	"PRIEST";
CB_CLASS_DRUID    =	"DRUID";
CB_CLASS_SHAMAN   =	"SHAMAN";
CB_CLASS_PALADIN  =	"PALADIN";
CB_CLASS_ROGUE    =	"ROGUE";
CB_CLASS_HUNTER   =	"HUNTER";
CB_CLASS_WARRIOR  =	"WARRIOR";
if (GetLocale()=="deDE") then
CB_CLASS_MAGE = "MAGIER";
CB_CLASS_WARLOCK = "HEXENMEISTER";
CB_CLASS_PRIEST = "PRIESTER";
CB_CLASS_DRUID = "DRUIDE";
CB_CLASS_SHAMAN = "SCHAMANE";
CB_CLASS_PALADIN = "PALADIN";
CB_CLASS_ROGUE = "SCHURKE";
CB_CLASS_HUNTER = "J�GER";
CB_CLASS_WARRIOR = "KRIEGER";
end

function TurtleChatColors_GetClassColor( class )
	local classcolor = CGUILD;
	--coloring class text
	if (class == CB_CLASS_MAGE) then
		classcolor = "|cff69ccf0";
	elseif (class == CB_CLASS_WARLOCK) then
		classcolor = "|cff9482c9";
	elseif (class == CB_CLASS_PRIEST) then
		classcolor = "|cffffffff";
	elseif (class == CB_CLASS_DRUID) then
		classcolor = "|cffff7d0a";
	elseif (class == CB_CLASS_SHAMAN) then
		classcolor = "|cff0070de";
	elseif (class == CB_CLASS_PALADIN) then
		classcolor = "|cfff58cba";
	elseif (class == CB_CLASS_ROGUE) then
		classcolor = "|cfffff569";
	elseif (class == CB_CLASS_HUNTER) then
		classcolor = "|cffabd473";
	elseif (class == CB_CLASS_WARRIOR) then
		classcolor = "|cffc79c6e";
	end
	return classcolor;
end


-- IsQuestFlaggedCompleted(QID)