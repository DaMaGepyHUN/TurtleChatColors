TurtleChatColors_ChatFrame_OnEvent = ChatFrame_OnEvent

-- CHAT_MSG_GUILD	CHAT_MSG_SYSTEM		


local CLORANGE = "|cFFEEDD55"
local CLLRED = "|cFFFF9999"
local CDYELLOW = "|cFFC9CC00"
local CDUNG = "|cFFEEFFBB"
local CWTS = "|cFF66DDFF"
local CROLE = "|cFFCCEE00"
local CGUILD = "|cFF3CE13F"

local CRED = "|cFFFF0000"
local CYELLOW = "|cFFFFFF00"
local CGREEN = "|cFF00FF00"
local CDGREEN = "|cFF00BB00"
local CBLUE = "|cFF7070FF"
local CWHITE = "|cFFFFFFFF"
local CORANGE = "|cFFFF8000"
local CBROWN = "|cFFFFB080"
local CPURPLE = "|cFFD060D0"
local CPINK = "|cFFFF80FF"
local CLRED = "|cFFFF8080"
local CLGREEN = "|cFF80FF80"
local CLGRAY = "|cFFC0C0C0"
local CGRAY  = "|cFF888888"
local CDGRAY = "|cFF707070"
local CLBLUE = "|cFF40FFFF"
local CEND = "|r"
local CMYCOLOR = "|cFFFF8060"
local CSTART = CBLUE.."-"..CYELLOW.."-"..CBLUE.."- ";
local gspecial = false

		local chatDUNG = {"STOCKADE","stockades","Stockades","stockade","Stockade"," elites"," elite "," Elites","Loch Modan",
						" SM","Scarlet Monastery"," GY"," LIB"," CATH","REDRIDGE"," Redridge"," redridge"," wetland"," wetlands"," Wetlands"," Wetland","ELITE",
						"Scholomance","scholomance","Stratholme","stratholme"," Strath", "LBRS","UBRS","BRD","ONYXIA","Onyxia","onyxia",
						" ZulGurub"," Zul Gurub"," ZG","Brd","BWL","Blackwing Lair","Blackwing"," AQ ","AQ20","AQ40","NAXX","NAX"," MC ","MOLTEN CORE","Molten Core",
						" brd"," scholo"," Scholo "," Strat "," strat"," UD ","DireMaul","Strat UD","diremaul"," ubrs","SCHOLO","Sunken Temple","sunken temple"," ST ",
						" DM:"," DMe","DM east","DM west","DM north","tribute","zulgurub","DM E","GNOMEREGAN","SUNKEN","TEMPLE","Uldaman"," ZF","gnomeregan","ARM/CATH","MARAUDON","uldaman"," DM "," VC ",
						"Maraudon","maraudon","ARENA"," arena","Dire Maul","Gnomeregan","ARMORY","Deadmines","deadmines"," STV"," BB ","LF tank","LF Tank",
						" BFD"," RFD"," RFK"," RFC"," rfc"," WC"," bfd","Zul Farak","Zul'Farak","Armory"," ulda"," sm "," Cath"," RR "," .hc","loch modan","westfall",
						"armory","Zul'Farrak"," cath","GRAVEYARD","Graveyard"," ARM"," Gnomer ","SFK","Arm/Cath","SM ","lib/arm"," Mara "," Princess",
						"razorfen","Blackfathom"," zf ","cath "," Zf","ULDAMAN","shadowfang","Stockades","ZF ","BLACKFATHOM"," GS","Mulgore"};
		local chatGREEN = {" DMF"," dmf"," hogger","Hogger"," DPS "," DPS"," dps"," Dps"," escort ","Tank "," tank "," HEALER "," HEAL "," heal ","Heal "," Heal ","/heals","/heal","/dps"," heals","healer ","heal "," healer","Healer",
						"FULL RUN","Q run","XP FARM","XP runs","XP run"," quests","Elite Quests","Quests","RUNS","aoe runs","full run","farming","Farming"," full"," Full","AoE","AOE","aoe run",
						"FARM","QUEST"," Quest ","QuestRun"," quest "," Aoe","exp run"," RUN","Questrun"," aoe"," runs"," Lava"," lava","last spot","Last Spot","LAST SPOT","Emp Run"," tents ",
						"Middleman","middleman","emp run","exp farm"," exp "," q run","7d+emp","7d/emp","Last spot"," xp ","jailbreak","reputation"," GM's"," GM ","__"};
		local chatBLUE = {"WTS","wts","wtb","WTB","LFG","LFM","LF1M","LF2M","LF3M","LF4M","LF ","lfg ","lfm ","lf1m","__","__","__"};
		local chatRED = {" hc ","hardcore","Hardcore "," Hardcore"," HC"," RIP","r.i.p"," F! ","WTF","PVP","PvP"," pvp","HardcoreDeath","/db unseen"};
		local chatUP = {"lfm ","lfg ","lf1m ","lf2m ","lf3m ","wtb ","wts "};

local hooks = {}

function CharChain(scc,scn)
	local sctxt=""; if scc and scn then for i=1,scn do sctxt=sctxt..scc end end return sctxt
end;


local function AddMessage(self, message, a1, a2, a3)	-- ( ) . % + - * ? [ ^ $
	if message then
		local a,b,c,d = 0,0,0,0
		local HCstars=1
		local color, level,   hName,hNameLink, hLevel, hClass, hColor,   hKiller, hKillerLvl,  hZone;

		if strsub(message,1,7)=="[Guild]" or strsub(message,1,7)=="[Party]" or strsub(message,1,4)=="[G] " or strsub(message,1,4)=="[P] " then 
			local _, _, _, name, _, type = string.find(message, "(|Hplayer:.-|h%[)(%a+)(%])(.*:%s)"); -- |Hplayer:XXX|hXXX|h
			if name and not string.find(name, "%s") then
				color,level = TurtleChatColors_ClassData(string.upper(name));
				if level then 
					--kiir(string.gsub(message,"|","!"))
					local glevel = CGRAY..":|r"..CLGRAY..level.."|r" -- ":LvL"
					a,b = string.find(message,"|Hplayer:"..name.."|h%[");
					if a and b then
						message = string.gsub(message,  "|Hplayer:"..name.."|h%["..name.."%]|h", 
														"%["..color.."|Hplayer:"..name.."|h"..name.."|h|r"..glevel.."%]");
					else
						a,b = string.find(message,"|h"..name.."|h|r%]:");
						if a and b then
							message = string.gsub(message,  "|h"..name.."|h|r%]:", 
															"|h"..name.."|h|r"..glevel.."%]:");
						else
						a,b = string.find(message,"|h"..name.."|h|r>");
							if a and b then
								message = string.gsub(message,  "|h"..name.."|h|r>", 
																"|h"..name.."|h|r"..glevel..">");
							end
						end
					end
					--message = string.gsub(message, "(|Hplayer:.-|h%[)([%w]+)(%])", "%1" .. color .. "%2|r"..glevel.."%3");
				end
			end
			message = string.gsub(message,"%[Guild%] ","%[G%]");
			message = string.gsub(message,"%[Party%] ","%[P%]");
			-- chat location/keyword highlights --
			for mqff = 1,table.getn(chatUP) do message = string.gsub(message, chatUP[mqff], string.upper(chatUP[mqff])); end
			for mqff = 1,table.getn(chatRED) do message = string.gsub(message, chatRED[mqff], CLLRED..chatRED[mqff].."|r"); end
			for mqff = 1,table.getn(chatDUNG) do message = string.gsub(message, chatDUNG[mqff], CDUNG..chatDUNG[mqff].."|r"); end		
			for mqff = 1,table.getn(chatGREEN) do message = string.gsub(message, chatGREEN[mqff], CROLE..chatGREEN[mqff].."|r"); end		
			for mqff = 1,table.getn(chatBLUE) do message = string.gsub(message, chatBLUE[mqff], CWTS..chatBLUE[mqff].."|r"); end
        elseif strsub(message,1,7)=="[Party]" then message = string.gsub(message,"%[Party%]","%[P%]")
        elseif strsub(message,1,9)=="A tragedy" then 
			gReadRoster();
			if not (string.find(message," natural") or string.find(message,"in PvP")) then -- MOB death
			-- A tragedy has occurred. Hardcore character XXX has fallen to YY1 YY2 (level 37) at level ZZZ. May this sacrifice not be forgotten. --
				_,a = string.find(message," character ");
				b,_ = string.find(message," has fallen");
				hName = strsub(message,a+1,b-1);
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				_,a = string.find(message,"fallen to ");
				b,c = string.find(message," %(level ");
				d,_ = string.find(message,"%) at ");
				if a and b and c and d then
					hKiller = strsub(message,a+1,b-1);
					hKillerLvl = tonumber(strsub(message,c+1,d-1));
					if not (hKiller and hKillerLvl) then kiir("ERROR!  hKiller / hKillerLvl = nil") end
					_,a = string.find(message," at level ");
					b,_ = string.find(message,". May this");
					hLevel = tonumber(strsub(message,a+1,b-1));
				else hKiller="??"; hKillerLvl="?"; hLevel=1; end
				level,hClass,hZone = GetGuildMemberInfo(hName)
				if level then -- is in the guild, can get more info (class, location)
					if not hZone or hZone=="" then hZone="Azeroth"; end
					hColor = TurtleChatColors_GetClassColor( string.upper(hClass) );					
				else hZone=""; hColor=CLGRAY; hClass=""; end
				if hKillerLvl==nil then kiir("ERROR! hKillerLvl nil"); hKillerLvl="?" end
				if hLevel==nil then kiir("ERROR! hLevel nil"); hLevel="?"; HCstars=1; else HCstars = math.floor(hLevel/10) end
				if hKillerLvl=="?" or hLevel=="?" or hLevel<10 then kiir(CYELLOW..message);
				elseif level then -- a guildie
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death".."!"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..": "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."has fallen to:\n";
					message = message.."   "..CharChain(" ",math.floor((HCstars+1)*1.3))..CLLRED..hKiller..CDGRAY.." ("..CLRED..hKillerLvl..CDGRAY..")"..CLORANGE.." @ ".."|cFFAA9999"..hZone.."... "..CLRED.."RIP"..CRED.." :("
					if gspecial then 
						if hKiller=="Unseen" then SendChatMessage("F   ..."..hZone.." took a "..hClass..", RIP! Next time use: /db unseen","GUILD"); 
						else SendChatMessage("F   ..."..hZone.." took a "..hClass..", RIP!","GUILD"); end
					end
				else -- not in guild
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..":  "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."@ ";
					message = message..CLLRED..hKiller..CDGRAY.." ("..CLRED..hKillerLvl..CDGRAY..")... "..CLRED.."RIP"..CRED.." :("		
					if gspecial then SendChatMessage("F   ...(was not in the guild)","GUILD"); end
				end
			elseif string.find(message,"in PvP") then
			-- A tragedy has occurred. Hardcore character Alebla has fallen in PvP to Lertia at level 15. May this sacrifice not be forgotten. --
				_,a = string.find(message," character ");
				b,_ = string.find(message," has fallen");
				hName = strsub(message,a+1,b-1);
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				_,a = string.find(message,"in PvP to ");
				b,c = string.find(message," at level ");
				d,_ = string.find(message,". May t");
				if a and b and c and d then
					hKiller = strsub(message,a+1,b-1);
					hLevel = tonumber(strsub(message,c+1,d-1));
					if not (hKiller and hLevel) then kiir("ERROR!  hKiller / hLevel = nil"); hLevel=1; end
				else hKiller="??"; hLevel=1; end
				level,hClass,hZone = GetGuildMemberInfo(hName)
				if level then -- is in the guild, can get more info (class, location)
					if not hZone or hZone=="" then hZone="Azeroth"; end
					hColor = TurtleChatColors_GetClassColor( string.upper(hClass) );					
				else hZone=""; hColor=CLGRAY; hClass=""; end
				if hLevel==nil then kiir("ERROR! hLevel nil"); hLevel="?"; HCstars=1; else HCstars = math.floor(hLevel/10) end
				if hLevel=="?" or hLevel<10 then kiir(CYELLOW..message);
				elseif level then -- a guildie
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death".."!"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..": "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."was killed in "..CLLRED.."PvP"..CLORANGE.." by:\n";
					message = message.."   "..CharChain(" ",math.floor((HCstars+1)*1.3))..CLLRED..hKiller..CLORANGE.." @ ".."|cFFAA9999"..hZone.."... "..CLRED.."RIP"..CRED.." :("
					if gspecial then SendChatMessage("F   ...was a brave "..hClass.." (@ "..hZone.."), RIP!","GUILD"); end
				else -- not in guild
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..":  "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."in "..CLLRED.."PvP"..CLORANGE.." by ";
					message = message..CLLRED..hKiller.."... "..CLRED.."RIP"..CRED.." :("		
					if gspecial then SendChatMessage("F   ...(was not in the guild)","GUILD"); end
				end
			elseif string.find(message,"natural ca") then
			-- A tragedy has occurred. Hardcore character Therilas died of natural causes at level 27. May this sacrifice not be forgotten. --
				_,a = string.find(message," character ");
				b,_ = string.find(message," died of");
				hName = strsub(message,a+1,b-1);
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				_,c = string.find(message," at level ");
				d,_ = string.find(message,". May t");
				if c and d then
					hLevel = tonumber(strsub(message,c+1,d-1));
					if not hLevel then kiir("ERROR!  hLevel = nil"); hLevel=1; end
				else hLevel=1; end
				level,hClass,hZone = GetGuildMemberInfo(hName)
				if level then -- is in the guild, can get more info (class, location)
					if not hZone or hZone=="" then hZone="Azeroth"; end
					hColor = TurtleChatColors_GetClassColor( string.upper(hClass) );					
				else hZone=""; hColor=CLGRAY; hClass=""; end
				if hLevel==nil then kiir("ERROR! hLevel nil"); hLevel="?"; HCstars=1; else HCstars = math.floor(hLevel/10) end
				if hLevel=="?" or hLevel<10 then kiir(CYELLOW..message);
				elseif level then -- a guildie
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death".."!"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..": "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."died of "..CLGREEN.."natural"..CLORANGE.." causes @ ".."|cFFAA9999"..hZone.."... "..CLRED.."RIP"..CRED.." :("
					if special then SendChatMessage("F   ..."..hZone.." took a "..hClass..", RIP!","GUILD"); end
				else -- not in guild
					message = "   "..CRED..CharChain("*",HCstars)..CYELLOW.."*"..CLRED.."HC Death"..CYELLOW.."*"..CRED..CharChain("*",HCstars)..":  "..hColor..hNameLink..CGRAY.." ("..CWHITE..hLevel..CGRAY..") "..CLORANGE.."died of "..CLGREEN.."natural"..CLORANGE.." causes... "..CLRED.."RIP"..CRED.." :("
					message = message..CLLRED..hKiller.."... "..CLRED.."RIP"..CRED.." :("		
					if gspecial then SendChatMessage("F   ...(was not in the guild)","GUILD"); end
				end
			else -- unknown death cause
				message=message..""
			end
      elseif (strsub(message,-8)=="ll face.") and (string.find(message,"Hardcore m")>15) then 
			-- XXX has reached level YYY in Hardcore mode! Their ascendance towards immortality continues, however, so do the dangers they will face.
			gReadRoster();
			local e,_ = string.find(message," has reached level ")
			if e then 
				hName = strsub(message,1,e-1)
				hNameLink = "|Hplayer:"..hName.."|h"..string.upper(hName).."|h"
				level,hClass,hZone = GetGuildMemberInfo(hName)
				if level then hColor = TurtleChatColors_GetClassColor( string.upper(hClass) ) else hColor=CWHITE; hClass=""; hZone=""; end
				_,a = string.find(message,"reached level ");
				b,_ = string.find(message," in Hardcore");
				if a and b then	
					hLevel = tonumber(strsub(message,a+1,b-1)); 
					if not hLevel then kiir("ERROR!  hLevel = nil"); hLevel=1; end
				else hLevel=1; end
				if level then hColor = TurtleChatColors_GetClassColor( string.upper(hClass) ); else hColor=CLGRAY; end
				if hLevel then HCstars = math.floor(hLevel/10) else HCstars=1; end
				if hLevel=="?" or hLevel<10 then kiir(CYELLOW..message);
				elseif level then -- a guildie
					message = "   "..CDGREEN..CharChain("*",HCstars)..hColor..hNameLink..CDGREEN..CharChain("*",HCstars)..CYELLOW.." has reached level "..CDGREEN.."*"..CWHITE..hLevel..CDGREEN.."*"..CYELLOW.." in Hardcore"..CDGREEN.." @ |cFFAA9999"..hZone;
					if gspecial and hLevel then 
						if hLevel>49 then SendChatMessage("GRATS!   Almost there, keep living "..string.upper(hClass).."!","GUILD"); 
						elseif hLevel>39 then SendChatMessage("GRATS!   Keep living "..hClass.."!","GUILD"); 
						else SendChatMessage("Grats!   Keep living "..hClass.."!","GUILD"); end
						--SendChatMessage("GZ, "..(60-hLevel).." more to go!","GUILD"); end
					end
				else -- not in guild
					message = "   "..CDGREEN..CharChain("*",HCstars)..hColor..hNameLink..CDGREEN..CharChain("*",HCstars)..CYELLOW.." has reached level "..CDGREEN.."*"..CWHITE..hLevel..CDGREEN.."*"..CYELLOW.." in Hardcore!"
					SendChatMessage("(^ not in the guild ^)","GUILD"); 
				end
			else -- unknown death cause
				message=message..""
			end	
        elseif (strsub(message,-9)=="Immortal!") then 
			-- XXX has transcended death and reached level 60 on Hardcore mode without dying once! XXX shall henceforth be known as the Immortal! --
			gReadRoster();
			message=message.."" 
			if gspecial then SendChatMessage("CONGRATULATIONS!","GUILD"); end
        elseif strsub(message,1,7)=="XP gain" then 
			_,a = string.find(message," gain is");
			if a then
				if strsub(message,-3)=="OFF" then message = strsub(message,1,a)..": "..CLRED.."OFF" else message = strsub(message,1,a)..": "..CGREEN.."ON" end
			end
			showrested(1) -- %
		end
	end
    return hooks[self](self, message, a1, a2, a3)
end


local function kiir(kirtxt) if kirtxt then DEFAULT_CHAT_FRAME:AddMessage(CSTART..CMYCOLOR..kirtxt..CEND); end end

function showrested(sr)
	p="player";
	x=UnitXP(p);
	m=UnitXPMax(p);
	r=GetXPExhaustion();
	if -1==(r or -1) then t=CLRED.."Not rested." 
	else t="|cFFAAAAFFRested: "..CWHITE..(math.floor((r*1000)/(m*1.5))/10)..CGRAY.."%";end;
	if sr then t=t.."            "..CDGRAY.."macro: "..CLGRAY.."/run showrested()" end
	DEFAULT_CHAT_FRAME:AddMessage(CSTART..t..CEND);
end


--MACRO: /run for b=0,4 do if GetBagName(b) then for s=GetContainerNumSlots(b),1,-1 do if GetContainerItemLink(b,s) then if string.find(GetContainerItemLink(b,s),"Dim Torch") then PickupContainerItem(b,s); DeleteCursorItem() end end end end end
function DeleteTorches()
	local gshardbag = -1;
    local gshardslot= 0;
	if endbag==nil then endbag=0 end
    for bag=0,4 do
        if (GetBagName(bag)~=nil) then
            for slot=GetContainerNumSlots(bag),1,-1 do
				if (GetContainerItemLink(bag,slot)) then
			        if (string.find(GetContainerItemLink(bag,slot), "Dim Torch")) then
						--kiir(bag.." / "..slot)
						PickupContainerItem(bag,slot); DeleteCursorItem()
					end
			    end				
            end
        end
    end
end

function gspec() gspecial=true end -- shows auto F GZ and location in guildchat... only for myself! :)

for index = 1, NUM_CHAT_WINDOWS do
	if(index ~= 2) then
		local frame = _G['ChatFrame'..index]
		hooks[frame] = frame.AddMessage
		frame.AddMessage = AddMessage
	end
end
	


TurtleChatColors_Names = {};
TurtleChatColors_Level = {};




function TurtleChatColors_OnLoad()
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
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
		local name,_,_,level,class,zone = GetGuildRosterInfo(i);
		if( class and name and zone) then 
			if name == gname then return level,class,zone end
		end
	end
	return nil
end

function TurtleChatColors_OnEvent(event)
	if (event == "VARIABLES_LOADED") then GuildRoster(); end	
	if (event == "GUILD_ROSTER_UPDATE") then gReadRoster(); end
end

function TurtleChatColors_ClassData(arg2, class, level )
	if arg2 then arg2 = string.upper(arg2); end
	if class then class = string.upper(class); end
	if not TurtleChatColors_Names then TurtleChatColors_Names = {}; end
	if not TurtleChatColors_Level then TurtleChatColors_Level = {}; end
	if not arg2 then return ""; end

	if not class then  -- only name --> return with classcolor, level
		for name, color in TurtleChatColors_Names do
			if name == arg2 then return color, TurtleChatColors_Level[arg2]; end
		end
	end
    --have to check if I already have the name there...
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
		local color = TurtleChatColors_GetClassColor( class );
		--if class then kiir(arg2.." = "..class) else kiir(arg2.." = ???") end
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