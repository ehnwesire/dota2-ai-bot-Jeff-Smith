----------------------------------------------------------------------------------------------------
-- ability_item_usage_hero.lua
-- Project reboot
-- Author: KingleeBotSmiths 
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com 
----------------------------------------------------------------------------------------------------
 
castLBDesire = 0;
castECDesire = 0;

function AbilityUsageThink()

	local npcBot = GetBot()
	
	if ( npcBot:IsUsingAbility() ) then return end;
	
	abilityLB = npcBot:GetAbilityByName( "luna_lucent_beam" );
	abilityEC = npcBot:GetAbilityByName( "luna_eclipse" );
	
	castLBDesire, castLBTarget = ConsiderLucentBeam();
	castECDesire = ConsiderEclipse()
	
	if ( castECDesire > castLBDesire )
	then
		npcBot:Action_UseAbility( abilityEC );
		return; 
	end
	if ( castLBDesire > 0)
	then 
		npcBot:Action_UseAbilityOnEntity( abilityLB, castLBTarget );
	end

end

----------------------------------------------------------------------------------------------------

function CanCastLucentBeamOnTarget()

	local npcBot = GetBot();
	local npcTarget = npcBot:GetTarget();
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
	
end

----------------------------------------------------------------------------------------------------

function ConsiderLucentBeam()

	local npcBot = GetBot();
	local npcTarget = npcBot:GetTarget();
	
	if ( not abilityLB:IsFullyCastable() )
	then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	
	if ( castECDesire > 0 )
	then 
		return BOT_ACTION_DESIRE_NONE, 0; 
	end
	
	local nCastRange = abilityLB:GetCastRange();
	local nDamage = abilityLB:GetAbilityDamage();
	
	local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE );
	for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
	do
		if ( npcEnemy:IsChanneling() ) 
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy;
		end
	end
	
	-- If we're seriously retreating, see if we can land a stun on someone who's damaged us recently
	if ( npcBot:GetActiveMode() == BOT_MODE_RETREAT and npcBot:GetActiveModeDesire() >= BOT_MODE_DESIRE_HIGH ) 
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( npcBot:WasRecentlyDamagedByHero( npcEnemy, 2.0 ) ) 
			then
				if ( CanCastLucentBeamOnTarget( npcEnemy ) ) 
				then
					return BOT_ACTION_DESIRE_MODERATE, npcEnemy;
				end
			end
		end
	end
	
	-- If we're going after someone
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		if ( npcTarget ~= nil ) 
		then
			if ( CanCastLucentBeamOnTarget() )
			then
				return BOT_ACTION_DESIRE_HIGH, npcTarget;
			end
		end
	end
	
	return BOT_ACTION_DESIRE_NONE, 0;
end

----------------------------------------------------------------------------------------------------

function ConsiderEclipse()
	
	local npcBot = GetBot();
	-- If we're in a teamfight, use it on the scariest enemy
	local nearbyEnemies = npcBot:GetNearbyHeroes( 800, true, BOT_MODE_NONE);
	if ( #nearbyEnemies >= 3 ) 
	then
		return BOT_ACTION_DESIRE_HIGH;
	end
	
	if  ( #nearbyEnemies >= 4)
	then 
		return BOT_ACTION_DESIRE_VERY_HIGH;
	end
	
	return BOT_ACTION_DESIRE_NONE;
	
end
----------------------------------------------------------------------------------------------------
--LevelUpUrAbility!

	local AbilityToUpgrade = {
"luna_lunar_blessing",
"luna_lucent_beam",
"luna_lucent_beam",
"luna_moon_glaive",
"luna_lucent_beam",
"luna_eclipse", -- Lv6
"luna_lucent_beam",
"luna_moon_glaive",
"luna_moon_glaive",
"special_bonus_attack_speed_20",-- "special_bonus_cast_range_200"
"luna_moon_glaive",
"luna_eclipse", -- Lv12
"luna_lunar_blessing",
"luna_lunar_blessing",
"special_bonus_unique_luna_3",-- "special_bonus_unique_luna_2" unique3 is +24 damage   unique2 is -4s Lucent Beam Cooldown
"luna_lunar_blessing",
"luna_eclipse", -- Lv18
"special_bonus_all_stats_10",-- "special_bonus_unique_luna_1" unique1 is +100 lucent beam damage
"special_bonus_lifesteal_25"-- ""special_bonus_unique_luna_5""    unique5 is +0.25s eclipse lucent beam ministun
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