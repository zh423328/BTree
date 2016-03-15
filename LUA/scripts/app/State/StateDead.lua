local State = require("app.State.State")
local  StateDead = class("StateDead",State)

function StateDead:ctor()
	-- body
end

function StateDead:OnEnter(entity)
	-- body
	entity.curState = StateEvent.die;
end

function StateDead:OnExit()
	-- body
end

function StateDead:Process(entity,...)
	-- body
	entity:playDie();
end

return StateDead;

