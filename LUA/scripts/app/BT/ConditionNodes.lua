--随机数初始化，去除前面几个
math.randomseed(os.time())
local len = math.random(0, 100)
for _i = 1, len, 1 do
    math.random(0, 100)
end

local NF = require "app.BT.BTNode"

--lt<,le<=,eq==,ge >= gt>
local CmpType = {lt = 1,
                        le = 2,
                        eq = 3,
                        ge = 4,
                        gt = 5,
                    }
                    
local function Cmp(cmp, lv, rv)
        if cmp == CmpType.lt then
                do return lv < rv end
        elseif cmp == CmpType.le then
                do return lv <= rv end
        elseif cmp == CmpType.eq then
                do return lv == rv end
        elseif cmp == CmpType.ge then
                do return lv >= rv end
        elseif cmp == CmpType.gt then
                do return lv > rv end
        else
                do return false end
        end
end

------------------------
local InSkillRange = NF.AI.ConditionNode:new()

function InSkillRange:new(skillId)
        local tmp = {_skillId = skillId}
        setmetatable(tmp, {__index = InSkillRange})
        tmp.__index = tmp
        return tmp
end

function InSkillRange:Proc(entity)
        --计算自己和敌人的距离
        local rnt = entity:InSkillRange(self._skillId);
        return rnt
end

--------------------------
local InSkillCoolDown = NF.AI.ConditionNode:new()

function InSkillCoolDown:new(skillId)
        local tmp = {_skillId = skillId}
        setmetatable(tmp, {__index = InSkillCoolDown})
        tmp.__index = tmp
        return tmp
end

function InSkillCoolDown:Proc(entity)
        --技能冷却
        local rnt = entity:ProcInSkillCoolDown(self._skillId)
        return rnt
end

--------------------------------
--是否可攻击---
local IsCanAttackTargt = NF.AI.ConditionNode:new();

function IsCanAttackTargt:new()
    -- body
    local  tmp = {};
    setmetatable(tmp, IsCanAttackTargt);
    tmp.__index = tmp;

    return tmp;
end

function IsCanAttackTargt:Proc(entity)
    -- body
    return entity:CanAttack();
end


NF.AI.CmpType = CmpType
NF.AI.InSkillRange = InSkillRange
NF.AI.InSkillCoolDown = InSkillCoolDown
NF.AI.IsCanAttackTargt = IsCanAttackTargt