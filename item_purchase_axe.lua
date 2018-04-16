----------------------------------------------------------------------------

local ItemsToBuy = 
{ 
	"item_stout_shield", --Do not sell it 
    "item_tango",
	"item_tango",
	"item_boots",
    "item_ring_of_regen",
    "item_wind_lace", --not sure if this code’s right.  We should get tranquil boots from here
    "item_blink",
    "item_broadsword",
    "item_chainmail",
    "item_robe", -- blade-mail 
    "item_vitality_booster",
    "item_ring_of_health", -- Vanguard
    "item_chainmail",
    "item_branches",
    "item_recipe_buckler", -- get buckler
    "item_recipe_crimson_guard", --use buckler and vanguard to get crimson guard
	"item_ring_of_health",
	"item_cloak",
	"item_ring_of_regen", -- get hood of defiance
    "item_ring_of_regen",
	"item_branches",
	"item_recipe_headdress", -- get headdress
	"item_recipe_pipe", -- pipe of insight
    "item_reaver",
    "item_vitality_booster",
    "item_vitality_booster", -- The Heart!
	"item_boots",--decombine tranquilboots if possible.
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