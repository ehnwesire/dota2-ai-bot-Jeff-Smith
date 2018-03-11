--------------------------------------------------------------------------------------------------------------------
-- ability_item_usage_skeleton_king.lua
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
	
	Hi jasmine: hey old man
]]--

--------------------------------------------------------------------------------------------------------------------

--Just the desire variable to cast spells... nothing really 
castHBDesire = 0;
castMSDesire = 0;

--------------------------------------------------------------------------------------------------------------------

function AbilityUsageThink()

	local npcBot = GetBot(); 
	
	--Check if we are already using an ability or channeling 
	if ( npcBot:IsUsingAbility() and npcBot:IsChanneling() )
	then
		return;
	end
	
	--Getting the handle to skeleton's only active ability (maybe lul)
	abilityHB = npcBot:GetAbilityByName( "skeleton_king_hellfire_blast" ); 
	abilityMS = npcBot:GetAbilityByName( "skeleton_king_mortal_strike" );
	
	--Setting the desire to cast hellfire blast and intended target as return values of the function for later use 
	castHBDesire, castHBTarget = ConsiderHellfireBlast(); 
	castMSDesire = ConsiderMortalStrike();
	
	--If we have some desire for casting hellfire blast, cast it (on the target)
	if ( castHBDesire > 0.1 )
	then 
		npcBot:Action_UseAbilityOnEntity( abilityHB, castHBTarget );
		return; 
	end
	
	--Considering to cast mortal strike with high desires because it might be a waste of mana...?
	if ( castMSDesire > 0.4 )
	then
		npcBot:Action_UseAbility( abilityMS );
		return; 
	end

end

--------------------------------------------------------------------------------------------------------------------

--Making sure of the target's conditions to receive that blast RIGHT IN THEIR FACE! BOOM!
function CanCastHellfireBlastOnTarget()
	--three commonest conditions for us to check always: visibility, magic immune, vulnerability
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end

--------------------------------------------------------------------------------------------------------------------

function ConsiderHellfireBlast()

	local npcBot = GetBot();
	
	--Making sure that the ability is castable by the bot 
	--This is an Ability-Scoped function (Ability:xxx)
	if ( not abilityHB:IsFullyCastable() )
	then	
		return BOT_ACTION_DESIRE_NONE, 0; 
	end; 
	
	--Getting several of the ability's values: 
	local nCastRange = abilityHB:GetCastRange();
	local nDamage = abilityHB:GetAbilityDamage();
	
	--If an enemy is using an ability or channeling, we should say "HI!" and stop him right away
	local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE );
	for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
	do
		if ( npcEnemy:IsChanneling() ) 
		then
			return BOT_ACTION_DESIRE_VERYHIGH, npcEnemy;
		end
	end

	--If we are pushing, defending, retreaing, or roaming to gank with the team, cast the spell on the target when the distance is close enough...? 
	--(since skeleton king is a pretty dumn hero...)
	--REAL: if we are pushing or defending ONLY, cast the ability on the nearest enemy if they reach the cast range just right on. 
	--ONLY CAST THIS WHEN WE HAVE ENOUGH MANA (0.9)
	if ( npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or
		 npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or
		 npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT ) 
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE );
		local npcTarget = npcBot:GetTarget();
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes ) 
		do 
			if ( CanCastHellfireBlastOnTarget( npcTarget ))
			then 
				if (npcBot:GetMana() / npcBot:GetMaxMana() > 0.9)
				then
					return BOT_ACTION_DESIRE_LOW, npcEnemy; 
				end
			end
		end
	end
	
	--This part could be replaced by the next if. Possibly. 
	--[[ 
	--if we are roaming or retreating, still get the nearest enemy but this time consider less of the mana 
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_RETREAT )
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes ) 
		do 
			if (npcBot:GetMana() / npcBot:GetMaxMana() > 0.6)
			then
				return BOT_ACTION_DESIRE_MODERATE, npcEnemy; 
			end
		end
	end
	--]]
	
	
	--When we're going after someone
	--Use hellfire blast on the mode selected target. If the damage is enough to kill them or make them wounded then the action shoudld have a HIGH desire. 
	if ( npcBot:GetActiveMode() == BOT_MODE_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM or
		 npcBot:GetActiveMode() == BOT_MODE_GANK or
		 npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY ) 
	then
		local npcTarget = npcBot:GetTarget();
		if ( CanCastHellfireBlastOnTarget( npcTarget ))
		then 
			local npcHealth = npcTarget:GetHealth();
			local nDamage = abilityHB:GetAbilityDamage(); 
			if ( npcTarget ~= nil ) 
			then
					return BOT_ACTION_DESIRE_HIGH, npcTarget;
			end
		
			if ( npcHealth() < nDamage or npcHealth < nDamage + 200 ) 
			then 
				return BOT_ACTION_DESIRE_VERYHIGH, npcTarget; 
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------

--This should be it for now, but we will always add more codes for maximum improvements
--UPDATE: Skeleton king should open the vampire aura when the active mode is pushing so that the creeps last longer. 
--UPDATE: Skeleton king's third ability is now usable. I was playing this hero yesterday
--and I found that the ability could call cute little skeleton creeps out, for pushing maybe? 
--UPDATE: Skeleton king's mana is really restricted before he purchases echo sabre or intelligence-boost items 
--basically his mana can only support 1 hellfire blast + 1 reincarnation

--------------------------------------------------------------------------------------------------------------------

-- function Consider
-- OK, so for that random third ability, my idea is that we should only consider casting it when the bot is pushing
-- From my gameplays i think that this stupid ability needs to gather charges for a long time to get more skeletons 
-- While pushing once i casted this ability i need to start minding my mana for reincarnation. 
-- How about when the bot is pushing alone? When theres no enemy heroes present aroun? 
-- The easiest way to do this should be writing multiple if statemtents within one if. 
-- Anyways try to work hard...

--------------------------------------------------------------------------------------------------------------------

function ConsiderMortalStrike()

	local npcBot = GetBot();
	local botHasMana = npcBot:GetMana() / npcBot:GetMaxMana () > 0.8; 
	
	--When skeleton king is pushing or doing rosh and there is no enemy hero around, cast mortal strike to push
	--[[
	{ hUnit, ... } GetNearbyHeroes( nRadius, bEnemies, nMode)
	Returns a table of heroes, sorted closest-to-furthest, that are in the specified mode. 
	If nMode is BOT_MODE_NONE, searches for all heroes. If bEnemies is true, nMode must be BOT_MODE_NONE. 
	nRadius must be less than 1600
	--]]
	if ( npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT or
		npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or
		npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or
		npcBot:GetActiveMode() == BOT_MODE_ROSHAN )
	then 
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( 1200 , true, BOT_MODE_NONE );
		for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
		do
			if ( not npcEnemy:CanBeSeen() ) 
			then
				return BOT_ACTION_DESIRE_HIGH;
			end
		end
	end
	
	--When the bot is defending an ally and has enough mana cast mortal strike 
	if ( npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY )
	then
		if ( botHasMana )
		then 
			return BOT_ACTION_DESIRE_HIGH;
		end
	end
	
end