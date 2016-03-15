--
-- Author: Your Name
-- Date: 2016-03-07 22:15:33
--
AIMgr = {};
local this = AIMgr;

StateEvent = {};
StateEvent.none = 0;
StateEvent.stand = 1;
StateEvent.walk = 2;
StateEvent.run = 3;
StateEvent.attack = 4;
StateEvent.skill = 5;
StateEvent.hurt = 6;
StateEvent.die = 7;

Direction = {};
Direction.left_to_right = 1;
Direction.right_to_left = 2;


AIFightState = {};
AIFightState.Start = 1;
AIFightState.Stop = 2;

function AIMgr.initData()
	-- body
	AIMgr.AiRoots = {};

	for k,v in pairs(role) do
		local s = "app.BT.BT"..v.ai;
		AIMgr.AiRoots[k] = require(s);
	end
end

--计算伤害--
function AIMgr.getAi(idx)
	-- body
	return AIMgr.AiRoots[idx];
end

function AIMgr.GetTickCount()
	-- body
	return os.clock()*1000;
end