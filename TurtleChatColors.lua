-- vanilla 1.12	+ TurtleWoW
--- .hcmessages 60 		turns off all death message below 60
--- alt+0177 = ±  (+-)
--- damagepyhun@gmail.com

TurtleChatColorsVer = 1.3
local gspecial = false
local tccGuildBrackets = 1
local CLORANGE = "|cFFEEDD55"
local CDYELLOW = "|cFFC9CC00"
local CDUNG = "|cFFEFFFCF"
local CWTS = "|cFF66DDFF"
local CROLE = "|cFFC8F800"
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

		local chatDUNG = {"STOCKADE","stockades","Stockades","stockade","Stockade"," elites"," elite "," Elite"," Elites","Loch Modan","DEADMINES"," CG"," GC","Gilneas City"," Gilneas","Crescent Grove"," Crescent",
						" SM","Scarlet Monastery"," GY"," LIB"," CATH","REDRIDGE"," Redridge"," redridge"," wetland"," wetlands"," Wetlands"," Wetland","ELITE"," hfq","HFQ","gbase","Guild Base",
						"Scholomance","scholomance","Stratholme","stratholme"," Strath", "LBRS","lbrs","UBRS","BRD","BRM"," brm","ONYXIA","Onyxia","onyxia"," Ony"," ony"," kara ","karazhan"," Karazhan"," Kara ",
						" ZulGurub"," Zul Gurub"," ZG","Brd","BWL","Blackwing Lair","Blackwing"," AQ ","aq20","AQ20","AQ40","NAXX","NAX"," MC ","MOLTEN CORE","Molten Core","mailbox",
						" brd"," scholo"," Scholo "," Strat "," strat"," UD ","DireMaul","Strat UD","diremaul"," ubrs","SCHOLO","Sunken Temple","sunken temple"," ST "," rend",
						" DMW"," DM"," DM:"," DMe","DM east","DM west","DM north","tribute","zulgurub","DM E","GNOMEREGAN","SUNKEN","TEMPLE","Uldaman"," ZF","gnomeregan","ARM/CATH","MARAUDON","uldaman"," DM "," VC ",
						"Maraudon","maraudon","ARENA"," arena","Dire Maul","Gnomeregan","Zul Farrak","ARMORY","Deadmines","deadmines"," STV"," BB "," DMF"," dmf","WPL",
						"BFD","RFD","RFK","RFC"," rfc"," WC"," bfd","Zul Farak","Zul'Farak","Armory"," ulda"," sm "," Cath"," RR "," .hc","loch modan","westfall",
						"armory","Zul'Farrak","GRAVEYARD"," zf ","Graveyard"," ARM"," Gnomer ","SFK","Arm/Cath","SM ","lib/arm"," Mara "," Princess"," Arathi",
						"razorfen","Blackfathom"," cath","cath "," Zf","ULDAMAN","shadowfang","Stockades","ZF ","BLACKFATHOM"," GS"," Mulgore","Mulgore "};
		local chatGREEN = {"LF tank","LF Tank"," hogger"," Hogger"," DPS "," DPS"," dps"," Dps","1dps","2dps"," escort ","Tank "," tank ","Healz"," HEALER "," HEALER"," HEAL"," HEAL "," heal ","Heal "," Heals"," Heal ","/heals","/heal","/dps"," heals","healer ","heal "," healer","Healer"," tank"," TANK","/HEAL","/DPS",
						"FULL RUN","Q run","XP FARM","XP runs","XP run"," quests","Elite Quests","Quests","RUNS","aoe runs","full run","farming","Farming","fullrun"," full"," Full","AoE","AOE","aoe run","need all",
						"FARM","QUEST"," Quest ","QuestRun"," quest "," Aoe","exp run"," RUN","Questrun"," aoe"," runs"," Lava"," lava","last spot","Last Spot","LAST SPOT","Emp Run"," tents "," summon"," lotus"," eels"," petri",
						"Middleman","middleman","emp run","exp farm"," exp "," q run","7d/emp","Last spot"," xp ","jailbreak","reputation"," GM's"," GM ","Gratz","Enchanter","enchanter","Tailor","tailor","alchemist",
						"TANK ","HEAL ","__","__"};
		local chatBLUE = {"LFG","LFM","LF1M","LF2M","LF3M","LF4M","LF ","lfg ","lfm ","LFW","lf1m","Congrats!","grats!","Hard Chores"," inferno","__"};
		local chatLGREEN = {"WTS","wts","wtb","WTB","WTT"}
		local chatRED = {" hc "," hardcore","Hardcore "," Hardcore","Inferno"," HC"," RIP"," F! "," F ","WTF","PVP","PvP"," pvp","showtooltip"," eu "," na "," EU "," NA ","%:nohelf%:","<AFK>"};
		local chatUP = {"lfm ","lfg","lf1m","lf2m","lf3m","wtb","wts","lbrs","ubrs","bwl","brd","dmw","wpl"}; -- convert to uppercase before all
		
local acc1alts = {"Damagepy","Gepygnum","Gepybankhc","Frostgepy","Catmedic","Gungnumgepy","Gepy","Hotmedic","__","__"}
local acc2alts = {"Coldgepy","Gnumage","Gepymage","Dragontamer","Gungepy","Magepy","Hungepy","Chillgepy","Minigepy","__"}
		
function gkiir(kirtxt) if kirtxt then DEFAULT_CHAT_FRAME:AddMessage(CSTART..CMYCOLOR..kirtxt..CEND); end end

function CharChain(scc,scn)
	local sctxt=""; if scc and scn then for i=1,scn do sctxt=sctxt..scc end end return sctxt
end;



function TurtleChangeHCChat (message)
	if string.upper(message)=="F :(" or string.upper(message)=="RIP" or string.upper(message)=="F" then message=CLRED..string.upper(message);
	elseif string.upper(strsub(message,-2))==" F" then message=strsub(message,1,-2)..CLRED.."F"; 
	elseif string.upper(strsub(message,-4))==" RIP" then message=strsub(message,1,-4)..CLRED..strsub(message,-3);
	elseif string.upper(strsub(message,-5))==" F :(" then message=strsub(message,1,-5)..CLRED.."F :(";
	elseif string.upper(message)=="GZ" or string.upper(message)=="GZ!" then message=CROLE..message;
	end
	-- chat location/keyword highlights --
	for mqff = 1,table.getn(chatUP) do message = string.gsub(message, chatUP[mqff], string.upper(chatUP[mqff])); end
	for mqff = 1,table.getn(chatGREEN) do message = string.gsub(message, chatGREEN[mqff], CROLE..chatGREEN[mqff].."|r"); end		
	for mqff = 1,table.getn(chatLGREEN) do message = string.gsub(message, chatLGREEN[mqff], CLGREEN..chatLGREEN[mqff].."|r"); end		
	for mqff = 1,table.getn(chatRED) do message = string.gsub(message, chatRED[mqff], CLLRED..chatRED[mqff].."|r"); end
	for mqff = 1,table.getn(chatDUNG) do message = string.gsub(message, chatDUNG[mqff], CDUNG..chatDUNG[mqff].."|r"); end		
	for mqff = 1,table.getn(chatBLUE) do message = string.gsub(message, chatBLUE[mqff], CWTS..chatBLUE[mqff].."|r"); end
	--return "|cFFE6C980[HC] "..message
	message = string.gsub(message, "%+%-", "\194\177");
	message = string.gsub(message, "%-%+", "\194\177");
	return message
end

function CheckIfGAnn() -- My personal announcement... if I'm online on both acc, then only one of them will announce to the guild
	local gann = false
	if gspecial then
		local myname = UnitName("player")
		local curacc = 0
		local acc1,acc2 = false,false;
		gann = true		
		for acchk = 1,table.getn(acc1alts) do 
			if acc1alts[acchk]==myname then curacc=1; end
			local _,_,_,_,online = GetGuildMemberInfo(acc1alts[acchk]);	if online then acc1 = acchk; end
		end		
		for acchk = 1,table.getn(acc2alts) do 
			if acc2alts[acchk]==myname then curacc=2; end; 
			local _,_,_,_,online = GetGuildMemberInfo(acc2alts[acchk]);	if online then acc2 = acchk; end
		end
		--[[
		if acc1 and acc2 and curacc==2 then gann=false else gann=true end
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
	if string.find(message,"%[") and string.find(message,"%]:") then
		local a,b = string.find(message,"%[")
		local c,d = string.find(message,"%]:")
		local hName = strsub(message,b+1,c-1);
		local gname = hName
		gReadRoster();
		local e
		e = string.find(gname," "); if e then gname=strsub(gname,1,e-1) end
		e = string.find(gname,"%("); if e then gname=strsub(gname,1,e-1) end
		e = string.find(gname,"/"); if e then gname=strsub(gname,1,e-1) end
		gname = string.upper(strsub(gname,1,1))..string.lower(strsub(gname,2)) -- first character uppercase, rest lowercase
		local level,hClass = GetGuildMemberInfo(gname)
		local hColor = CLGRAY;
		if level then 
			if not hClass then hClass=""; end
			hColor = TurtleChatColors_GetClassColor(string.upper(hClass));
		end
		message = "["..hColor..hName.."|r]: "..strsub(message,d+2);
	end
	for mqff = 1,table.getn(chatUP) do message = string.gsub(message, chatUP[mqff], string.upper(chatUP[mqff])); end
	for mqff = 1,table.getn(chatDUNG) do message = string.gsub(message, chatDUNG[mqff], CDUNG..chatDUNG[mqff].."|r"); end		
	for mqff = 1,table.getn(chatGREEN) do message = string.gsub(message, chatGREEN[mqff], CROLE..chatGREEN[mqff].."|r"); end		
	for mqff = 1,table.getn(chatLGREEN) do message = string.gsub(message, chatLGREEN[mqff], CLLGREEN..chatLGREEN[mqff].."|r"); end		
	message = string.gsub(message, "%+%-", "\194\177");
	message = string.gsub(message, "%-%+", "\194\177");
	return message
end


function TurtleChangeSystem (message)	-- special characters (must escape with %):   ( ) . % + - * ? [ ^ $
	if message then	
		local a,b,c,d,e,f,g,h
		local HCstars=1
		local color, level,   hName,hNameLink, hLevel, hClass, hColor,   hKiller, hKillerLvl,  hZone, hNote;
		local omessage = nil;
		
		if grelayer then omessage = message; end 
		
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
				if f and g then	hLevel = tonumber(strsub(message,f+1,g-1));	end
				if hLevel==60 or hLevel=="60" then h,_ = string.find(message,". They"); end
				if not h then h="??"; omessage=message; end
				if a and b and c and d then
					hKiller = strsub(message,a+1,b-1);
					hKillerLvl = tonumber(strsub(message,c+1,d-1));
					if not (hKiller and hKillerLvl) then gkiir("ERROR!  hKiller / hKillerLvl = nil") end
					--_,a = string.find(message," at level ");
					--b,_ = string.find(message,". May this");
					--hLevel = tonumber(strsub(message,a+1,b-1));
				else hKiller="??"; hKillerLvl="?"; end
				level,hClass,hZone,hNote = GetGuildMemberInfo(hName)
				if not level then level=hLevel; end
				if not level then _,level = TurtleChatColors_ClassData(string.upper(hName)); if level then gReadRoster(); level,hClass,hZone,hNote = GetGuildMemberInfo(hName); end end -- retry if not in guild
				if level and e and h then -- is in the guild, can get more info (class, location)
					if not hZone or hZone=="" then hZone = strsub(message,e+1,h-1); end					
					if not hClass then hClass=""; end
					hColor = TurtleChatColors_GetClassColor(string.upper(hClass) );					
				else hZone=""; hColor=CLGRAY; hClass=""; hNote=nil; end
				if hKillerLvl==nil then gkiir("ERROR! hKillerLvl nil"); hKillerLvl="?" end
				if hLevel==nil then gkiir("ERROR! hLevel nil"); hLevel="?"; HCstars=1; else HCstars = math.floor(hLevel/10) end
				if hKillerLvl=="?" or hLevel=="?" or hLevel<10 then gkiir(CYELLOW..message);
				elseif level and GetGuildMemberInfo(hName)~=nil then -- a guildie
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death".."!"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..": "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."has fallen to:\n";
					message = message.."   "..CharChain(" ",math.floor((HCstars+1)*1.3))..CLLRED..hKiller..CDGRAY.." ("..CLRED..hKillerLvl..CDGRAY..")"..CLORANGE.." @ ".."|cFFAA9999"..hZone
					if gripmsg then message = message..grip; end
					if hNote then hNote="("..CGRAY..hNote.."|r) "; else hNote="" end 
					if gspecial and hName~=UnitName("player") and CheckIfGAnn() then 
						SendChatMessage("We lost "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r "..hNote..": "..CLLRED..hKiller.."|r "..CLRED..hKillerLvl.."|r @ "..hZone..", F :(","GUILD"); 
						SendChatMessage("Rest In Peace brave "..hClass.."... we hope you go agane :(","WHISPER",nil,hName); 
					end
				else -- not in guild
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..":  "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."<< ";
					message = message..CLLRED..hKiller..CDGRAY.." ("..CLRED..hKillerLvl..CDGRAY..") "..CLORANGE.."@ |cFFAA9999"..hZone
					if gripmsg then message = message..grip; end
					local rtarget="GUILD"; rtarget="hardcore";					
					if hName~=UnitName("player") then 
						if string.find(hKiller,"Tunnel Rat") then SendChatMessage("Tunnel rats rule!",rtarget);	end 
					end
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
				if not h then h,_ = string.find(message,". They"); if not h then h="??"; omessage=message; end; end
				if f and g then	hLevel = tonumber(strsub(message,f+1,g-1));	end
				if a and b and c and d then
					hKiller = strsub(message,a+1,b-1);
					hLevel = tonumber(strsub(message,c+1,d-1));
					if not (hKiller and hLevel) then gkiir("ERROR!  hKiller / hLevel = nil"); hLevel=1; end
				else hKiller="??"; hLevel=1; end
				level,hClass,hZone,hNote = GetGuildMemberInfo(hName)
				if not level then level=hLevel; end
				if not level then _,level = TurtleChatColors_ClassData(string.upper(hName)); if level then gReadRoster(); level,hClass,hZone,hNote = GetGuildMemberInfo(hName); end end -- retry if not in guild
				if level then -- is in the guild, can get more info (class, location)
					if not hZone or hZone=="" then hZone = strsub(message,e+1,h-1); end					
					if hClass==nil then hClass=""; end
					hColor = TurtleChatColors_GetClassColor( string.upper(hClass) );					
				else hZone=""; hColor=CLGRAY; hClass=""; hNote=nil; end
				if hLevel==nil then gkiir("ERROR! hLevel nil"); hLevel="?"; HCstars=1; else HCstars = math.floor(hLevel/10) end
				if hLevel=="?" or hLevel<10 then gkiir(CYELLOW..message);
				elseif level and GetGuildMemberInfo(hName)~=nil then -- a guildie
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death".."!"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..": "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."was killed in "..CLLRED.."PvP"..CLORANGE.." by:\n";
					message = message.."   "..CharChain(" ",math.floor((HCstars+1)*1.3))..CLLRED..hKiller..CGRAY.." ("..CRED..hLevel..CGRAY..") "..CLORANGE.." @ ".."|cFFAA9999"..hZone
					if gripmsg then message = message..grip; end
					if hNote then hNote="("..CGRAY..hNote.."|r) "; else hNote="" end 
					if gspecial and hName~=UnitName("player") and CheckIfGAnn() then 
						SendChatMessage("We lost "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r "..hNote.."in PvP @ "..hZone..", F :(","GUILD"); 
						SendChatMessage("Rest In Peace brave "..hClass.."... :(","WHISPER",nil,hName); 
					end
				else -- not in guild
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..":  "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."in "..CLLRED.."PvP"..CLORANGE.." by ";
					message = message..CLLRED..hKiller..CGRAY.." ("..CRED..hLevel..CGRAY..") "..CLORANGE.." @ ".."|cFFAA9999"..hZone
					if gripmsg then message = message..grip; end
				end
			elseif string.find(message,"natural ca") or string.find(message," burned to") or string.find(message," has drowned") then
			-- A tragedy has occurred. Hardcore character XXX (level NN) died of natural causes in ZZ. May this sacrifice not be forgotten. --
			-- 														   ) has burned to death in ZZ. May
				--omessage = message;
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
				level,hClass,hZone,hNote = GetGuildMemberInfo(hName)
				if not level then level=hLevel; end
				if not level then _,level = TurtleChatColors_ClassData(string.upper(hName)); if level then gReadRoster(); level,hClass,hZone,hNote = GetGuildMemberInfo(hName); end end -- retry if not in guild
				if level then -- is in the guild, can get more info (class, location)
					if not hZone or hZone=="" then hZone = strsub(message,e+1,h-1); end					
					if not hClass then hClass=""; end
					hColor = TurtleChatColors_GetClassColor( string.upper(hClass) );					
				else hZone=""; hColor=CLGRAY; hClass=""; hNote=nil; end
				if hLevel==nil then gkiir("ERROR! hLevel nil"); hLevel="?"; HCstars=1; else HCstars = math.floor(hLevel/10) end
				if hLevel=="?" or hLevel<10 then gkiir(CYELLOW..message);
				elseif level and GetGuildMemberInfo(hName)~=nil then -- a guildie
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death".."!"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..": "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..hcause..CLORANGE.." @ ".."|cFFAA9999"..hZone
					if gripmsg then message = message..grip; end
					if hNote then hNote="("..CGRAY..hNote.."|r) "; else hNote="" end 
					if gspecial and hName~=UnitName("player") and CheckIfGAnn() then 
						SendChatMessage("We lost "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r "..hNote.."@ "..hZone..", F :(","GUILD"); 
						SendChatMessage("Rest In Peace brave "..hClass.."... :(","WHISPER",nil,hName); 
					end
				else -- not in guild
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..":  "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..hcause..CLORANGE.." @ ".."|cFFAA9999"..hZone
					if gripmsg then message = message..grip; end
				end
			else -- unknown death cause
				message=message..""
			end 
		elseif (strsub(message,-8)=="ey face.") and (string.find(message,"Hardcore m")>15) then 
			-- XXX has reached level YYY in Hardcore mode! As they ascend towards immortality, their glory grows! However, so too does the danger they face.
			gReadRoster();
			local e,_ = string.find(message," has reached level ")
			if e then 
				hName = strsub(message,1,e-1)
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				level,hClass,hZone,hNote = GetGuildMemberInfo(hName)
				if not level then 
					_,level = TurtleChatColors_ClassData(string.upper(hName));
					if level then gReadRoster(); level,hClass,hZone,hNote = GetGuildMemberInfo(hName); end  -- retry if not in guild
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
					message = "   "..CDGREEN..CharChain("*",HCstars)..hColor..hNameLink..CDGREEN..CharChain("*",HCstars)..CYELLOW.." has reached level "..CDGREEN.."*"..CWHITE..hLevel..CDGREEN.."*"..CYELLOW.." in Hardcore"..CDGREEN.." @ |cFFAA9999"..hZone..CYELLOW.." !";
					if gspecial and hName~=UnitName("player") and CheckIfGAnn() then 
						if hNote then hNote=CGRAY.." ("..hNote..")|r"; else hNote="" end 
						if hLevel>=50 then SendChatMessage("GRATS on "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r"..hNote..", almost there!","GUILD"); 
						elseif hLevel>=20 then SendChatMessage("Grats on "..CBGRAY..hLevel.."|r "..hColor..hNameLink.."|r"..hNote.."!","GUILD"); end 
						--else SendChatMessage("Grats!","GUILD"); end
						--SendChatMessage("GZ, "..(60-hLevel).." more to go!","GUILD"); end
					--else gkiir("guildie");
					end
				else -- not in guild
					message = "   "..CDGREEN..CharChain("*",HCstars)..hColor..hNameLink..CDGREEN..CharChain("*",HCstars)..CYELLOW.." has reached level "..CDGREEN.."*"..CWHITE..hLevel..CDGREEN.."*"..CYELLOW.." in Hardcore!"
				end
			else -- unknown death cause
				message=message..""
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
				level,hClass,hZone = GetGuildMemberInfo(hName)				
				if not level then _,level = TurtleChatColors_ClassData(string.upper(hName)); if level then gReadRoster(); level,hClass,hZone = GetGuildMemberInfo(hName); end end -- retry if not in guild
				if level then hColor = TurtleChatColors_GetClassColor( string.upper(hClass) ) else hColor=CLGRAY; hClass=""; hZone=""; end
				message = "   "..CDGREEN..CharChain("*",6)..hColor..hNameLink..CDGREEN..CharChain("*",6)..CYELLOW.." has transcended death and reached level "..CDGREEN.."*"..CWHITE..hLevel..CDGREEN.."*"..CYELLOW.." on Hardcore mode without dying once! ";
				message = message..hColor..hName..CLORANGE.." shall henceforth be known as the "..CLGREEN.."IMMORTAL"..CLORANGE.." !";
				if level and gspecial and CheckIfGAnn() then 
					if GetGuildMemberInfo(hName)~=nil and hName~=UnitName("player") then SendChatMessage("Congratulations "..hColor..hNameLink.."|r!","GUILD"); end
				end
			end 
		elseif (strsub(message,-13)=="no Challenge!") then 
			-- XXX has laughed in the face of death in the Hardcore challenge. XXX has begun the Inferno Challenge! --
			gReadRoster();
			a,_ = string.find(message," has laugh");
			if a then
				hName = strsub(message,1,a-1)
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				level,hClass,hZone = GetGuildMemberInfo(hName)
				if not level then _,level = TurtleChatColors_ClassData(string.upper(hName)); if level then gReadRoster(); level,hClass,hZone = GetGuildMemberInfo(hName); end end -- retry if not in guild
				if level then hColor = TurtleChatColors_GetClassColor( string.upper(hClass) ) else hColor=CLGRAY; hClass=""; hZone=""; end
				message = "   "..CDGREEN..CharChain("*",6)..hColor..hNameLink..CDGREEN..CharChain("*",6)..CYELLOW.." has laughed in the face of death in the "..CLRED.."Hardcore challenge"..CYELLOW..", and has begun the "..CRED.."INFERNO Challenge"..CYELLOW.."!";
				if level and gspecial and CheckIfGAnn() then 
					if GetGuildMemberInfo(hName)~=nil and hName~=UnitName("player") then SendChatMessage("CONGRATULATIONS "..hColor..hNameLink.."|r on "..CWHITE.."60|r!","GUILD"); end
				end
			end 
        elseif strsub(message,1,7)=="XP gain" then 
			_,a = string.find(message," gain is");
			if a then				
				if strsub(message,-3)=="OFF" then message = strsub(message,1,a)..": "..CLRED.."OFF" else message = strsub(message,1,a)..": "..CGREEN.."ON" end
				message = CYELLOW..message
			end
			showrested(1) -- %
		else
			message="";
		end		
	else message=""; end
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
	DEFAULT_CHAT_FRAME:AddMessage(CSTART..t..CEND);
	if sr then
		if UnitLevel("player")<5 then DEFAULT_CHAT_FRAME:AddMessage(CLRED.."You can't chat until level "..CYELLOW.."5"..CLRED.." !"..CEND); end
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
						--gkiir(bag.." / "..slot)
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
	if gspold~=gspecial then DEFAULT_CHAT_FRAME:AddMessage(CWHITE.."TurtleChatColors"..CYELLOW.." announcements are: "..gsptxt..CEND); end
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
		if (class and name and zone) then 
			if name == gname then 
				if onote=="" then 
					if nnote~="" then onote=nnote else onote=nil end
				end
				return level,class,zone,onote,online
			end
		elseif level and name==gname then
				if onote=="" then 
					if nnote~="" then onote=nnote else onote=nil end
				end
				return level,class,zone,onote,online		
		end
	end
	return nil
end



function TurtleChatColors_OnLoad() 
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	--this:RegisterEvent("CHAT_MSG_SYSTEM"); -- for later: for parsing returned /who (SendWho) queries if can't find the player in the guildroster
	--this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	--this:RegisterEvent("WHO_LIST_UPDATE");
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
		if sysresult~="" then 
			this:AddMessage(sysresult);
			return
		end
	elseif (event == "CHAT_MSG_CHANNEL") then --text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons
		--kiir(arg4.." / "..arg9) -- channelName channelBaseName
		--[[
		if sysresult~="" then 
			this:AddMessage(sysresult);
			return
		end
		]]
	elseif (event == "CHAT_MSG_HARDCORE") then --text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons
		arg1 = TurtleChangeHCChat(arg1)
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
CB_CLASS_HUNTER = "JÄGER";
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