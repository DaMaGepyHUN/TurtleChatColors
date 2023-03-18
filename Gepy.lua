-- version number (last update) --
-- Modifier reminders:	IsAltKeyDown() IsControlKeyDown() IsShiftKeyDown()
gepyver = "20061207";
-- ---------------------------------------------------------------------------------------------------------------------------------------------
Gepy_Version = "2."..gepyver;
GEPY_ADDON_PATH = "Interface\\AddOns\\Gepy\\";
local CRED = "|cFFFF0000"
local CYELLOW = "|cFFFFFF00"
local CGREEN = "|cFF00FF00"
local CDGREEN = "|cFF00BB00"
local CBLUE = "|cFF7070FF"
local CWHITE = "|cFFFFFFFF"
local CGRAY = "|cFF808080"
local CORANGE = "|cFFFF8000"
local CBROWN = "|cFFFFB080"
local CPURPLE = "|cFFD060D0"
local CPINK = "|cFFFF80FF"
local CLRED = "|cFFFF8080"
local CLGREEN = "|cFF80FF80"
local CLGRAY = "|cFFC0C0C0"
local CDGRAY = "|cFF707070"
local CLBLUE = "|cFF40FFFF"
local CHAT_END = "|r"
local CMYCOLOR = "|cFFFF8060"
local CSTART = CBLUE.."-"..CYELLOW.."-"..CBLUE.."- ";

local isWarlock,isMage,isPriest,isDruid,isHunter = false,false,false,false,false
local gPlayerLevel = 0
local playernev = "Unknown"
local CatFormNum = 3 -- the form number on the shapeshiftbar, after getting aquaform, cat form goes from 2 to 3
local Gspellcheck = 0
local GHunterFoodBag,GHunterFoodSlot = 3,99
local StingAllowed = true;
local gPetCanAttack = true;
local SpellsChecked = false;
local doMark = true;

-- class checks
	if (UnitClass("player")=="Warlock") then isWarlock = true; end
	if (UnitClass("player")=="Mage") then isMage = true; end
	if (UnitClass("player")=="Priest") then isPriest = true; end
	if (UnitClass("player")=="Druid") then isDruid = true; end
	if (UnitClass("player")=="Hunter") then isHunter = true; end
	if (UnitClass("player")=="Paladin") then isPaladin = true; end

-- Hunter Non-Stingable targets
local NoSting = {"War Reaver","Blighted Horror","Barbed Lasher","Constrictor Vine","Magma Elemental","Onyxia","Gusting Vortex","Onyxian Warder","Azuregos","Thundering Exile",
				"Lord Kazzak","","","","","","","","","","","","",""}
local NoStingNum = table.getn(NoSting)
-- Minimum SpellLvlRequirements
local FortiMin = {1,2,14,26,38,50} --  ?{1,12,24,36,48,60}, "Prayer of Fortitude" {48,60} "Holy Candle","Sacred Candle"
local ShieldMin = {6,12,18,24,30,36,42,48,54,60} --"Power Word: Shield"
	--"Shadow Protection"{30,42,56}
	--"Divine Spirit"{40,42,54,60}
	--"Fear Ward" 20
local MotwMin = {1,10,20,30,40,50,60} -- Mark of the Wild, "Gift of the Wild", {50,60} "Wild Berries","Wild Thornroot"
local ThornsMin = {2,14,24,34,44,54}
local AIMin = {1,4,18,32,47} -- Arcane Intellect ?{1,14,28,42,56} No: rogue warrior hpet wpet    "Arcane Brilliance" 56 ("Arcane Powder")
	--"Dampen Magic"{12,24,36,48,60}    "Amplify Magic"{18,30,42,54}
local BoWMin = {14,24,34,44,54,60} -- "Greater Blessing of Wisdom", {54,60}, {"Symbol of Kings","Symbol of Kings"}
local BoMMin = {4,12,22,32,42,52,60} -- "Greater Blessing of Might", {52,60}, {"Symbol of Kings","Symbol of Kings"}
	--"Blessing of Salvation" {26}, "Greater Blessing of Salvation", {60}, {"Symbol of Kings"}
	--"Blessing of Kings" {20}, 15, {60}, {"Symbol of Kings"}
	--"Blessing of Sanctuary" {30,40,50,60}, "Greater Blessing of Sanctuary", {60}, {"Symbol of Kings"}
	--"Blessing of Light" {40,50,60}, "Greater Blessing of Light",  {60}, {"Symbol of Kings"}
	--"Unending Breath" 16 WARLOCK
	--"Detect Greater Invisibility" 50, "Detect Invisibility" 38, "Detect Lesser Invisibility" 26
	
-- druid helpers
	local glastform,glastformnum,gcurform,GAttackSlot,GShootSlot = "",0,"",0,0 -- "Attack" spell slot on actionbars, "Shoot"
-- priest helpers
	local GPR,GPRsh,MBcombat,GHunt = 0,0,0,0
-- spellbook checks
	local GIsRejuvenation, GIsRegrowth, GIsCatForm, GIsBearForm, GIsMoonfire, GIsPWFortitude, GIsMarkoftheWild, GIsMindBlast, GIsMindFlay = 0,0,0,0,0,0,0,0,0
	local GIsMaul, GIsEnrage, GIsSmite, GIsClaw, GIsMangle, GFerocity, GIsShred, GIsRake = 0,0,0,0,0,0,0,0
	local GIsSerpent, GIsArcane, GIsMark, GIsMonkey, GIsHawk, GIsConcshot, GHunterRangedSlot = 0,0,0,0,0,0,0
	local GIsRavage, GIsFeroBite = 0,0

function GetCol(gcols)
	if (gcols=="") or (gcols==nil) then gcols="ffc0c0";
	elseif gcols=="lred" or gcols=="lightred" then gcols="ff8080"; 
	elseif gcols=="red"    then gcols="ff0000"; 
	elseif gcols=="dred" or gcols=="darkred" then gcols="aa0000"; 
	elseif gcols=="cyan"  then gcols="00ffff";
	elseif gcols=="lgreen" or gcols=="lightgreen" then gcols="55ff55"; 
	elseif gcols=="green"  then gcols="00dd00";
	elseif gcols=="dgreen" or gcols=="darkgreen" then gcols="009900"; 
	elseif gcols=="orange" then gcols="ffaa00";
	elseif gcols=="lblue" or gcols=="lightblue" then gcols="bbbbff"; 
	elseif gcols=="blue"   then gcols="8080ff"; 
	elseif gcols=="dblue" or gcols=="darkblue" then gcols="0000ff"; 
	elseif gcols=="yellow" then gcols="ffff00";
	elseif gcols=="lpurple" or gcols=="lightpurple" then gcols="e080ff"; 
	elseif gcols=="purple" then gcols="d060d0";
	elseif gcols=="dpurple" or gcols=="darkpurple" then gcols="c000ff"; 
	elseif gcols=="white" then gcols="ffffff";
	elseif gcols=="lgray" or gcols=="lightgray" then gcols="c0c0c0"; 
	elseif gcols=="gray" then gcols="888888";
	elseif gcols=="dgray" or gcols=="darkgray" then gcols="555555"; 
	elseif gcols=="ddgray" then gcols="333333"; 
	elseif gcols=="black" then gcols="000000";
	elseif gcols=="brown" then gcols="886600";
	elseif gcols=="pink"   then gcols="ff80ff"; 
	elseif gcols=="channel" then gcols="ffc0c0"; 
	elseif gcols=="party" then gcols="aaaaff"; 
	elseif gcols=="guild" then gcols="00ff00"; 
	elseif gcols=="me" then gcols="ff8000"; 
	elseif gcols=="common" or gcols=="igreen" then gcols="1eff00"; 
	elseif gcols=="uncommon" or gcols=="igreen" then gcols="1eff00"; 
	elseif gcols=="rare" or gcols=="iblue" then gcols="0070dd"; 
	elseif gcols=="epic" or gcols=="ipurple" or gcols=="epix" then gcols="a335ee"; 
	elseif gcols=="legendary" or gcols=="iorange" then gcols="ff9218"; 
	end;
	if (string.len(gcols)~=6) then gcols="ffc0c0"; end;
	return gcols;
end

function GCheckSpells()
	if (UnitClass("player")=="Priest") then
		GIsPWFortitude = GIsSpellLearned("Power Word: Fortitude");	
		GIsMindBlast = GIsSpellLearned("Mind Blast");	
		GIsMindFlay = GIsSpellLearned("Mind Flay");		
		GIsSmite = GIsSpellLearned("Smite");	
	elseif (UnitClass("player")=="Druid") then
		GFerocityRank = GGetFerocity()	
		GIsMarkoftheWild = GIsSpellLearned("Mark of the Wild");
		GIsRejuvenation = GIsSpellLearned("Rejuvenation")
		GIsRegrowth = GIsSpellLearned("Regrowth")
		GIsCatForm = GIsSpellLearned("Cat Form")
		GIsBearForm = GIsSpellLearned("Dire Bear Form") or GIsSpellLearned("Bear Form");
		GIsRoot= GIsSpellLearned("Entangling Roots");
		GIsMoonfire = GIsSpellLearned("Moonfire");
		GIsWrath = GIsSpellLearned("Wrath");
		GIsStarfire = GIsSpellLearned("Starfire");
		GIsMaul = GIsSpellLearned("Maul");
		GIsClaw = GIsSpellLearned("Claw");
		GIsMangle = GIsSpellLearned("Mangle");
		GIsRake = GIsSpellLearned("Rake");
		GIsShred = GIsSpellLearned("Shred");
		GIsEnrage = GIsSpellLearned("Enrage");	
		GIsPounce = GIsSpellLearned("Pounce");
		GIsRip = GIsSpellLearned("Rip");
		GIsRavage = GIsSpellLearned("Ravage");
		GIsFeroBite = GIsSpellLearned("Ferocious Bite");
	elseif (UnitClass("player")=="Mage") then
		GIsAIntellect = GIsSpellLearned("Arcane Intellect");	
	elseif (UnitClass("player")=="Paladin") then
		GIsBoW = GIsSpellLearned("Blessing of Wisdom");
		GIsBoM = GIsSpellLearned("Blessing of Might");
		GIsBoK = GIsSpellLearned("Blessing of Kings");
	elseif (UnitClass("player")=="Hunter") then
		GIsSerpent = GIsSpellLearned("Serpent Sting");
		GIsArcane = GIsSpellLearned("Arcane Shot");	
		GIsMark = GIsSpellLearned("Hunter's Mark");
		GIsMonkey = GIsSpellLearned("Aspect of the Monkey");
		GIsHawk = GIsSpellLearned("Aspect of the Hawk");
		GHunterRangedSlot = GSearchSpellSlot("Ability_Hunter_Quickshot")	-- for rangecheck, must be on actionbar (Serpent Sting or arcane shot)
		if (GHunterRangedSlot==0) then GHunterRangedSlot = GSearchSpellSlot("Ability_ImpalingBolt") end -- arcane shot
		if (GHunterRangedSlot==0) then GHunterRangedSlot = GSearchSpellSlot("Spell_Frost_Stun") end -- concussive shot
		GIsConcshot = GIsSpellLearned("Concussive Shot");
	end
end

function gcolors() -- lists colors   /run gcolors()
	local GColList = {"white","lgray","gray","dgray","lred","red","dred","lgreen","green","dgreen","cyan","lblue","blue","dblue","pink","lpurple","purple","dpurple","yellow","orange","brown","channel","me","party","guild","rare","epix","legendary","igreen","iblue","ipurple","iorange"}
	local coldb=table.getn(GColList);
	local colstr="   ";
	DEFAULT_CHAT_FRAME:AddMessage(CLGRAY.."ColorCodes"..CGRAY..": "..CYELLOW..coldb..CDGRAY.."       gcodes() = rrggbb list...");
	for gcfor = 1,coldb do
		colstr=colstr.."|cFF"..GetCol(GColList[gcfor])..GColList[gcfor].." ";
		if mod(gcfor,7)==0 then 			
			DEFAULT_CHAT_FRAME:AddMessage(colstr);
			colstr="   ";
		end		
	end
	if colstr~="   " then DEFAULT_CHAT_FRAME:AddMessage(colstr); end;
end

function gcodes() -- lists colors   /run gcodes()
	local GColList = {"white","lgray","gray","dgray",  "channel","lred","red","dred",  "guild","lgreen","green","dgreen",  "cyan","lblue","blue","dblue",  "pink","lpurple","purple","dpurple",  "yellow","orange","me","brown",  "party","rare","epix","legendary"}
	local coldb=table.getn(GColList);
	local colstr="   ";
	DEFAULT_CHAT_FRAME:AddMessage(CLGRAY.."ColorCodes"..CGRAY..": "..CYELLOW..coldb);
	for gcfor = 1,coldb do
		colstr=colstr.."|cFF"..GetCol(GColList[gcfor])..GColList[gcfor]..":"..GetCol(GColList[gcfor]).."   ";
		if mod(gcfor,4)==0 then 			
			DEFAULT_CHAT_FRAME:AddMessage(colstr);
			colstr="   ";
		end		
	end
	if colstr~="   " then DEFAULT_CHAT_FRAME:AddMessage(colstr); end;
end

function grested()
	p="player";
	x=UnitXP(p);
	m=UnitXPMax(p);
	r=GetXPExhaustion();
	if -1==(r or -1) then t=CLRED.."Not rested." 
	else t="|cFF8888FFRested: "..CWHITE..(math.floor((r*1000)/(m*1.5))/10)..CGRAY.."%";end;
	kiir(t)
end
-- /run p="player";x=UnitXP(p);m=UnitXPMax(p);r=GetXPExhaustion();if -1==(r or -1) then t="- Not rested!"else t="- Rested: "..(math.floor((r*1000)/(m*1.5))/10).." %";end;DEFAULT_CHAT_FRAME:AddMessage(t);
	
function gzone()
	kiir("Zone: "..GetZoneText().."          SubZone: "..GetSubZoneText());
end

function gme(metxt,mecol) GME(metxt,mecol) end
function GME(metxt,mecol)
	if metxt==nil then kiir(CWHITE.."GME "..CGRAY.."(|cFF40FF40".."Text, Color"..CGRAY..")   |cFFFF8000  "..UnitName("player").."|cFFFF4040 defaultcolor"); else
		if mecol==nil then mecol="ff4040"; end
		mecol = GetCol(mecol);
		SendChatMessage("\124cff"..mecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","EMOTE");
	end
end

function gsay(metxt,mecol) GSAY(metxt,mecol) end
function GSAY(metxt,mecol)
	if metxt==nil then kiir(CWHITE.."GSAY "..CGRAY.."(|cFF40FF40".."Text, Color"..CGRAY..")   "..CWHITE.."  says:|cFF30FFE0 defaultcolor"); else
		if mecol==nil then mecol="30ffe0"; end
		mecol = GetCol(mecol);
		SendChatMessage("\124cff"..mecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","SAY");
	end
end

function gyell(metxt,mecol) GYELL(metxt,mecol) end
function GYELL(metxt,mecol)
	if metxt==nil then kiir(CWHITE.."GYELL "..CGRAY.."(|cFF40FF40".."Text, Color"..CGRAY..")   "..CRED.."  yells:|cFFC100FF defaultcolor"); else
		if mecol==nil then mecol="c100ff"; end
		mecol = GetCol(mecol);
		SendChatMessage("\124cff"..mecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","YELL");
	end
end

function graid(metxt,mecol) GRAID(metxt,mecol) end
function GRAID(metxt,mecol)
	if metxt==nil then kiir(CWHITE.."GRAID "..CGRAY.."(|cFF40FF40".."Text, Color"..CGRAY..")   |cFFFF8100  Raid:|cFFFF1111 defaultcolor"); else
		if mecol==nil then mecol="ff1111"; end
		mecol = GetCol(mecol);
		SendChatMessage("\124cff"..mecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","RAID");
	end
end

function LFGch(mech)
	  local gspecol="ff6666";
	  local LFGt0="**";
	  local LFGt1="Don't forget to ";
	  local LFGt2="/join LookingForGroup";
	  local LFGt3="rightclick chat's General tab > Join New Channel";
	  local LFGt4="if you haven't already to use LFG anywhere";
	  local LFGtxt="\124cff".."ff1111".."\124Hitem:19:0:0:0:0:0:0:0\124h"..LFGt0.."\124h\124r"..LFGt1;
	LFGtxt=LFGtxt.."\124cff"..gspecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..LFGt2.."\124h\124r".." or ";
	LFGtxt=LFGtxt.."\124cff"..gspecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..LFGt3.."\124h\124r "..LFGt4;
	--LFGtxt=LFGtxt.."\124cff".."ff0000".."\124Hitem:19:0:0:0:0:0:0:0\124h".."!".."\124h\124r";
	SendChatMessage(LFGtxt,"CHANNEL",nil,mech);
end

function gch1(metxt,mecol) GCH1(metxt,mecol) end
function GCH1(metxt,mecol) -- pink
	if metxt==nil then kiir(CWHITE.."GCH1 "..CGRAY.."(|cFF40FF40".."Text, Color"..CGRAY..")   |cFFFFC0C0  [1.General]:|cFFFF80FF defaultcolor"); else
		local index=GetChannelName("General")
		if (index==nil) or (index==0) then index="1"; end;
		if mecol==nil then mecol="ff80ff"; end
		mecol = GetCol(mecol);
		SendChatMessage("\124cff"..mecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","CHANNEL",nil,index);
	end
end

function gwts(metx1,metx2,metx3,mecol) GWTS(metx1,metx2,metx3,mecol) end
function GWTS(metx1,metx2,metx3,mecol)
	if metx1==nil and metx2==nil and metx3==nil then kiir(CWHITE.."GWTS "..CGRAY.."(|cFF40FF40".."Text1, [Item], Text2, Color"..CGRAY..")   |cFFFFC0C0  [2.Trade]: WTS|cFF0070DD [default:r]|cFFFFC0C0 cheap! |cFF0070DD br|cFF1EFF00gc|cFFA335EEep|cFFFF9218ol"); else
		if metx2==nil then metx2=""; end
		if metx3==nil then metx3=""; end
		if mecol==nil then mecol="rare"; end -- rare
		if mecol=="common" or mecol=="green" or mecol=="g" or mecol=="c" then mecol="1eff00"; end
		if mecol=="rare" or mecol=="blue" or mecol=="b" or mecol=="r" then mecol="rare"; end
		if mecol=="epic" or mecol=="epix" or mecol=="purple" or mecol=="e" or mecol=="p" then mecol="epic"; end
		if mecol=="legendary" or mecol=="orange" or mecol=="e" or mecol=="l" then mecol="legendary"; end
		mecol = GetCol(mecol);
		mecol=metx1.." \124cff"..mecol.."\124Hitem:19:0:0:0:0:0:0:0\124h["..metx2.."]\124h\124r "..metx3;
		SendChatMessage(mecol,"CHANNEL",nil,"2");
	end
end



	local Glinen = "|cffffffff|Hitem:2589:0:0:0|h[Linen Cloth]|h|r"
	local G6bag  = "|cffffffff|Hitem:4238:0:0:0|h[Linen Bag]|h|r"
	local Gwool  = "|cffffffff|Hitem:2592:0:0:0|h[Wool Cloth]|h|r"
	local G8bag  = "|cffffffff|Hitem:4240:0:0:0|h[Woolen Bag]|h|r"
	local Gsilk  = "|cffffffff|Hitem:4306:0:0:0|h[Silk Cloth]|h|r"
	local G10bag = "|cffffffff|Hitem:4245:0:0:0|h[Small Silk Pack]|h|r"
	local Gheavy = "|cffffffff|Hitem:4234:0:0:0|h[Heavy Leather]|h|r"
	local Gmagew = "|cffffffff|Hitem:4338:0:0:0|h[Mageweave Cloth]|h|r"
	local G12bag = "|cffffffff|Hitem:10050:0:0:0|h[Mageweave Bag]|h|r"
	local Grune = "|cffffffff|Hitem:14047:0:0:0|h[Runecloth]|h|r"
	local G14bag = "|cffffffff|Hitem:14046:0:0:0|h[Runecloth Bag]|h|r"
	local Grugged = "|cffffffff|Hitem:8170:0:0:0|h[Rugged Leather]|h|r"

function bag6(mech)		if mech==nil then mech="1"; end; SendChatMessage("Making "..G6bag.." from: 7x"..Glinen.."","CHANNEL",nil,mech); end
function bag8(mech)		if mech==nil then mech="1"; end; SendChatMessage("Making "..G8bag.." from: 10x"..Gwool.." /w, or mail mats","CHANNEL",nil,mech); end
function bag10(mech)	if mech==nil then mech="1"; end; SendChatMessage("Making "..G10bag.." from: 20x"..Gsilk..", or 15x"..Gsilk.." 2x"..Gheavy..", /w or mail mats","CHANNEL",nil,mech); end
function bag12(mech)	if mech==nil then mech="1"; end; SendChatMessage("Making "..G12bag.." from: 24x"..Gmagew.."","CHANNEL",nil,mech); end
function bag14(mech)	if mech==nil then mech="1"; end; SendChatMessage("Making "..G14bag.." from: 32x"..Grune..", or 28x"..Grune.." 2x"..Grugged..", /w or mail mats","CHANNEL",nil,mech); end
function gtest()
	SendChatMessage("|cff1eff00|Hitem:9626:0:0:0|h[Dnarmen Charrge]|h|r","CHANNEL",nil,7);
end

function GWhisp_Analiser(event, arg1, arg2, arg3)
	local whisptxt = string.lower(arg1);
	local whispname = string.lower(arg2);
	local whispmsg = arg1;
	whispmsg=string.gsub(whispmsg,"|c","_c");		
	whispmsg=string.gsub(whispmsg,"|r","_r");		
	whispmsg=string.gsub(whispmsg,"||","__");
	whispmsg=string.gsub(whispmsg,"|","_");
	whispmsg=string.gsub(whispmsg,"\\","/");		
	--kiir(whispmsg);	
end
-- /w guntamer a \ b | c

function gremoveitemlink(gremitem)
	gremitem=string.gsub(gremitem," ","~");
	gremitem=string.gsub(gremitem,"\n","~");
	gremitem=string.gsub(gremitem,"\10","~");
	local wstart=strfind(gremitem,"|c");
	local wend=strfind(gremitem,"|r");
	local wcnt=0;
	local wlen=0;
	while (wstart~=nil and wend~=nil and wcnt<10) do
		wstarb=strfind(gremitem,"|h%[");
		wenb=strfind(gremitem,"\93|h");
		wlen=string.len(gremitem);
		gremitem=strsub(gremitem,1,wstart-1).."("..strsub(gremitem,wstarb+1+2,wenb-1)..")"..strsub(gremitem,wend+2,wlen);
		wstart=strfind(gremitem,"|c");
		wend=strfind(gremitem,"|r");
		wcnt=wcnt+1;
	end;
	gremitem=string.gsub(gremitem,"|","~");
	return gremitem;
end




function GMoveItem(glast,gitemname)
	local gshardslot=0;
	if glast==nil then glast=2 end; -- 1,2,3,4,5
	if gitemname==nil then gitemname="Soul Shard"; end
	local gemptybag = -1;
    local gemptyslot= 0;
	local gshardbag = -1;
    local gshardslot= 0;
	local maxtargetbag=5-glast; 	
	for bag=maxtargetbag,1,-1 do -- top first empty slot: gemptybag, gemptyslot
        if GetBagName(bag) then
            for slot=1,GetContainerNumSlots(bag),1 do
				if (GetContainerItemLink(bag,slot)==nil) and (gemptyslot==0) then gemptybag = bag; gemptyslot = slot; break; end				
            end
        end
    end
	if (gemptyslot>0) then -- empty slot found! 
		--kiir("EMPTY slot:     Bag: "..gemptybag.."    Slot: "..gemptyslot);		
		for bag=0,maxtargetbag do
			if (GetBagName(bag)~=nil) then
				for slot=GetContainerNumSlots(bag),1,-1 do
					if (GetContainerItemLink(bag,slot)) then
						if (string.find(GetContainerItemLink(bag,slot), gitemname)) then 
							if (gemptybag>bag) or ((gemptybag==bag) and (gemptyslot<slot)) then 
								--kiir("Bag:"..(5-bag).." Slot:"..slot.."  -->  Bag:"..(5-gemptybag).." Slot:"..gemptyslot);
								gshardbag = bag; gshardslot = slot; break;
							end
						end
					end				
				end
			end
		end
		if (gshardslot>0) then 
			--kiir("Shard MOVE from =     Bag: "..gshardbag.."    Slot: "..gshardslot);
			PickupContainerItem(gshardbag,gshardslot);  if CursorHasItem() then PickupContainerItem(gemptybag,gemptyslot) end -- ===============
		end
	end
	if gshardslot>0 then return true else return false end
end


function GMoveShardsFromLastBag(lastbag) -- 1,(2),3,4,5   default:2   (will not move shards to top first bag)
	-- search last empty spot 4..lastbag (4,3,2,1,0)
	if (UnitAffectingCombat("player")==nil) or (UnitAffectingCombat("player")==false) then
		if lastbag==nil then lastbag=2 end; -- 1,2,3,4,5
		if not GMoveItem(lastbag,"Soul Shard") then
			if not GMoveItem(lastbag,"Soulstone") then
				GMoveItem(lastbag,"Healthstone")
			end
		end
	end
end

--[[
function GMoveShardsFromLastBag(lastbag) -- 4..lastbag = shardbags       2 = 4,3,2 shardbag  <--  move from 1,0
	-- search last empty spot 4..lastbag (4,3,2,1,0)
	if lastbag==nil then lastbag=2 end
	local gemptybag = -1;
    local gemptyslot= 0;
	local gshardbag = -1;
    local gshardslot= 0;
    for bag=lastbag,3 do
        if (GetBagName(bag)~=nil) then
            for slot=GetContainerNumSlots(bag),1,-1 do
				if (GetContainerItemLink(bag,slot)==nil) then gemptybag = bag; gemptyslot = slot; end				
            end
        end
    end
	if (gemptyslot>0) then -- empty slot found! 
		--kiir("EMPTY slot:     Bag: "..gemptybag.."    Slot: "..gemptyslot);		
		for bag=lastbag-1,0,-1 do
			if (GetBagName(bag)~=nil) then
				for slot=1,GetContainerNumSlots(bag),1 do
					if (GetContainerItemLink(bag,slot)) then
						if (string.find(GetContainerItemLink(bag,slot), "Soul Shard")) then	gshardbag = bag; gshardslot = slot; end
					end				
				end
			end
		end
		if (gshardslot>0) then 
			--kiir("Shard MOVE from =     Bag: "..gshardbag.."    Slot: "..gshardslot);
			PickupContainerItem(gshardbag,gshardslot);  if CursorHasItem() then PickupContainerItem(gemptybag,gemptyslot) end -- ===============
		--else kiir("No SHARD!  ("..(lastbag-1).."..0)")
		end
	--else kiir("No EMPTY slot!  (4.."..lastbag..")")
	end
end
]]

function GMoveHSFromLastBag(lastbag) -- 4..lastbag = shardbags       2 = 4,3,2 shardbag  <--  move from 1,0
	-- search last empty spot 4..lastbag (4,3,2,1,0)
	if lastbag==nil then lastbag=2 end
	local gemptybag = -1;
    local gemptyslot= 0;
	local gshardbag = -1;
    local gshardslot= 0;
    for bag=lastbag,3 do
        if (GetBagName(bag)~=nil) then
            for slot=GetContainerNumSlots(bag),1,-1 do
				if (GetContainerItemLink(bag,slot)==nil) then gemptybag = bag; gemptyslot = slot; end				
            end
        end
    end
	if (gemptyslot>0) then -- empty slot found! 
		--kiir("EMPTY slot:     Bag: "..gemptybag.."    Slot: "..gemptyslot);		
		for bag=lastbag-1,0,-1 do
			if (GetBagName(bag)~=nil) then
				for slot=1,GetContainerNumSlots(bag),1 do
					if (GetContainerItemLink(bag,slot)) then
						if (string.find(GetContainerItemLink(bag,slot), "Healthstone")) then gshardbag = bag; gshardslot = slot; end
					end				
				end
			end
		end
		if (gshardslot>0) then 
			--kiir("Shard MOVE from =     Bag: "..gshardbag.."    Slot: "..gshardslot);
			PickupContainerItem(gshardbag,gshardslot);  if CursorHasItem() then PickupContainerItem(gemptybag,gemptyslot) end -- ===============
		--else kiir("No SHARD!  ("..(lastbag-1).."..0)")
		end
	--else kiir("No EMPTY slot!  (4.."..lastbag..")")
	end
	local gemptybag = -1;
    local gemptyslot= 0;
	local gshardbag = -1;
    local gshardslot= 0;	
    for bag=lastbag,3 do
        if (GetBagName(bag)~=nil) then
            for slot=GetContainerNumSlots(bag),1,-1 do
				if (GetContainerItemLink(bag,slot)==nil) then gemptybag = bag; gemptyslot = slot; end				
            end
        end
    end
	if (gemptyslot>0) then -- empty slot found! 
		--kiir("EMPTY slot:     Bag: "..gemptybag.."    Slot: "..gemptyslot);		
		for bag=lastbag-1,0,-1 do
			if (GetBagName(bag)~=nil) then
				for slot=1,GetContainerNumSlots(bag),1 do
					if (GetContainerItemLink(bag,slot)) then
						if (string.find(GetContainerItemLink(bag,slot), "Soulstone")) then gshardbag = bag; gshardslot = slot; end
					end				
				end
			end
		end
		if (gshardslot>0) then 
			--kiir("Shard MOVE from =     Bag: "..gshardbag.."    Slot: "..gshardslot);
			PickupContainerItem(gshardbag,gshardslot);  if CursorHasItem() then PickupContainerItem(gemptybag,gemptyslot) end -- ===============
		--else kiir("No SHARD!  ("..(lastbag-1).."..0)")
		end
	--else kiir("No EMPTY slot!  (4.."..lastbag..")")
	end
end



function gch(metx1,metx2,mecol,mech) GCH(metx1,metx2,mecol,mech) end
function GCH(metx1,metx2,mecol,mech)
	if metx1==nil and metx2==nil then kiir(CWHITE.."GCH "..CGRAY.."(|cFF40FF40".."ColoredText, Text2, Color, Channel"..CGRAY..")   |cFFFFC0C0  [X.Channel]:|cFFFFF0D8 defaultchannel=1"); else
		if metx1==nil then metx1=""; end
		if metx2==nil then metx2=""; end
		if mecol==nil then mecol="fff0d8"; end -- eggshell yellow
		if mech==nil then mech="1"; end
		mecol = GetCol(mecol);
		SendChatMessage("\124cff"..mecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..metx1.."\124h\124r"..metx2,"CHANNEL",nil,mech);
	end;
end

function GMERED(metxt)
	if metxt~=nil then SendChatMessage("\124cffff0000\124Hitem:19:0:0:0:0:0:0:0\124h[Player]\124h\124r: \124cffff8080\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","EMOTE"); end
end

function gguild(metxt,mecol) GGUILD(metxt,mecol) end
function GGUILD(metxt,mecol)	
	if metxt==nil then kiir(CWHITE.."GGUILD "..CGRAY.."(|cFF40FF40".."Text, Color"..CGRAY..")   |cFF00FF00  Guild:|cFFCCFF44 defaultcolor"); else
		if (mecol=="") or (mecol==nil) then mecol="ccff44"; end;
		mecol = GetCol(mecol);
		SendChatMessage("\124cff"..mecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","GUILD");
	end
end

function gwelcome(gwtxt)
	if gwtxt==nil then gwtxt="Welcome"; end
	SendChatMessage("\124cffd7ff46\124Hitem:19:0:0:0:0:0:0:0\124h"..gwtxt.."\124h\124r\124cffff7070\124Hitem:19:0:0:0:0:0:0:0\124h!\124h\124r","GUILD");
end

function gblue(meblu,metxt) GBLUE(meblu,metxt) end
function GBLUE(meblu,metxt)	
	if meblu==nil then kiir(CWHITE.."GBLUE "..CGRAY.."(|cFF40FF40".."Blueitem, guildtext"..CGRAY..")   |cFF00FF00  Guild: |cFF0070dd[Blue] |cFF00ff00Guildtext"); else
		if metxt==nil then metxt="" end;
		SendChatMessage("\124cff0070dd\124Hitem:19:0:0:0:0:0:0:0\124h["..meblu.."]\124h\124r "..metxt,"GUILD");
	end
end

function gparty(metxt,mecol) GPARTY(metxt,mecol) end
function GPARTY(metxt,mecol)	
	if metxt==nil then kiir(CWHITE.."GPARTY "..CGRAY.."(|cFF40FF40".."Text, Color"..CGRAY..")   |cFFAAAAFF  Party:|cFF8080FF defaultcolor"); else
		if (mecol=="") or (mecol==nil) then mecol="8080ff"; end;
		mecol = GetCol(mecol);
		SendChatMessage("\124cff"..mecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","PARTY");
	end
end

function gwhisper(metxt,metar,mecol) GWHISPER(metxt,metar,mecol) end
function GWHISPER(metxt,metar,mecol)	
	if (metxt==nil) or (metar==nil) then kiir(CWHITE.."GWHISPER "..CGRAY.."(|cFF40FF40".."Text, Target, Color"..CGRAY..")   |cFFFF80FF  whispers:|cFFFF8181 defaultcolor"); else
		if (mecol=="") or (mecol==nil) then mecol="ff8181"; end;
		mecol = GetCol(mecol);
		SendChatMessage("\124cff"..mecol.."\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","WHISPER",nil,metar);
	end
end

function GO(metxt) SendChatMessage("\124cffff8000\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","GUILD"); end
function GB(metxt) SendChatMessage("\124cff8888ff\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","GUILD"); end
function GR(metxt) SendChatMessage("\124cffff4040\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","GUILD"); end
function GY(metxt) SendChatMessage("\124cffffff00\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","GUILD"); end
function GG(metxt) SendChatMessage("\124cff00aa00\124Hitem:19:0:0:0:0:0:0:0\124h"..metxt.."\124h\124r","GUILD"); end
--[[ ]]--

function GIsSpellLearned(GISL)
	local numTabs = GetNumSpellTabs()
	local GISLfound = 0
	for ii=1,numTabs do
		local tabName, _, tabOffset, numEntries = GetSpellTabInfo(ii)
		for jj = tabOffset + 1, tabOffset + numEntries do
			local spellName, spellSubName = GetSpellName(jj, BOOKTYPE_SPELL)  -- spellSubName = "Rank 2"
			if (GISL==spellName) then GISLfound = jj; end -- 1.. spellbook index
			--kiir(CWHITE..spellName .. CLGRAY.."(" .. spellSubName .. ")  "..CLGREEN..jj..CLBLUE.."  "..tabName)
		end
	end 
	--if (GISLfound==0) then kiir(CRED..GISL.."nem létezik!") else local spellName, spellSubName = GetSpellName(GISLfound, BOOKTYPE_SPELL); end
	return GISLfound;
end

function GetSpellRanks(GSR)
  if GIsSpellLearned(GSR) then
	local numTabs = GetNumSpellTabs()
	for ii=1,numTabs do
		local tabName, _, tabOffset, numEntries = GetSpellTabInfo(ii)
		for jj = tabOffset + 1, tabOffset + numEntries do
			local spellName, spellSubName = GetSpellName(jj, BOOKTYPE_SPELL)
			if (GSR==spellName) then kiir(spellName.."  -->  "..spellSubName); end -- 1.. spellbook index
			--kiir(CWHITE..spellName .. CLGRAY.."(" .. spellSubName .. ")  "..CLGREEN..jj..CLBLUE.."  "..tabName)
		end
	end 		
  end
end

function GIsSpellRank(GSN,GSR) -- 0:no such spell rank
	local numTabs = GetNumSpellTabs()
	local GSRank = 0
	for ii=1,numTabs do
		local tabName, _, tabOffset, numEntries = GetSpellTabInfo(ii)
		for jj = tabOffset + 1, tabOffset + numEntries do
			local spellName, spellSubName = GetSpellName(jj, BOOKTYPE_SPELL)  -- spellSubName = "Rank 2"
			if (GSN==spellName) then 
				if spellSubName=="Rank "..GSR then GSRank=GSR; end;
			end
		end
	end 
	return GSRank;
end


function GGetCombo()
	if GetUnitName("target") then
		return GetComboPoints()
	else return 0; end
end

function GCanHunterShot() -- if ranged attacks are "RED" or "out of range" on actionbar... can be too far or too close!
	if GHunterRangedSlot~=0 then
		if IsActionInRange(GHunterRangedSlot)==1 then return true else return false end
	else return true end -- if no ranged action found on actionbar, its better to return true as default so shot actions are enabled
end

function EnemyHPpercent()
	if UnitExists("target") then
		return (UnitHealth("target")*100/UnitHealthMax("target"))
	else return -1; end;
end

function PlayerHPpercent()
	if UnitHealthMax("player") then return (UnitHealth("player")*100/UnitHealthMax("player")) else return 0; end
end

function reset() ResetInstances(); end
function GIR() ResetInstances(); end
function RI() ResetInstances(); end

function AutoTarget()
	if UnitExists("pet") then 
		if GetUnitName("target")==nil or UnitIsCorpse("target") or UnitIsDeadOrGhost("target") then
			AssistUnit("pet");
		end
	end
	if GetUnitName("target")==nil then TargetNearestEnemy() end
	if UnitExists("target") then if UnitIsDeadOrGhost("target") or UnitIsCorpse("target") then TargetNearestEnemy() end; end
	if UnitExists("target") and UnitIsPlayer("target") and (UnitIsFriend("player","target")) then --[[kiir("Assisting "..GetUnitName("target"));]] AssistUnit("target"); end
	if UnitIsFriend("player","target") then AssistUnit("target"); end
end

--==============================
--==    ATTACK rotations    ====
--==============================
function GepyAttack()
	if SpellsChecked==false then GCheckSpells() end
  UIErrorsFrame:Hide();
	if Gspellcheck==0 then Gspellcheck=1; GCheckSpells() end
	--[[kiir(CWHITE.."GepyATTACK!");
	if UnitExists("target") and UnitIsFriend("player", "target") then kiir("FRIENDLY"); end
	if UnitIsPlayer("target") then kiir("PLAYER!") end;]]
	
	--if UnitExists("pet") then PetDefensiveMode(); end
	AutoTarget()
	TurtleDismount()
	
	if (isPaladin) then -- auras buffs and activate seal even if no target
			if (GIsSpellLearned("Retribution Aura")>0) and (IsPalaAuraActive()==false) and (GPlayerHasBuff("Spell_Holy_SealOfWisdom")==false) then CastSpellByName("Retribution Aura")
			elseif (GIsSpellLearned("Devotion Aura")>0) and IsPalaAuraActive()==false then CastSpellByName("Devotion Aura")
			elseif GPlayerHasBuff("Spell_Holy_MindSooth") and GIsBoW>0 and GPlayerBuffDuration("Spell_Holy_SealOfWisdom")<60 then CastSpellByName("Blessing of Wisdom")
			elseif GIsBoM>0 and (GPlayerHasBuff("Spell_Holy_FistOfJustice")==false) and (GPlayerHasBuff("Spell_Holy_SealOfWisdom")==false) then CastSpellByName("Blessing of Might")
			elseif GIsBoM>0 and GPlayerHasBuff("Spell_Holy_FistOfJustice") and GPlayerBuffDuration("Spell_Holy_FistOfJustice")<60 then CastSpellByName("Blessing of Might") 
			elseif GIsBoW>0 and GPlayerHasBuff("Spell_Holy_SealOfWisdom") and GPlayerBuffDuration("Spell_Holy_SealOfWisdom")<60 then CastSpellByName("Blessing of Wisdom") 
		elseif (GIsSpellLearned("Seal of Command")>0) and IsPalaSealActive()==false then CastSpellByName("Seal of Command")			
		elseif (GIsSpellLearned("Seal of Righteousness")>0) and IsPalaSealActive()==false then CastSpellByName("Seal of Righteousness")	
		end 
	end	-- "Spell_Holy_HolySmite": Seal of the Crusader
	
	if (GetUnitName("target")~=nil) --[[and UnitIsEnemy("player","target")]] then
	
		if (isWarlock) then  
			if UnitExists("pet") and (gPetCanAttack) then --[[kiir("PET attack");]] PetAttack(); end
			if (GPlayerHasBuff("Spell_Shadow_Twilight")) then CastSpellByName("Shadow Bolt") -- nightfall
			elseif (GTargetHasDebuff("Spell_Shadow_Requiem")==false) and (GIsSpellLearned("Siphon Life")>0) and (UnitCreatureType("target")~="Mechanical") then CastSpellByName("Siphon Life")
			elseif (GTargetHasDebuff("Spell_Shadow_AbominationExplosion")==false) and (GIsSpellLearned("Corruption")>0) then CastSpellByName("Corruption")
			elseif ((GTargetHasDebuff("Spell_Shadow_UnholyStrength")==false) and (GTargetHasDebuff("Spell_Shadow_GrimWard")==false) and (GTargetHasDebuff("Spell_Shadow_CurseOfSargeras")==false)) and (GIsSpellLearned("Curse of Agony")>0) then CastSpellByName("Curse of Agony")
			elseif (GTargetHasDebuff("Spell_Fire_Immolation")==false) and (GIsSpellLearned("Immolate")>0) and (gPlayerLevel<12) then CastSpellByName("Immolate")
			else 
				--[[if (GIsSpellLearned("Drain Life")>0) then
				if (GTargetHasDebuff("Spell_Shadow_LifeDrain02")==false) then GepyChannel("Drain Life") end
				else CastSpellByName("Shadow Bolt") end]]
				CastSpellByName("Shadow Bolt")
			end
			
		elseif (isPaladin) then 
			GStartAutoattack()
			--	judgement if active
			-- hammer of justice
			-- exorcism if undead or demon? isdemon?


		elseif (isHunter) then -- in MC no mark or stings allowed!  /gepy sting   to turn on/off
			local sstart, sduration, senable, astart, aduration, aenable = 0,0,0,0,0,0
			if (gPlayerLevel<12) and (GIsConcshot>0) then sstart, sduration, senable = GetSpellCooldown(GIsConcshot,BOOKTYPE_SPELL); else sduration=1 end
			--kiir("0gPlayerLevel="..gPlayerLevel)
			--if not UnitAffectingCombat("player") then kiir("NOT In Combat") else kiir("In Combat") end
			--[[if (GIsMark>0) then kiir("2GIsMark>0") end
			if (GTargetHasDebuff("Ability_Hunter_SniperShot")==false) then kiir("3GTargetHasDebuff(Ability_Hunter_SniperShot)==false") end
			if (StingAllowed) then kiir("4StingAllowed") end
			if (UnitExists("pet")==nil) then kiir("5UnitExists(pet)==nil") end
			if GTargetHasDebuff("Spell_Frost_Stun")==false then kiir("6GTargetHasDebuff(Spell_Frost_Stun)==false") end ]]
			if UnitExists("pet") and (GetZoneText()~="The Molten Core") and (gPetCanAttack) then PetAttack("target"); end
			--kiir("sduration: "..sduration) 
			if (GIsArcane>0) then 
				astart, aduration, aenable = GetSpellCooldown(GIsArcane,BOOKTYPE_SPELL);
			else aduration=-1; end
			
			if (not UnitAffectingCombat("player")) then GHunt=0; end
			if (not UnitAffectingCombat("player")) and (GIsMark>0) and (doMark) and (GTargetHasDebuff("Ability_Hunter_SniperShot")==false) and (StingAllowed) and (GetZoneText()~="The Molten Core") then 
				CastSpellByName("Hunter's Mark"); 
			--Concussive Shot if no pet and below lvl 12
			elseif (not UnitAffectingCombat("player")) and (gPlayerLevel<12) and (UnitExists("pet")==nil) and (GIsConcshot>0) and (GTargetHasDebuff("Spell_Frost_Stun")==false) and (sduration==0) then
				CastSpellByName("Concussive Shot");
			elseif UnitAffectingCombat("player") and CheckInteractDistance("target",3) then 
				CastSpellByName("Raptor Strike"); 
				CastSpellByName("Mongoose Bite"); 
			elseif (StingAllowed) and (GIsSerpent>0) and (GTargetHasDebuff("Ability_Hunter_Quickshot")==false) --and GHunt==0 
				then 
				sstart, sduration, senable = GetSpellCooldown(GIsSerpent,BOOKTYPE_SPELL);
				if (sduration==0) then 					
					GHunt=0; local UNam=UnitName("target"); for stf=1,NoStingNum do if (UNam==NoSting[stf]) then GHunt=1; end; end;
					--[[if (UnitCreatureType("target")=="Elemental") or (GetZoneText()=="The Molten Core") then GHunt=2; else
						 
					end ]]
					if GHunt==0 then CastSpellByName("Serpent Sting"); else CastSpellByName("Arcane Shot") end
				end; 
				GStartAutoattack(); --CastSpellByName("Auto Shot")			
			elseif (GIsArcane>0) and (aduration==0) and (gPlayerLevel<36) and (UnitName("target")~="Azuregos") then CastSpellByName("Arcane Shot")-- check arcane shot cooldown				
			elseif (GIsSpellLearned("Auto Shot")>0) and (not UnitAffectingCombat("player")) then CastSpellByName("Auto Shot")
			elseif (GIsSpellLearned("Trueshot")>0) then CastSpellByName("Trueshot")
			end
			
		elseif (isDruid) then  
			--local powerType = UnitPowerType("player"); kiir("powerType = "..powerType) -- 0 - mana   1 - rage    3 - energy
			--local currMana, maxMana = UnitMana("player"), UnitManaMax("player"); kiir("Mana:  "..currMana.." / "..maxMana)
			if GGetForm()==1 then -- BEAR form
				GStartAutoattack()
				if GIsEnrage>0 then local _, eduration = GetSpellCooldown(GIsEnrage,BOOKTYPE_SPELL); if eduration==0 then CastSpellByName("Enrage") end end
				if GIsMaul>0 then if UnitMana("player")>=(15-GFerocityRank) then CastSpellByName("Maul") end end
			elseif GGetForm()==CatFormNum then -- CAT form
				GStartAutoattack()
				--kiir("PowType: "..UnitPowerType("player").."     Energy: "..UnitMana("player").."     Combo: "..GGetCombo())
				if GIsProwl() then -- PROWL
					if GIsRavage>0 and UnitMana("player")>=60 then CastSpellByName("Ravage") 
					elseif GIsShred>0 and UnitMana("player")>=60 then CastSpellByName("Shred") 
					elseif GIsRake>0 and (UnitMana("player")>=(40-GFerocityRank)) and (GTargetHasDebuff("XXX_Rake")==false) then CastSpellByName("Rake") 
					elseif GIsMangle>0 and UnitMana("player")>=(45-GFerocityRank) then CastSpellByName("Mangle") 
					elseif GIsClaw>0 and UnitMana("player")>=(45-GFerocityRank) then CastSpellByName("Claw") 
					end
				else --kiir(UnitMana("player").." = "..(45-GFerocityRank)) -- NORMAL
						--if GIsRake>0 and (UnitMana("player")>=(40-GFerocityRank)) and (GTargetHasDebuff("XXX_Rake")==false) then CastSpellByName("Rake")
					if 
					--(GIsFeroBite>0 and UnitMana("player")>=35) and (GGetCombo()>=5 or (GGetCombo()>=4 and EnemyHPpercent()<26) ) then CastSpellByName("Ferocious Bite") elseif 
					--GIsMangle>0 and UnitMana("player")>=(45-GFerocityRank) then CastSpellByName("Mangle") elseif
					GIsClaw>0 and UnitMana("player")>=(45-GFerocityRank) then CastSpellByName("Claw") 
					end
				end
			else -- Caster form
				local wstart, wduration, wenable, sstart, sduration, senable, mstart, mduration, menable = 0,0,0,0,0,0,0,0,0
			      wstart, wduration, wenable = GetSpellCooldown(GIsWrath,BOOKTYPE_SPELL);
				  if GIsMoonfire>0 then mstart, mduration, menable = GetSpellCooldown(GIsMoonfire,BOOKTYPE_SPELL); end 
				  if GIsStarfire>0 then sstart, sduration, senable = GetSpellCooldown(GIsStarfire,BOOKTYPE_SPELL); end
				--if (UnitAffectingCombat("player")==nil) then kiir("GPR = "..GPR.."  (nocombat)") else kiir("GPR = "..GPR.."  (COMBAT)"); end
				if (not UnitAffectingCombat("player")) then
					if (GPR==1) then
						if (mduration==0) and (mstart==0) and (GTargetHasDebuff("Spell_Nature_StarFall")==false) then CastSpellByName("Moonfire"); GPR=2;
						elseif (GTargetHasDebuff("Spell_Nature_StarFall")) then GPR=2; end
					else GPR=0;
						if (GIsRoot>0) and (GTargetHasDebuff("Spell_Nature_StrangleVines")==false) then 
							GPR=2; CastSpellByName("Entangling Roots"); 
						elseif (GIsStarfire>0) then if (sduration==0) and (sstart==0) then CastSpellByName("Starfire"); GPR=1; end
						elseif (wduration==0) and (wstart==0) then CastSpellByName("Wrath"); GPR=1; end
					end
				end
				if UnitAffectingCombat("player") then GPR=2;
					if (GIsMoonfire>0) then
						if (GTargetHasDebuff("Spell_Nature_StarFall")==false) then CastSpellByName("Moonfire"); end;
						if (GTargetHasDebuff("Spell_Nature_StarFall")) then GPR=3; -- only does moonfire once!
							if (GIsStarfire>0) then if (sduration==0) and (sstart==0) then CastSpellByName("Starfire"); GPR=1; end
							elseif (wduration==0) and (wstart==0) then CastSpellByName("Wrath"); end
						end 
					else 
						if (GIsStarfire>0) then if (sduration==0) and (sstart==0) then CastSpellByName("Starfire"); GPR=1; end
						elseif (wduration==0) and (wstart==0) then CastSpellByName("Wrath"); end					
					end
				end;
			
			end
			
		elseif (isPriest) then  -- Spell_Shadow_ShadowWordPain
		  if GIsMindBlast>0 then	
			local mstart, mduration, menable, sstart, sduration, senable = 0,0,0,0,0,0
			      mstart, mduration, menable = GetSpellCooldown(GIsMindBlast,BOOKTYPE_SPELL);
			if GIsSmite>0 then sstart, sduration, senable = GetSpellCooldown(GIsSmite,BOOKTYPE_SPELL); end 
			--kiir(GPR.."-----------"); kiir("  SMITE  start:"..sstart.."  duration:"..sduration.."  enable:"..senable); kiir("  MINDB  start:"..mstart.."  duration:"..mduration.."  enable:"..menable);  
			if (not UnitAffectingCombat("player")) then GPR=1;				
				if UnitAffectingCombat("player") then MBcombat=1 else MBcombat=0; end
				if (mduration==0) and (mstart==0) then CastSpellByName("Mind Blast"); end;
			elseif (mduration==0) and (sduration==0) and (GTargetHasDebuff("Spell_Shadow_ShadowWordPain")==false) then GPR=1;
			elseif (GPR==1) and (mduration>2) and (sduration==0) then  
				if MBcombat==1 then GPR=21; -- was already in combat when MB was cast (probably 2nd MB) --> continue wanding
				-- started as out of combat
				elseif (GIsMindFlay==0) then -- no mindflay yet
					if GPlayerHasBuff("Spell_Holy_PowerWordShield") then GPR=20 else GPR=25; end -- Active Shield --> 2nd Smite					
					if (GTargetHasDebuff("Spell_Shadow_ShadowWordPain")==false) then CastSpellByName("Shadow Word: Pain") end
				else -- SW:pain after mindblast
					CastSpellByName("Shadow Word: Pain"); GPR=GPR+1; -- SW:Pain
				end
			end
			-- SW:pain DOT
		   if UnitAffectingCombat("player") then
			if (GPR==2) then 
				if (GTargetHasDebuff("Spell_Shadow_ShadowWordPain")==false) then CastSpellByName("Shadow Word: Pain") else GPR=GPR+2; end;
			-- MindFlay 1
			elseif (GPR==4) then -- if got MindFlay, 1.
				if (GTargetHasDebuff("Spell_Shadow_SiphonMana")==true) then GPR=GPR+1; else CastSpellByName("Mind Flay"); end
			elseif (GPR==5) then
				if (GTargetHasDebuff("Spell_Shadow_SiphonMana")==false) then GPR=GPR+1; end
			elseif (GPR==6) then -- 2nd mindflay
				if (GTargetHasDebuff("Spell_Shadow_SiphonMana")==true) then GPR=GPR+1; else CastSpellByName("Mind Flay"); end
			elseif (GPR==7) then 
				if (GTargetHasDebuff("Spell_Shadow_SiphonMana")==false) then GPR=GPR+1; end
			elseif (GPR==8) then -- MB if ready?
				if (mduration==0) and (mstart==0) then GPR=12; else CastSpellByName("Mind Flay"); GPR=GPR+1; end;				
			elseif (GPR==9) then -- 3. mindflay 
				if (GTargetHasDebuff("Spell_Shadow_SiphonMana")==true) then GPR=GPR+1; else CastSpellByName("Mind Flay"); end
			elseif (GPR==10) then 
				if (GTargetHasDebuff("Spell_Shadow_SiphonMana")==false) then GPR=GPR+1; end
			elseif (GPR==11) then --3. mf end
				if (mduration==0) and (mstart==0) then CastSpellByName("Mind Blast"); GPR=GPR+1; end;
			
			elseif (GPR==12) then
				if (mduration~=0) or (mstart~=0) then GPR=GPR+1; else CastSpellByName("Mind Blast"); end
			elseif (GPR==13) then -- MB utáni MF
				if (GTargetHasDebuff("Spell_Shadow_SiphonMana")==true) then GPR=GPR+1; else CastSpellByName("Mind Flay"); end
			elseif (GPR==14) then 
				if (GTargetHasDebuff("Spell_Shadow_SiphonMana")==false) then GPR=GPR+1; end
			elseif (GPR==15) then -- MF véget ért
				GPR=21; -- wand
				
			elseif (GPR==20) then --kiir(GPR.." NextSmiteCasted, SWP = Sm.start:"..sstart.."  Sm.dura:"..sduration.."  enable:"..senable.."         MB.dura:"..mduration);
				--if (GTargetHasDebuff("Spell_Shadow_ShadowWordPain")==false) then CastSpellByName("Shadow Word: Pain");
				if (GTargetHasDebuff("Spell_Shadow_ShadowWordPain")==false) then CastSpellByName("Shadow Word: Pain")
				elseif (sduration==0) and (sstart==0) then CastSpellByName("Smite"); GPR=GPR+1; end;
			elseif (GPR==21) then
								if (sduration~=0) or (sstart~=0) then GPR=GPR+1; else CastSpellByName("Smite"); end
			elseif (GPR==22) then				
				if (sduration==0) and (sstart==0) then CastSpellByName("Smite"); GPR=GPR+1; end;
			elseif (GPR==23) then --kiir(GPR.." NextSmiteCasted, SWP = Sm.start:"..sstart.."  Sm.dura:"..sduration.."  enable:"..senable.."         MB.dura:"..mduration);
				if (sduration~=0) or (sstart~=0) then GPR=GPR+1; else CastSpellByName("Smite"); end
			elseif (GPR==24) then -- after 2nd smite, wait for MindBlast
				if (mduration==0) and (mstart==0) then GPR=10; CastSpellByName("Mind Blast"); end;
			elseif (GPR==25) then --kiir(GPR.." NextSmiteCasted, SWP = Sm.start:"..sstart.."  Sm.dura:"..sduration.."  enable:"..senable.."         MB.dura:"..mduration);
				--if (GTargetHasDebuff("Spell_Shadow_ShadowWordPain")==false) then CastSpellByName("Shadow Word: Pain"); end;
				if (sduration==0) then GPR=GPR+1; end;
				
			elseif (GPR==30) then --kiir(GPR.." SWPend, wand = Sm.dura: "..sduration.."  enable:"..senable.."         MB.dura:"..mduration); 
				GPR=GPR+1; CastSpellByName("Shoot");
			elseif (GPR==31) then --kiir(GPR.." Wanding = Sm.dura: "..sduration.."  enable:"..senable.."         MB.dura:"..mduration);
				if (not UnitAffectingCombat("player")) then GPR=0; end	
			end
		   end --unitaffectingcombat
		  end -- Gismindblast
		end	-- Priest end
		
	--else local ganam=GetUnitName("target"); if ganam==nil then ganam="???"; end kiir("Nincs celpont vagy friendly!:  "..ganam); if UnitIsEnemy("player","target")==false then kiir("Nem ellenseg"); end
	end
	--kiir("CAST = "..GCSpell)
  UIErrorsFrame:Clear(); UIErrorsFrame:Show();
end


function gPetAttack() --
	if (gPetCanAttack) then PetAttack(); end
end

function nomark(nm)
	if nm==nil then doMark=(not doMark) elseif nm then doMark=true else doMark=false end;
	if doMark then nm=CGREEN.."ON" else nm=CRED.."OFF"; end
	kiir(CYELLOW.."Hunter's Mark: "..nm)
end

function PetAttackToggle(gpat) -- (): toggle	-1: only info		0: OFF		1+: ON		
	if (gpat==nil) then 
		if (gPetCanAttack) then 
			gPetCanAttack=false; 
		else 
			gPetCanAttack=true; 
		end;
	elseif (gpat>=0) then
		if (gpat==0) then gPetCanAttack=false; else gPetCanAttack=true; end;
	end;
	if (gPetCanAttack) then kiir(CLGREEN.."PetAttack ON"); else kiir(CRED.."PetAttack OFF"); end;
end


function IsPalaAuraActive()
	if (GPlayerHasBuff("Spell_Holy_DevotionAura")) or (GPlayerHasBuff("Spell_Holy_AuraOfLight")) or (GPlayerHasBuff("Spell_Holy_MindSooth")) -- devo retri conc
	then return true; else return false; end;
	end
function IsPalaSealActive()
	if (GPlayerHasBuff("Ability_ThunderBolt")) or (GPlayerHasBuff("Spell_Holy_HolySmite")) or (GPlayerHasBuff("Ability_Warrior_InnerRage")) --Righteousness, Crusader, Command
		or (GPlayerHasBuff("Spell_Holy_SealOfWrath"))
	then return true; else return false; end;
	end


local gForceBuff=0;
local gLastTarget=""
local gCurTarget=""
local gLastForcebuffed=false;
--===================
--==    BUFFS    ====
--===================
function GepyBuffs() -- MAGE 	FireWard:Spell_Fire_FireArmor  Spell_Frost_FrostWard
	if SpellsChecked==false then GCheckSpells() end
  UIErrorsFrame:Hide();
	--GListPlayerBuffs();
	--if UnitIsEnemy("player","target") then GListDebuffs("target"); end; GListBuffs("target");
	local gtarg = "player"
	local haveTarget = UnitExists("target")
	local nonplayer = true;

  if GIsAlive() then
	local gModPressed=false; if IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown() then gModPressed=true end
	-- check for proper BUFF target (gtarg)
	if UnitExists("mouseover") then
		--if UnitInRange("mouseover")~=nil then if UnitInRange("mouseover") then
		if UnitReaction("mouseover","player")>=4 and UnitLevel("mouseover")~=nil and not UnitIsDeadOrGhost("mouseover") and not UnitIsCorpse("mouseover") 
		and UnitIsConnected("mouseover") and UnitIsVisible("mouseover") and not UnitOnTaxi("mouseover") then 
			if GetUnitName("mouseover")~=GetUnitName("player") then gtarg="mouseover"; end;
		end; --end; end
	end
	if gtarg=="player" and UnitExists("target") then
		if UnitReaction("target","player")~=nil then
		if UnitReaction("target","player")>=4 then
		--if UnitInRange("target")~=nil then if UnitInRange("target") then	 
		if UnitLevel("target")~=nil 
		and not UnitIsDeadOrGhost("target") 
		and not UnitIsCorpse("target") 
		and UnitIsConnected("target") and UnitIsVisible("target") and not UnitOnTaxi("target" ) then gtarg="target"; end; end; end;--end; end
	end
	if gtarg=="mouseover" and UnitExists("target") then
		--if UnitInRange("target")~=nil then if UnitInRange("target") then
		if not UnitIsDeadOrGhost("target") and not UnitIsCorpse("target") then
		if UnitReaction("target","player")>=4 
		and GetUnitName(gtarg)==GetUnitName("target") then gtarg="target"; end; end; --end; end;
	end
	if gtarg=="target" and not UnitIsDeadOrGhost("target") and not UnitIsCorpse("target") then if UnitName(gtarg)==UnitName("player") then gtarg="player"; end; end
	if gtarg=="player" then nonplayer=false; end
	
  if (gtarg=="player") or not (nonplayer and UnitIsPVP(gtarg)--[[and isHC]]) or gModPressed then -- dont buff pvp flagged in HC --> AllowedToHeal
	if gtarg=="mouseover" then TargetUnit(gtarg); end;
	
	if nonplayer then 	
		if UnitName("target")~=nil then gCurTarget = UnitName("target"); else gCurTarget=""; end
	else gCurTarget=UnitName("player") end
	if gModPressed then 
		if gCurTarget ~= gLastTarget or gForceBuff<1 then gForceBuff=1; end
	else gForceBuff=0; end
	TurtleDismount()
	-- ----------------------
	--local gKirt="gForceBuff="..gForceBuff.."   "; if gCurTarget ~= gLastTarget then gKirt=gKirt.."NEW!="..gCurTarget else gKirt=gKirt.."Last="..gCurTarget; end; if gModPressed then gKirt=gKirt.."   (F)"; end; if gLastForcebuffed then gKirt=gKirt.."   LastForced"; end kiir(gKirt)
	
	if (isMage) then -- AI{1,4,18,32,47}
		if nonplayer then
			if (UnitClass(gtarg)~="Rogue" and UnitClass(gtarg)~="Warrior") or gForceBuff>0 then
				if (GIsAIntellect>0) and (((GUnitHasBuff(gtarg,"Spell_Holy_MagicalSentry")==false) and (GUnitHasBuff(gtarg,"Spell_Holy_MagicalSentry")==false)) or gForceBuff==1) then 
					for i=5,1,-1 do  if (UnitLevel(gtarg)>=AIMin[i]) and GIsSpellRank("Arcane Intellect",i)>0 then gForceBuff=0; CastSpellByName("Arcane Intellect(Rank "..i..")"); break; end; end 
				end
			end
		else
			if (GIsAIntellect>0) and ((not (GPlayerBuffDuration("Spell_Holy_MagicalSentry")>200 or GPlayerBuffDuration("Spell_Holy_MagicalSentry")>200)) or gForceBuff==1) then 
				gForceBuff=2; CastSpellByName("Arcane Intellect",1);
			elseif ((GPlayerHasBuff("Spell_Frost_FrostArmor02")==false) and (GPlayerHasBuff("Spell_MageArmor",1)==false)) or gForceBuff==2 then
				if (GIsSpellLearned("Mage Armor")>0) then gForceBuff=3; CastSpellByName("Mage Armor")
				elseif (GIsSpellLearned("Ice Armor")>0) then gForceBuff=3; CastSpellByName("Ice Armor") 
														else gForceBuff=3; CastSpellByName("Frost Armor"); end
			elseif ((GPlayerHasBuff("Spell_Nature_AbolishMagic")==false) or gForceBuff==3) and (GIsSpellLearned("Dampen Magic")>0) then gForceBuff=4; CastSpellByName("Dampen Magic",1) 
			elseif ((GPlayerHasBuff("Spell_Ice_Lament")==false) or gForceBuff==4) and (GIsSpellLearned("Ice Barrier")>0) then gForceBuff=5; CastSpellByName("Ice Barrier") 
			--elseif (GPlayerHasBuff("Spell_Shadow_DetectLesserInvisibility")==false) and (GIsSpellLearned("Mana Shield")>0) then CastSpellByName("Mana Shield") 
			--elseif (GPlayerHasBuff("Spell_Frost_FrostWard")==false) and (GIsSpellLearned("Frost Ward")>0) then CastSpellByName("Frost Ward") 
			end
		end
		
	elseif (isDruid) then
		-- MOUSEOVER
		--[[if gtarg=="mouseover" and UnitExists("target") and UnitIsFriend("player","target") then		
			TargetUnit("mouseover");
			if GIsShapeshifted() then GCancelForm() end
			if (GIsMarkoftheWild>0) and (((GUnitHasBuff("target","Spell_Nature_Regeneration")==false) and --[[GotW icon??!]](GUnitHasBuff("target","Spell_Nature_Regeneration")==false)) or gForceBuff==1) then 
				for i=7,1,-1 do  if (UnitLevel(gtarg)>=MotwMin[i]) and GIsSpellRank("Mark of the Wild",i)>0 then CastSpellByName("Mark of the Wild(Rank "..i..")"); break; end; end 
			elseif (GIsSpellLearned("Thorns")>0) and (GUnitHasBuff("target","Spell_Nature_Thorns")==false) then 
				for i=6,1,-1 do  if (UnitLevel(gtarg)>=ThornsMin[i]) and GIsSpellRank("Thorns",i)>0 then CastSpellByName("Thorns(Rank "..i..")"); break; end; end 
			end
		-- TARGET
		elseif 
		]]
		if nonplayer then
			if (GIsMarkoftheWild>0) and (GUnitHasBuff("target","Spell_Nature_Regeneration")==false or gForceBuff==1) then 
				for i=7,1,-1 do  if (UnitLevel(gtarg)>=MotwMin[i]) and GIsSpellRank("Mark of the Wild",i)>0 then gForceBuff=2; CastSpellByName("Mark of the Wild(Rank "..i..")"); break; end; end 
			elseif (GIsSpellLearned("Thorns")>0) and (GUnitHasBuff("target","Spell_Nature_Thorns")==false or gForceBuff==2) then 
				for i=6,1,-1 do  if (UnitLevel(gtarg)>=ThornsMin[i]) and GIsSpellRank("Thorns",i)>0 then gForceBuff=3; CastSpellByName("Thorns(Rank "..i..")"); break; end; end 
			end -- Friend Buff
		-- PLAYER (SELF)	
		else --gkiir("HP: "..PlayerHPpercent().." %")
			if gModPressed and gLastForcebuffed==false and gForceBuff>1 then gForceBuff=1 end
			if (GIsMarkoftheWild>0) and ((not GPlayerHasBuff("Spell_Nature_Regeneration") and not GPlayerHasBuff("Mark of the Wild")) or gForceBuff==1) then -- motw
				gForceBuff=2; CastSpellByName("Mark of the Wild")
			elseif (GPlayerHasBuff("Spell_Nature_Thorns")==false or gForceBuff==2) and (GIsSpellLearned("Thorns")>0) then gForceBuff=3; CastSpellByName("Thorns")
			elseif (GIsRegrowth>0) and ((GPlayerHasBuff("Spell_Nature_ResistNature")==false and PlayerHPpercent()<75) or gForceBuff==3) then gForceBuff=4; CastSpellByName("Regrowth",1) 
			elseif (GIsRejuvenation>0) and ((GPlayerHasBuff("Spell_Nature_Rejuvenation")==false and PlayerHPpercent()<85) or gForceBuff==4) then gForceBuff=5; CastSpellByName("Rejuvenation",1) 
			else 
				gForceBuff=1;
				if (GIsRegrowth==0) and (GIsSpellLearned("Regrowth")>0) then GIsRegrowth = GIsSpellLearned("Regrowth") end
				if (GIsRejuvenation==0) and (GIsSpellLearned("Rejuvenation")>0) then GIsRejuvenation = GIsSpellLearned("Rejuvenation") end
			end
--[[			elseif (GPlayerHasBuff("Spell_Nature_ResistNature")==false or gForceBuff==3) and (GIsRegrowth>0) then gForceBuff=4; CastSpellByName("Regrowth",1) 
			elseif (GPlayerHasBuff("Spell_Nature_Rejuvenation")==false or gForceBuff==4) and (GIsRejuvenation>0) then gForceBuff=5; CastSpellByName("Rejuvenation",1) 
			else 
				if (GIsRegrowth==0) and (GIsSpellLearned("Regrowth")>0) then GIsRegrowth = GIsSpellLearned("Regrowth") end
				if (GIsRejuvenation==0) and (GIsSpellLearned("Rejuvenation")>0) then GIsRejuvenation = GIsSpellLearned("Rejuvenation") end ]]
		end
		
	elseif (isPriest) then
		if nonplayer then
			if (GIsPWFortitude>0) and (((GUnitHasBuff(gtarg,"Spell_Holy_WordFortitude")==false) and (GUnitHasBuff(gtarg,"Spell_Holy_PrayerOfFortitude")==false)) or gtarg=="target") then 
				for i=6,1,-1 do  if (UnitLevel(gtarg)>=FortiMin[i]) and GIsSpellRank("Power Word: Fortitude",i)>0 then CastSpellByName("Power Word: Fortitude(Rank "..i..")"); break; end; end 
			end
		else	
			if (GIsPWFortitude>0) and not (GPlayerBuffDuration("Spell_Holy_WordFortitude")>200 or GPlayerBuffDuration("Spell_Holy_PrayerOfFortitude")>200) then
				CastSpellByName("Power Word: Fortitude")
			elseif (GIsSpellLearned("Inner Fire")>0) and (GPlayerBuffDuration("Spell_Holy_InnerFire")<90) then 
				CastSpellByName("Inner Fire") 
			elseif (GIsSpellLearned("Fear Ward")>0) and (GPlayerBuffDuration("Spell_Holy_Excorcism")<60) then 
				CastSpellByName("Fear Ward") 
			elseif (GIsSpellLearned("Shadow Protection")>0) and (GPlayerBuffDuration("Spell_Shadow_AntiShadow")<60) then 
				CastSpellByName("Shadow Protection") 
			elseif (GIsSpellLearned("Power Word: Shield")>0) and (GPlayerHasBuff("Spell_Holy_PowerWordShield")==false) then 
				--CastSpellByName("Power Word: Shield")
			end
		end

	elseif (isPaladin) then
		if nonplayer then 	
			if UnitClass(gtarg)=="Rogue" or UnitClass(gtarg)=="Warrior" then
				if GIsBoM>0 and (GUnitHasBuff(gtarg,"Spell_Holy_FistOfJustice")==false) then
					for i=7,1,-1 do  if (UnitLevel(gtarg)>=BoMMin[i]) and GIsSpellRank("Blessing of Might",i)>0 then CastSpellByName("Blessing of Might(Rank "..i..")"); break; end; end 
				end
			elseif GIsBoW>0 and (GUnitHasBuff(gtarg,"Spell_Holy_SealOfWisdom")==false) then
				for i=6,1,-1 do  if (UnitLevel(gtarg)>=BoMMin[i]) and GIsSpellRank("Blessing of Wisdom",i)>0 then CastSpellByName("Blessing of Wisdom(Rank "..i..")"); break; end; end 
			end
		else -- ToDo: Detect talent spec and use BoW if healer 
			if (GIsSpellLearned("Retribution Aura")>0) and (IsPalaAuraActive()==false) and (GPlayerHasBuff("Spell_Holy_SealOfWisdom")==false) then CastSpellByName("Retribution Aura")
			elseif (GIsSpellLearned("Devotion Aura")>0) and IsPalaAuraActive()==false then CastSpellByName("Devotion Aura")
			elseif GPlayerHasBuff("Spell_Holy_MindSooth") and GIsBoW>0 and GPlayerBuffDuration("Spell_Holy_SealOfWisdom")<90 then CastSpellByName("Blessing of Wisdom")
			elseif GIsBoM>0 and (GPlayerHasBuff("Spell_Holy_FistOfJustice")==false) and (GPlayerHasBuff("Spell_Holy_SealOfWisdom")==false) then CastSpellByName("Blessing of Might")
			elseif GIsBoM>0 and GPlayerHasBuff("Spell_Holy_FistOfJustice") and GPlayerBuffDuration("Spell_Holy_FistOfJustice")<90 then CastSpellByName("Blessing of Might") 
			elseif GIsBoW>0 and GPlayerHasBuff("Spell_Holy_SealOfWisdom") and GPlayerBuffDuration("Spell_Holy_SealOfWisdom")<90 then CastSpellByName("Blessing of Wisdom") 
			end 
		end
		
	elseif (isWarlock) then
		if (GPlayerHasBuff("Spell_Shadow_RagingScream")==false) then
			if (GIsSpellLearned("Demon Armor")>0) then CastSpellByName("Demon Armor") else 
				if (GIsSpellLearned("Demon Skin")>0) then CastSpellByName("Demon Skin") end
			end
		elseif (GPlayerHasBuff("Spell_Shadow_DetectInvisibility")==false) and (GPlayerHasBuff("Spell_Shadow_DetectLesserInvisibility")==false) then
			if (GIsSpellLearned("Detect Greater Invisibility")>0) then CastSpellByName("Detect Greater Invisibility") 
			elseif (GIsSpellLearned("Detect Invisibility")>0) then CastSpellByName("Detect Invisibility") 
			elseif (GIsSpellLearned("Detect Lesser Invisibility")>0) then CastSpellByName("Detect Lesser Invisibility") end
		elseif (GPlayerHasBuff("Spell_Shadow_DemonBreath")==false) and (GIsSpellLearned("Unending Breath")>0) then
			if (GIsSpellLearned("Unending Breath")>0) then CastSpellByName("Unending Breath") end			
		elseif (GPlayerHasBuff("Spell_Shadow_AntiShadow")==false) and (GIsSpellLearned("Shadow Ward")>0) then
			if (GIsSpellLearned("Shadow Ward")>0) then CastSpellByName("Shadow Ward") end			
		end
		
	elseif (isHunter) then
		if (GIsHawk>0) then
			if (GPlayerHasBuff("Spell_Nature_RavenForm")==false) then CastSpellByName("Aspect of the Hawk") end
		elseif (GIsMonkey>0) and (GPlayerHasBuff("Ability_Hunter_AspectOfTheMonkey")==false) then CastSpellByName("Aspect of the Monkey")
		end
		if (GIsSpellLearned("Trueshot Aura")>0) and (GPlayerHasBuff("Ability_TrueShot")==false) then CastSpellByName("Trueshot Aura"); end
	end
	
	-- after mouseover targeting, target last target back...
	if gCurTarget~=nil and gCurTarget~="" then gLastTarget = gCurTarget; else gLastTarget=""; end
	if gtarg=="mouseover" then 
		if haveTarget then gLastTarget=UnitName("target"); TargetLastTarget(); else ClearTarget() end; 
	end
	--kiir(gLastTarget);
	GActivateTracking()
  end --allowedtoheal
	if gModPressed then gLastForcebuffed=true else gLastForcebuffed=false; end
  end--GIisAlive
  UIErrorsFrame:Clear(); UIErrorsFrame:Show();
end


local GFromShift = true -- next time start with regrowth
function GRegrowthRejuForm() -- shift out (if no reju, remember form), Regrowth, Reju, back to last Form, (if reju going) autotarget, autoattack, claw
	if isDruid then
		if GIsShapeshifted() then -- GIsRegrowth	Spell_Nature_ResistNature
			GFromShift = true;
			if GIsRegrowth or GIsRejuvenation then
				if (not GPlayerHasBuff("Spell_Nature_Rejuvenation")) then 
					GCancelForm()  --> glastformnum, glastform
				else -- Reju active
					AutoTarget(); 
					GStartAutoattack()
					GGetCurrentFormName()
					if glastform=="Cat Form" then 
						--if isMangle then CastSpellByName("Mangle") elseif isClaw then CastSpellByName("Claw") end
						CastSpellByName("Claw")
					elseif glastform=="Bear Form" or glastform=="Dire Bear Form" then 
						CastSpellByName("Maul")
					end
				end
			end--and (not GPlayerHasBuff("Spell_Nature_ResistNature"))
		else 
			if GIsRegrowth and (not GPlayerHasBuff("Spell_Nature_Rejuvenation")) and GFromShift then -- no reju, cast regrowth even if its still active
				CastSpellByName("Regrowth",1);  GFromShift = false
			elseif GIsRejuvenation and (not GPlayerHasBuff("Spell_Nature_Rejuvenation")) then
				CastSpellByName("Rejuvenation",1)
			elseif glastformnum>0 then CastSpellByName(glastform,1) 
			elseif GIsCatForm then CastSpellByName("Cat Form",1) 
			elseif GIsBearForm then 
				if GIsSpellLearned("Dire Bear Form") then CastSpellByName("Dire Bear Form",1) else CastSpellByName("Dire Bear Form",1) end
			end
		end
	end
end

function GRake()
	if isDruid then
		if (not GIsShapeshifted()) and GIsCatForm then CastSpellByName("Cat Form",1)		
		elseif GGetCurrentFormName()=="Cat Form" and GIsRake then
			AutoTarget(); 
			if GIsRake and UnitMana("player")>=35 and not GTargetHasDebuff("Ability_Druid_Disembowel") and (UnitCreatureType("target")~="Elemental") then --GListDebuffs("target")				
				CastSpellByName("Rake")
			elseif UnitMana("player")>=40 then CastSpellByName("Claw") end
			GStartAutoattack()
		end
	end
end

function GRipPounce()
	if isDruid then
		if (not GIsShapeshifted()) and GIsCatForm then CastSpellByName("Cat Form",1)		
		elseif GGetCurrentFormName()=="Cat Form" then
			AutoTarget()
			if GIsProwl() and GIsPounce and UnitMana("player")>=50 and (not PlayerFrame.inCombat) and (not UnitAffectingCombat("player")) then 
				CastSpellByName("Pounce") 
			elseif GIsRip and UnitMana("player")>=30 and GGetCombo()>0 and (UnitCreatureType("target")~="Elemental") then CastSpellByName("Rip")
			elseif UnitMana("player")>=40 then CastSpellByName("Claw"); 
			else GStartAutoattack() end	
		end
	end
end

--GIsFeroBite GIsProwl() GIsRavage GIsRip GIsPounce
function GFerobiteRavage()
	if isDruid then
		if (not GIsShapeshifted()) and GIsCatForm then CastSpellByName("Cat Form",1)		
		elseif GGetCurrentFormName()=="Cat Form" then
			AutoTarget()
			if GIsProwl() and GIsRavage and UnitMana("player")>=60 and (not PlayerFrame.inCombat) and (not UnitAffectingCombat("player")) then CastSpellByName("Ravage")
			elseif GIsFeroBite and UnitMana("player")>=35 and GGetCombo()>0 then CastSpellByName("Ferocious Bite") 
			elseif UnitMana("player")>=40 then CastSpellByName("Claw"); 
			else GStartAutoattack() end
		end
	end
end


function GFFaerieFire() -- Feral
	if isDruid then
		if (not GIsShapeshifted()) and GIsCatForm then CastSpellByName("Cat Form",1)		
		elseif GGetCurrentFormName()=="Cat Form" then
			AutoTarget()
			GStartAutoattack()
			if GIsSpellLearned("Faerie Fire (Feral)") and (not GTargetHasDebuff("Spell_Nature_FaerieFire")) then --GListDebuffs("target")				
				CastSpellByName("Faerie Fire (Feral)()")
			elseif GIsSpellLearned("Tiger's Fury") and UnitMana("player")>=60 and (not GTargetHasDebuff("Ability_Mount_JungleTiger")) then
				CastSpellByName("Tiger's Fury")
			elseif UnitMana("player")>=40 then CastSpellByName("Claw") end
		end
	end
end

function GFormRejuMoon() -- shift out, reju, moonfire outofcombat + got target, shift back
	local canshift = 0;	
	--if GAttackSlot>0 then kiir("slot: "..GAttackSlot.." = "..GetActionText(GAttackSlot)) else kiir("noattakslot"); GAttackSlot=GSearchAttackSlot() end
	-- CANCEL FORM
	--kiir("Rage:"..UnitMana("player").."     HP:"..(UnitHealth("player")*100/UnitHealthMax("player")))
  if isDruid then
	if (GIsShapeshifted() and GIsRejuvenation>0) and (((GGetForm()==1) and (UnitMana("player")<20)) or (GGetForm()==CatFormNum) or (UnitAffectingCombat("player"))) then
		if UnitExists("target") then
			if (UnitReaction("target","player")<5) then -- enemy
				if (GTargetHasDebuff("Spell_Nature_StarFall")==false) and (not UnitAffectingCombat("player")) then canshift=1; 
				elseif GPlayerHasBuff("Spell_Nature_Rejuvenation")==false then canshift=1; end
			elseif GPlayerHasBuff("Spell_Nature_Rejuvenation")==false then canshift=1; end
		elseif GPlayerHasBuff("Spell_Nature_Rejuvenation")==false then canshift=1; end
		if canshift==1 then GCancelForm() end --> glastform
	end
	-- REGROWTH
	if (canshift==0) and (GIsRegrowth>0) and GIsShapeshifted()==false then
		if GPlayerHasBuff("Spell_Nature_ResistNature")==false then canshift=1; CastSpellByName("Regrowth",1) end		
	end
	-- REJUVENATION
	if (canshift==0) and (GIsRejuvenation>0) and GIsShapeshifted()==false then
		if GPlayerHasBuff("Spell_Nature_Rejuvenation")==false then canshift=1; CastSpellByName("Rejuvenation",1) end		
	end
	-- MOONFIRE addition
	if (canshift==0) and UnitExists("target") and (GIsMoonfire>0) and (not UnitAffectingCombat("player")) and GIsShapeshifted()==false then
		if (UnitReaction("target","player")<5) and (GTargetHasDebuff("Spell_Nature_StarFall")==false) then canshift=1; CastSpellByName("Moonfire") end
	end
	-- SHIFT BACK
	if (canshift==0) and (GIsShapeshifted()==false) then
		if (glastform~="") then
			CastSpellByName(glastform,1);
		else
			if (GIsCatForm>0) then CastSpellByName("Cat Form",1)
			elseif (GIsBearForm>0) then CastSpellByName("Bear Form",1)
			end
		end
	else 
		GStartAutoattack() -- if got "Attack" action dragged to any actionbar slot
		if GGetForm()==1 then CastSpellByName("Maul")
		elseif GGetForm()==CatFormNum then 
			if isMangle then CastSpellByName("Mangle")
			elseif isClaw then CastSpellByName("Claw") 
			end
		end

	end
  end
end



-- Its from Sea, explodes (splits) text by separator
function darabol ( text, separator, t, noPurge, inclusive ) 
		local value;
	   	local mstart, mend = 1;
		local oldn, numMatches = 0, 0;
		local regexKey;
		if (inclusive) then
			regexKey = "([^"..separator.."]*)";
		else
			regexKey = "([^"..separator.."]+)";
		end
		local sfind = strfind;	-- string.find if not in WoW (n calls)		
		if ( not t ) then
			t = {};
		else
			oldn = t;
		end		
		-- Using string.find instead of string.gfind to avoid garbage generation
		mstart, mend, value = sfind(text, regexKey, mstart);
	   	while (value) do
			numMatches = numMatches + 1;
			t[numMatches] = value
			mstart = mend + 1;
			mstart, mend, value = sfind(text, regexKey, mstart);
	   	end		
		if ( not noPurge ) then
			for i = numMatches+1, oldn do
				t[i] = nil;
			end
		end		
		return t;
	end
	
-- ---------------------------------------------------------------------------------------------------------------------------------------------
function Gepy_ButtonClick()	DEFAULT_CHAT_FRAME:AddMessage(Gepy_EditBox:GetText()); Gepy_EditBox:SetText(""); end
function Gepy_Close() GepyFrame:Hide(); end
-- ---------------------------------------------------------------------------------------------------------------------------------------------

function kiir(kirtxt) if kirtxt then DEFAULT_CHAT_FRAME:AddMessage(CSTART..CMYCOLOR..kirtxt..CHAT_END); end end

function kiirszin(kirtxt,szin) if kirtxt and szin then
	local szinkod = CMYCOLOR;
	if (szin=="white") then szinkod = CWHITE; end;
	if (szin=="yellow") then szinkod = CYELLOW; end;
	if (szin=="red") then szinkod = CRED; end;
	if (szin=="blue") then szinkod = CBLUE; end;
	if (szin=="green") then szinkod = CGREEN; end;
	if (szin=="gray") then szinkod = CGRAY; end;
	if (szin=="orange") then szinkod = CORANGE; end;
	if (szin=="brown") then szinkod = CBROWN; end;
	if (szin=="purple") then szinkod = CPURPLE; end;
	if (szin=="pink") then szinkod = CPINK; end;
	if (szin=="lred") then szinkod = CLRED; end;
	if (szin=="lgreen") then szinkod = CLGREEN; end;
	if (szin=="lgray") then szinkod = CLGRAY; end;
	if (szin=="lblue") then szinkod = CLBLUE; end;
	DEFAULT_CHAT_FRAME:AddMessage(szinkod..kirtxt..CHAT_END);
end end

kiirszin("GepyMod v"..gepyver.." loaded.","yellow");

function errkiir(kirtxt) DEFAULT_CHAT_FRAME:AddMessage(CLRED.."--- "..CRED..kirtxt..CHAT_END); end

function RestedPercent()
	if GetXPExhaustion() then
		p="player";
		x=UnitXP(p);
		m=UnitXPMax(p);
		r=GetXPExhaustion();
		if -1==(r or -1) then t="No rest."
		else t="Rest: "..(math.floor(20*r/m+0.5)).." bubbles ("if r+x<m then t=t..r else t=t.."level +"..(r+x-m)end t=t.."XP)"end;
		DEFAULT_CHAT_FRAME:AddMessage(t)	
		kiir(t)
	end
end


function elsonagybetu(genb) -- first character capitalizer
   if (genb~=nil) then return string.upper(strsub(genb,1,1))..strsub(genb,2) else return "" end
end

function GGetTalent(gtab,gtalent)	
	local nameTalent, icon, tier, column, currRank, maxRank = GetTalentInfo(gtab,gtalent);
	return currank
end

function GGetFerocity() -- Ferocity 2nd tab, 1st talent (left to right, top to bottom #)
	if isDruid then 
		local nameTalent, icon, tier, column, currRank, maxRank = GetTalentInfo(2,1); -- tab,num
		return currRank
	else return 0; end
end

function GUnitHasBuff(GUUnit, GUBuff)	-- "target","Spell_Holy_MagicalSentry"
	local GUB=0
	for i=1,40 do 
		if (string.find(tostring(UnitBuff(GUUnit,i)), GUBuff)) then GUB=i end
	end
	if GUB>0 then return true else return false end
end

function GUnitHasDebuff(GUUnit, GUDebuff)
	local GUD=0
	for i=1,40 do 
		if (string.find(tostring(UnitDebuff(GUUnit,i)), GUDebuff)) then GUD=i end
	end
	if GUD>0 then return true else return false end
end

function GTargetHasDebuff(GUDebuff)
	local GUD=0
	for i=1,40 do 
		if (string.find(tostring(UnitDebuff("target",i)), GUDebuff)) then GUD=i end
	end
	if GUD>0 then return true else return false end
end

function GPlayerHasBuff(GPBuff) -- bufftexturename
	local GPBdb=0
	local GPHB=-1
	while not (GetPlayerBuff(GPBdb,"HELPFUL")==-1) do
		if (string.find(GetPlayerBuffTexture(GetPlayerBuff(GPBdb,"HELPFUL")),GPBuff)) then GPHB=GPBdb; end
		GPBdb = GPBdb+1;
	end
	if GPHB==-1 then return false else return true end
end

function GPlayerHasBuffName(GPBuff) -- "Prowl" ...
  GIsBuffActiveTooltip:SetOwner(UIParent, "ANCHOR_NONE")
  local i = 1
  while UnitBuff("player", i) do
	GIsBuffActiveTooltip:ClearLines(); GIsBuffActiveTooltip:SetUnitBuff("player",i)
    if string.find(GIsBuffActiveTooltipTextLeft1:GetText() or "", GPBuff) then return i; end; 
	i = i + 1
  end
  return false
end

function GFeignDeath()
	UIErrorsFrame:Hide();
	--if not GPlayerHasBuffName("Feign Death") and UnitAffectingCombat("player") then CastSpellByName("Feign Death") end
	if not GPlayerHasBuffName("Feign Death") then CastSpellByName("Feign Death") end
	UIErrorsFrame:Clear(); UIErrorsFrame:Show();
end

function GPlayerBuffDuration(GPBuff) -- bufftexturename
	local GPBdb=0
	local GPHB=-1
	while not (GetPlayerBuff(GPBdb)==-1) do
		if (strfind(GetPlayerBuffTexture(GetPlayerBuff(GPBdb)),GPBuff)) then GPHB=GPBdb; end
		GPBdb = GPBdb+1;
	end
	if GPHB>-1 then return GetPlayerBuffTimeLeft(GPHB) else return 0; end
end

local gtooltip = CreateFrame("GameTooltip", "GIsBuffActiveTooltip", UIParent, "GameTooltipTemplate")
gtooltip:Hide()

function GPlayerHasBuffNameNum(GPBuff) -- "Prowl" ...
  GIsBuffActiveTooltip:SetOwner(UIParent, "ANCHOR_NONE")
  local i = 1
  while UnitBuff("player", i) do
		GIsBuffActiveTooltip:ClearLines()
		GIsBuffActiveTooltip:SetUnitBuff("player",i)		
    if string.find(GIsBuffActiveTooltipTextLeft1:GetText() or "", GPBuff) then return i; end
    i = i + 1
  end
  return 0
end


function GPlayerHasDebuffName(GPBuff) -- "Prowl" ...
  GIsBuffActiveTooltip:SetOwner(UIParent, "ANCHOR_NONE")
  local i = 1
  while UnitDebuff("player", i) do
		GIsBuffActiveTooltip:ClearLines()
		GIsBuffActiveTooltip:SetUnitDebuff("player",i)		
    if string.find(GIsBuffActiveTooltipTextLeft1:GetText() or "", GPBuff) then return true end
    i = i + 1
  end
  return false
end

function GPlayerHasDebuff(GPDebuff) -- bufftexturename
	local GPBdb=0
	local GPHB=0
	while not (GetPlayerBuff(GPBdb)==-1) do
		if (strfind(GetPlayerDebuffTexture(GetPlayerBuff(GPBdb)),GPBuff)) then GPHB=1; end
		GPBdb = GPBdb+1;
	end
	if GPHB==0 then return false else return true end
end

function GListPlayerBuffs()
	kiir(CWHITE..playernev..CLGREEN.." Buffs"..CGRAY..":");
	local gbdb=0;
	while not (GetPlayerBuff(gbdb)==-1) do
		local gpbname = GetPlayerBuff(gbdb)
		local gpbtexture = GetPlayerBuffTexture(gpbname)
		kiir(CGREEN.."   "..gbdb..CGRAY.." = "..CLGRAY..gpbname..CGRAY.." / "..CWHITE..gpbtexture ); 
		gbdb=gbdb+1;
	end
	if gbdb>0 then kiir(CGREEN.."   BUFFS:  "..CYELLOW..gbdb); end
end

function GListBuffs(unit)
	if UnitExists(unit) then
		kiir(CWHITE..UnitName(unit).." ("..CYELLOW..unit..")"..CLGREEN.." Buffs"..CGRAY..":");
		local gbdb=0;
		for i=1,40 do
			local a,b,c,d = UnitBuff(unit, i)
			if c==nil then c="nil"; end
			if d==nil then d="nil"; end
			if e==nil then e="nil"; end
			if a then kiir(CGREEN.."   "..i..CGRAY.." = "..CLGRAY..a.."  "..CGRAY..b.."  "..CWHITE..c.."  "..CLGRAY..d.."  "..CGRAY..e); gbdb=gbdb+1; end
		end
		if gbdb>0 then kiir(CGREEN.."   BUFFS:  "..CYELLOW..gbdb); end
	end
end

function GListDebuffs(unit) -- name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId
	kiir(CWHITE..unit..CLRED.." Debuffs"..CGRAY..":");
	local gbdb=0;
	for i=0, 40 do
		local a,b,c = UnitDebuff(unit, i) 
		if c then kiir(CRED.."   "..i..CGRAY.." = "..CLGRAY..a..CGRAY.."  "..b.."  "..CWHITE..c ); gbdb=gbdb+1; 
		elseif a then kiir(CRED.."   "..i..CGRAY.." = "..CLGRAY..a ); gbdb=gbdb+1; 
		end
	end
	if gbdb>0 then kiir(CGREEN.."   DEBUFFS:  "..CYELLOW..gbdb); end
end


function GGetContainerItemByName(item) -- true/false    + gitemBagNum,gitemSlotNum
	gitemBagNum=-1; gitemSlotNum=0;
	for i=0,4 do
		for c=1,GetContainerNumSlots(i) do
			y=GetContainerItemLink(i,c)            
			if (y~=nil) then
                if string.find(y,item) then
				gitemBagNum=i; gitemSlotNum=c;
				return true;
                end
			end
		end
	end
	return false;
end

function GFeedPet()
	if UnitExists("Pet") and (not PlayerFrame.inCombat) and (not UnitAffectingCombat("player")) then 
		local GHunterFoodSlotRl = GHunterFoodSlot; if GHunterFoodSlot>GetContainerNumSlots(GHunterFoodBag) then GHunterFoodSlotRl=GetContainerNumSlots(GHunterFoodBag) end
		local GFlink = GetContainerItemLink(GHunterFoodBag,GHunterFoodSlotRl)
		if GFlink~=nil then
			local texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(GHunterFoodBag,GHunterFoodSlotRl);
			if itemCount>0 then
				CastSpellByName("Feed Pet"); 
				TargetUnit("Pet"); 
				PickupContainerItem(GHunterFoodBag, GHunterFoodSlotRl);
				if itemCount==1 then kiir("This was your last FOOD!") end
			end			
		else 
			if GHunterFoodSlot>GetContainerNumSlots(GHunterFoodBag) then GHunterFoodSlotRl="last "..CLGRAY.."("..GHunterFoodSlotRl..")" else GHunterFoodSlotRl=GHunterFoodSlotRl.."." end
			kiir("No item in bag "..CWHITE..(5-GHunterFoodBag)..CMYCOLOR.." at "..CWHITE..GHunterFoodSlotRl..CMYCOLOR.." slot!")
		end
	end
	GUpdateFeedMacro(-1)
end

function GetIconIndex(GII) -- 0: not found     1...GetNumMacroIcons()
	local numIcons = GetNumMacroIcons();
	local gindex = 0
	for j=1,numIcons do
		if string.find(GetMacroIconInfo(j), GII) then gindex = j; break end
	end
	return gindex
end

function GFindMacroByName(GFMBN) -- subtext search, 0: -
	local GPerFind = 0
	for gi=19,36 do 
		local name, iconTexture = GetMacroInfo(gi); 
		if name~=nil then 
			if string.find(name,GFMBN) then GPerFind=gi end 
		end
	end
	return GPerFind
end

function GUpdateFeedMacro(diff)
	if diff==nil then diff=0; end
	if not PlayerFrame.inCombat then
		local GMFind = GFindMacroByName("Fed:")				
		if (GMFind>0) then -- GHunterFoodBag,GHunterFoodSlot
			local GHunterFoodSlotReal = GHunterFoodSlot; if GHunterFoodSlot>GetContainerNumSlots(GHunterFoodBag) then GHunterFoodSlotReal=GetContainerNumSlots(GHunterFoodBag) end
			local GMLink = GetContainerItemLink(GHunterFoodBag,GHunterFoodSlotReal)
			local GICount = 0
			local GOldName, GiconTexture, Gbody, GisLocal = GetMacroInfo(GMFind);
			if GMLink~=nil then
				local Gname, GitemCount = GetContainerItemInfo(GHunterFoodBag,GHunterFoodSlotReal);
				GICount = GitemCount
			end			
			EditMacro(GMFind, "Fed:"..(GICount+diff), GetIconIndex(GiconTexture), Gbody, nil, 1)
		end
	end
end

function GAutoCreateMacros()
	-- EditMacro(index or macroName, name, icon, body, local, perCharacter)
	-- macroId = EditMacro(1, "MyMacro", 12, "/script CastSpellById(1);", 1, 1);
	-- name, iconTexture, body, isLocal = GetMacroInfo("name" or macroSlot);
	-- macroSlot = 1..18, 19..36
	local numAccountMacros, numCharacterMacros = GetNumMacros()
	if (GetMacroIndexByName("Attak")<1) and (numAccountMacros<18) then kiir("Creating 'Attak' global macro...");
		CreateMacro("Attak", GetIconIndex("Interface\Icons\Spell_ChargeNegative"), "/gepy attack", nil, nil); 
	--else kiir("'Attak' macro already exists."); 
	end
	numAccountMacros, numCharacterMacros = GetNumMacros()
	if (GetMacroIndexByName("BUFFS")<1) and (numAccountMacros<18) then kiir("Creating 'BUFFS' global macro...");
		CreateMacro("BUFFS", GetIconIndex("Interface\Icons\Spell_ChargePositive"), "/gepy buffs", nil, nil); 
	--else kiir("'BUFFS' macro already exists."); 
	end
	if isHunter then
		--for i=1,36 do local name, iconTexture = GetMacroInfo(i); if name~=nil then kiir(i..": "..name.." = "..iconTexture) end end
		numAccountMacros, numCharacterMacros = GetNumMacros()
		local GFind = GFindMacroByName("Fed:")
		if GFind==0 then CreateMacro("Fed:", GetIconIndex("Ability_BullRush"), "/run GFeedPet()", nil, 1); kiir("Creating 'Fed:' character-macro..."); end		
		GUpdateFeedMacro()
	end
end

function GIsDead()
	if GPlayerHasDebuffName("Ghost") then return true else return false end -- "Ability_Vanish"
	--[[local GPD = "Ability_Vanish"
	local GPBdb=0
	local GPHB=0
	while not (GetPlayerBuff(GPBdb,"HARMFUL")==-1) do
		if (strfind(GetPlayerBuffTexture(GetPlayerBuff(GPBdb,"HARMFUL")),GPD)) then GPHB=1; end
		GPBdb = GPBdb+1;
	end
	if GPHB==0 then return false else return true end ]]
end

function GIsNotDead()
	if GPlayerHasDebuffName("Ghost") then return false else return true end -- "Ability_Vanish"
	--[[local GPD = "Ability_Vanish"
	local GPBdb=0
	local GPHB=0
	while not (GetPlayerBuff(GPBdb,"HARMFUL")==-1) do
		--kiir(GPBdb.."  "..GetPlayerBuff(GPBdb,"HARMFUL").." / "..GetPlayerBuffTexture(GetPlayerBuff(GPBdb,"HARMFUL"))); -- Player Debuffs
		if (strfind(GetPlayerBuffTexture(GetPlayerBuff(GPBdb,"HARMFUL")),GPD)) then GPHB=1; end
		GPBdb = GPBdb+1;
	end
	if GPHB==0 then return true else return false end  ]]
end

function GIsAlive()
	if GPlayerHasDebuffName("Ghost") then return false else return true end -- "Ability_Vanish"
end

function GIsProwl()
	if GPlayerHasBuffName("Prowl") then return true else return false end -- "Ability_Ambush"
end

function GUseHealthStone() --> gitemBagNum,gitemSlotNum
	if UnitHealth("player") < UnitHealthMax("player") then
			if GGetContainerItemByName("Major Healthstone") then UseContainerItem(gitemBagNum,gitemSlotNum)
		elseif GGetContainerItemByName("Greater Healthstone") then UseContainerItem(gitemBagNum,gitemSlotNum)
		elseif GGetContainerItemByName("Healthstone") then UseContainerItem(gitemBagNum,gitemSlotNum)
		elseif GGetContainerItemByName("Lesser Healthstone") then UseContainerItem(gitemBagNum,gitemSlotNum)
		elseif GGetContainerItemByName("Minor Healthstone") then UseContainerItem(gitemBagNum,gitemSlotNum)
		end
	end
end

function GUseSpellstone() --> gitemBagNum,gitemSlotNum
	local GOffhandLink = GetInventoryItemLink("player",17)
	if (GOffhandLink~=nil) then
		if strfind(GetInventoryItemLink("player",17),"Spellstone") or strfind(GetInventoryItemLink("player",17),"Orb of Dar") then
			if GetInventoryItemCooldown("player",17)==0 then UseInventoryItem(17) end -- 17 offhand, 13 trinket1, 14 trinket2
		end
	else -- no offhand equipped
		if GGetContainerItemByName("Spellstone") then UseContainerItem(gitemBagNum,gitemSlotNum) end
	end
end

function GUseWarlockOffhand() --> gitemBagNum,gitemSlotNum
	local GOffhandLink = GetInventoryItemLink("player",17)
	if (GOffhandLink~=nil) then
		if strfind(GetInventoryItemLink("player",17),"Orahil") or strfind(GetInventoryItemLink("player",17),"Orb of Dar") then
			if GetInventoryItemCooldown("player",17)==0 then UseInventoryItem(17) end -- 17 offhand, 13 trinket1, 14 trinket2
		end
	else -- no offhand equipped
		if GGetContainerItemByName("Spellstone") then UseContainerItem(gitemBagNum,gitemSlotNum) end
	end
end

function GVoidSacrifice() -- Sacrifice + use healthstone
	if UnitAffectingCombat("player") then
		local a = UnitCreatureFamily("pet"); 
		if a=="Voidwalker" then CastSpellByName("Sacrifice")
		--elseif (a~="Voidwalker") and (UnitExists("pet")==false) then CastSpellByName("Summon Voidwalker") 
		end
		GUseHealthStone() -- if not at max health
		GUseSpellstone() -- if equiped, or Warlock Orb of Dar'Orahil
		-- Mark of Resolution absorb
		if GetInventoryItemLink("player",13) then 
			if strfind(GetInventoryItemLink("player",13),"of Resolution") then
				if GetInventoryItemCooldown("player",13)==0 then UseInventoryItem(13) end
			end
		end
		if GetInventoryItemLink("player",14) then 
			if strfind(GetInventoryItemLink("player",14),"of Resolution") then
				if GetInventoryItemCooldown("player",14)==0 then UseInventoryItem(13) end
			end
		end
	end
end

function GDestroyLastSoulshard(endbag) --finds a shard and destroys it, from bottom to top (4,3,2,1,0)
	local gshardbag = -1;
    local gshardslot= 0;
	if endbag==nil then endbag=0 end
    for bag=0,endbag do
        if (GetBagName(bag)~=nil) and (gshardbag==-1) then
            for slot=GetContainerNumSlots(bag),1,-1 do
				if (GetContainerItemLink(bag,slot)) then
			        if (string.find(GetContainerItemLink(bag,slot), "Soul Shard")) then	gshardslot = slot; end
			    end				
            end
        end
		if (gshardslot>0) and (gshardbag<0) then 
			gshardbag = bag;
			--kiir("Shard KILL =     Bag: "..gshardbag.."    Slot: "..gshardslot);
			PickupContainerItem(gshardbag,gshardslot); DeleteCursorItem()												 -- ===============
		end
    end
	--if (gshardslot==0) then kiir("No SHARD found to KILL!  ("..endbag.."..0)"); end
end

function GDeleteLastShard() -- last shard in bag
	--/cast Drain Soul(Rank 1)	
	local a=GetBagName(4); 
	if a=="Core Felcloth Bag" or a=="Felcloth Bag" or a=="Soul Pouch" or a=="Box of Souls" or a=="Small Soul Pouch" then 
		PickupContainerItem(4,GetContainerNumSlots(4)); DeleteCursorItem()
	else
		--kiir("No shardbag!")
		GDestroyLastSoulshard(0); -- 0 = from main bag only, 1 = main + next
	end
end

function GBagIsEmpty(gbag) -- bag is empty?
	if GetBagName(gbag)~=nil then
		local gbfree = 1
		for gi = 1,GetContainerNumSlots(gbag) do
			if (GetContainerItemLink(gbag,gi)~=nil) then gbfree = 0; end
		end
		if gbfree==1 then return true else return false end
	else return false end
end

function GMoveBags (gfrom,gto,gharom) -- 1,2,3,4, 5
	local gfromname = nil
	local gtoname = nil
	local gfrom2 = gfrom -- remember original parameters
	local gto2 = gto
	kiir(CBLUE.."----------------------------------------------------------------------------")
	if gharom~=nil then gfrom=nil; gto=nil; kiir("Too many parameters!") end
	-- change bag-order to real wow order
	if gfrom~=nil then gfrom=5-gfrom; if (gfrom<1) or (gfrom>5) then gfrom=nil end end
	if gto~=nil then gto=5-gto; if (gto<1) or (gto>5) then gto=nil end end
	-- only 1 parameter! = SMARTMODE!
	if (gfrom~=nil) and (gto==nil) then
		if (GetBagName(gfrom)~=nil) then
			if GBagIsEmpty(gfrom) then gto=gfrom; gfrom=0; gto2=gfrom2; gfrom2=5;
			elseif GBagIsEmpty(0) then gto=0; gto2=5; end
		end
	end
	
	if gto==nil then gto=0; gto2=5; end -- 1 paraméter: 2. MAIN bag
	if (gfrom~=nil) and (gto~=nil) then 
		gfromname = GetBagName(gfrom)
		gtoname   = GetBagName(gto)
	else
		kiir(CLGREEN.."MOVE"..CGREEN.." contents of a bag to an "..CLRED.."EMPTY"..CGREEN.." bag:"..CLGRAY.."    /run "..CWHITE.."BAG(from,to)"); 
		kiir(CGREEN.."Parameters:   "..CYELLOW.."1 2 3 4 "..CWHITE.."5               "..CGRAY.."("..CLGRAY.."5"..CGRAY.." = MAIN original 16 slot bag)");
		kiir(CGREEN.."SMART-MODE:    "..CLGRAY.."/run "..CWHITE.."BAG(bag)"); 
		kiir(CGRAY.."    If "..CLGRAY.."bag"..CGRAY.." has items and MAIN bag is empty:   "..CLGRAY.."bag"..CGRAY.." --> MAIN"); 
		kiir(CGRAY.."    If "..CLGRAY.."bag"..CGRAY.." is empty and MAIN bag has items:   bag"..CGRAY.." <-- "..CLGRAY.."MAIN"); 
	end
	local gfrompic = ""
	local gtopic = ""
	local gcol = ""
	local grnum = 0;  -- "translated" parametered bagnumber
	-- generate graphical representation of the bags: 1 2 3 4 5
	for ii = 4,0,-1 do gcol=CDGREEN;
		grnum = 5-ii
		if GetBagName(ii)==nil then gcol=CRED; end
		if gfrom==ii then gfrompic = gfrompic..CGRAY.."["..CWHITE..grnum..CGRAY.."] " else gfrompic = gfrompic..gcol..grnum.." " end
	end
	for ii = 4,0,-1 do gcol=CDGREEN;
		grnum = 5-ii
		if GetBagName(ii)==nil then gcol=CRED; end
		if gto==ii then gtopic = gtopic..CGRAY.."["..CWHITE..grnum..CGRAY.."] " else gtopic = gtopic..gcol..grnum.." " end
	end
		
	if (gfrom~=nil) and (gto~=nil) then -- there are parameters
	  if (gfromname~=nil) and (gtoname~=nil) then
		if gfrom~=gto then
			local gfromnum = GetContainerNumSlots(gfrom)
			local gtonum = GetContainerNumSlots(gto)		
			-- count bag items
			local gfromdb = 0
			for ii = 1,gfromnum do if (GetContainerItemLink(gfrom,ii)~=nil) then gfromdb = gfromdb+1; end end
			
			if (gfromdb <= gtonum) and (GBagIsEmpty(gto)) then
				kiir(CDGREEN.."MOVING "..CWHITE..gfromdb..CDGREEN.." item(s)...       "..gfrompic..CGRAY.."---> "..gtopic);
				-- MOVEEEE!
				local gnext = 1
				for ii = 1,gfromnum do
					if (GetContainerItemLink(gfrom,ii)~=nil) then
						PickupContainerItem(gfrom,ii);  
						if CursorHasItem() then PickupContainerItem(gto,gnext) end
						gnext = gnext+1;
					end				
				end
				kiir(CGREEN.."Done"..CDGREEN..".");
				
			else kiir("Target doesn't have enough slot or not empty: "..CYELLOW..gfromdb..CGRAY.." slot       "..gfrompic..CGRAY.."---> "..gtopic); end
		else
			kiir(CWHITE.."Source"..CMYCOLOR.." and "..CWHITE.."Target"..CMYCOLOR.." are the "..CLGREEN.."SAME"..CMYCOLOR.." bags!:  "..gfrompic)
		end
	  else 
		if gfromname==nil then kiir(CWHITE.."Source"..CMYCOLOR.." bag does not exist!:  "..gfrompic); end
		if gtoname  ==nil then kiir(CWHITE.."Target"..CMYCOLOR.." bag does not exist!:  "..gtopic); end
	  end
	end
end

function BAG(b1,b2,b3) -- bag alias for /run BAG(..)
	GMoveBags (b1,b2,b3)
end


function GSearchSpellIDbyName(gsname)
	-- search AC ID
	local numTabs = GetNumSpellTabs()
	local GISLfound = 0
	for ii=1,numTabs do
		local tabName, _, tabOffset, numEntries = GetSpellTabInfo(ii)
		for jj = tabOffset + 1, tabOffset + numEntries do
			local spellName, spellSubName = GetSpellName(jj, BOOKTYPE_SPELL)
			if (spellName==gsname) then GISLfound = jj; end -- 1.. spellbook index
			--kiir(CWHITE..spellName .. CLGRAY.."(" .. spellSubName .. ")  "..CLGREEN..jj..CLBLUE.."  "..tabName)
		end
	end
	return GISLfound
end

function GCOEX()
	if GIsSpellLearned("Curse of Exhaustion")>0 then
		if (GIsSpellLearned("Amplify Curse")>0) then 
			-- search AC ID
			local GCoexID = GSearchSpellIDbyName("Amplify Curse") 
			if GCoexID~=0 then
				--kiir(GISLfound.." = "..GetSpellName(GISLfound, BOOKTYPE_SPELL))
				local start, duration, enable = GetSpellCooldown(GCoexID,BOOKTYPE_SPELL)
				if duration<1.51 then CastSpellByName("Amplify Curse"); end
				--CastSpellByName("Amplify Curse");
			end
		end
		CastSpellByName("Curse of Exhaustion")
	end
end

function Gagony()
	if GIsSpellLearned("Curse of Agony")>0 then
		if (GIsSpellLearned("Amplify Curse")>0) then 
			-- search AC ID
			local GCoexID = GSearchSpellIDbyName("Amplify Curse") 
			if GCoexID~=0 then
				--kiir(GISLfound.." = "..GetSpellName(GISLfound, BOOKTYPE_SPELL))
				local start, duration, enable = GetSpellCooldown(GCoexID,BOOKTYPE_SPELL)
				if duration<1.51 then CastSpellByName("Amplify Curse"); end
				--CastSpellByName("Amplify Curse");
			end
		end
		CastSpellByName("Curse of Agony")
	end
end

function GActivateTracking()
	if GetTrackingTexture()==nil then
		if GIsSpellLearned("Find Herbs")>0 then CastSpellByName("Find Herbs") 
		elseif GIsSpellLearned("Find Minerals")>0 then CastSpellByName("Find Minerals") -- GetTrackingTexture()=="InterfaceIconsSpell_Nature_Earthquake"
		elseif GIsSpellLearned("Find Treasure")>0 then CastSpellByName("Find Treasure") 
		end
	end
end

function GGetForm()	-- 0,1,2,3,4,5 		-->	 gcurform = formname
   a,b,c,d = GetShapeshiftFormInfo(1); 
	   if (c) then gcurform=b; return 1;     -- bear 1
   elseif (d) then gcurform="";return 0; end -- caster 0
   a,b,c = GetShapeshiftFormInfo(3);
   if (c) then gcurform=b; return 3; end	 -- cat 3		(this is probably Aquatic form)
   a,b,c = GetShapeshiftFormInfo(4); 
   if (c) then gcurform=b; return 4; end	 -- travel 4
   a,b,c = GetShapeshiftFormInfo(2); 
   if (c) then gcurform=b; return 2; end	 -- aquatic 2 	(if no aquatic yet then cat)
   gcurform=""
   return 0;
end

function GGetCurrentFormInfo() --> FormNum, FormName		glastformnum (if in Form)
	for i=1,GetNumShapeshiftForms() do
		local _, name, active = GetShapeshiftFormInfo(i) -- icon, name, active, castable
		if active then glastformnum=i; glastform=name; return i, name; end
	end
	return 0, "noform";
end

function GGetCurrentFormName() -- (Dire) Bear Form, Aquatic Form, Cat Form, Travel Form, Moonkin Form, Tree of Life Form
	for i=1,GetNumShapeshiftForms() do
		local _, name, active = GetShapeshiftFormInfo(i) -- icon, name, active, castable
		if active then 
			--if name=="Dire Bear Form" then name="Bear Form" end
			glastform=name; 
			return name; 
		end
	end
	return "noform";
end


-- CastShapeshiftForm(index)    1 = Bear/Dire Bear Form    2 = Aquatic Form    3 = Cat Form    4 = Travel Form    5 = Moonkin Form 
-- NS+HT			local s,d,e=GetSpellCooldown(122,"spell") if(d==0) then cast("Nature's Swiftness"); else cast("Healing Touch"); end;
-- Reju+Swiftmend	a=GetSpellCooldown; s,d,e=a(146,"spell"); if(d==0) then if(not buffed('Rejuvenation', 'target')) then cast('Rejuvenation'); else s,d,e=a(148,"spell"); if(d==0) then cast('Swiftmend'); end; end; end;

function GCancelForm()	--> glastform
	for i=1, GetNumShapeshiftForms() do 
		local icon, name, active = GetShapeshiftFormInfo(i) -- icon, name, active, castable
		if active then 
			CastShapeshiftForm(i); 
			glastform = name; glastformnum = i;
			break
		end 
	end
end

function GIsShapeshifted()	-- gcurform = formname
	for i=1, GetNumShapeshiftForms() do 
		_, name, active = GetShapeshiftFormInfo(i);
		if active then gcurform=name; return true end 
	end
	gcurform=""
	return false
end

function GFormReju() 
	local canshift = 0;
	-- CANCEL FORM
	if (GIsShapeshifted() and GIsRejuvenation>0) then 
		if UnitExists("target") then
			if (UnitReaction("target","player")>=4) then
				if (GUnitHasBuff("target","Spell_Nature_Rejuvenation")==false) then canshift=1; end
			elseif GPlayerHasBuff("Spell_Nature_Rejuvenation")==false then canshift=1; end
		elseif GPlayerHasBuff("Spell_Nature_Rejuvenation")==false then canshift=1; end
		if canshift==1 then GCancelForm() end --> glastform
	end
	-- REJUVENATION
	if (canshift==0) and GIsRejuvenation>0 then	
		if UnitExists("target") then
			if (UnitReaction("target","player")>=4) then
				if (GUnitHasBuff("target","Spell_Nature_Rejuvenation")==false) then canshift=1; CastSpellByName("Rejuvenation"); end
			elseif GPlayerHasBuff("Spell_Nature_Rejuvenation")==false then canshift=1; CastSpellByName("Rejuvenation",1) end		
		elseif GPlayerHasBuff("Spell_Nature_Rejuvenation")==false then canshift=1; CastSpellByName("Rejuvenation",1)
		end
	end
	-- SHIFT BACK
	if (canshift==0) and (GIsShapeshifted()==false) then
		if (glastform~="") then
			CastSpellByName(glastform,1);
		else
			if (GIsCatForm>0) then CastSpellByName("Cat Form",1)
			elseif (GIsBearForm>0) then CastSpellByName("Bear Form",1)
			end
		end
	else --CastSpellByName("Attack",1);
	end
end

function GProwl()
  if GIsSpellLearned("Prowl")>0 then
	if GIsShapeshifted() and GGetForm()~=CatFormNum then GCancelForm()
	elseif GIsShapeshifted()==false then CastSpellByName("Cat Form",1)
	--elseif GIsCAtForm>0 and GIsProwl()=false then CastSpellByName("Prowl",1)
	elseif GGetForm()==CatFormNum then CastSpellByName("Prowl",1)
	end	
  end
end

function GSearchSpellSlot(GSSS) -- 0 - not found, 1..120 slotid
	local GSpellSlotFind = 0;
	local GActionSlot = 0;
	local GActionTexture = nil
	for GActionSlot = 120,1, -1 do
		GActionTexture = GetActionTexture(GActionSlot) -- texture name
		if GActionTexture then 			
			--local GActxt = GActionSlot;	if GActionTexture then GActxt=GActxt..": "..GetActionTexture(GActionSlot) end if GetActionText(GActionSlot) then GActxt=GActxt.." = "..GetActionText(GActionSlot) end kiir(GActxt)
			if (GetActionText(GActionSlot)==nil) and strfind(GActionTexture, GSSS) then GSpellSlotFind=GActionSlot; end			
		end
	end
	--kiir(GSpellSlotFind)
	return GSpellSlotFind;
end

function GSearchAttackSlot()
	local GAttackSlotFind = 0;
	local lActionSlot = 0;
	for lActionSlot = 1, 120 do
		--lActionText = GetActionText(lActionSlot); -- macro title
		--if lActionTexture then
		--[[local GActxt = lActionSlot;
		if GetActionTexture(lActionSlot) then GActxt=GActxt..": "..GetActionTexture(lActionSlot) end 
		if GetActionText(lActionSlot) then GActxt=GActxt.." = "..GetActionText(lActionSlot) end 
		if GetActionTexture(lActionSlot) then
			local atype, aid, asubType, aspellID = GetActionInfo(slot) 
			if atype then GActxt=GActxt.." Type:"..atype end
			if aid then GActxt=GActxt.." ID:"..aid end
			if asubType then GActxt=GActxt.." Sub:"..asubType end
			if aspellID then GActxt=GActxt.." SpID:"..aspellID end ]]
		if GetActionTexture(lActionSlot) then
			if IsAttackAction(lActionSlot) then GAttackSlotFind = lActionSlot; end
		end
	end
	return GAttackSlotFind;
end

function GStartAutoattack()
  UIErrorsFrame:Hide()
	if GAttackSlot~=0 then
		if IsAttackAction(GAttackSlot) then
			if not IsCurrentAction(GAttackSlot) then UseAction(GAttackSlot) end
		end
	else 
		GAttackSlot = GSearchAttackSlot()
	end
	--if not PlayerFrame.inCombat then AttackTarget() end
  UIErrorsFrame:Clear(); UIErrorsFrame:Show();
end

function GSearchShootSlot()
	local GAttackSlotFind = 0;
	local lActionSlot = 0;
	local WandTex = GetInventoryItemTexture("player",GetInventorySlotInfo("RangedSlot"))
	if WandTex then 
		for lActionSlot = 1, 120 do
			if GetActionTexture(lActionSlot) then
				if GetActionTexture(lActionSlot)==WandTex then -- found the current wand texture
					if not GetActionText(lActionSlot) then
						if GAttackSlotFind==0 then GAttackSlotFind = lActionSlot; end
					end
				end
			end
		end
		return GAttackSlotFind;
	end
end

function GStartWanding()
  UIErrorsFrame:Hide()
	if GShootSlot then 
	  if GShootSlot>0 then
		if not IsAutoRepeatAction(GShootSlot) then
			if not IsCurrentAction(GShootSlot) then 
				--GepyCast("Shoot")
				UseAction(GShootSlot)
			else 
				kiir("flashing");
			end
		end
	  else GShootSlot = GSearchShootSlot() end
	else GShootSlot = GSearchShootSlot() end
  UIErrorsFrame:Clear(); UIErrorsFrame:Show();
end





-- SPELL (assist)
function GepyCast(GCSpell)
  UIErrorsFrame:Hide()
  if (GIsSpellLearned(GCSpell)>0) then
	if GetUnitName("target")==nil then --[[kiir("No target, targeting nearest...");]] TargetNearestEnemy()
	elseif UnitExists("target") then 
		if UnitIsDeadOrGhost("target") or UnitIsCorpse("target") then TargetNearestEnemy() end; 
	end
	if UnitExists("target") and UnitIsPlayer("target") and (UnitIsFriend("player","target")) then AssistUnit("target"); end
	if UnitIsFriend("player","target") then AssistUnit("target"); end
	--if UnitExists("pet") and (gPetCanAttack) then --[[kiir("PET attack");]] PetAttack(); end	
	--[[if UnitIsPlayer("target") and (UnitIsEnemy("player","target")==false) then AssistUnit("target"); end
	if GetUnitName("target")==nil then TargetNearestEnemy() end
	if UnitIsEnemy("player","target")==false then AssistUnit("target"); end ]]
	if (GetUnitName("target")~=nil) --[[and UnitIsEnemy("player","target")]] then 
		TurtleDismount()
		CastSpellByName(GCSpell); 
	end
  end
  UIErrorsFrame:Clear(); UIErrorsFrame:Show();
end


function GepyAspect(GCSpell)
  --GListPlayerBuffs();
  TurtleDismount()
  if (GCSpell=="Hawk") or (GCSpell=="Cheetah")  or (GCSpell=="Pack") or (GCSpell=="Wild") then GCSpell="Aspect of the "..GCSpell; end
  if (GIsSpellLearned(GCSpell)>0) then
	    if (GCSpell=="Aspect of the Hawk") and (GPlayerHasBuff("Spell_Nature_RavenForm")==false) then CastSpellByName(GCSpell);
	elseif (GCSpell=="Aspect of the Cheetah") and (GPlayerHasBuff("Ability_Mount_JungleTiger")==false) then CastSpellByName(GCSpell);
	elseif (GCSpell=="Aspect of the Pack") and (GPlayerHasBuff("Ability_Mount_WhiteTiger")==false) then CastSpellByName(GCSpell);
	elseif (GCSpell=="Aspect of the Wild") and (GPlayerHasBuff("Spell_Nature_ProtectionfromNature")==false) then CastSpellByName(GCSpell);
	end;
  end
end


-- SPELL (assist)
function GepyChannel(GCSpell)
	--GListDebuffs("target"); GListBuffs("target");
	--kiir(GetUnitName("target"))
  UIErrorsFrame:Hide()
	AutoTarget()
	TurtleDismount()
	local GCoreSpell = GCSpell;
	local GSF=string.find(GCSpell,"Rank ");
	if GSF then GCoreSpell=strsub(GCSpell, 1, GSF-2); end
	--kiir(GCSpell.."         CORE = "..GCoreSpell)
  if (GIsSpellLearned(GCoreSpell)>0) then
	if GetUnitName("target")==nil then --[[kiir("No target, targeting nearest...");]] TargetNearestEnemy()
	elseif UnitExists("target") then if UnitIsDeadOrGhost("target") or UnitIsCorpse("target") then TargetNearestEnemy() end; end
	if UnitExists("target") and UnitIsPlayer("target") and (UnitIsFriend("player","target")) then --[[kiir("Assisting "..GetUnitName("target"));]] AssistUnit("target"); end
	if UnitExists("target") and UnitIsFriend("player","target") then --[[kiir("Assisting(2) "..GetUnitName("target"));]] AssistUnit("target"); end	
	--if UnitExists("pet") and (gPetCanAttack) then PetAttack(); end
	
	if (isWarlock) and (not UnitAffectingCombat("player")) then
		--if GSF 	then GDeleteLastShard(0) else GMoveShardsFromLastBag(2) end-- if ANY (Rank X)  -->  KILL Shard from soulbag's last slot or last (4th) bag!
																		   -- 2 = 4,3,2 = shardbags  (move from 1,0)
		GMoveShardsFromLastBag(2)
	end
	
	if (GetUnitName("target")~=nil) --[[and UnitIsEnemy("player","target")]] then
		--kiir(GCSpell.." = "..strsub(GCSpell,1,10))
		if (isWarlock) then
			if (GCoreSpell=="Drain Life") and (UnitCreatureType("target")~="Mechanical") then
				if (GTargetHasDebuff("Spell_Shadow_LifeDrain02")==false) then CastSpellByName(GCSpell) end
			elseif (GCoreSpell=="Drain Soul") then 
				--if GSF then	GDeleteLastShard() else GMoveShardsFromLastBag(2) end-- if ANY (Rank X)  -->  KILL Shard from soulbag's last slot or last (4th) bag!
																				 -- 2 = 4,3,2 = shardbags  (move from 1,0)
				GMoveShardsFromLastBag(2)
				if (GPlayerHasBuff("Spell_Shadow_Haunting")==false) then 
					CastSpellByName(GCSpell)
					--GDestroyLastSoulshard(4); -- kill from last (original) bag	 (3 = last + next)
				end
			else			
				CastSpellByName(GCSpell)
			end
		elseif (isPriest) then
			if (GCoreSpell=="Mind Flay") then
				if (GTargetHasDebuff("Spell_Shadow_SiphonMana")==false) then CastSpellByName(GCSpell) end
			end
		end
	end
  else --kiir("NO spell: "..GCoreSpell)
  end
  UIErrorsFrame:Clear(); UIErrorsFrame:Show();
end


function GepyMouseHeal(GCSpell)	-- mouseover target self
  UIErrorsFrame:Hide()
	local GCoreSpell = GCSpell;
	local GSF=string.find(GCSpell,"Rank ");
	if GSF then GCoreSpell=strsub(GCSpell, 1, GSF-2); end -- raw spellname without(Rank x)
	local haveTarget = UnitExists("target")
	local htarg="player";
	local gmhdebug=""
	
  if (GIsSpellLearned(GCoreSpell)>0) and GIsAlive() then  
	TurtleDismount()
	if GetMouseFocus().unit then --kiir("GetMouseFocus().unit = "..GetMouseFocus().unit)
		if SlashCmdList.LUFMO then --kiir("SlashCmdList.LUFMO")
			--TargetUnit(GetMouseFocus().unit)
			SlashCmdList.LUFMO(GCSpell,nil) -- LunaUnitframe
			--TargetLastTarget()
			htarg="none"
		end
	end
	if (htarg~="none") and UnitExists("mouseover") then
		--if UnitInRange("mouseover")~=nil then if UnitInRange("mouseover") then
		if (UnitReaction("mouseover","player")>=4) then
			if (UnitLevel("mouseover")~=nil) and (not UnitIsDeadOrGhost("mouseover")) and (not UnitIsCorpse("mouseover")) and UnitIsConnected("mouseover") and UnitIsVisible("mouseover") and (not UnitOnTaxi("mouseover")) 
				then htarg="mouseover"
			else
				if (UnitReaction("mouseover","player")<4) then gmhdebug=gmhdebug.."UnitReaction="..UnitReaction("mouseover","player").."   "; end
				if UnitLevel("mouseover")==nil then gmhdebug=gmhdebug.."UnitLevel=Nil   "; end
				if UnitIsDeadOrGhost("mouseover") then gmhdebug=gmhdebug.."UnitIsDeadOrGhost   "; end
				if UnitIsCorpse("mouseover") then gmhdebug=gmhdebug.."UnitIsCorpse   "; end
				if UnitIsConnected("mouseover")==false then gmhdebug=gmhdebug.."UnitIsNotConnected   "; end
				if UnitIsVisible("mouseover")==false then gmhdebug=gmhdebug.."UnitIsNotVisible   "; end
				if UnitOnTaxi("mouseover") then gmhdebug=gmhdebug.."UnitOnTaxi   "; end
				--if gmhdebug~="" then kiirszin(gmhdebug,"lred"); end
			end
		end
	end
	if htarg=="player" and UnitExists("target") then -- if targeting someone
		--if UnitInRange("target")~=nil then if UnitInRange("target") then
		if UnitReaction("target","player")~=nil then
			if (UnitReaction("target","player")>=4) then -- friendly target
				if (UnitLevel("target")~=nil) 
				and (not UnitIsDeadOrGhost("target")) 
				and (not UnitIsCorpse("target")) 
				and UnitIsConnected("target") 
				and UnitIsVisible("target") 
				and (not UnitOnTaxi("target")) 
				then htarg="target"; 
				else
					--
				end; --end; end
			end
		end
	end
	if htarg=="mouseover" and UnitExists("target") then
		--if UnitInRange("target")~=nil then if UnitInRange("target") then
		if not UnitIsDeadOrGhost("target") and not UnitIsCorpse("target") then
		if UnitReaction("target","player")>=4 and GetUnitName(htarg)==GetUnitName("target") then htarg="target"; end; end; --end; end; 
	end
	if htarg=="target" and not UnitIsDeadOrGhost("target") and not UnitIsCorpse("target") then if GetUnitName(htarg)==GetUnitName("player") then htarg="player"; end; end
	if htarg=="mouseover" then TargetUnit(htarg); end;
	-- The actual healing --	
	if (htarg~="none") then CastSpellByName(GCSpell); end
	-- after mouseover targeting, target last target back...
	if htarg=="mouseover" then 
		if haveTarget then TargetLastTarget(); else ClearTarget() end; 
	end
  end
  UIErrorsFrame:Clear(); UIErrorsFrame:Show();
end

function GepyOutfitter(goname)
	if not IsControlKeyDown() then
		ToggleCharacter("PaperDollFrame"); 
		OutfitterFrame:Show(); 
	end	
end

function TurtleDismount()
	local gTD = GPlayerHasBuffNameNum("Riding Turtle")	
	if gTD>0 then 
		if GPlayerHasBuff("inv_pet_speedy") then 
			--CancelPlayerBuff(GetPlayerBuff(gTD-1,"HELPFUL"));
			CastSpellByName("Riding Turtle")
		end
	end
end









-- Command Line / parameter handling...
function Gepy_SlashCommandHandler(arg1)
   local command="";
   local option="";
   local longoption="";
   local comm="";
   local txt = "";
   local opt = "";
   local optbumm = {};
  if (arg1) then
	local _,_,command = string.find(arg1,"(%l+)");

	if( command ) then 
		optbumm[2]=nil; optbumm[3]=nil; optbumm[4]=nil;
		optbumm = darabol(arg1," ");
		if (optbumm[2]) then option = optbumm[2]; longoption = option; end
		comm = string.lower(command);
		if (option == nil) then option = ""; end
		if (optbumm[3]) then longoption = longoption.." "..optbumm[3]; end
		if (optbumm[4]) then longoption = longoption.." "..optbumm[4]; end
		if (optbumm[5]) then longoption = longoption.." "..optbumm[5]; end

		if (comm=="buffs") then GepyBuffs(); end
		if (comm=="attack") then GepyAttack(); end
		if (comm=="cast") --[[and (UnitIsDeadOrGhost("player")==false)]] then GepyCast(longoption); end
		if (comm=="channel") --[[and (UnitIsDeadOrGhost("player")==false)]] then GepyChannel(longoption); end		
		if (comm=="mouseheal") --[[and (UnitIsDeadOrGhost("player")==false)]] then GepyMouseHeal(longoption); end		
		if (comm=="bag") then BAG(optbumm[2],optbumm[3]); end		
		
		if (comm=="rr") then
			local rn = GetNumRaidMembers(); 
			if (rn==0) then errkiir("Can\'t RaidRoll, not in raid!");
			else
				local rrand = random(1,rn);
				local rname, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(rrand);
				--kiirszin("   RaidRoll (1-"..rn.."): "..CGREEN..rname,"brown");
				SendChatMessage("RaidRoll (1-"..rn.."): ["..class.."] "..rname,"RAID");
			end
		end
				
		if (comm=="gr") then
		  if (IsInGuild()) then
		  	GuildRoster();
			local gn = GetNumGuildMembers(true); 
			if (gn==0) then errkiir("Error, GuildMembers=0, repeat the command to refresh guildinfo!");
			else
				local rrand = random(1,gn);
				local rname, rrank, rankIndex, level, class, zone, note, officernote, online, status  = GetGuildRosterInfo(rrand);
				local grtxt = CLGREEN.."GuildRoll"..CBROWN.." (1-"..gn.."):  "..CWHITE..string.upper(rname)..CGRAY.."  (lvl "..level.." "..class..", "..CLGRAY..rrank..CGRAY..")";
				if (online == nil) then grtxt = grtxt..CRED.." [Offline]"; end;
				kiirszin("   "..grtxt,lblue);
				if (option ~= "hide") then SendChatMessage("GuildRoll (1-"..gn.."): ["..class.."]  "..string.upper(rname),"GUILD"); end;
			end
		  else errkiir("You are not in a guild!"); end	
		end

		if (comm=="sting") or (comm=="serpent") or (comm=="serpentsting") then
			if (StingAllowed) then StingAllowed=false; kiir("Hunter SerpentSting allowed = "..CRED.."OFF");
			else StingAllowed=true; kiir("Hunter SerpentSting allowed = "..CLGREEN.."ON");
			end
		end;
		
		if (comm=="ver") then
			kiir("Making a version check (your version: "..CPURPLE..gepyver..CMYCOLOR..")...");
			SendAddonMessage("gepy", "vercheck "..gepyver.." "..altnevnum, "GUILD");
		end;
			
		if (comm=="verann") then
			kiir("Announcing version...");
			option=string.gsub(option,"_","~");
			SendAddonMessage("gepy", "verann "..gepyver.." "..altnevnum.." "..option, "GUILD");
		end;
			
		if (comm=="help") then			
			kiirszin(CSTART..CPINK.."Gepy's Imba Addon v"..Gepy_Version.."", lblue);
			kiirszin(" rr "..CLGRAY.."- RaidRoll, rolls a random raid member and shows in raidchat","white");
			kiirszin(" gr "..CLGRAY.."- GuildRoll, rolls a random guild member and shows in guildchat","white");
			--kiirszin(" att "..CLGRAY.."- Lists people in attendence channel, even if they play with an alt","white");
			--kiirszin(" alt "..CLGRAY.."- Lists people from "..altchanname.." channel, with their guild and altname","white");
			--kiirszin(" altlist "..CLGRAY.."- Lists mainnames and altnames"..altchanname,"white");
			--kiirszin(" nir "..CLGRAY.."- Lists ppl who online but Not In the Raid","white");
			--kiirszin(" hp X "..CLGRAY.."- Lists ppl from raid who has less than X health (default:4k)","white");
			--kiirszin(" whp "..CLGRAY.."- Shows warrior's Maximum Health in raidchat","white");
			--kiirszin(" lp "..CLGRAY.."- Leaves Party/Raid if you are bugged (LeaveParty();)","white");
			--kiirszin(" ria "..CLGRAY.."- Attendence list of players from raid and channel","white");
			--kiirszin(" rir "..CLGRAY.."- List of players only from the raid","white");
			--kiirszin(" cthun "..CLGRAY.."- Raidofficers can announce Cthun layout (use the additional "..CGRAY.."force"..CLGRAY.." parameter if you are not an officer)","white");
			--kiirszin(" sapp "..CLGRAY.."- Raidofficers can announce Sapphiron layout (use the additional "..CGRAY.."force"..CLGRAY.." parameter if you are not an officer)","white");
			--kiirszin(" ver "..CLGRAY.."- Version check","white");
			kiirszin(" bag "..CLGRAY.."- Item movement between bags (on bag upgrade), shows more info...","white");
			kiirszin(" attack "..CLGRAY.."- My personal attack rotation (warlock), use from MACRO!","white");
			kiirszin(" buffs "..CLGRAY.."- My personal auto-buffing (for my priest/mage), use from MACRO!","white");
			kiirszin(" cast <spellname> "..CLGRAY.."- Assist+Target+Cast (max rank by default), from MACRO!","white");
			kiirszin(" channel <spellname> "..CLGRAY.."- Assi+Targ+Channel (spammable, not any spell!), from MACRO!","white");
			kiirszin(" mouseheal <spellname> "..CLGRAY.."- Mouseover > Target > Self, no unitframe! MACRO!","white");
			--kiirszin(CSTART..CPINK.."Get the latest version from "..CGREEN.."http://heroes.hardwired.hu/-/gepy.html","lblue");
		end

	else
		kiirszin(CSTART..CPINK.."Gepy's Imba Addon v"..Gepy_Version.."", lblue);
		txt = txt..CWHITE.."rr "..CLGRAY.."raidroll, ";
		txt = txt..CWHITE.."gr "..CLGRAY.."guildroll, ";
		--txt = txt..CWHITE.."att "..CLGRAY.."attendence, ";
		--txt = txt..CWHITE.."alt "..CLGRAY.."altcheck, ";
		--txt = txt..CWHITE.."altlist "..CLGRAY.."altnames, ";
		--txt = txt..CWHITE.."nir "..CLGRAY.."notinraid, ";
		--txt = txt..CWHITE.."hp "..CDGRAY.."X "..CLGRAY.."raidHPcheck, ";
		--txt = txt..CWHITE.."whp "..CLGRAY.."warrior-raidhp, ";
		--txt = txt..CWHITE.."lp "..CDGRAY.."X "..CLGRAY.."leaveparty, ";
		--txt = txt..CWHITE.."ria "..CDGRAY.."X "..CLGRAY.."attendeelist, ";
		--txt = txt..CWHITE.."cthun "..CDGRAY.."force "..CLGRAY.."cthunlayout, ";
		--txt = txt..CWHITE.."sapp "..CDGRAY.."force "..CLGRAY.."sapphironlayout, ";
		--txt = txt..CWHITE.."ver "..CDGRAY.."versioncheck, ";
		txt = txt..CWHITE.."bag "..CLGRAY.."bag-management, ";
		txt = txt..CWHITE.."attack "..CLGRAY.."attack-rotation, ";
		txt = txt..CWHITE.."cast "..CLGRAY.."smart-castassist, ";
		txt = txt..CWHITE.."channel "..CLGRAY.."spammable-spellchanneling, ";
		txt = txt..CWHITE.."mouseheal "..CLGRAY.."mouseover-healing, ";
		txt = txt..CLGREEN.."help "..CLGRAY.."detailed help";
		kiirszin(CSTART..CPURPLE.."Parameters: "..txt, "lblue");
	end
  end
end


function removeitemlink(gremitem) -- for hidden addon channel, you can't send itemlinks or WoW crashes!
	gremitem=string.gsub(gremitem," ","~");
	gremitem=string.gsub(gremitem,"\n","~");
	gremitem=string.gsub(gremitem,"\10","~");
	local wstart=strfind(gremitem,"|c");
	local wend=strfind(gremitem,"|r");
	local wcnt=0;
	local wlen=0;
	while (wstart~=nil and wend~=nil and wcnt<10) do
		wstarb=strfind(gremitem,"|h%[");
		wenb=strfind(gremitem,"\93|h");
		wlen=string.len(gremitem);
--			kiir("talalat: ST:"..wstart..", EN:"..wend..", LN:"..wlen);	
--			kiir("belso: '"..strsub(gremitem,wstarb,wenb).."'");
--			kiir("vege: '"..strsub(gremitem,wend+2,wlen).."' ("..(wend+2)..","..(wlen)..")");
--			kiir("eredeti: "..gremitem);
		gremitem=strsub(gremitem,1,wstart-1).."("..strsub(gremitem,wstarb+1+2,wenb-1)..")"..strsub(gremitem,wend+2,wlen);
		wstart=strfind(gremitem,"|c");
		wend=strfind(gremitem,"|r");
		wcnt=wcnt+1;
	end;
	gremitem=string.gsub(gremitem,"|","~");
	return gremitem;
end


function Gepy_OnLoad()
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("SKILL_LINES_CHANGED");
	this:RegisterEvent("PLAYER_TALENT_UPDATE");
	this:RegisterEvent("TRAINER_CLOSED");
	this:RegisterEvent("CHAT_MSG_WHISPER"); -- whispcmd

	
	--this:RegisterEvent("VARIABLES_LOADED");

	SlashCmdList["GEPY"] = Gepy_SlashCommandHandler
	SLASH_GEPY1 = "/gepy";
	SLASH_GEPY2 = "/gpy";
	listkiir = 0;
end

function Gepy_OnEvent(event)
	if (event=="PLAYER_ENTERING_WORLD" or event=="PLAYER_LOGIN") then 
		SpellsChecked = false;
		ConsoleExec("CameraDistanceMaxFactor 5");
		gPlayerLevel = UnitLevel("player"); 
		playernev = UnitName("player"); 
		GCheckSpells();
		GAttackSlot = GSearchAttackSlot()
		GShootSlot = GSearchShootSlot()
		-- MACROs
		GAutoCreateMacros()				
		if MinimapZoomIn:Hide()~=nil then MinimapZoomIn:Hide(); end
		if MinimapZoomOut:Hide()~=nil then MinimapZoomOut:Hide(); end
		grested()
		GCheckSpells()
		if isHunter then GUpdateFeedMacro(0); end
		--C_Timer.After(5, function() grested(); GCheckSpells(); GUpdateFeedMacro(0); end)
	end
	if (event=="PLAYER_LEVEL_UP") then gPlayerLevel = arg1; GCheckSpells(); SpellsChecked = false; end;
	if (event=="SPELLS_CHANGED") or (event=="SKILL_LINES_CHANGED") or (event=="PLAYER_TALENT_UPDATE") or (event=="TRAINER_CLOSED") then GCheckSpells(); Gspellcheck=0; end;
	if (event=="CHAT_MSG_WHISPER") then GWhisp_Analiser(event, arg1, arg2, arg3); end; -- whisp commands
end



