----------------------------------------------------------------------------

local ItemsToBuy = 
{ 
	"item_courier"
       "item_tango"
       "item_boots"
       "item_clarity"
       "item_arcane_boots"
       "item_glimmer_cape"
       "item_mekansm"
       "item_medallion_of_courage"
       --"item_hand_of_midas" (Optional) i will see how I get on with coding this item.
       "item_aether_lens"
       "item_cyclone"
       "item_guardian_greaves"
       "item_solar_crest"
       "item_rod_of_atos"
       --"item_force_staff" (Optional)same reason as the above.
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

----------------------------------------------------------------------------
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