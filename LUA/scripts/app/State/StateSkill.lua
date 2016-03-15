local State = require("app.State.State")
local  StateSkill = class("StateSkill",State)

function StateSkill:ctor()
	-- body
end

function StateSkill:OnEnter(entity)
	-- body
	entity.curState = StateEvent.skill;
end

function StateSkill:OnExit()
	-- body
end

function StateSkill:Process(entity,...)
	-- body
	entity:playSkill();
end

return StateSkill;

