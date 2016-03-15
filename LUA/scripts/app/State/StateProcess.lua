local StateStand = require("app.State.StateIdle");
local StateWalk = require("app.State.StateWalk");
local StateAttack = require("app.State.StateAttack");
local StateSkill = require("app.State.StateSkill");
local StateHurt = require("app.State.StateHurt");
local StateDead = require("app.State.StateDead");

local StateProcess  = class("StateProcess")

function StateProcess:ctor()
	-- body
	self.fsmTable = {};
	--self.curState = StateEvent.none;

	self.fsmTable[StateEvent.stand] = StateStand.new();
	self.fsmTable[StateEvent.walk] = StateWalk.new();
	self.fsmTable[StateEvent.attack] = StateAttack.new();
	self.fsmTable[StateEvent.skill] = StateSkill.new();
	self.fsmTable[StateEvent.hurt] = StateHurt.new();
	self.fsmTable[StateEvent.die] = StateDead.new();
end

function StateProcess:ChangeStatus(entity,event,...)
	-- body
	if entity.curState ~= nil and entity.curState ~= StateEvent.none then
		--todo
		print("call event"..entity.curState);	
		self.fsmTable[entity.curState]:OnExit();
		self.fsmTable[event]:OnEnter(entity);
		self.fsmTable[event]:Process(entity, ...)
	else
		self.fsmTable[event]:OnEnter(entity);
		self.fsmTable[event]:Process(entity, ...)
	end
end
return StateProcess;