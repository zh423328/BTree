local State = require("app.State.State")
local  StateWalk = class("StateWalk",State)

function StateWalk:ctor()
	-- body
end

function StateWalk:OnEnter(entity)
	-- body
	entity.curState= StateEvent.walk;
end

function StateWalk:OnExit()
	-- body
end

function StateWalk:Process(entity,...)
	-- body
	entity:playWalk();
end

return StateWalk;

