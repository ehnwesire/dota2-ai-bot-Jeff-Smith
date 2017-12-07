X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
       "item_glimmer_cape"
       "item_aether_lens"
       "item_cyclone"
       "item_guardian_greaves"
       "item_solar_crest"
       "item_rod_of_atos"
};			

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  {2,3,2,3,1,4,2,3,3,2,4,3,1,1,1,4}, skills, 
	  {2,3,6,8}, talents
);

return X