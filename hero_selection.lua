----------------------------------------------------------------------------------------------------
-- hero_selection.lua
-- Author: KingleeBotSmiths 
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com 
----------------------------------------------------------------------------------------------------

function Think()

team1 = {"npc_dota_hero_skeleton_king", "npc_dota_hero_lina", "npc_dota_hero_axe",
"npc_dota_hero_abaddon", "npc_dota_hero_crystal_maiden"};
team2 = {"npc_dota_hero_sniper", "npc_dota_hero_drow_ranger", "npc_dota_hero_earthshaker",
"npc_dota_hero_enigma", "npc_dota_hero_sandking"};

--5 different team setups, provided by jerry!
--not anymore, it is eric's testing time :DDD
--math.randomseed(tostring(os.time()):reverse():sub(1, 6))
	
if ( GetTeam() == TEAM_RADIANT )
	then
		SelectHero(2,team1[1]);
		SelectHero(3,team1[2]);
		SelectHero(4,team1[3]);
		SelectHero(5,team1[4]);
		SelectHero(6,team1[5]);
	elseif ( GetTeam() == TEAM_DIRE )
	then
		SelectHero(7,team2[1]);
		SelectHero(8,team2[2]);
		SelectHero(9,team2[3]);
		SelectHero(10,team2[4]);
		SelectHero(11,team2[5]);
	end
end

--the first hero selection code that we wrote for selecting teams randomly
--[[
function Think()

team1 = {"npc_dota_hero_antimage", "npc_dota_hero_axe", "npc_dota_hero_pudge",
"npc_dota_hero_crystal_maiden", "npc_dota_hero_puck"};
team2 = {"npc_dota_hero_death_prophet", "npc_dota_hero_necrolyte", "npc_dota_hero_pugna",
"npc_dota_hero_viper", "npc_dota_hero_skeleton_king"};
team3 = {"npc_dota_hero_drow_ranger", "npc_dota_hero_earthshaker", "npc_dota_hero_legion_commander",
"npc_dota_hero_silencer", "npc_dota_hero_obsidian_destroyer"};
team4 = {"npc_dota_hero_pudge", "npc_dota_hero_viper", "npc_dota_hero_treant",
"npc_dota_hero_venomancer", "npc_dota_hero_sven"};
team5 = {"npc_dota_hero_sniper", "npc_dota_hero_drow_ranger", "npc_dota_hero_earthshaker",
"npc_dota_hero_enigma", "npc_dota_hero_sandking"};

teams = {team1, team2, team3, team4, team5};
--5 different team setups, provided by jerry!
--math.randomseed(tostring(os.time()):reverse():sub(1, 6))
firstTeam = RandomInt(0,5);
secondTeam = RandomInt(0,5);

while (firstTeam==secondTeam ) 
	do 
		secondTeam=RandomInt(0,5); 
	end
	
if ( GetTeam() == TEAM_RADIANT )
	then
		SelectHero(2,teams[firstTeam][1]);
		SelectHero(3,teams[firstTeam][2]);
		SelectHero(4,teams[firstTeam][3]);
		SelectHero(5,teams[firstTeam][4]);
		SelectHero(6,teams[firstTeam][5]);
	elseif ( GetTeam() == TEAM_DIRE )
	then
		SelectHero(7,teams[secondTeam][1]);
		SelectHero(8,teams[secondTeam][2]);
		SelectHero(9,teams[secondTeam][3]);
		SelectHero(10,teams[secondTeam][4]);
		SelectHero(11,teams[secondTeam][5]);
	end
end

LoadScript: X:\Steam\steamapps\common\dota 2 beta\game\dota\scripts\vscripts\bots\hero_selection.lua, scope name HeroSelectionScriptScope
LoadScript: X:\Steam\steamapps\common\dota 2 beta\game\dota\scripts\vscripts\bots\team_desires.lua, scope name TeamDesiresScriptScope
LoadScript: X:\Steam\steamapps\common\dota 2 beta\game\dota\scripts\vscripts\bots\team_desires.lua not found!
LoadScript: X:\Steam\steamapps\common\dota 2 beta\game\dota\scripts\vscripts\bots\hero_selection.lua, scope name HeroSelectionScriptScope
LoadScript: X:\Steam\steamapps\common\dota 2 beta\game\dota\scripts\vscripts\bots\team_desires.lua, scope name TeamDesiresScriptScope
LoadScript: X:\Steam\steamapps\common\dota 2 beta\game\dota\scripts\vscripts\bots\team_desires.lua not found!
Bot scripts reloaded.
--]]
	
	
