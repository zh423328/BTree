local NF = require "app.BT.BTNode"

-----------寻找目标------------
local AOI = NF.AI.ActionNode:new()

function AOI:new()
        local tmp = {}
        setmetatable(tmp, {__index = AOI})
        tmp.__index = tmp
        return tmp
end

function AOI:Proc(entity)
        --查找目标，记录到blackBoard
         --log_game_info("AI","AOI")
        local rnt = entity:getNearTarget()
        if rnt then
            --todo
            return true;
        end

        return false;
end

--------------------------
local ChooseCastPoint = NF.AI.ActionNode:new()

function ChooseCastPoint:new(skillId)
        local tmp = {_skillId = skillId}
        setmetatable(tmp, {__index = ChooseCastPoint})
        tmp.__index = tmp
        return tmp
end

function ChooseCastPoint:Proc(entity)
        --查找移动目标点，记录到blackBoard
        local rnt = entity:ProcChooseCastPoint(self._skillId)

        return rnt
end

-------------------------
local MoveTo = NF.AI.ActionNode:new()

function MoveTo:new()
        local tmp = {}
        setmetatable(tmp, {__index = MoveTo})
        tmp.__index = tmp
        return tmp
end

function MoveTo:Proc(entity)
        --调用移动方法
         --log_game_info("AI","MoveTo")
        local rnt = entity:ProcMoveTo()
        return true
end
------------------------
local EnterRest = NF.AI.ActionNode:new()

function EnterRest:new(sec)
        local tmp = {_sec = sec}
        setmetatable(tmp, {__index = EnterRest})
        tmp.__index = tmp
        return tmp
end

function EnterRest:Proc(entity)
        entity:ProcEnterRest(self._sec)
--        entity.blackBoard:ChangeState(Mogo.AI.AIState.REST_STATE):
--        entity.blackBoard.waitSec = self._sec
        return true
end

----------------------
local EnterCD = NF.AI.ActionNode:new()

function EnterCD:new(sec)
        local tmp = {_sec = sec}
        setmetatable(tmp, {__index = EnterCD})
        tmp.__index = tmp
        return tmp
end

function EnterCD:Proc(entity)
        entity:ProcEnterCD(self._sec)
        return true
end

----------------------
local CastSpell = NF.AI.ActionNode:new()

function CastSpell:new(skillId)
        local tmp = {_skillId = skillId}
        setmetatable(tmp, {__index = CastSpell})
        tmp.__index = tmp
        return tmp
end

function CastSpell:Proc(entity)
        local rnt = entity:ProcCastSpell(self._skillId)
        return rnt
end


--------------------------------
NF.AI.AOI = AOI
NF.AI.CastSpell = CastSpell
NF.AI.ChooseCastPoint = ChooseCastPoint
NF.AI.EnterRest = EnterRest
NF.AI.EnterCD = EnterCD
NF.AI.MoveTo = MoveTo
