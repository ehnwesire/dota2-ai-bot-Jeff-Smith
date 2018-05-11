local U = {}

local dota2team = {

	[1] = {
		['name'] = "Team Liquid";
		['alias'] = "Liquid";
		['players'] = {
			'MATUMBAMAN',
			'Miracle-',
			'MinD_ContRoL',
			'GH',
			'KuroKy'
		};
		['sponsorship'] = '';
	},
	[2] = {
		['name'] = "Newbee";
		['alias'] = "Newbee";
		['players'] = {
			'Moogy',
			'Sccc',
			'kpii',
			'Kaka',
			'Faith'
		};
		['sponsorship'] = 'G2A';
	},
	[3] = {
		['name'] = "Evil Geniuses";
		['alias'] = "EG";
		['players'] = {
			'Arteezy',
			'Suma1L',
			'UNiVeRsE',
			'Cr1t-',
			'Fear'
		};
		['sponsorship'] = 'G2A';	
	},
	[4] = {
		['name'] = "LGD Gaming";
		['alias'] = "LGD";
		['players'] = {
			'Ame',
			'Maybe',
			'fy',
			'Yao',
			'Victoria'
		};
		['sponsorship'] = 'G2A';
	},
	[5] = {
		['name'] = "Virtus.pro";
		['alias'] = "VP";
		['players'] = {
			'RAMZES666',
			'No[o]ne',
			'9pasha',
			'Lil',
			'Solo'
		};
		['sponsorship'] = 'G2A';
	},
	[6] = {
		['name'] = "Team Secret";
		['alias'] = "Secret";
		['players'] = {
			'Ace',
			'MidOne',
			'Fata',
			'YapzOr',
			'Puppey'
		};
		['sponsorship'] = 'G2A';
	}
	
}

local sponsorship = {"GG.bet", "gg.bet", "VPGAME", "LOOT.bet", "loot.bet", "", "Esports.bet", "G2A", "Dota2.net"};

function U.GetDota2Team()

	--Getting random team name and sponsorship
	local bot_names = {};
	local rand = RandomInt(1, #dota2team);
	local srand = RandomInt(1, #sponsorship);
	
	if ( GetTeam() == TEAM_RADIANT ) 
	then
		while rand%2 ~= 0 do
			rand = RandomInt(1, #dota2team); 
		end
	else
		while rand%2 ~= 1 do
			rand = RandomInt(1, #dota2team); 
		end
	end
	
	local team = dota2team[rand];
	
	for _,player in pairs(team.players) do
		if sponsorship[srand] == "" then
			table.insert(bot_names, team.alias.."."..player);
		else
			table.insert(bot_names, team.alias.."."..player.."."..sponsorship[srand]);
		end
	end
	return bot_names;
end

return U