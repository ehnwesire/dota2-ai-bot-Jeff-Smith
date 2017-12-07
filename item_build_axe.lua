X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
       "item_tranquil_boots"
       "item_blink"
       "item_blade_mail"
       "item_crimson_guard"
       "item_shivas_guard"
       "item_heart"
};			

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  {2,3,3,1,3,4,3,1,1,1,4,2,2,2,4}, skills, 
	  {1,4,5,8}, talents
);

return X