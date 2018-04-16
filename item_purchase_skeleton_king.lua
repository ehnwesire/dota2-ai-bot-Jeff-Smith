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
    "item_flask",
    "item_stout_shield",
    "item_boots",
    "item_gloves",
    "item_belt_of_strength", -- power treads!
    "item_relic",
	"item_recipe_radiance", --"item_radiance"
    "item_mithril_hammer",
    "item_ogre_axe",
    "item_recipe_black_king_bar", --BKB
    "item_javelin",
    "item_javelin",
    "item_hyperstone", -- monkey king bar
    "item_gloves",
    "item_mithril_hammer",
    "item_recipe_maelstrom",
    "item_javelin",
    "item_belt_of_strength",
    "item_recipe_basher",
    "item_hyperstone",
    "item_recipe_mjollnir", --mjollnir
    "item_vitality_booster",
    "item_ring_of_health",
    "item_recipe_abyssal_blade",--abyssal blade
    "item_hyperstone",
    "item_hyperstone", --Moon shard! consumed.
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