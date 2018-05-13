--------------------------------------------------------------------------------------------------------------------
-- ability_item_usage_abaddon.lua
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

local castMCDesire = 0;
local castASDesire = 0;
local castBTDesire = 0;
 
function AbilityUsageThink()
 
    local npcBot = GetBot();

	--If the bot is channeling or castng an ability, do nothing at all 
    if ( npcBot:IsUsingAbility() or npcBot:IsChanneling() ) 
	then 
	    print("Jeff Smith is working dawg!ABDstopall");
		return 
	end;

	--Getting the handles to abadoon's three abilities 
    abilityMC = npcBot:GetAbilityByName( "abaddon_death_coil" ); 
    abilityAS = npcBot:GetAbilityByName( "abaddon_aphotic_shield" );
    abilityBT = npcBot:GetAbilityByName( "abaddon_borrowed_time" );
    
    castMCDesire, castMCTarget = ConsiderMistCoil();
    castASDesire, castASTarget = ConsiderAphoticShield();
    --castBTDesire = ConsiderBorrowedTime(); 
	--Just let the bot go by itself!
	
	--Considering to cast aphotic shield with a higher priority because it saves life
	--[[ if ( castASDesire > castBTDesire and castASDesire > castMCDesire )
    then
	    print("Jeff Smith is working dawg!ABDcastAS");
		npcBot:Action_UseAbilityOnEntity( abilityAS, castASTarget );
        return;
    end --]]
 
	--Triggering borrowed time when Abaddon is in danger or needs to do so
	--OK, how about we take the getEstimatedDamage into consideration here? 
    if ( castBTDesire > 0.5 )
    then
	    print("Jeff Smith is working dawg!ABDsaveurself");
        npcBot:Action_UseAbility( abilityBT ); 
        return;
    end
 
    if ( castMCDesire > 0.1 )
    then
	    print("Jeff Smith is working dawg!ABDcastMC");
        npcBot:Action_UseAbilityOnEntity( abilityMC, castMCTarget );
        return;
    end

end
 
----------------------------------------------------------------------------------------------------
 
function CanCastMistCoilOnTarget( npcTarget )
     return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end

function CanCastAphoticShieldOnTarget( npcTarget )
     return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end

-- The Borrowed Time is a skill casts on abaddon himself.

function CanCastSpellOnTarget ( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end

----------------------------------------------------------------------------------------------------
 
-- This skill gives ally hero a sheild and also put a strong dispell, which dispell almost every debuff.
function ConsiderAphoticShield()

    local npcBot = GetBot();
	local npcTarget = npcBot:GetTarget();
	local ASCastRange = abilityAS:GetCastRange()
	
	if npcTarget~=nil then return BOT_ACTION_DESIRE_NONE, 0; end
	--If we can't cast Aphotic Shield, do nothing at all
    if ( not abilityAS:IsFullyCastable() )
    then
	print("Jeff Smith is working dawg!ABDstopAS");
        return BOT_ACTION_DESIRE_NONE, 0;
    end

	--We want Abaddon to save his allies by casting AS in them.
	--[[ { hUnit, ... } GetNearbyHeroes( nRadius, bEnemies, nMode)
	Returns a table of heroes, sorted closest-to-furthest, that are in the specified mode. 
	If nMode is BOT_MODE_NONE, searches for all heroes. 
	If bEnemies is true, nMode must be BOT_MODE_NONE. nRadius must be less than 1600.
	
	hUnit GetTeamMember( nPlayerNumberOnTeam )
	Returns a handle to the Nth player on the team.
	--]]
	--ABILITY_TARGET_TEAM_FRIENDLY guess this should be used
	
	--[[ 
	Aphotic shield's consideration: 
	Teammate is debuffed, low-health or needs help ---> 
	Distance < CastRange ---> 
	UseAbility 
	But how should we get uhhhh the four team members included? 
	--]]
    if ( npcTarget ~= nil and CanCastSpellOnTarget ( npcTarget ) )
    then
        if ( npcTarget:GetHealth() <= 400 and UnitToUnitDistance( npcTarget, npcBot ) <= ( ASCastRange ) )
        then
		    print("Jeff Smith is working dawg!ABDsaveally");
            return BOT_ACTION_DESIRE_VERYHIGH, npcTarget;
        end
    end

	--When allies in cast range are debuffed seriosuly or have 30% or lower health, cast aphotic shield 
    local tableHelplessAllies = npcBot:GetNearbyHeroes( ASCastRange + 200, false, BOT_MODE_NONE );
    for _,npcAlly in pairs( tableHelplessAllies ) --the line's code is hard to understand, in pairs
	--this should work to make use of every unit in the array 
    do
		local allyLowHealth = npcAlly:GetHealth() / npcAlly:GetMaxHealth() < 0.3; 
        
		if ( npcAlly:IsBlind() or npcAlly:IsDisarmed() 
		or npcAlly:IsHexed() or npcAlly:IsMuted() 
		or npcAlly:IsRooted() or npcAlly:IsSilenced() 
		or npcAlly:IsStunned() or allyLowHealth ) 
		--ATTENTION!  This logic is amazing!but should we connect them w/ 'and' or 'or'? And more, 
		--check this : IsSpeciallyDeniable() (Returns whether the unit is deniable by allies due to a debuff.) 
		--I want to use this code! Where should we put it? Leave enemy no chance to kill!
		--OMG That's a bad finding I think we should add it in ability_item_usage_general!
        then
		    print("Jeff Smith is working dawg!ABDdebuff");
			return BOT_ACTION_DESIRE_VERYHIGH, npcAlly;
        end
	end
end

----------------------------------------------------------------------------------------------------

-- this skill uses Abaddon's health for outputs of damage/heal to enemy/ally
function ConsiderMistCoil() 

	local npcBot = GetBot();
	local npcTarget = npcBot:GetTarget();
	local MCCastRange = abilityMC:GetCastRange();
	local MCDamage = abilityMC:GetAbilityDamage();
	
	--If we want to cast aphotic shield more, do nothing at all
	--[[ if ( castASDesire > 0 ) 
     then
	       print("Jeff Smith is working dawg!ABDstopMC");
           return BOT_ACTION_DESIRE_NONE, 0;
     end; --]]

    --if abaddon's health is low and enemy is insight, deny himself by casting Mist Coil on enemy 
	if ( npcBot:GetHealth() <= 150 and UnitToUnitDistance( npcTarget, npcBot ) <= ( MCCastRange ) ) 
    then
	    print("Jeff Smith is working dawg!ABDkillurself!");
        return BOT_ACTION_DESIRE_VERYHIGH, npcTarget;
    end
	
	local nRadius = abilityMC:GetCastRange()
	--Use skill to heal wounded allies when Abaddon's health is in a good shape. 
	--Also makes sure of keeping abaddon's mana good (?)
    local tableLowHealthAllies = npcBot:GetNearbyHeroes( nRadius, false, BOT_MODE_NONE );
    for _,npcAlly in pairs( tableLowHealthAllies ) 
    do 
	    if ( npcAlly:GetHealth() <= 300 and npcBot:GetHealth() / npcBot:GetMaxHealth() > 0.8 
			and npcBot:GetMana() / npcBot:GetMaxMana() > 0.65 )
        then
		        print("Jeff Smith is working dawg!ABDhealally");
		        return BOT_ACTION_DESIRE_MEDIUM, npcAlly;
		end
	end
	

	--if we are roaming to gank an enemy, cast Mist Coil on them to deal damage 
	--Also making sure of that abadoon has enough mana 
    if (  npcBot:GetActiveMode() == BOT_MODE_ROAM or
		npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
        npcBot:GetActiveMode() == BOT_MODE_GANK )
    then
		local botHasMana = npcBot:GetMana() / npcBot:GetMaxMana() > 0.65;
		if ( npcTarget ~= nil and CanCastSpellOnTarget( npcTarget ) and botHasMana )
        then
			    print("Jeff Smith is working dawg!ABDdamage");
                return BOT_ACTION_DESIRE_MEDIUM, npcTarget;
		end
	end
	
	--[[If Mist Coil can kill or badly would an enemy, go for it
	local npcTarget = npcBot:GetTarget();
	if ( npcBot:GetTarget():GetHealth() < MCDamage + 100 ) 
	then
	    print("Jeff Smith is working dawg!ABDdecapitate");
		return BOT_ACTION_DESIRE_HIGH, npcTarget; 
	end--]]
		
	--if the enemy's health is more than 60%, and our mana is more than 60% & Health more than 80%, 
	--cast it on the enemy as an inflict of damage
	--condition under farming mode, laning mode, defend ally, defending towers 
	--Like trading health, I like it. 
	if (  npcBot:GetActiveMode() == BOT_MODE_FARM or
        npcBot:GetActiveMode() == BOT_MODE_LANING or
        npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY or
		npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT or
        npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID or
        npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP )
	then
		--[[ local enemyHP = npcTarget:GetHealth();
		if (enemyHP=nil) then return;
		if ( npcTarget:GetHealth() / npcTarget:GetMaxHealth() > 0.6 )
		then
			if ( npcBot:GetHealth() / npcBot:GetMaxHealth() > 0.8 and npcBot:GetMana() / npcBot:GetMaxMana() > 0.6 )
			then
			    print("Jeff Smith is working dawg!ABDinterfere");
				return BOT_ACTION_DESIRE_MEDIUM, npcTarget; 
			end
		end
		]]--
		return BOT_ACTION_DESIRE_MEDIUM, npcTarget;
	end	
		
    return BOT_ACTION_DESIRE_MEDIUM, 0;
end


----------------------------------------------------------------------------------------------------
--LevelUpUrAbility!

	 local AbilityToUpgrade = {
"abaddon_aphotic_shield",
"abaddon_frostmourne", --frostmourne is Curse of Avernus as abaddon skill 3
"abaddon_aphotic_shield",
"abaddon_frostmourne",
"abaddon_aphotic_shield",
"abaddon_borrowed_time", -- Lv6
"abaddon_aphotic_shield",
"abaddon_frostmourne",
"abaddon_frostmourne",
"special_bonus_exp_boost_20",-- "special_bonus_movement_speed_25"
"abaddon_death_coil",
"abaddon_borrowed_time", -- Lv12
"abaddon_death_coil",
"abaddon_death_coil",
"special_bonus_armor_6",-- "special_bonus_unique_abaddon_2" unique2 is +60 mist coil heal/damage
"abaddon_death_coil",
"abaddon_borrowed_time", -- Lv18
"special_bonus_attack_damage_90",-- "special_bonus_cooldown_reduction_20"
"special_bonus_unique_abaddon"-- ""special_bonus_unique_abaddon_3""    unique is +225 aphotic shield health   unique3 is +25% frostmourne attack n move slow
};

function AbilityLevelUpThink() 

if ( #AbilityToUpgrade == 0 ) then
return;
end

local npcBot = GetBot();
  if (npcBot:GetAbilityPoints() > 0) then 
  local sNextAbility = npcBot:GetAbilityByName(AbilityToUpgrade[1])
    if (sNextAbility~=nil and sNextAbility:CanAbilityBeUpgraded() and sNextAbility:GetLevel() < sNextAbility:GetMaxLevel())
	then
    npcBot:ActionImmediate_LevelAbility(AbilityToUpgrade[1])
table.remove( AbilityToUpgrade, 1 )
    end	
  end
end
----------------------------------------------------------------------------------------------------
--function ConsiderBorrowedTime()  -- This skill regens every damage absorbed.
--The condition we use this actively: 
--we estimate upcoming damage, if it will be really high, we triger ultimate actively to absorb all the damage.
-- reason: usually when fight starts, tons of damage will be dealt at the beginning, then there will be a period which has less damgage occurs becuase every hero is waiting for cooldown.
-- now if you get me.
--I mean What The Heck     lets not edit this Ulti because its self-castable.


