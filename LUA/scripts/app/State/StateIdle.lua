local State = require("app.State.State")
local  StateStand = class("StateStand",State)

function StateStand:ctor()
	-- body
end

function StateStand:OnEnter(entity)
	-- body
	entity.curState  = StateEvent.stand;
end

function StateStand:OnExit()
	-- body
end

function StateStand:Process(entity,...)
	-- body
	entity:playStand();
end

return StateStand;

