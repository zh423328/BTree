local Entity = require("app.Entity.Entity");

local FightUI = require("app.layers.FightUI");
local ControlUI = require("app.layers.Control");
local HpMenu = require("app.layers.Hp");

local  FightScene = class("FightScene", function ()
	-- body
	return display.newScene("FightScene");
end)

CurFightScene = nil;

function FightScene:ctor()
	self.Entitys = {};
	self:initMap();
	self:initEntity();
	self:initEnemy();
	self:initSound();
	CurFightScene = self;
end

--加载UI
function FightScene:initUI()
	-- body
	self.fightUI = FightUI.new();
	self:addChild(self.fightUI);

	self.controlUI = ControlUI.new();
	self:addChild(self.controlUI);

	--self.hpmenu = HpMenu.new();
	--self:addChild(self.hpmenu);
end

--加载地图
function FightScene:initMap()
	-- body
	self.mapNode = display.newNode();
	if self.mapNode then
		--todo
		self.mapNode:setAnchorPoint(ccp(0.5,0.5));
		self:addChild(self.mapNode);

		self.bg = display.newSprite("map/1.png");
		if self.bg then
			self.mapNode:addChild(self.bg);
			self.bg:setAnchorPoint(ccp(0,0));
			--self.bg:setPosition(ccp(0,0));
		end
	end
end


--加载实体
function FightScene:initEntity()
	-- body
	self.entity = Entity.new(20001,0.5,0.25,Direction.left_to_right);
	self.mapNode:addChild(self.entity);
	self.entity:setPosition(ccp(50,CONFIG_MAP_CENTER));

	self.Entitys[self.entity.idx] = self.entity;
end

function FightScene:initEnemy()
	-- body
	self.enemy = Entity.new(20002,0.5,0.41,Direction.right_to_left);
	self.mapNode:addChild(self.enemy);
	self.enemy:setPosition(ccp(1000,CONFIG_MAP_CENTER));
	self.enemy:Auto();	--开启ai模式
	self.Entitys[self.enemy.idx] = self.enemy;
end

function FightScene:initSound()
	SoundManager.PlayerBackMusic(string.format("sound/music_fight1.mp3",soundidx));
end

function FightScene:removeEntity(model)
	-- body
	if model == self.entity then
		--todo
		self.entity = nil;
	elseif model == self.enemy then
		self.enemy = nil;
	end

	self.Entitys[model.idx] = nil;

	--table.remove(self.Entitys,model);
end

function FightScene:onEnter()
	--异步加载--
	display.addSpriteFramesWithFile("ui/FightUI/fight.plist","ui/FightUI/fight.png",function()
		-- body
		self:initUI();
	end);
	display.addSpriteFramesWithFile("fight/blood.plist","fight/blood.png");

	--设置退出游戏--
	self:setKeypadEnabled(true);
	self:addNodeEventListener(cc.KEYPAD_EVENT,function(event)
		-- body
		self:KeyEvent(event)
	end)
end

function FightScene:onExit()
	display.removeSpriteFramesWithFile("ui/FightUI/fight.plist","ui/FightUI/fight.png");
	display.removeSpriteFramesWithFile("fight/blood.plist","fight/blood.png");
end


function FightScene:KeyEvent(event)
	-- body
	if event.key == "back" then
		--todo
		if device.platform == "windows" then
			--todo
			local function onButtonClicked(event)
    			if event.buttonIndex == 1 then
    				--确定--
    				app:exit();
   				else
   				 	--取消--
   				 	--device.cancelAlert()
		    	end
			end

			device.showAlert("Confirm Exit", "Are you sure exit game ?", {"YES", "NO"}, onButtonClicked)
		else
			app:exit();
		end
	end
end

return FightScene;