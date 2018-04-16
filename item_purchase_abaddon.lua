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