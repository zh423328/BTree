local HpMenu = class("HpMenu", function()
	-- body
	return display.newLayer();
end)

function HpMenu:ctor()
	-- body
	self:initMenu();
	self:addNodeEventListener(cc.NODE_EVENT,function(event)
		-- body
		if event.name == "enter" then
			--todo
			self:onEnter();
		else
			self:onExit();
		end
	end)
end

function HpMenu:initMenu()
	-- body
	CCFileUtils:sharedFileUtils():addSearchPath("ui/HpDemo/");
	local layer = cc.uiloader:load("ui/HpDemo/HpDemo_1.ExportJson");
	if layer then
		self:addChild(layer);

		self.bar = cc.uiloader:seekNodeByName(layer,"ProgressBar1");

		self.bar2 = cc.uiloader:seekNodeByName(layer,"ProgressBar2");

		self.enemybar = cc.uiloader:seekNodeByName(layer,"ProgressBar3");

		self.enemybar2 = cc.uiloader:seekNodeByName(layer,"ProgressBar4");
	end
end

function HpMenu:onEnter()
	-- body
	-- display.addSpriteFramesWithFile("ui/HpDemo/HpDemo0.plist", "ui/HpDemo/HpDemo0.png",function()
	-- 	-- body
	-- 	self:initMenu();
	-- end)

	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,function(dt)
		-- body
		self:update(dt);
	end)

	self:scheduleUpdate();
end

function HpMenu:onExit()
	-- body
	--display.removeSpriteFramesWithFile("ui/HpDemo/HpDemo0.plist", "ui/HpDemo/HpDemo0.png");
	self:unscheduleUpdate();
end

function HpMenu:update(dt)
end

return HpMenu;