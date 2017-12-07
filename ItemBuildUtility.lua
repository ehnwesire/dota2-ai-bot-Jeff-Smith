----------------------------------------------------------------------------------------------------
-- The script was taken from adamqqq's Ranked Matchmaking AI Bot
-- The KingleeBotSmiths certify that they didn't create this work
-- ItemBuildUtility.lua 
-- Used by KingleeBotSmiths
-- Smith Trey Email: benjtrey@163.com
-- Smith Eric Email: looking4eric@outlook.com 
-- Smith Jerry Email: j1059244837@icloud.com
----------------------------------------------------------------------------------------------------
--	Ranked Matchmaking AI v1.0a
--	Author: adamqqq		Email:adamqqq@163.com
----------------------------------------------------------------------------------------------------

--initializing an array? or array list?
--the {} thing is associated with "table"
local X = {}

--Change to false to disable random talent choice
local rand = false;

--calls the npcBot and what is "fill talent table"?
--CONCLUSION: This returns the ability slots that are supoosed to be talents 
function X.FillTalenTable(npcBot)
	local talents = {};
	--why is this 0, 23? 1 + 23 = 25 is fair enough
	for i = 0, 23 
	do
		--API: Gets a handle to ability in the specified slot. Slots range from 0 to 23.
		local ability = npcBot:GetAbilityInSlot(i);
		--still need to specify the use of ~= 
		if ability ~= nil and ability:IsTalent() 
		then
			--what does ability:GetName() return?
			table.insert(talents, ability:GetName());
		end
	end
	return talents;
end

function X.FillSkillTable(npcBot, slots)
	local skills = {};
	for _,slot in pairs(slots)
	do
		table.insert(skills, npcBot:GetAbilityInSlot(slot):GetName());
		--returns the four ability names as an array of 4 strings
	end
	return skills;
end

function X.GetSlotPattern(nPattern)
	if nPattern == 1 then
		return {0,1,2,3};
	elseif  nPattern == 2 then
		return {0,1,3,4};
	elseif  nPattern == 3 then
		return {0,1,2,5};	
	elseif  nPattern == 4 then
		return {0,1,2,4};
	elseif  nPattern == 5 then
		return {0,1,2};	
	elseif  nPattern == 6 then
		return {0,1,4,7};		
	elseif  nPattern == 7 then
		return {0,3,4,5};	
	elseif  nPattern == 8 then
		return {0,2,3,6};	
	elseif  nPattern == 9 then
		return {0,1,3,8};		
	end
end

--s is the array of 1,2,3,4,1,1,1,1,4,4,5,5,5, like this 
--skills: returns the four ability names as an array of 4 strings
function X.GetBuildPattern(status, s, skills, t, talents)
	if status == "normal" 
	then
		if rand then
			return {
				skills[s[1]],    skills[s[2]],    skills[s[3]],    skills[s[4]],    skills[s[5]],
				skills[s[6]],    skills[s[7]],    skills[s[8]],    skills[s[9]],    talents[RandomInt(1,2)],
				skills[s[10]],   skills[s[11]],   skills[s[12]],   skills[s[13]],   talents[RandomInt(3,4)],
				skills[s[14]],    	"-1",      	  skills[s[15]],    	"-1",   	talents[RandomInt(5,6)],
					"-1",   		"-1",   		"-1",       		"-1",       talents[RandomInt(7,8)]
			}
		--The part that is supposed to work because we have disabled the random selection
		else
			return {
				skills[s[1]],    skills[s[2]],    skills[s[3]],    skills[s[4]],    skills[s[5]],
				skills[s[6]],    skills[s[7]],    skills[s[8]],    skills[s[9]],    talents[t[1]],
				skills[s[10]],   skills[s[11]],   skills[s[12]],   skills[s[13]],   talents[t[2]],
				skills[s[14]],    	"-1",      	  skills[s[15]],    	"-1",   	talents[t[3]],
					"-1",   		"-1",   		"-1",       		"-1",       talents[t[4]]
			}
		end
	end
end

return X;