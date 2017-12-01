function Think()

team1 = {"npc_dota_hero_skeleton_king", "npc_dota_hero_lina", "npc_dota_hero_axe",
"npc_dota_hero_dazzle", "npc_dota_hero_crystal_maiden"};
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