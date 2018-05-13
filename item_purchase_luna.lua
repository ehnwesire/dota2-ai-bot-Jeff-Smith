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

local tableItemsToBuy = { 
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
	"item_eagle", --replace Ring of Aquila
	"item_talisman_of_evasion",
	"item_quarterstaff", --butterfly
	"item_reaver",
	"item_lifesteal", -- Decombine Mask of Madness if possible.
	"item_claymore", -- satanic        and replace mask of madness if its still in storage.
	"item_slippers",         --decombine Ring of Aquila if possible x1
	"item_circlet",          --decombine Ring of Aquila if possible x2
	"item_recipe_wraith_band",--decombine Ring of Aquila if possible x3
	"item_staff_of_wizardry",
	"item_ring_of_health",
	"item_recipe_force_staff", -- hurrican pike
	};


----------------------------------------------------------------------------------------------------

function ItemPurchaseThink()

	local npcBot = GetBot();

	if ( #tableItemsToBuy == 0 )
	then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end

	local sNextItem = tableItemsToBuy[1];

	npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );

	if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
	then
		npcBot:ActionImmediate_PurchaseItem( sNextItem );
		table.remove( tableItemsToBuy, 1 );
	end

end

----------------------------------------------------------------------------------------------------