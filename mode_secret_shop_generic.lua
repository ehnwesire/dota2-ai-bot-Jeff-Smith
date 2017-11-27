function GetDesire () 

	local npcBpt = GetBot (); 
	
	local desire = 0.0; 
	
	if ( npcBot:IsUsingAbility() or npcBot:IsChanneling() )
	then
		return 0;
	end
	
	if ( npcBot.secretShopMode == true and npcBot:GetGold () >= npcBot:GetNextItemPurchaseValue())
	then
		if ( npcBot:DistanceFromSecretShop() < 2000()) 
		then	
			desire = (2000-npcBot:DistanceFromSecretShop)/npcBot:DistanceFromSecretShop*0.3+0.3; 
		end
		
		else
			npcBot.secretShopMode = false; 
		end
		
		return desire; 
end
	
function Think () 

	local npcBot = GetBot(); 
	
	local secretShop1 = GetShopLocation( GetTeam(), SHOP_SECRET ); 
	local secretShop2 = GetShopLocation( GetTeam(), SHOP_SECRET2 ); 
	
	if ( GetUnitToLocationDistance(npcBot, secretShop1) <= GetUnitToLocationDistance(npcBot, secretShop2); 
	then 
		npcBot:Action_MoveToLocation (secretShop1); 
	else
		npcBot:Action_MoveToLocation (secretShop2);
	end
end