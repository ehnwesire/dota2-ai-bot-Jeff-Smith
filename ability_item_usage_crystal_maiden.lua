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

--------------------------------------------------------------------------------------------------------------------

castCNDesire = 0;
castFDesire = 0;
castFFDesire = 0;

--------------------------------------------------------------------------------------------------------------------

function AbilityUsageThink()

	local npcBot = GetBot();

	--Check if we're already using an ability or (channeling)
    if ( npcBot:IsUsingAbility() or npcBot:IsChanneling() ) --or npcBot:IsChanneling()
	then 
		return;
	end

    abilityCN = npcBot:GetAbilityByName( "crystal_maiden_crystal_nova" );  -- target area
    abilityF = npcBot:GetAbilityByName( "crystal_maiden_frostbite" );  --target unit
    abilityFF = npcBot:GetAbilityByName( "crystal_maiden_freezing_field" ); --no target/ channeled
	
	--Considering to use each ability
    castCNDesire, castCNLocation = ConsiderCrystalNova();
    castFDesire, castFTarget = ConsiderFrostbite();
    castFFDesire = ConsiderFreezingField();
	
	--Considering to cast freezing field with a higher priority because its cool 
    if ( castFFDesire > castFDesire and castFFDesire > castCNDesire )
    then
		npcBot:Action_UseAbility( abilityFF );
		return;
	end
 
    if ( castCNDesire > 0 )
    then
		npcBot:Action_UseAbilityOnLocation( abilityCN, castCNLocation );
        return;
    end
 
    if ( castFDesire > 0 )
    then
		npcBot:Action_UseAbilityOnEntity( abilityF, castFTarget );
		return;
    end
 
end
 
----------------------------------------------------------------------------------------------------

function CanCastCrystalNovaTarget( npcTarget )
    return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end

function CanCastFrostbiteOnTarget( npcTarget )
    return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end

--When the ability is channeled should we still consider these factors?
function CanCastFreezingFieldTarget( ) --no target skill
    return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end

--The global function used to check availability of casting the spell 
function CanCastSpellOnTarget ( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end
----------------------------------------------------------------------------------------------------
 
function ConsiderFrostbite()
 
    local npcBot = GetBot();
	--If we can't cast Frostbite, do nothing at all
    if ( not abilityF:IsFullyCastable() )
    then
		return BOT_ACTION_DESIRE_NONE, 0;
    end;
	
	--If we want to cast freezing field more then consider freezing field first 
    if ( castFFDesire > 0 )
    then
		return BOT_ACTION_DESIRE_NONE, 0;
    end
	
	local npcTarget = npcBot:GetTarget();
    local nCastRange = abilityF:GetCastRange();
    local nDuration = abilityF:GetDuration();
	--How about let's try GetAbilityDamage?
	local FBDamage = abilityF:GetAbilityDamage();
    local nEstimatedDamageToTarget = npcBot:GetEstimatedDamageToTarget( true, npcTarget, nDuration, DAMAGE_TYPE_MAGICAL  );
	--[[
	float GetEstimatedDamageToTarget( bCurrentlyAvailable, hTarget, fDuration, nDamageTypes )
	Gets an estimate of the amount of damage that this unit can do to the specified unit.
	If bCurrentlyAvailable is true, it takes into account mana and cooldown status
	--]]
	--GetEstimatedDamageToTarget returns the UNIT's damage, not an ABILITY's one.
	--Should be useful when we calculate how dangerousity(?) of an enemy 
    local eDamageType = DAMAGE_TYPE_MAGICAL;
    local tableNearbyAllyHeroes = npcBot:GetNearbyHeroes( 800, false, BOT_MODE_NONE)
	--There was an undefined nRadius in the parameter... ( nRadius + 500, )
	--[[
	GetNearbyHeroes from API: 
	{ hUnit, ... } GetNearbyHeroes( nRadius, bEnemies, nMode)
	Returns a table of heroes, sorted closest-to-furthest, that are in the specified mode. 
	If nMode is BOT_MODE_NONE, searches for all heroes. 
	If bEnemies is true, nMode must be BOT_MODE_NONE. nRadius must be less than 1600.
	--]]
	--What about the modes? This is probably the universal logic for crystal maiden to cast frostbite 
    
	--When crystal maiden has got 2 more allies around and the enemy is low on health, cast frostbite on the enemy
    if ( npcTarget ~= nil and CanCastFrostbiteOnTarget( npcTarget ) ) --~= means approximate, approximately...
	then
		--These codes will probably malfunction because they didn't involve calculating the ability's damage
		--Try to find some ability damage calculations from API later --SOLVED 
		--if ( npcTarget:GetActualDamage( nEstimatedDamageToTarget) > npcTarget:GetHealth() + 200)
		if ( abilityF:GetDamage() > npcTarget:GetHealth() + 200 )
		then
            if ( ( tableNearbyAllyHeroes >= 2 ) and UnitToUnitDistance(npcTarget, npcBot)= nCastRange + 100 ) 
			then
				return BOT_ACTION_DESIRE_HIGH, npcTarget;
            end
		end
    end
	
	if ( npcTarget:IsChanneling() )
    then
        return BOT_ACTION_DESIRE_HIGH, npcTarget; --cEnemy:GetLocation(); --No need to get location I think? --Yeah good idea
    end

    return BOT_ACTION_DESIRE_NONE, 0;
end

----------------------------------------------------------------------------------------------------

--Need to add more conditions, this is only one and it's far not enough
function ConsiderFreezingField() 

	local npcBot = GetBot();
 
	--If we can't cast freezing field, do nothing at all
	if ( not abilityFF:IsFullyCastable() ) then
        return BOT_ACTION_DESIRE_NONE, 0;
    end 
 
	local locationAoE = npcBot:FindAoELocation( false, true, npcBot:GetLocation(), nRadius, 0, 0 );
    --[[
	{ int count, vector targetloc } FindAoELocation( bEnemies, bHeroes, vBaseLocation, nMaxDistanceFromBase, nRadius, fTimeInFuture, nMaxHealth)
	Gets the optimal location for AoE to hit the maximum number of units described by the parameters. 
	Returns a table containing the values targetloc that is a vector for the center of the AoE 
	and count that will be equal to the number of units within the AoE that mach the description. ]]--
	--So how do we use the table?
	local nRadius = abilityFF:GetSpecialValueInt( "freezing_field_aoe" );
	
	--Counting the number of nearby enemy heroes 
    local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE );

	--if the bot is pushing or defending a tower, and can get 3 or more heroes with the ability, go for it
    if ( npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or
		npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or
		npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT or
		npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		npcBot:GetActiveMode() == BOT_MODE_ATTACK )
    then
		if ( tableNearbyEnemyHeroes >= 3 )
        then
			return BOT_ACTION_DESIRE_HIGH;
        end		   
    end
	
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM )
	then
		return BOT_ACTION_DESIRE_MODERATE;
	end

    return BOT_ACTION_DESIRE_NONE;
end

--------------------------------------------------------------------------------------------------
 
function ConsiderCrystalNova() 
 
    local npcBot = GetBot();
	local npcTarget = npcBot:GetTarget();
	
	--If we can't cast Crystal Nova, do nothing at all
    if ( not abilityCN:IsFullyCastable() ) then
		return BOT_ACTION_DESIRE_NONE, 0;
    end
	
	--If we want to cast freezing field then consider freezing field first 
    if ( castFFDesire > 0 )
    then
		return BOT_ACTION_DESIRE_NONE, 0;
    end

	-- I want to do some ambitious code here. High risk.
	local FnCastRange = abilityF:GetCastRange();
	local CNCastRange = abilityCN:GetCastRange();
	--local CNDamage = math.floor ( nEstimatedDamageToTarget );
	local CNDamage = abilityCN:GetAbilityDamage();

	--when CM is roaming or ganking
	--The list modes below is written in official Lina’s bot script, but the codes cannot be found in official website.  Need to check if this works.
    if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
        npcBot:GetActiveMode() == BOT_MODE_GANK or
        npcBot:GetActiveMode() == BOT_MODE_ATTACK )
    then
        if ( npcTarget ~= nil and CanCastCNOnTarget( npcTarget) )
        then
            if ( UnitToUnitDistance( npcTarget, npcBot ) > FnCastRange and UnitToUnitDistance( npcTarget, npcBot ) <= CNCastRange + 300) 
			--when frostbite(range 525) can not reach the enemy but crystal nova(range 700 + effect radius 425) can hit the enemy, 
			--then nova the enemy first to decelerate the enemy. I wrote CNCastRange + 300, we add 300 more distance because we have a 425 units effect radius, 
			--the reason why I didn’t write exactly 425, is because the bot and target might be moving in a different speed, 
			--and to cast Crystal nova there’s a cast animation costs 0.9s. 
			--This is smart mannnnnnn i think crystal maiden moves slowly so we should also take this into consideration?
            then
                return BOT_ACTION_DESIRE_HIGH, npcTarget:GetLocation();
            end
			
        end
    end
    return BOT_ACTION_DESIRE_NONE, 0;
end
--Should be done for now but we will always need more work on logics 

----------------------------------------------------------------------------------------------------

function AbilityLevelUpThink ()
  --this should be the ability level up part, who knows? 
end

----------------------------------------------------------------------------------------------------
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
    npcBot:Action_Chat(AbilityToUpgrade[1],true);
    npcBot:Action_LevelAbility(AbilityToUpgrade[1])
table.remove( AbilityToUpgrade, 1 )
    end	
  end
end