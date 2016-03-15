local  State = class("State")

function State:ctor()
	-- body
end

function State:OnEnter(entity)
	-- body
	entity.curState = StateEvent.none;
end

function State:OnExit()
	-- body
end

function State:Process(entity,...)
	-- body
end

return State;

