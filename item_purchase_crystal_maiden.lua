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
    "item_energy_booster", --arcane boots
    "item_shadow_amulet",
    "item_cloak", -- glimmer cape
    "item_ring_of_regen",
    "item_branches",
    "item_recipe_headdress",
    "item_chainmail",
    "item_branches",
    "item_recipe_buckler", -- get buckler
    "item_recipe_mekansm",
    "item_energy_booster",
    "item_void_stone",
    "item_recipe_aether_lens",
    "item_staff_of_wizardry",
    "item_wind_lace",
    "item_void_stone",
    "item_recipe_cyclone",
    "item_recipe_guardian_greaves",
    "item_chainmail",
    "item_sobi_mask",
    "item_blight_stone", -- problematic!
    "item_talisman_of_evasion", --solar crest
    "item_staff_of_wizardry",
    "item_circlet",
    "item_gauntlets",
    "item_recipe_racer",
    "item_circlet",
    "item_gauntlets",
    "item_recipe_racer",
    "item_recipe_rod_of_atos",
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

--------------------------------------------------------------------------------------------------------------------

--[[
function SellExtraItem() --let’s sell the redundant stuffs
      if ( GameTime () > 10*60 ) -- N* 60s
      then 
         SellSpecifiedItem ( "item_clarity" )
         SellSpecifiedItem ( "item_tango" )
      end

     --elseif (PurchaseResult==PURCHASE_ITEM_OUT_OF_STOCK -- The Current build does not have extra items to sell.
      --then
         --SellSpecifiedItem ( "item_stout_shield" )
         --SellSpecifiedItem ( "item_tango" )
      --end
  end
 ]]--