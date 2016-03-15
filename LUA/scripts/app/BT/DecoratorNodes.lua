--local p = {}
--setmetatable(p, {__index = _G})
--setfenv(1, p)

local NF = require "app.BT.BTNode"

----- Not Class -----
local Not = NF.AI.DecoratorNode:new()

function Not:new()
        local tmp = {}
        setmetatable(tmp, {__index = Not})
        tmp.__index = tmp
        return tmp
end

function Not:Proc(entity)
        --print('Not')
        return not self.child:Proc(entity)
end

----- Success Class -----
local Success = NF.AI.DecoratorNode:new()

function Success:new()
        local tmp = {}
        setmetatable(tmp, {__index = Success})
        tmp.__index = tmp
        return tmp
end

function Success:Proc(entity)
        --print('Success')
        return self.child:Proc(entity)
end

NF.AI.Not = Not
NF.AI.Success = Success