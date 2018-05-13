--------------------------------------------------------------------------------------------------------------------
-- ability_item_usage_crystal_maiden.lua
-- Author: KingleeBotSmiths 
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com 
--------------------------------------------------------------------------------------------------------------------

--[[
	Some reference:  
	
	Desire values for taking an action 
	BOT_ACTION_DESIRE_NONE 
	BOT_ACTION_DESIRE_VERYLOW 
	BOT_ACTION_DESIRE_LOW 
	BOT_ACTION_DESIRE_MODERATE 
	BOT_ACTION_DESIRE_HIGH 
	BOT_ACTION_DESIRE_VERYHIGH 
	BOT_ACTION_DESIRE_ABSOLUTE 
	
	Team or bot modes that should be active while taken
	BOT_MODE_NONE
	BOT_MODE_LANING
	BOT_MODE_ATTACK
	BOT_MODE_ROAM
	BOT_MODE_RETREAT
	BOT_MODE_SECRET_SHOP
	BOT_MODE_SIDE_SHOP
	BOT_MODE_PUSH_TOWER_TOP
	BOT_MODE_PUSH_TOWER_MID
	BOT_MODE_PUSH_TOWER_BOT
	BOT_MODE_DEFEND_TOWER_TOP
	BOT_MODE_DEFEND_TOWER_MID
	BOT_MODE_DEFEND_TOWER_BOT
	BOT_MODE_ASSEMBLE
	BOT_MODE_TEAM_ROAM
	BOT_MODE_FARM
	BOT_MODE_DEFEND_ALLY
	BOT_MODE_EVASIVE_MANEUVERS
	BOT_MODE_ROSHAN
	BOT_MODE_ITEM
	BOT_MODE_WARD
]]--


--LevelUpUrAbility!

local AbilityToUpgrade = {
"crystal_maiden_frostbite",
"crystal_maiden_brilliance_aura",
"crystal_maiden_brilliance_aura",
"crystal_maiden_crystal_nova",
"crystal_maiden_brilliance_aura",
"crystal_maiden_freezing_field", -- Lv6
"crystal_maiden_brilliance_aura",
"crystal_maiden_frostbite",
"crystal_maiden_frostbite",
"special_bonus_cast_range_100",-- "special_bonus_hp_250"
"crystal_maiden_frostbite",
"crystal_maiden_freezing_field", -- Lv12
"crystal_maiden_crystal_nova",
"crystal_maiden_crystal_nova",
"special_bonus_unique_crystal_maiden_4",-- "special_bonus_gold_income_20" !!!!!! Eric choose whichever you want, current is +14% manacost/manaloss reduction aura. Another one is +120g/min
"crystal_maiden_crystal_nova",
"crystal_maiden_freezing_field", -- Lv18
"special_bonus_unique_crystal_maiden_3",-- "special_bonus_attack_speed_250" unique3 is +60 ulti damage per hit
"special_bonus_unique_crystal_maiden_2"-- ""special_bonus_unique_crystal_maiden_1"" unique2 is +300 crystal nova damage.  Unique1 is +1.5s frostbite duration.
};

function AbilityLevelUpThink() 

if ( #AbilityToUpgrade == 0 ) then
return;
end

local npcBot = GetBot();
  if (npcBot:GetAbilityPoints() > 0) then 
  local sNextAbility = npcBot:GetAbilityByName(AbilityToUpgrade[1])
    if (sNextAbility~=nil and sNextAbility:CanAbilityBeUpgraded() and sNextAbility:GetLevel() < sNextAbility:GetMaxLevel()) then
    npcBot:ActionImmediate_LevelAbility(AbilityToUpgrade[1])
	table.remove( AbilityToUpgrade, 1 )
    end	
  end
end