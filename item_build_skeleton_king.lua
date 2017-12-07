X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
       "item_power_treads"
       "item_desolator"
       "item_black_king_bar"
       "item_monkey_king_bar"
       "item_mjollnir"
       "item_abyssal_balde"
       "item_moon_shard"
};			

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  {1,2,1,2,1,4,1,3,2,2,4,3,3,3,4}, skills, 
	  {1,4,6,7}, talents
);

return X