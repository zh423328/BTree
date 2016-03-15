local ControlUI = class("ControlUI", function()
	-- body
	return display.newLayer();
end)

function ControlUI:ctor()
	-- body
	local layer = cc.uiloader:load("ui/FightUI/Control.ExportJson");
	if layer then
		self:addChild(layer);

		self.left = cc.uiloader:seekNodeByName(layer,"left");
		if self.left then
			--todo
			self.left:onButtonPressed(function()
				-- body
				self:ControlPressed(true);
			end)
			self.left:onButtonRelease(function()
				-- body
				self:ControlReleaseed(true);
			end)
		end

		self.right = cc.uiloader:seekNodeByName(layer,"right");
		if self.right then
			--todo
			self.right:onButtonPressed(function()
				-- body
				self:ControlPressed(false);
			end)
			self.right:onButtonRelease(function()
				-- body
				self:ControlReleaseed(false);
			end)
		end

		self.auto = cc.uiloader:seekNodeByName(layer,"auto");
		if self.auto then
			--todo
			self.auto:onButtonClicked(function()
				-- body
				self:Auto();
			end);
		end
	end
end

function ControlUI:ControlPressed(bLeft)
	--body
	local entity = CurFightScene.entity;

	if entity then
		--todo
		if bLeft then
			--todo
			entity.direction = Direction.right_to_left;
			entity.ismoving = true;
		else
			entity.direction = Direction.left_to_right;
			entity.ismoving = true;
		end

		entity.ismoveToTarget = false;
		entity.moveTarget = nil;
		entity.movePoint = ccp(0,0);

		entity:ChangeDirection(entity.direction);
	end


end

function ControlUI:ControlReleaseed(bLeft)
	-- body
	local entity = CurFightScene.entity
	if  entity then
		--todo
		entity:StopMove();
	end
end

function ControlUI:Auto()
	-- body
	local entity = CurFightScene.entity
	if  entity then
		--todo
		entity:Auto();

		if entity.fightState == AIFightState.Stop then
		--todo
			self.auto:setButtonImage("normal","#BT_GUAJIJM.png");	
		else
			self.auto:setButtonImage("normal","#BT_GUAJIJM_STOP.png");
		end
	end
end


return ControlUI;