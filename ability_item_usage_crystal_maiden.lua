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
	end; 
    abilityCN = npcBot:GetAbilityByName( "crystal_maiden_crystal_nova" );  -- target area
    abilityF = npcBot:GetAbilityByName( "crystal_maiden_frostbite" );  --target unit
    abilityFF = npcBot:GetAbilityByName( "crystal_maiden_freezing_field" ); --no target/ channeled
	
	--Considering to use each ability
    castCNDesire, castCNLocation = ConsiderCrystalNova();
    castFDesire, castFTarget = ConsiderFrostbite();
    castFFDesire = ConsiderFreezingField();
	
	--Considering Freezing Field with a higher priority 
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

----------------------------------------------------------------------------------------------------
 
function ConsiderFrostbite()
 
    local npcBot = GetBot();
	 
	--If the ability is not castable, do nothing at all
    if ( not abilityF:IsFullyCastable() )
    then
		return BOT_ACTION_DESIRE_NONE, 0;
    end;
	
	
	--If we want to cast freezing field then consider freezing field first 
    if ( castFFDesire > 0 )
    then
		return BOT_ACTION_DESIRE_NONE, 0;
    end
	
	local npcTarget = npcBot:GetTarget();
    local nCastRange = abilityF:GetCastRange();
    local nDuration = abilityF:GetDuration();
	--How about let's try GetAbilityDamage?
    local nEstimatedDamageToTarget = npcBot:GetEstimatedDamageToTarget( true, npcTarget, nDuration, DAMAGE_TYPE_MAGICAL  );
	--[[
	float GetEstimatedDamageToTarget( bCurrentlyAvailable, hTarget, fDuration, nDamageTypes )
	Gets an estimate of the amount of damage that this unit can do to the specified unit.
	If bCurrentlyAvailable is true, it takes into account mana and cooldown status
	--]]
	--GetEstimatedDamageToTarget returns the UNIT's damage, not an ABILITY's one.
    local eDamageType = DAMAGE_TYPE_MAGICAL;
    local tableNearbyAllyHeroes = npcBot:GetNearbyHeroes( 800, false, BOT_MODE_NONE)
	--There was an undefined nRadius in the parameter... ( nRadius + 500, )
	--[[
	{ hUnit, ... } GetNearbyHeroes( nRadius, bEnemies, nMode)
	Returns a table of heroes, sorted closest-to-furthest, that are in the specified mode. 
	If nMode is BOT_MODE_NONE, searches for all heroes. 
	If bEnemies is true, nMode must be BOT_MODE_NONE. nRadius must be less than 1600.
	--]]
	
    --When crystal maiden has got 2 more allies around and the enemy is low on health, cast frostbite on the enemy
    if ( npcTarget ~= nil and CanCastFrostbiteOnTarget( npcTarget ) ) --~= means approximate, approximately...
	then
		--These codes will probably malfunction because they didn't involve calculating the ability's damage
		--Try to find some ability damage calculations from API later
		if ( npcTarget:GetActualDamage( nEstimatedDamageToTarget) > npcTarget:GetHealth() + 200)
		then
            if ( (tableNearbyAllyHeroes >= 2 ) and UnitToUnitDistance( npcTarget, npcBot ) = ( nCastRange + 100) ) 
			then
				return BOT_ACTION_DESIRE_HIGH, npcTarget;
           end
		end
    end
	
	if ( npcTarget:IsChanneling() )
    then
        return BOT_ACTION_DESIRE_HIGH, npcTarget; --cEnemy:GetLocation(); --No need to get location I think?
    end

    return BOT_ACTION_DESIRE_NONE, 0;
end

----------------------------------------------------------------------------------------------------

function ConsiderFreezingField() 

local npcBot = GetBot();
 
	--If we can't cast freezing field, do nothing at all
    if ( not abilityFF:IsFullyCastable() ) 
	then
        return BOT_ACTION_DESIRE_NONE, 0;
    end 
 
 
     local nRadius = abilityBC:GetSpecialValueInt( "freezing_field_aoe" );
     local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE );

	--if the bot is pushing or defending a tower, and can get 2 or more heroes with the call, use it
     if (  npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or
           npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or
           npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT or
           npcBot:GetActiveMode() == BOT_ BOT_MODE_TEAM_ROAM or
           npcBot:GetActiveMode() == BOT_MODE_ATTACK )
     then
           local locationAoE = npcBot:FindAoELocation( false, true, npcBot:GetLocation(), nRadius, 0, 0 );
 
           if ( locationAoE.count >= 3 )
           then
                return BOT_ACTION_DESIRE_MEDIUM, locationAoE.targetloc;
		   --if CM can get 3 or more heroes by the FF, then maybe CM should go for damage.
           end		   
     end

     return BOT_ACTION_DESIRE_NONE, 0;
end

--------------------------------------------------------------------------------------------------
 
function ConsiderCrystalNova() 
 
     local npcBot = GetBot();
	 local npcTarget = npcBot:GetTarget();
		
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
local CNnCastRange = abilityCN:GetCastRange();
local CNDamage = math.floor ( nEstimatedDamageToTarget );

	 --when CM is roaming or ganking///////. The list modes below is written in official Lina’s bot script, but the codes cannot be found in official website.  Need to check if this works.
     if (  npcBot:GetActiveMode() == BOT_MODE_ROAM or
           npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
           npcBot:GetActiveMode() == BOT_MODE_GANK or
           npcBot:GetActiveMode() == BOT_MODE_ATTACK )
     then
           if ( npcTarget ~= nil and CanCastCNOnTarget( npcTarget) )
           then
                if ( UnitToUnitDistance( npcTarget, npcBot ) > FnCastRange and UnitToUnitDistance( npcTarget, npcBot ) <= CNCastRange + 300) 
--when frostbite(range 525) can not reach the enemy but crystal nova(range 700 + effect radius 425) can hit the enemy, then nova the enemy first to decelerate the enemy. I wrote CNCastRange + 300, we add 300 more distance because we have a 425 units effect radius, the reason why I didn’t write exactly 425, is because the bot and target might be moving in a different speed, and to cast Crystal nova there’s a cast animation costs 0.9s. --
                then
                     return BOT_ACTION_DESIRE_High, npcTarget;
                end
			
           end
     end
		
     return BOT_ACTION_DESIRE_NONE, 0;
end

----------------------------------------------------------------------------------------------------