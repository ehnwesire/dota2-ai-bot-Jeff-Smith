--------------------------------------------------------------------------------------------------------------------
-- item_purchase_abaddon.lua
-- Author: KingleeBotSmiths 
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com
--------------------------------------------------------------------------------------------------------------------

require( GetScriptDirectory().."/utility" ) 

local ItemsToBuy = 
{ 
      "item_tango"
      "item_stout_shield"
      "item_boots"
      "item_phase_boots"
      "item_hand_of_midas"
      "item_ radiance"
      "item_ octarine_core"
      "item_ shivas_guard"
      "item_solar_crest"
      "item_ultimate_specter"
      "item_moon_shard" --how to make bot consume it?
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

function SellExtraItem() --let’s sell the redundant stuffs
      if ( GameTime () > 15*60 )
      then 
         SellSpecifiedItem ( "item_stout_shield" )
         SellSpecifiedItem ( "item_tango" )
      end

      elseif (PurchaseResult==PURCHASE_ITEM_OUT_OF_STOCK
      then
         SellSpecifiedItem ( "item_stout_shield" )
         SellSpecifiedItem ( "item_tango" )
         SellSpecifiedItem ( "item_hand_of_midas" )
      end
  end