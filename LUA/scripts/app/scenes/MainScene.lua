
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	display.addSpriteFramesWithFile("model/20001/20001_attack.plist", "model/20001/20001_attack.png");

	local sprite = display.newSprite("#20001_attack_0000.png");
	self:addChild(sprite);
	sprite:setPosition(ccp(display.cx,display.cy));

	local array = CCArray:create();
	for i=0,30 do
		local strframe = string.format("%s_%04d.png","20001_attack",i);
		local frame =  CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(strframe);
		if not frame  then
			--todo
			break;
		end
		array:addObject(frame);
		print(strframe);
	end

	local action = CCAnimation:createWithSpriteFrames(array,0.1);

	sprite:runAction(CCRepeatForever:create(CCAnimate:create(action)));
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
