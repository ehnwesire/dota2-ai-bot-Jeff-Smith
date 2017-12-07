--------------------------------------------------------------------------------------------------------------------
-- item_build_abaddon.lua
-- Author: KingleeBotSmiths 
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com
--------------------------------------------------------------------------------------------------------------------

X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
      "item_phase_boots"
      "item_ radiance"
      "item_ octarine_core"
      "item_ shivas_guard"
      "item_solar_crest"
      "item_ultimate_specter"
      "item_moon_shard" --how to make bot consume it?
};			

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  {2,3,2,1,2,4,2,3,3,3,4,1,1,1,4}, skills, 
	  {2,3,6,8}, talents
);

return X