local StateProcess = require("app.State.StateProcess");
local HpProgress = require("app.Entity.HpProgress");

local Entity = class("Entity", function()
	-- body
	return display.newNode();
end)

function Entity:ctor(modelidx,x,y,direction)
	-- body
	self.modelidx = modelidx;
	self.idx = CalcMgr.Gen();
	self.direction = direction;
	self.attackidx = -1;
	self.attackcomplete = true;
	self.ismoveing = false;
	self.ismoveToTarget = false;
	self.moveTarget = nil;
	self.movePoint = nil;
	self.isAuto = false;
	self.lastthink = 0;

	self.fsm = StateProcess.new();
	self:initAtr();
	self:initModel(x,y);
	
	self.skillColDown={};

	self.fightState = AIFightState.Stop;
	self.bHit = false;

	--数据保存--
	self.blackBoard = NF.AI.BlackBoard:new()


	--节点事件--
	self:addNodeEventListener(cc.NODE_EVENT,function(event)
		-- body
		if event.name == "enter" then
			--todo
			self:onEnter();
		elseif event.name == "exit" then
			self:onExit();
		end
	end)
end

function Entity:onEnter()
		--帧事件--
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,function(dt)
		-- body
		self:update(dt);
	end)

	self:scheduleUpdate();

    self.think=scheduler.scheduleGlobal(function(dt)
		-- body
		self:updateThink(dt)
    end, 0.1);


end

function Entity:onExit()
	-- body
	self:unscheduleUpdate();
	scheduler.unscheduleGlobal(self.think);
	scheduler.unscheduleGlobal(self.blackBoard.timeoutId);
end

function Entity:updateThink(dt)
	-- body
	self:Think(NF.AI.AIEvent.AvatarPosSync);
end


--帧事件--
function Entity:update(dt)
	if self.ismoving then
		--todo
		local px = self.atr.speed*dt;
		if self.direction == Direction.right_to_left then
			--todo
			px = -px;
		end
		self:ChangeStatus(StateEvent.walk);

		local pt = self:getPositionX() + px;

		self:setPosition(ccp(pt,self:getPositionY()));
	end

	--移动目标
	if self.ismoveToTarget then
		--todo
		local ptX = -100000;
		if self.moveTarget then
			--todo
			ptX = self.moveTarget:getPositionX();
		elseif self.movePoint.x ~= 0 and self.movePoint.y ~= 0 then

		else
			return;
		end

		if ptX > self:getPositionX() then
				--todo
			self:ChangeDirection(Direction.left_to_right);
		else
			self:ChangeDirection(Direction.right_to_left);
		end

		local px = self.atr.speed*dt;
		if self.direction == Direction.right_to_left then
			--todo
			px = -px;
		end

		local dis = math.abs(self:getPositionX()-ptX);
		if  dis < self:getAttackDis() then
			--todo
			self:StopMove();
			self:MoveEnd();
			return;
		end

		self:ChangeStatus(StateEvent.walk);

		local pt = self:getPositionX() + px;

		self:setPosition(ccp(pt,self:getPositionY()));

	end
end

function Entity:initModel(x,y)
	-- body
	self:AddAnimationList(StateEvent.stand);
	self.model = display.newSprite(string.format("#%d_stand_0000.png",self.modelidx));
	self:addChild(self.model);
	self.model:setAnchorPoint(ccp(x,y));
	self:ChangeDirection(self.direction);

	---添加shadow
	local shadow = display.newSprite("fight/shadow.png");
	self:addChild(shadow,-1);

	--添加血条
	self.hp = HpProgress.new("ui/hp1.png","ui/hp2.png","ui/hp3.png",self);
	--self.hp.entity = self;
	local pt = self.model:getAnchorPointInPoints();
	self.hp:setPosition(ccp(pt.x,pt.y+self.atr.height));
	self.model:addChild(self.hp);

	self:ChangeStatus(StateEvent.stand);
end

function Entity:ChangeStatus(event)
	if self.curState == StateEvent.die then
		--todo
		return;
	end

	if self.curState == event and event ~= StateEvent.attack then
		--todo
		return;
	end

	if (self.curState == StateEvent.attack or self.curState == StateEvent.skill) and event == StateEvent.hurt then
		--todo
		return;
	end

	self.fsm:ChangeStatus(self,event);
end
--属性--
function Entity:initAtr()
	self.atr = role[self.modelidx];
	self.atr.hpmax = self.atr.hp;
end
function Entity:ChangeDirection(direction)
	-- body
	self.direction = direction;
		--根据朝向翻转
	if self.direction == Direction.left_to_right then
		self.model:setFlipX(false);
	else
		self.model:setFlipX(true);
	end
end

function Entity:AddAnimationList(event,idx)
	-- body
	if event == StateEvent.stand then
		--todo
		display.addSpriteFramesWithFile(string.format("model/%d/%d_stand.plist",self.modelidx,self.modelidx),string.format("model/%d/%d_stand.png",self.modelidx,self.modelidx));
	elseif event == StateEvent.walk then
		--todo
		display.addSpriteFramesWithFile(string.format("model/%d/%d_run.plist",self.modelidx,self.modelidx),string.format("model/%d/%d_run.png",self.modelidx,self.modelidx));
	elseif event == StateEvent.hurt then
		--todo
		display.addSpriteFramesWithFile(string.format("model/%d/%d_hurt.plist",self.modelidx,self.modelidx),string.format("model/%d/%d_hurt.png",self.modelidx,self.modelidx));
	elseif event == StateEvent.die then
		--todo
		display.addSpriteFramesWithFile(string.format("model/%d/%d_die.plist",self.modelidx,self.modelidx),string.format("model/%d/%d_die.png",self.modelidx,self.modelidx));
	elseif event == StateEvent.skill then
		--todo
		display.addSpriteFramesWithFile(string.format("model/%d/%d_skill.plist",self.modelidx,self.modelidx),string.format("model/%d/%d_skill.png",self.modelidx,self.modelidx));
	elseif event == StateEvent.attack then
		--todo
		if idx ~= 0 then
			--todo
			display.addSpriteFramesWithFile(string.format("model/%d/%d_attack_%d.plist",self.modelidx,self.modelidx,idx),string.format("model/%d/%d_attack_%d.png",self.modelidx,self.modelidx,idx));
		else
			display.addSpriteFramesWithFile(string.format("model/%d/%d_attack.plist",self.modelidx,self.modelidx),string.format("model/%d/%d_attack.png",self.modelidx,self.modelidx));
		end
		
	end
end

function Entity:getAction(event,idx)
	-- body
	if event == StateEvent.stand then
		return "stand";
	elseif event == StateEvent.walk then
		return "run";
	elseif event == StateEvent.hurt then
		--todo
		return "hurt";
	elseif event == StateEvent.die then
		return "die";
	elseif event == StateEvent.skill then
		return "skill";
	elseif event == StateEvent.attack then
		--todo
		if idx ~= 0 then
			--todo
			return string.format("attack_%d",idx);
		else
			return "attack"
		end
		
	end
end
function Entity:getAnimate(event,idx,duration)
	-- body
	local anmation = AnimationMgr.getModelAnimation(self.modelidx,self:getAction(event,idx),duration,0,30);

	return CCAnimate:create(anmation);
end

function Entity:playStand()
	if self.model then
		--todo
		self:stopAllActions();
		self.model:stopAllActions();
		local action = CCRepeatForever:create(self:getAnimate(StateEvent.stand,0,0.1));

		self.model:runAction(action);
	end
end

---行走--
function Entity:playWalk()
	-- body
	if self.model then
		--todo
		self:stopAllActions();
		self.model:stopAllActions();
		local action = CCRepeatForever:create(self:getAnimate(StateEvent.walk,0,0.1));

		self.model:runAction(action);
	end
end

--死亡--
function Entity:playDie()
	-- body
	if self.model then
		--todo
		self:stopAllActions();
		self.model:stopAllActions();
		local action = self:getAnimate(StateEvent.stand,0,0.1);

		local array = CCArray:create();
		array:addObject(action);
		array:addObject(CCFadeOut:create(0.5));
		array:addObject(cc.CallFunc:create(function()
			-- body
			CurFightScene:removeEntity(self);
			self:removeFromParentAndCleanup(true);
		end))

		local  seq = CCSequence:create(array);
		self.model:runAction(seq);

		local duration = action:getDuration()/2;
		--后退--
		if self.direction == Direction.left_to_right then
			--todo
			local move = CCMoveBy:create(duration, ccp(-100,0));
			self.model:runAction(move);
		else
			local move = CCMoveBy:create(duration, ccp(100,0));
			self.model:runAction(move);
		end
	end
end

function Entity:playHurt()
	-- body
	if self.model then
		--todo
		self:stopAllActions();
		self.model:stopAllActions();
		local action = self:getAnimate(StateEvent.hurt,0,0.1);

		local  seq = CCSequence:createWithTwoActions(action,cc.CallFunc:create(function()
			-- body
			self.bHit = false;
			self:ChangeStatus(StateEvent.stand);
		end));
		self.model:runAction(seq);
		self.bHit = true;
	end
end

function Entity:playBlood(damage)
    local animation = AnimationMgr.getCommonAnimation("fight/blood.plist", "fight/blood.png","blood",0.07);
    local blood = display.newSprite("#blood_0000.png");
  	local action = CCSequence:createWithTwoActions(CCAnimate:create(animation),cc.CallFuncN:create(function(node)
  		-- body
  		node:removeFromParent();
  	end));

    blood:runAction(action);
    self:addChild(blood);
    blood:setPosition(ccp(0, 100));

    local damageLabel = ui.newBMFontLabel({text = tostring(damage),font = "fnt/fnt-lianji.fnt"});
    damageLabel:setPosition(ccp(0,200));
    damageLabel:setScale(0.5);

	self:addChild(damageLabel);
	local jumpby = CCJumpBy:create(0.7, ccp(math.random(0,60)-30,-100), 50, 1);
	local seq2 = CCSequence:createWithTwoActions(jumpby,cc.CallFuncN:create(function(node)
  		-- body
  		node:removeFromParent();
  	end)); 

	local fadeout = CCFadeOut:create(0.7);

	local spawn = CCSpawn:createWithTwoActions(seq2, fadeout);
   damageLabel:runAction(spawn);
end


function Entity:playAttack()
	if self.curState == StateEvent.attack then
		--todo
		if self.attackcomplete then
			--todo
			self.attackidx = self.attackidx + 1;

			if self.attackidx > 5 then
				--todo
				self.attackidx = 0;
			end
		else
			return;
		end
	else
		self.attackidx = 0;
	end	
--开始--
	self.attackcomplete = false;

	local action = self:getAnimate(StateEvent.attack,self.attackidx,0.1);

	if self.model then
		--todo
		self:stopAllActions();
		self.model:stopAllActions();
		self.model:runAction(CCSequence:createWithTwoActions(action,cc.CallFunc:create(function()
			self:ChangeStatus(StateEvent.stand);
		end)))

		local duration = action:getDuration();
		--延时--
		scheduler.performWithDelayGlobal(function()
			-- body
			--播放音效--
			SoundManager.PlayAttackMusic();

			--是否有怪物受攻击--
			--受击--
			self:AttackEnemy();
		end, duration/2);

		--
		scheduler.performWithDelayGlobal(function()
			-- body
			self.attackcomplete = true;
		end, duration-0.1)

		self.skillColDown[1] = AIMgr.GetTickCount()+100;
	end

end

function Entity:AttackEnemy()
	-- body
	local  attackrect = self:getAttackRect();

	local  attackTable = {};

	if self.blackBoard.enemyId == nil then
		--todo
		for k,v in pairs(CurFightScene.Entitys) do
			if v.idx ~= self.idx then
				--todo
				--local hurtRect =  v:getHurtRect();
				local dis = math.abs(self:getPositionX()-v:getPositionX());
				--相交
				-- if attackrect:intersectsRect(hurtRect) then
				-- 	--todo
				-- 	table.insert(attackTable,v);

				if dis < self:getAttackDis() then
					--todo
					table.insert(attackTable,v);
				end
			end
		end
	else
		local enemy = CurFightScene.Entitys[self.blackBoard.enemyId];
		if enemy then
			--todo
			table.insert(attackTable,enemy);
		end
	end


	for k,v in pairs(attackTable) do
		if v then
			local damage = CalcMgr.calDamage(self,v);
			v:FlootBlood(self,damage); 
		end
	end

	if #attackTable >= 1 then
		--todo
		local target = attackTable[1];
		self:FaceToEntity(target);
	end
end

function Entity:getAttackDis()
	-- body
	return 130;
end

function Entity:getAttackRect()
	-- body
	local size = cc.SizeMake(self.atr.AttackX,self.atr.AttackY);

	if self.direction == Direction.right_to_left then
        return cc.RectMake(self:getPositionX()-size.width,self:getPositionY()-size.height/2,size.width,size.height);
    else
        return cc.RectMake(self:getPositionX(), self:getPositionY() - size.height / 2, size.width, size.height);
    end
end

function Entity:getHurtRect()
	-- body
	local size = cc.SizeMake(self.atr.SizeX,self.atr.SizeY);

	return cc.RectMake(self:getPositionX() - size.width/2, self:getPositionY() - size.height / 2, size.width, size.height);
end

function Entity:FlootBlood(entity,damage)
	-- body
	damage = math.ceil(damage);
	if self.atr.hp < damage then
		--todo
		damage = self.atr.hp;
	end

	self.atr.hp = self.atr.hp - damage;

	self.blackBoard[entity.idx] = entity.idx;

	--self:FaceToEntity(entity);

	if self.atr.hp > 0 then
		--todo
		self:ChangeStatus(StateEvent.hurt);
	else
		self:ChangeStatus(StateEvent.die);
	end

	self:playBlood(damage);
end

function Entity:playSkill()
	local action = self:getAnimate(StateEvent.skill,0,0.1);

	if self.model then
		--todo
		self:stopAllActions();
		self.model:stopAllActions();
		self.model:runAction(CCSequence:createWithTwoActions(action,cc.CallFunc:create(function()
			self:ChangeStatus(StateEvent.stand);
		end)))

		local duration = action:getDuration();

		--延时--
		self.model:performWithDelay(function()
			-- body
			--播放音效--
			local skill = math.random(1,4);
			SoundManager.PlaySkillManager(skill);

			--是否有怪物受攻击--
			--受击--
			self:AttackEnemy();
		end, duration/2);

		--print(duration);
		self.skillColDown[2] = AIMgr.GetTickCount()+duration*1000;
	end
end

--寻找最近一个玩家--
function Entity:getNearTarget()
	-- body
	local target = nil;
	local disPrev = 10000000000;
	local count = 0;
	for k,v in pairs(self.blackBoard.hatelist) do
		if CurFightScene.Entitys[v] and CurFightScene.Entitys[v].atr.hp > 0 then
			--todo
			target = CurFightScene.Entitys[v];
			break;
		end
	end

	if not target then
		--todo
		for k,v in pairs(CurFightScene.Entitys) do
			if v.idx ~= self.idx then
				--todo
				local dis = math.abs(self:getPositionX()-v:getPositionX());

				if dis < disPrev then
					--todo
					disPrev = dis;
					target = v;
				end
			end
		end
	end

	--优先攻击hatelist表--


	if target then
		--todo
		self.blackBoard.enemyId = target.idx;
	else
		self.blackBoard.enemyId = nil;
	end

	return target;
end

function Entity:moveToTarget(target)
	-- body
	print("call moveToTarget");
	self.ismoveToTarget = true;
	self.moveTarget = target;
	self.ismoving = false;
	self.movePoint = ccp(0,0);
end

function Entity:moveTo(x,y)
	-- body
	self.ismoveToTarget = true;
	self.moveTarget = nil;
	self.ismoving = false;
	self.movePoint = ccp(x,y);
end

function Entity:ProcInSkillCoolDown(skill)
	-- body
	if skill == 1  then
		--todo
		return true;
	end

	if not self.skillColDown[skill]  then
			--todo
      	self.skillColDown[skill] = 0;
		return true;
	end
	return  self.skillColDown[skill] < AIMgr.GetTickCount();
end

function Entity:getMovePointStraight(enemyEntity,range) 
	-- body
	if enemyEntity then
		--todo
		local dis = ccpSub(enemyEntity:getPositionInCCPoint(),self:getPositionInCCPoint());
		local add = ccpMult(dis, 0.8);

		return add.x + self:getPositionX(),add.y + self:getPositionY();
	end

	return;
	
end


function Entity:ProcChooseCastPoint(skillId)
        local enemyEntity = CurFightScene.Entitys[self.blackBoard.enemyId];

        local skillRange = self:getAttackDis();

        local tarX, tarY = self:getMovePointStraight(enemyEntity,skillRange*0.8)     

        if tarX == nil or tarY == nil then--这里不应该返回nil 否则证明已经到达了施法距离进来此函数是不对的
            local x,y = self:getPositionInCCPoint()
            self.blackBoard.movePoint = {x, y}
            return false
        end

        self.blackBoard.movePoint = {tarX, tarY}

    return true
end

function Entity:CanThink()
	if self.atr.hp <= 0 then
		--todo
		return false;
	end

	if self.bHit then
		--todo
		return false;
	end

    if self.blackBoard.aiState == NF.AI.AIState.REST_STATE then
        return false
    end

    if self.fightState == AIFightState.Stop then
    	--todo
    	return false;
    end

    return true
end


--暂时设定移动到目标--
function Entity:ProcMoveTo()
	-- body
	local enemyEntity = CurFightScene.Entitys[self.blackBoard.enemyId];
	self:moveToTarget(enemyEntity);
end

function Entity:ProcEnterRest(sec)
    self.blackBoard:ChangeState(NF.AI.AIState.THINK_STATE)
    scheduler.performWithDelayGlobal(function()
		-- body
        local aiEvent = NF.AI.AIEvent.RestEnd;
        self.blackBoard.timeoutId = nil;
        self.blackBoard:ChangeState(NF.AI.AIState.THINK_STATE)
        self:Think(aiEvent)
	end, sec)

    return true
end

function Entity:ThinkBefore()
    self.blackBoard.skillActTime = 0
    self.blackBoard.skillActTick = 0
end

function Entity:ThinkAfter()
end

function Entity:StopMove()
	-- body
	self.ismoving = false;

	self.ismoveToTarget = false;
	self.moveTarget = nil;
	self.movePoint = nil;

	self:ChangeStatus(StateEvent.stand);
end

function Entity:MoveEnd()
	-- body
	 self:Think(NF.AI.AIEvent.MoveEnd);
end

function Entity:Think(event)
    if self:CanThink() == false then
        return
    end
    local tmpAIRoot = AIMgr.getAi(self.modelidx);
    if not tmpAIRoot then
        return 
    end
    self.blackBoard:ChangeEvent(event)

    self:ThinkBefore()
    tmpAIRoot:Proc(self) 
    self:ThinkAfter()
end

function Entity:ProcThink()
    self:Think(NF.AI.AIEvent.Self)
    return true
end

function Entity:ProcEnterCD(sec)
    self.blackBoard:ChangeState(NF.AI.AIState.CD_STATE)
    self.blackBoard.timeoutId = scheduler.performWithDelayGlobal(function()
		-- body
        local aiEvent = NF.AI.AIEvent.CDEnd;
        self.blackBoard.timeoutId = nil;
        self.blackBoard:ChangeState(NF.AI.AIState.THINK_STATE)
        self:Think(aiEvent)
	end, sec+ 100)

	return true;
end

function Entity:ProcCastSpell(skillId)
	-- body
		if skillId <= 0 or skillId >= 3 then
			--todo
			return false;
		end
	    self.blackBoard.movePoint = nil

	    return self:CastSkill(skillId)
end

function Entity:CastSkill(skillIdx)
	if self:ProcInSkillCoolDown(skillIdx) then
		--todo
			-- body
		if skillIdx == 1 then
		    	--todo
		    self:ChangeStatus(StateEvent.attack);
		elseif skillIdx == 2 then
		    self:ChangeStatus(StateEvent.skill);
		end

		return true;
	end

	return false;
end


function Entity:InSkillRange(skillidx)
	-- body
	if not self.blackBoard.enemyId then
		--todo
		return false;
	end
	local enemyEntity = CurFightScene.Entitys[self.blackBoard.enemyId];
	if enemyEntity then
		--todo
		local dis = self:getAttackDis();

		local enemydis = ccpDistance(self:getPositionInCCPoint(),enemyEntity:getPositionInCCPoint());

		if  enemydis < dis then
			--todo
			return true;
		end
	end


	return false;
end

function Entity:Auto()
	-- body
	self:StopMove();
	if self.fightState == AIFightState.Start then
		--todo
		self.fightState = AIFightState.Stop;
	else
		self.fightState = AIFightState.Start;
	end
end

--面向对象--
function Entity:FaceToEntity(entity)
	-- body
	if self:getPositionX() > entity:getPositionX() then
		--todo
		self:ChangeDirection(Direction.right_to_left);
	else
		self:ChangeDirection(Direction.left_to_right);
	end
end

--是否攻击--
function Entity:CanAttack()
	if self.blackBoard.enemyId then
		--todo
		local entity = CurFightScene.Entitys[self.blackBoard.enemyId];
		if  entity and entity.atr.hp >0 then
			--todo
			return true;
		else
			self.blackBoard.enemyId = nil;
		end
	end
	return false;
end

return Entity;