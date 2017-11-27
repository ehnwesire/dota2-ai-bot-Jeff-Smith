

local tableItemsToBuy = { 
				"item_courier",
				"item_tango",
				"item_boots",
				"item_clarity",
				"item_arcane_boots",
				"item_glimmer_cape",
				"item_mekansm",
				"item_medallion_of_courage",
				--"item_hand_of_midas", --optional for now 
				"item_blink", --optional
				"item_aether_lens",
				"item_cyclone",
				"item_guardian_greaves",
				"item_solar_crest",
				"item_rod_of_atos",
				--"item_force_staff", --optional 
			};


----------------------------------------------------------------------------------------------------

function ItemPurchaseThink()

	local npcBot = GetBot();

	if ( #tableItemsToBuy == 0 )
	then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end
--wehn the list of items are all purchased
	local sNextItem = tableItemsToBuy[1];

	npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );

	if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
	then
		npcBot:ActionImmediate_PurchaseItem( sNextItem );
		table.remove( tableItemsToBuy, 1 );
	end

end

----------------------------------------------------------------------------------------------------
