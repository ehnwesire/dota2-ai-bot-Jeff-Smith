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

--Initializing an array as the return value; used in the itembuildfiles as the prefixof functions 
--The {} thing is associated with table. commands
local X = {}

--Changed to false for disabling adamqqq's random talent choice
local rand = false;

--FillTalenTable returns an array of the heroes' talents in the talent tree as strings 
--FIRST CONCLUSION: This returns the ability slots that are supoosed to be talents 
function X.FillTalenTable(npcBot)
	local talents = {};
	for i = 0, 23 
	do
		--API Reference: Gets a handle to ability in the specified slot. Slots range from 0 to 23.
		local ability = npcBot:GetAbilityInSlot(i);
		--Still need to specify the use of ~=
		--Supposing that ability ~= nil is TRUE. 
		--IsTalent: Returns a bool value of whether if the ability is a talent
		--IsTalent is not recorded in the official API but was found in another API
		if ability ~= nil and ability:IsTalent() 
		then
			--What does ability:GetName() return?
			--Returns a string of the hero's ability name
			--In talents 
			table.insert(talents, ability:GetName());
		end
	end
	return talents;
end

function X.FillSkillTable(npcBot, slots)
	local skills = {};
	--for in pairs examines the whole table by some sort of random order
	--local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));
	--GetSlotPattern is assigned 0 1 2 3, so this gets the four abilities in the hero's four ability slots
	--this should be in the chronological order becaus 
	for _,slot in pairs(slots)
	do
		table.insert(skills, npcBot:GetAbilityInSlot(slot):GetName());
		--returns the four ability names as an array of 4 strings
	end
	return skills;
end

function X.GetSlotPattern(nPattern)
	--Returning the slot patterns of certain herores. 
	--Different values of the nPattern are for the heroes' different slot patterns 
	--Some examples would be meepo, invoker, elder titan, ember spritit
	--For specifications search all files of adamqqq's bot
	--Jeff Smith will temporarily take nPattern 1 to use because the 5 heroes
	--have the same type of slotpattern (ab, ab, ab, ult)
	--what's cool about the numbering convention here is 
	--array's COUNTINGS start with [1], like in GetBuildPattern we are using 
	--skills[s[1]], with s[1] indicating a 1, which equals to skills[1]
	--but when the measurements, or COUNTINGS, are actually done WITHIN the game 
	--the code starts to use 0 as the start.
	--SO the point here is that one number in an array could have 2 meanings
	--beased on its position and value, and that has been why these lines of codes
	--could be pretty hard for the Smiths to understand. 
	--Suppose that nPattern 2-9 are negligable, because the 5 heores all use
	--nPattern = 1 
	if ( nPattern == 1 ) 
	then
		return {0,1,2,3};
	end
end

--status is an indication of the hero type. by all means we will not really have 
--any meepos or invokers in our bot so we deleted the part where it says 
--status = "meepo" or "invoker"
--s: the array of 1,2,3,4,1,1,1,1,4,4,5,5,5, like this 
--s declares how the bot levels up abilities by returning values of 1-4 when called
--MARK: The numbering convention issue shows up when i suppose that it returns 0-3
--skills: returns the four ability names as an array of 4 strings
--t: the array of {1,4,5,7} that indicates how the hero wants to 
--level up its abilities
--talents: returns all talents on the talent tree as an array of 8 strings
--the point of the code is that while reading, developers should take account
--of what the 5 parameters indicate and their forms as arrays of integers or strings
--starting with s[1], since the array's first value, or element is a 1, thus it would
--return the value of 1 back when its called. so the parameter becomes skills[1] now.
--skills[1], then, returns the name of the corresponding hero's ability as a string.
--the same methos applies for talents also.
--Selecting the talents randomly might help because Dota2 is an unpredictable game
--when the hero doesn't have an ability point take "-1", as as a string, like the other
--parameters, into the array.
--the whole function works by a returning a final value of an array made up of 
--each ability(strings) to level up at each level in chronological order  
--when theres a talent available then the talent strings would take place instead.
--OK, that's basically it

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