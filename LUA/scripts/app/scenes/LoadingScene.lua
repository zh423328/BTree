--loadingscene
local LoadingScene = class("LoadingScene", function()
	-- body
	return display.newScene("LoadingScene");
end)

function LoadingScene:ctor()
	-- body
end

function LoadingScene:onEnter()
	-- body
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
		self:update(dt);
	end)

	--开启帧事件--
	self:scheduleUpdate();
	
	--ui--
	display.addSpriteFramesWithFile("ui/Loading/loadingScene.plist","ui/Loading/loadingScene.png");
	--火--
	display.addSpriteFramesWithFile("ui/loading/loading_fire.plist","ui/Loading/loading_fire.png");

	self:initSound();
	self:InitUI();
	self:StartLoad();
end

function LoadingScene:onExit()
	-- body
	display.removeSpriteFramesWithFile("ui/Loading/loadingScene.plist","ui/Loading/loadingScene.png");
	display.removeSpriteFramesWithFile("ui/loading/loading_fire.plist","ui/Loading/loading_fire.png");
end


function LoadingScene:InitUI()
	-- body
	local node = cc.uiloader:load("ui/Loading/Loading_1.ExportJson");
	if node  then
		--todo
		self:addChild(node);

		self.progressbar =cc.uiloader:seekNodeByTag(node, 13);
		self.progressbar:setPercent(0);

		self.frame = cc.uiloader:seekNodeByTag(node,11);

		self.fire = display.newSprite("#loading_fire_0000.png");
		if self.fire then
			--todo
			self.fire:setAnchorPoint(ccp(1,0.5));
			self.fire:setPosition(ccp(50,self.frame:getContentSize().height/2));
			self.frame:addChild(self.fire);
		end
	end
end

function LoadingScene:initSound()
	-- body
	--SoundManager.PlayerBackMusic("sound/music_chapter.mp3");
end

function LoadingScene:StartLoad()
	-- body
	self.restable = {};

	local entityTable = ResourceMgr.GetModel(20001);
	for i=1,#entityTable do
		table.insert(self.restable,entityTable[i]);
	end

	local entityTable2 = ResourceMgr.GetModel(20002);
	for i=1,#entityTable2 do
		table.insert(self.restable,entityTable2[i]);
	end

	table.insert(self.restable,"map/1.png");

	self.currentNum = 0;
	self.maxNum = #self.restable + 2;

	for i=1,#self.restable do
		display.addImageAsync(self.restable[i], function ()
			-- body
			self:LoadAsyncHandler();
		end)
	end

	self:proLoadMusic();
end

function LoadingScene:update(dt)
	-- body
	if self.progressbar then
		--todo
		self.progressbar:setPercent(self.currentNum/self.maxNum*100);
	end
end

function LoadingScene:EndLoading()
	-- body
end

function LoadingScene:LoadAsyncHandler()
	-- body
	self.currentNum  = self.currentNum + 1;

	if self.currentNum/self.maxNum >= 0.1 then
		--todo
		if self.fire then
			--todo
			local px = 25 + 579*self.currentNum/self.maxNum;
			self.fire:setPosition(ccp(px,self.fire:getPositionY()));
		end
	end 

	if self.currentNum == self.maxNum then
		--todo
		app:enterScene("FightScene");
	end
end

--预加载背景音乐和音效--
function LoadingScene:proLoadMusic()
	-- body
	audio.preloadMusic(CCFileUtils:sharedFileUtils():fullPathForFilename("Sound/music_fight1.mp3"));
	self.currentNum = self.currentNum + 1;

	audio.preloadSound(CCFileUtils:sharedFileUtils():fullPathForFilename("sound/sound_fight_attack.mp3"));
	self.currentNum = self.currentNum + 1;
end
return LoadingScene;