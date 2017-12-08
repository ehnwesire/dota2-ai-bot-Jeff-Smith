--------------------------------------------------------------------------------------------------------------------
-- ability_item_usage_abaddon.lua
-- Author: KingleeBotSmiths 
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com
--------------------------------------------------------------------------------------------------------------------

castMCDesire = 0;
castASDesire = 0;
castBTDesire = 0;
 
function AbilityUsageThink()
 
     local npcBot = GetBot();

     if ( npcBot:IsUsingAbility() ) then return end;

     abilityMC = npcBot:GetAbilityByName( "abaddon_mist_coil" ); 
     abilityAS = npcBot:GetAbilityByName( "abaddon_aphotic_shield" );
     abilityBT = npcBot:GetAbilityByName( "abaddon_borrowed_time" );
    

     castMCDesire, castMCTarget = ConsiderMistCoil();
     castASDesire, castASTarget = ConsiderAphoticShield();
     castBTDesire= ConsiderBorrowedTime();
 
     if ( castASDesire > castBTDesire and castASDesire > castMCDesire )
     then
           npcBot:Action_UseAbilityOnEntity( abilityAS, castASTarget );
           return;
     end
 
    if ( castBTDesire > 0.6 )
     then
           npcBot:Action_UseAbility( abilityBT ); -- actively trigger the ultimate
           return;
     end
 
     if ( castMCDesire > 0 )
     then
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

----------------------------------------------------------------------------------------------------
 
function ConsiderAphoticShield() -- This skill gives ally hero a sheild and also put a strong dispell, which dispell almost every debuff.
 
     local npcBot = GetBot();
     if ( not abilityAS:IsFullyCastable() )
     then
           return BOT_ACTION_DESIRE_NONE, 0;
     end;
 
     local nCastRange = abilityAS:GetCastRange()
     local npcTarget = npcBot:GetTarget()
     if ( npcTarget ~= nil and CanCastAphoticShieldOnTarget( npcTarget ) )
     then
           if ( npcTarget:GetHealth() <= 400 and UnitToUnitDistance( npcTarget, npcBot ) <= ( nCastRange ) )
           then
                return BOT_ACTION_DESIRE_VERYHIGH, npcTarget;
				--We want Abaddon to save his allies by casting AS in them.
           end
     end

     local tableHelplessAllies = npcBot:GetNearbyHeroes( nRadius + 200, false, BOT_MODE_NONE );
     for _,npcAlly in pairs( tableHelplessAllies ) --the line's code is hard to understand, in pairs
     do
          if ( npcAlly:IsBlind() and npcAlly:IsDisarmed() and npcAlly:IsHexed() and npcAlly:IsMuted() and npcAlly:IsRooted() and npcAlly:IsSilenced()and npcAlly:IsStunned() ) 
		  --ATTENTION!  This logic is amazing!but should we connect them w/ 'and' or 'or'? And more, 
		  --check this : IsSpeciallyDeniable() (Returns whether the unit is deniable by allies due to a debuff.) 
		  --I want to use this code! Where should we put it? Leave enemy no chance for kill!
          then
               return BOT_ACTION_DESIRE_HIGH, npcAlly;
          end
end

----------------------------------------------------------------------------------------------------

function ConsiderMistCoil()  -- this skill use health to cause damage/heal to enemy/ally
-- use this skill to deny himslef    use this skill during 'Borrowed Time'
-- use this skill to deny himslef    use this skill during 'Borrowed Time'
-- use this skill to deny himslef    use this skill during 'Borrowed Time'
-- use this skill to deny himslef    use this skill during 'Borrowed Time'
-- use this skill to deny himslef    use this skill during 'Borrowed Time'
-- use this skill to deny himslef    use this skill during 'Borrowed Time'



local npcBot = GetBot();
 
     if ( npcBot:GetHealth() <= 150 and UnitToUnitDistance( npcTarget, npcBot ) <= ( nCastRange ) )
           then
                return BOT_ACTION_DESIRE_VERYHIGH, npcTarget;
	end;
	
     if ( not abilityBC:IsFullyCastable() ) then
           return BOT_ACTION_DESIRE_NONE, 0;
     end;
 
      if ( castASDesire > 0 )  --usually using AS is the priority
     then
           return BOT_ACTION_DESIRE_NONE, 0;
     end;

     local nRadius = abilityMC:GetCastRange()
	 --if we are roaming to gank someone, and 
     if (  npcBot:GetActiveMode() == BOT_MODE_ROAM or
           npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
           npcBot:GetActiveMode() == BOT_MODE_GANK )
     then
           if ( npcTarget ~= nil )
           then
                if ( CanCastBattleHungerOnTarget( npcTarget ) )
                then
                     return BOT_ACTION_DESIRE_LOW, npcTarget;
                end
				
				if ( npcTarget:GetHealth < BHDamage + 100 )
				then
					return BOT_ACTION_DESIRE_HIGH, npcTarget; 
				end
				
				
           end
     end
		
		--if the enemy's health is more than 60%, and our mana is more than 60% & Health more than 80%, cast it on the enemy as
		--an inflict of damage
		--condition under farming mode, laning mode, defend ally, defending towers 
	 if (  npcBot:GetActiveMode() == BOT_MODE_FARM or
           npcBot:GetActiveMode() == BOT_MODE_LANING or
           npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY or
		   npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT or
           npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID or
           npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP )
		 if ( npcTarget:GetHealth() / npcTarget:GetMaxHealth() > 0.6 )
		 then
			if ( ( npcBot:GetHealth() / npcBot:GetMaxHealth() > 0.8) and ( npcBot:GetMana() / npcBot:GetMaxMana() > 0.6)
			then
				return BOT_ACTION_DESIRE_MEDIUM, npcTarget; 
			end
		end
	 end	
		
     return BOT_ACTION_DESIRE_NONE, 0;
end

----------------------------------------------------------------------------------------------------
 
function ConsiderBorrowedTime()  -- This skill regens every damage absorbed.
--The condition we use this actively: 
--we estimate upcoming damage, if it will be really high, we triger ultimate actively to absorb all the damage.
-- reason: usually when fight starts, tons of damage will be dealt at the beginning, then there will be a period which has less damgage occurs becuase every hero is waiting for cooldown.
-- now if you get me.
 
     local npcBot = GetBot();
 
     if ( castASDesire > 0 )
     then
           return BOT_ACTION_DESIRE_NONE, 0;
end



