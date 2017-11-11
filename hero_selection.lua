function Think()

team1 = {"npc_dota_hero_puck", "npc_dota_hero_axe", "npc_dota_hero_sandking",
"npc_dota_hero_crystal_maiden", "npc_dota_hero_antimage"};
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
firstTeam = math.random(5);
secondTeam = math.random(5);

while ( firstTeam == secondTeam ) 
	do 
		secondTeam = math.random(5); 
	end
	
if ( GetTeam() == TEAM_RADIANT )
	then
		SelectHero(2,teams[firstTeam][1]);
		SelectHero(3,teams[firstTeam][2]);
		SelectHero(4,teams[firstTeam][3]);
		SelectHero(5,teams[firstTeam][4]);
		SelectHero(6,teams[firstTeam][5]);
	elseif ( GetTeam() == TEAM_DIRE ) 
		SelectHero(7,teams[secondTeam][1]);
		SelectHero(8,teams[secondTeam][2]);
		SelectHero(9,teams[secondTeam][3]);
		SelectHero(10,teams[secondTeam][4]);
		SelectHero(11,teams[secondTeam][5]);
	end
end
	
	
	
	
