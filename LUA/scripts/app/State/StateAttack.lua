local State = require("app.State.State")
local  StateAttack = class("StateAttack",State)

function StateAttack:ctor()
	-- body
end

function StateAttack:OnEnter(entity)
	-- body
	print("attack");
	entity.curState = StateEvent.attack;
end

function StateAttack:OnExit()
	-- body
end

function StateAttack:Process(entity,...)
	-- body
	print("playerAttack");
	entity:playAttack();
end

return StateAttack;

