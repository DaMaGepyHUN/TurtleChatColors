Just some quick note about the addon:
https://github.com/DaMaGepyHUN/TurtleChatColors
(!) To install to the Interface/AddOns, RENAME folder to:  TurtleChatColors

http://damagepy.byethost3.com/TurtleChatColors1.png
http://damagepy.byethost3.com/TurtleChatColors2.png
http://damagepy.byethost3.com/TurtleChatColors3.png
Updated (shorter) deathmessage:
http://damagepy.byethost3.com/TurtleChatColors4.png

(Old pics, from when the Still Alive guild existed)
Fixed for the new system messages (drown burn etc)

What it does:
- Makes guildchat shorter replacing [Guild] with [G], [Party] with [P] etc...
- Queries guild roster to color names by class and to show their level:
  [G][Gepy:12]: ....  
- Makes names clickable in system messages (death/levelup) and colors them by 
  class if they are in the guild (if not then they will be silver-colored in
  system messages and green in guildchat)
- Slightly highlights certain keywords in chat: WTS LF2M, key locations like
  Stockades, Dire Maul, Deadmines, GS, or words like Healer, Quest run, etc.
- Repaces/reformats the Turtle system messages, coloring them, making names 
  clickable + class-colored, showing more info about location (if in guild)
- My auto-response in guildchat is a secret switch so the addon won't spam it
  automatcally for others. I made it so people without the addon can still
  see the death location and class (which I always wanted to know)
- no GUI, just "install" and it works. Should work with pfUI too, adding the 
  level info to the guildchat. if Class-coloring is turned off in pfUI then
  it won't color it.

I've added some other useful function which ppl can use in macros:

To show current rested bonus percentage (from: not rested ... 100%):
/run showrested()
To delete all "Dim Torch" from bags with one click (for STV survival lvling):
/run deletetorches()

TO-DO:
Later I may add my bag-swap macro as well for fast switching into new
bigger bags (moving all thing from old bag, switch, then moving all stuff
back), I have this and many other macro in my other private addon. For
example spammable auto-buff macro which buffs on mouseover (but does not 
buffs PvP flagged players unless holding a special key to force it), then
the targeted player, then self, chosing the proper spellrank, and also does 
stuff to you, for example on druid after buffing motw and thorns, also 
regrowth/reju if below certain HP%. I also have one-button attack rotation 
for most class for example on druid: if in bear form then uses enrage if 
available then spams maul, in cat form claw, but another macro first 
autotargets and uses feriefire, turns on autoattack, then rakes and then
claw spam and uses ferociousbite below a certain enemy HP% or at or above
4 combopoint. Another spammable macro is shifts out, casts regrowth/reju then
shifts back to the last used form and continues claw/autoattack (spammable,
so you wont shift in and then out again accidentally). Similar one-button
for locks, sending pet, and based on level talent and available spells it
DoTs with agony corruption siphonlife. There is also a macro for spammable
wanding which just turns it on and keeps it on, or a spammable channeling
macro for forexample drainlife or mindflay, where it only recasts them if
they are stopped channeling (therefore spammable). For hunters the one-button
attack macro sends pet (if available), autotargets, does hunter's mark,
serpent sting, turns auto shot on, then arcane shot (if you keep pressing)
and refreshes serpent sting if falls off or resists. But if you are below
level 10 or without a pet it does things differently, uses concshot first
then serpent (if learned), arcane, etc. There is also a feedpet macro which
shows the available number of food in a certain bagslot in the macro-text
and feeds the pet, or calls the pet if not out or resurrects if dead.
For locks a apammable macro for void sacrifice (if void is out) auto-eating 
a healthstone and on third press using a healingpot, or for example a
curseofexhaustion macro which uses amplifymagic if available. I also made a
mouseover healing macro, to heal mouseover, then target, then self (if no 
target or target is enemy) and uses the max rank automatically so no need
to swap newly purchased spells. The same goes for attacking spells with 
autotargeting. I wrote all of this because I wrote that private addon in 2005
for myself and using it myself since and adding more and more function for
servers where 1.12 and CastSpellByName is allowed. Found/joined Turtle HC
in mid January 2023, so I though some others may like my spec macros as well.
Let me know if you do, so I may make that available as well.
And I appreciate all feedback :)
  
Cya: DaMaGepy		(damagepyhun@gmail.com / discord:DaMaGepyHUN#2928)
