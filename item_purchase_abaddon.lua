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
    "item_stout_shield",
    "item_boots",
    "item_blades_of_attack",
	"item_blades_of_attack", --"item_phase_boots"
    "item_gloves",
	"item_recipe_hand_of_midas", --"item_hand_of_midas"
    "item_relic",
	"item_recipe_radiance", --"item_radiance"
	"item_vitality_booster", 
	"item_point_booster",
	"item_energy_booster", --"item_octarine_core"
    "item_mystic_staff",
	"item_platemail",
	"item_recipe_shivas_guard", --"item_shivas_guard",
    "item_chainmail",
    "item_sobi_mask",
    "item_blight_stone", --"item_medallion_of_courage",
    "item_talisman_of_evasion", --"item_solar_crest",
    "item_ogre_axe",
    "item_point_booster",
    "item_blade_of_alacrity",
    "item_staff_of_wizardry", --"item_ultimate_scepter"
    "item_hyperstone",
    "item_hyperstone", --"item_moon shard" consumable
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