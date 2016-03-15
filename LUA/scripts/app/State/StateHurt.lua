local State = require("app.State.State")
local  StateHurt = class("StateHurt",State)

function StateHurt:ctor()
	-- body
end

function StateHurt:OnEnter(entity)
	-- body
	entity.curState = StateEvent.hurt;
end

function StateHurt:OnExit()
	-- body
end

function StateHurt:Process(entity,...)
	-- body
	entity:playHurt();
end

return StateHurt;

