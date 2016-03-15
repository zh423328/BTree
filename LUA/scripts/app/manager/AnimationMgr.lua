AnimationMgr = {};
local this = AnimationMgr;

function AnimationMgr.New()
	-- body
	return this;
end


--创建一个Animation
function AnimationMgr.getModelAnimation(model,frameName,duration,startindex,length)
	-- body
	local modelstr = string.format("model/%d/%d_%s.plist",model,model,frameName);
	local modelpng = string.format("model/%d/%d_%s.png",model,model,frameName);
	display.addSpriteFramesWithFile(modelstr,modelpng);
	return AnimationMgr.getAnimation(model.."_"..frameName,duration,startindex,length);
end

--光效等其他的
function AnimationMgr.getCommonAnimation(imagepath,pngpath,frameName,duration)
	-- body
	display.addSpriteFramesWithFile(imagepath,pngpath);
	return AnimationMgr.getAnimation(frameName,duration,0,30);
end

--创建一个Animation
function AnimationMgr.getAnimation(frameName,duration,startIndex,length)
	local array = CCArray:create();
	for i=startIndex,startIndex+length do
		local strframe = string.format("%s_%04d.png",frameName,i);
		local frame =  CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(strframe);
		if not frame  then
			--todo
			break;
		end
		array:addObject(frame);
	end

	return CCAnimation:createWithSpriteFrames(array,duration);
end