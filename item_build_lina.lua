----------------------------------------------------------------------------------------------------
-- The script was taken from adamqqq's Ranked Matchmaking AI Bot
-- The KingleeBotSmiths certify that they didn't create this work
-- item_build_lina.lua 
-- Used by KingleeBotSmiths
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com
----------------------------------------------------------------------------------------------------
--	Ranked Matchmaking AI v1.0a
--	Author: adamqqq		Email:adamqqq@163.com
----------------------------------------------------------------------------------------------------

X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_magic_wand",
	"item_arcane_boots",
	"item_cyclone",
	"item_trident",
	"item_aether_lens",
	"item_ultimate_scepter",
	"item_sheepstick"
};			

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  {1,2,3,1,1,4,1,2,2,2,4,3,3,3,4}, skills, 
	  {1,3,5,7}, talents
);

return X