----------------------------------------------------------------------------

local ItemsToBuy = 
{ 
	"item_tango"
	"item_stout_shield"
    "item_tango"
    "item_tango"
    "item_boots"
    "item_tranquil_boots"
    "item_blink"
    "item_blade_mail"
    "item_crimson_guard"
    "item_shivas_guard"
    "item_heart"
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
        npcBot:Action_PurchaseItem( sNextItem ); 
        table.remove( ItemsToBuy, 1 );
    end

end

----------------------------------------------------------------------------
--[[
function SellExtraItem() --let’s sell the redundant stuffs
      if ( GameTime () > 10*60 )
      then 
         SellSpecifiedItem ( "item_stout_shield" )
         SellSpecifiedItem ( "item_tango" )
      end

      elseif (PurchaseResult==PURCHASE_ITEM_OUT_OF_STOCK
      then
         SellSpecifiedItem ( "item_stout_shield" )
         SellSpecifiedItem ( "item_tango" )
      end
  end
----------------------------------------------------------------------------
  -- Damn! From now on, it’s all the code for mode_secret_shop_generic.lua I think. But not a waste let’s save these codes because I’m not 100% sure if all the codes below belong to that lua, function Think() --Let’s define the rule of buying stuffs. 

      -- local npcBot = GetBot();
      -- local sShopLocation1 = GetShopLocation( GetTeam(), SHOP_SECRET );
     -- local sShopLocation2 = GetShopLocation( GetTeam(), SHOP_SECRET2 );
    --  local c = GetCourier(0);
     -- local PurchaseResult;

-- if ( npcBot.secretShopMode == true) and npcBot:GetGold() >= npcBot:GetNextItemPurchaseValue() )
-- then
      -- if ( GetUnitToLocationDistance( npcBot, sShopLocation1 ) <= GetUnitToLocationDistance( npcBot, sShopLocation2 )
      -- then
              npcBot:Action_MoveToLocation( sShopLocation1 )
      -- else
              npcBot:Action_MoveToLocation( sShopLocation2 )
      end
end

-- if (npcBot.secretShopMode == true) --If Bot need to buy things from sShop, if it’s close to the shop go buy stuffs, if the courier is close to the shop let courier buy it.
-- then 
          -- if (npcBot:DistanceFromSecretShop() <= 200)
          -- then PurchaseResult=npcBot:ActionImmediate_PurchaseItem( sNextItem )
end
      -- else
         -- if (c:DistanceFromSecretShop() <= 200) --The courier is arrived at sShop.
         -- then PurchaseResult=GetCourier(0):ActionImmediate_PurchaseItem( sNextItem )
       end
end
 ----------------------------------------------------------------------------
]]--