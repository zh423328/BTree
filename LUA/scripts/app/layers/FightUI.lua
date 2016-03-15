local FightUI = class("FightUI", function()
	-- body
	return display.newLayer();
end)

function FightUI:ctor()
	-- body
	local layer = cc.uiloader:load("ui/FightUI/Fight.ExportJson");
	if layer then
		self:addChild(layer);

		self.attackBtn = cc.uiloader:seekNodeByName(layer,"attack");
		if self.attackBtn then
			--todo
			self.attackBtn:onButtonClicked(function()
				-- body
				self:Attack();
			end)
		end

		self.progressbar = display.newProgressTimer("#BT_ATTACK_WY.png", display.PROGRESS_TIMER_RADIAL);
		if self.progressbar then
			--todo
			self.progressbar:setMidpoint(ccp(0.5,0.5));
			self.progressbar:setColor(ccc3(55, 55, 55));
			self.progressbar:setReverseDirection(true);
			self.attackBtn:addChild(self.progressbar);
		end

		self.skillBtn = cc.uiloader:seekNodeByName(layer,"skill");
		if self.skillBtn then
			--todo
			self.skillBtn:onButtonClicked(function()
				-- body
				self:Skill();
			end)
		end

		self.skillbar = display.newProgressTimer("#BT_FABAO_JINENG.png", display.PROGRESS_TIMER_RADIAL);
		if self.skillbar then
			--todo
			self.skillbar:setMidpoint(ccp(0.5,0.5));
			self.skillbar:setColor(ccc3(55, 55, 55));
			self.skillbar:setReverseDirection(true);
			self.skillBtn:addChild(self.skillbar);
		end
	end

	self:addNodeEventListener(cc.NODE_EVENT,function(event)
		-- body
		if event.name == "enter" then
			self:onEnter();
		elseif event.name == "exit" then
			self:onExit();
		end
	end)
end

function FightUI:onEnter()
	-- body

	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,function(dt)
		-- body
		self:update(dt);
	end)

	self:scheduleUpdate();
end

function FightUI:onExit()
	-- body
	self:unscheduleUpdate();
end

function FightUI:update(dt)
	--print(dt);
	local entity = CurFightScene.entity;
	if entity then
		--todo
		local tm = AIMgr.GetTickCount();
		local skill1 = entity.skillColDown[1] or 0;

		if tm > skill1 then
			--todo
			self.progressbar:setPercentage(0);
		else
			local delta1 = skill1-tm;
			self.progressbar:setPercentage(delta1/100*100);
		end
		
		local skill2 = entity.skillColDown[2] or 0;

		if tm > skill2 then
			--todo
			self.skillbar:setPercentage(0);
		else
			local delta1 = skill2-tm;
			self.skillbar:setPercentage(delta1/1200*100);
		end
	end
end


function FightUI:Attack()
	-- body
	local entity = CurFightScene.entity;
	if entity then
		--todo
		entity:CastSkill(1)
	end
end

function FightUI:Skill()
	-- body
		local entity = CurFightScene.entity;
	if entity then
		--todo
		entity:CastSkill(2)
	end
end


return FightUI;