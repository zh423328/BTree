
require("config")
require("framework.init")
require("app.manager.SoundManager");
require("app.manager.AnimationMgr");
require("app.manager.ResourceMgr");
require("app.manager.CalcMgr");
require("app.manager.AIMgr");
require("app.BT.BTNode");

scheduler = require("framework.scheduler")  

role = require("app.data.role");

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    AIMgr.initData();
    SoundManager.setMusicVolume(0.5);
    SoundManager.setEffectsVolume(0.5);
    self:enterScene("LoadingScene")
end



return MyApp
