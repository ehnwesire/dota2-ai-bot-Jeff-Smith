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

utility.checkItemBuild(ItemsToBuy)

function ItemPurchaseThink()
	utility.ItemPurchase(ItemsToBuy)
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