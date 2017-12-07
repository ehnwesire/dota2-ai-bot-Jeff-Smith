----------------------------------------------------------------------------------------------------
-- ability_item_usage_crystal_maiden.lua
-- Author: KingleeBotSmiths 
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com 
----------------------------------------------------------------------------------------------------

castCNDesire = 0;
castFDesire = 0;
castFFDesire = 0;

----------------------------------------------------------------------------------------------------

function AbilityUsageThink()

	local npcBot = GetBot();

	--Check if we're already usiing an ability or (channeling)
    if ( npcBot:IsUsingAbility() ) --or npcBot:IsChanneling()
	then 
		return 
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

function CanCastFreezingFieldTarget( ) --no target skill
    return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end

----------------------------------------------------------------------------------------------------
 
function ConsiderFrostbite()
 
     local npcBot = GetBot();
     if ( not abilityF:IsFullyCastable() )
     then
           return BOT_ACTION_DESIRE_NONE, 0;
     end;

     if ( castFDesire > 0 )
     then
           return BOT_ACTION_DESIRE_NONE, 0;
     end
 
     local nCastRange = abilityF:GetCastRange();
     local nDuration = abilityF:GetDuration();
     local nEstimatedDamageToTarget = abilityF:GetEstimatedDamageToTarget( true, npcTarget, nDuration, DAMAGE_TYPE_MAGICAL  );
     local eDamageType = abilityF:DAMAGE_TYPE_MAGICAL;
     local tableNearbyAllyHeroes = abilityF:GetNearbyHeroes( nRadius + 500, false, BOT_MODE_NONE)
	
     local npcTarget = npcBot:GetTarget();
     if ( npcTarget ~= nil and CanCastFrostbiteOnTarget( npcTarget ) ) --~= means approximate, approximately...
     then
           if ( npcTarget:GetActualDamage( nEstimatedDamageToTarget) > npcTarget:GetHealth() + 200 and (tableNearbyAllyHeroes >= 2 ) and UnitToUnitDistance( npcTarget, npcBot ) = ( nCastRange + 100) ) -- will nEstimatedDamage Work? 
           then
                return BOT_ACTION_DESIRE_HIGH, npcTarget;
				--When CM has ally beside her, and the enemy has a low health, Use frostbite to ensure teammates get the kill.
           end
     end

           if ( npcEnemy:IsChanneling() )
           then
                return BOT_ACTION_DESIRE_HIGH; --cEnemy:GetLocation();
           end
     end

     return BOT_ACTION_DESIRE_NONE, 0;
end

----------------------------------------------------------------------------------------------------

function ConsiderFreezingField() 

local npcBot = GetBot();
 
     if ( not abilityFF:IsFullyCastable() ) then
           return BOT_ACTION_DESIRE_NONE, 0;
     end;
 
 
     local nRadius = abilityBC:GetSpecialValueInt( "freezing_field_aoe" );
     local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE );

	--if the bot is pushing or defending a tower, and can get 2 or more heroes with the call, usse it
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