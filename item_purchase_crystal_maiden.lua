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
	"item_courier",
    "item_tango",
    "item_clarity",
    "item_boots",
    "item_ring_of_regen",
    "item_wind_lace", --get tranquil boots
    "item_shadow_amulet",
    "item_cloak", -- glimmer cape  
    "item_blink",
    "item_ogre_axe",
    "item_point_booster",
    "item_blade_of_alacrity",
    "item_staff_of_wizardry", --"item_ultimate_scepter"
    "item_staff_of_wizardry",
    "item_circlet",
    "item_gauntlets",
    "item_recipe_racer",
    "item_circlet",
    "item_gauntlets",
    "item_recipe_racer",
    "item_recipe_rod_of_atos",
	"item_ogre_axe",
	"item_mithril_hammer",
	"item_recipe_black_king_bar", -- black king bar
	"item_boots",--decombine tranquil if possible.
	"item_recipe_travel_boots",
	"item_recipe_travel_boots",-- level 2 boots of travel  replace tranquil boots
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

--[[
function SellExtraItem() --let’s sell the redundant stuffs
    if ( GameTime () > 10*60 ) -- N* 60s
    then 
        SellSpecifiedItem ( "item_clarity" )
        SellSpecifiedItem ( "item_tango" )
    end

    elseif (PurchaseResult==PURCHASE_ITEM_OUT_OF_STOCK -- The Current build does not have extra items to sell.
    then
        SellSpecifiedItem ( "item_stout_shield" )
        SellSpecifiedItem ( "item_tango" )
    end
end
--]]
 
--------------------------------------------------------------------------------------------------------------------
-- item_purchase_crystal_maiden.lua
-- Author: KingleeBotSmiths
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com
--------------------------------------------------------------------------------------------------------------------

--This item list comes from Dota Bot Smiths
local tableItemsToBuy = { 
	"item_courier",
    "item_tango",
    "item_clarity",
    "item_boots",
    "item_ring_of_regen",
    "item_wind_lace", --get tranquil boots
    "item_shadow_amulet",
    "item_cloak", -- glimmer cape  
    "item_blink",
    "item_ogre_axe",
    "item_point_booster",
    "item_blade_of_alacrity",
    "item_staff_of_wizardry", --"item_ultimate_scepter"
    "item_staff_of_wizardry",
    "item_circlet",
    "item_gauntlets",
    "item_recipe_racer",
    "item_circlet",
    "item_gauntlets",
    "item_recipe_racer",
    "item_recipe_rod_of_atos",
	"item_ogre_axe",
	"item_mithril_hammer",
	"item_recipe_black_king_bar", -- black king bar
	"item_boots",--decombine tranquil if possible.
	"item_recipe_travel_boots",
	"item_recipe_travel_boots",-- level 2 boots of travel  replace tranquil boots
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