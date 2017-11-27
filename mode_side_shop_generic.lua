function GetDesire () 

	local npcBpt = GetBot (); 
	
	local desire = 0.0; 
	
	if ( npcBot:IsUsingAbility() or npcBot:IsChanneling())
	then
		return 0
	end
	
	if ( npcBot.sideShopMode == true and npcBot:GetGold () >= npcBot:GetNextItemPurchaseValue())
	then
		if ( npcBot:DistanceFromSideShop() < 2000()) 
		then	
			desire = (2000-npcBot:DistanceFromSideShop)/npcBot:DistanceFromSideShop*0.3+0.3; 
		end
		
		else
			npcBot.sideShopMode = false; 
		end
		
		return desire; 
end
	
function Think () 

	local npcBot = GetBot(); 
	
	local sideShop1 = GetShopLocation( GetTeam(), SHOP_SIDE ); 
	local sideShop2 = GetShopLocation( GetTeam(), SHOP_SIDE2 ); 
	
	if ( GetUnitToLocationDistance(npcBot, sideShop1) <= GetUnitToLocationDistance(npcBot, sideShop2); 
	then 
		npcBot:Action_MoveToLocation (sideShop1); 
	else
		npcBot:Action_MoveToLocation (sideShop2);
	end
end