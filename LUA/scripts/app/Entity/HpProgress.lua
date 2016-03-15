local HpProgress = class("HpProgress", function(background, fill,fill2,entity)
    local progress = display.newSprite(background)
    progress.fill = display.newProgressTimer(fill, display.PROGRESS_TIMER_BAR)
 
    progress.fill2 = display.newProgressTimer(fill2, display.PROGRESS_TIMER_BAR)
 
    progress.fill2:setMidpoint(CCPoint(0, 0.5))
    progress.fill2:setBarChangeRate(CCPoint(1.0, 0))
    progress.fill2:setPosition(progress:getContentSize().width/2, progress:getContentSize().height/2)
    progress:addChild( progress.fill2)
    progress.fill2:setPercentage(100)

     progress.fill:setMidpoint(CCPoint(0, 0.5))
     progress.fill:setBarChangeRate(CCPoint(1.0, 0))
     progress.fill:setPosition(progress:getContentSize().width/2, progress:getContentSize().height/2)
     progress:addChild(progress.fill)
     progress.fill:setPercentage(100)
     progress.entity = entity;
    return progress
end)
 
function HpProgress:ctor()
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
 
function HpProgress:onEnter()
	-- body
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,function(dt)
		-- body
		self:update(dt);
	end)

	self:scheduleUpdate();
end

function HpProgress:onExit()
	self:unscheduleUpdate();
end

function HpProgress:setProgress(progress)
	self.fill:setPercentage(progress);
end

function HpProgress:update(dt)

	local curPer = self.entity.atr.hp/self.entity.atr.hpmax*100;
	self.fill:setPercentage(curPer);

	if not self.perhp  then
		--todo
		self.perhp = self.fill:getPercentage();
	end

	if self.perhp ~= curPer then
		if self.perhp-curPer < 1 then
			self.perhp	=  curPer;
		else
			self.perhp	= self.perhp + (curPer - self.perhp)/10;
		end
	end

	self.fill2:setPercentage(self.perhp);
end

return HpProgress