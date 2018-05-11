--[[

--------------------------------------------------------------------------------------------------------------------
-- item_purchase_abaddon.lua
-- Author: KingleeBotSmiths 
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com
--------------------------------------------------------------------------------------------------------------------

local ItemsToBuy = 
{ 
	"item_tango",
	"item_circlet",
	"item_boots",
	"item_slippers",
	"item_recipe_wraith_band",
	"item_sobi_mask",
	"item_ring_of_protection",--Ring of Aquila
	"item_gloves",
	"item_belt_of_strength", -- power treads
	"item_lifesteal",
	"item_quarterstaff", -- Mask of Madness
	"item_ogre_axe",
	"item_boots_of_elves",
	"item_boots_of_elves",-- dragon lance
	"item_blade_of_alacrity",
	"item_boots_of_elves",
	"item_recipe_yasha",
	"item_ultimate_orb",
	"item_recipe_manta",--Manta Style!
    "item_mithril_hammer",
    "item_ogre_axe",
    "item_recipe_black_king_bar", --BKB
	"item_eagle"--replace Ring of Aquila
	"item_talisman_of_evasion",
	"item_quarterstaff", --butterfly
	"item_reaver",
	"item_lifesteal"-- Decombine Mask of Madness if possible.
	"item_claymore", -- satanic        and replace mask of madness if its still in storage.
	"item_slippers",         --decombine Ring of Aquila if possible x1
	"item_circlet",          --decombine Ring of Aquila if possible x2
	"item_recipe_wraith_band",--decombine Ring of Aquila if possible x3
	"item_staff_of_wizardry",
	"item_ring_of_health",
	"item_recipe_force_staff", -- hurrican pike
}
function ItemPurchaseThink()

local npcBot = GetBot();

    if ( #ItemsToBuy == 0 )
    then
        npcBot:SetNextItemPurchaseValue( 0 );
        return;
    end

    local sNextItem = ItemsToBuy[1];

    npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );   

    if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )         
    then
        npcBot:ActionImmediate_PurchaseItem ( sNextItem );
        table.remove( ItemsToBuy, 1 );
    end

end
--]]

--------------------------------------------------------------------------------------------------------------------
-- item_purchase_luna.lua
-- Author: KingleeBotSmiths
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com
--------------------------------------------------------------------------------------------------------------------

--This item list comes from Dota Bot Smiths
local ItemsToBuy1 = 
{ 
    "item_tango",
    "item_stout_shield",
    "item_branches",
    "item_boots",
    "item_blades_of_attack",
	"item_blades_of_attack", --"item_phase_boots"
    "item_ring_of_regen",
	"item_recipe_headdress", -- headdress
	"item_sobi_mask", --this is Sage's Mask
	"item_ring_of_protection",
	"item_lifesteal", -- this is morbid mask   and now combined into vladmir's offering
    "item_relic",
	"item_recipe_radiance", --"item_radiance"
	"item_broadsword", 
	"item_chainmail",
	"item_robe", -- combined into Blademail
    "item_hyperstone",
	"item_platemail",
	"item_chainmail",
	"item_recipe_assault", --"item_assault",
    "item_ogre_axe",
    "item_point_booster",
    "item_blade_of_alacrity",
    "item_staff_of_wizardry", --"item_ultimate_scepter"
	"item_boots",---decombine phase boots if possible.
	"item_recipe_travel_boots",
	"item_recipe_travel_boots",-- level 2 boots of travel
    "item_hyperstone",
    "item_hyperstone", --"item_moon shard" consumable
}

--This item list comes from Dota Plus
local ItemsToBuy2 = 
{ 
    "item_tango",
    "item_stout_shield",
    "item_branches",
    "item_boots",
    "item_blades_of_attack",
	"item_blades_of_attack", --"item_phase_boots"
    "item_ring_of_regen",
	"item_recipe_headdress", -- headdress
	"item_sobi_mask", --this is Sage's Mask
	"item_ring_of_protection",
	"item_lifesteal", -- this is morbid mask   and now combined into vladmir's offering
    "item_relic",
	"item_recipe_radiance", --"item_radiance"
	"item_broadsword", 
	"item_chainmail",
	"item_robe", -- combined into Blademail
    "item_hyperstone",
	"item_platemail",
	"item_chainmail",
	"item_recipe_assault", --"item_assault",
    "item_ogre_axe",
    "item_point_booster",
    "item_blade_of_alacrity",
    "item_staff_of_wizardry", --"item_ultimate_scepter"
	"item_boots",---decombine phase boots if possible.
	"item_recipe_travel_boots",
	"item_recipe_travel_boots",-- level 2 boots of travel
    "item_hyperstone",
    "item_hyperstone", --"item_moon shard" consumable
}

--This item list comes from Dota2's Default Loadout
local ItemsToBuy3 = 
{
    "item_tango",
    "item_stout_shield",
    "item_branches",
    "item_boots",
    "item_blades_of_attack",
	"item_blades_of_attack", --"item_phase_boots"
    "item_ring_of_regen",
	"item_recipe_headdress", -- headdress
	"item_sobi_mask", --this is Sage's Mask
	"item_ring_of_protection",
	"item_lifesteal", -- this is morbid mask   and now combined into vladmir's offering
    "item_relic",
	"item_recipe_radiance", --"item_radiance"
	"item_broadsword", 
	"item_chainmail",
	"item_robe", -- combined into Blademail
    "item_hyperstone",
	"item_platemail",
	"item_chainmail",
	"item_recipe_assault", --"item_assault",
    "item_ogre_axe",
    "item_point_booster",
    "item_blade_of_alacrity",
    "item_staff_of_wizardry", --"item_ultimate_scepter"
	"item_boots",---decombine phase boots if possible.
	"item_recipe_travel_boots",
	"item_recipe_travel_boots",-- level 2 boots of travel
    "item_hyperstone",
    "item_hyperstone", --"item_moon shard" consumable
}

function ItemPurchaseThink()

local npcBot = GetBot();

	local randomNum = RandomInt( 1, 3 ) 
	--Returns a random integer between nMin and nMax, inclusive. 
	--Selecting random item list of the bot 
	if ( randomNum = 1 )
	then 
		local ItemsToBuy = ItemsToBuy1;
		print ( "Bot's loadout is List 1" );
	end
	
	else if ( randomNum = 2 ) 
	then 
		local ItemsToBuy = ItemsToBuy2;
		print ( "Bot's loadout is List 2" );
	end	
	
	else if ( randomNum = 3) 
		local ItemsToBuy = ItemsToBuy3;
		print ( "Bot's loadout is List 3" );
	end
	
    if ( #ItemsToBuy == 0 )
    then
        npcBot:SetNextItemPurchaseValue( 0 );
        return;
    end

	--Setting the next item to buy in list
    local sNextItem = ItemsToBuy[1];

    npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );   

	--Buying the items
    if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )         
    then
        npcBot:ActionImmediate_PurchaseItem ( sNextItem );
        table.remove( ItemsToBuy, 1 );
    end

end