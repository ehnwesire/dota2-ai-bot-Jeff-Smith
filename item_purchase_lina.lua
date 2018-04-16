--------------------------------------------------------------------------------------------------------------------
-- item_purchase_abaddon.lua
-- Author: KingleeBotSmiths 
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com
--------------------------------------------------------------------------------------------------------------------

local ItemsToBuy = 
{ 
	"item_faerie_fire",
	"item_circlet",
	"item_mantle",
	"item_recipe_null_talisman",-- nil Talisman
    "item_boots",
    "item_blades_of_attack",
	"item_blades_of_attack", --"item_phase_boots"
	"item_shadow_amulet",
	"item_claymore", --shadow blade
	"item_ring_of_health",
	"item_void_stone",
	"item_vitality_booster",			
	"item_point_booster",
	"item_energy_booster",--bloodstone
	"item_blight_stone",
	"item_mithril_hammer",
	"item_mithril_hammer",--desolator
    "item_gloves",
    "item_mithril_hammer",
    "item_recipe_maelstrom",
    "item_hyperstone",
    "item_recipe_mjollnir", --mjollnir
    "item_javelin",
    "item_javelin",
    "item_hyperstone", -- monkey king bar
	"item_ultimate_orb",|
	"item_recipe_silver_edge", --Shadow blade converted into Silver Edge
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