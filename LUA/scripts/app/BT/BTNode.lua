--local p = {}
--setmetatable(p, {__index = _G})
--setfenv(1, p)

----AIState Class -----
local AIState = {}
AIState.THINK_STATE = 1
AIState.REST_STATE = 2
AIState.PATROL_STATE = 3
AIState.ESCAPE_STATE = 4
AIState.FIGHT_STATE = 5
AIState.CD_STATE = 6

local AIEvent = {}
AIEvent.MoveEnd = 1
AIEvent.Born = 2
AIEvent.AvatarDie = 3
AIEvent.CDEnd = 4
AIEvent.RestEnd = 5
AIEvent.BeHit = 6
AIEvent.AvatarPosSync = 7
AIEvent.Self = 8
AIEvent.AvatarRevive = 9

-----BlackBoard Class -----
local BlackBoard = {}
BlackBoard.__index = BlackBoard

function BlackBoard:new()
        local tmp = {}
        setmetatable(tmp, {__index = BlackBoard})
        tmp.__index = tmp
        tmp.aiState = AIState.THINK_STATE
        tmp.aiEvent = AIEvent.MoveEnd
        tmp.enemyId = nil -- -1表示无目标
        tmp.timeoutId = 0
        tmp.skillActTime = 0
        tmp.skillActTick = 0
        tmp.hatelist = {};

        return tmp
end

function BlackBoard:ChangeState(state)
        self.aiState = state
end

function BlackBoard:ChangeEvent(event)
        self.aiEvent = event
end

-----Base Class ------
local BTNode = {}
BTNode.__index = BTNode


function BTNode:new()
        local tmp = {}
        setmetatable(tmp, {__index = BTNode})
        tmp.__index = tmp
        return tmp
end
        
function BTNode:Proc(entity)
        --print("not implement this interface")
end

----- BehaviorTreeRoot Class -----
local BehaviorTreeRoot = BTNode:new()

function BehaviorTreeRoot:new()
        local tmp = {}
        setmetatable(tmp, {__index = BehaviorTreeRoot})
        tmp.__index = tmp
        return tmp
end

function BehaviorTreeRoot:Proc(entity)
        local rst = self.root:Proc(entity) --不用尾调用
        return rst
end

function BehaviorTreeRoot:SetRoot(root)
        self.root = root;
end

-----ConditionNode Class-----
local ConditionNode = BTNode:new()

function ConditionNode:new()
        local tmp = {}
        setmetatable(tmp, {__index = ConditionNode})
        tmp.__index = tmp
        return tmp
end

function ConditionNode:Proc(entity)
        return false
end

----- ActionNode Class -----
local ActionNode = BTNode:new()

function ActionNode:new()
        local tmp = {}
        setmetatable(tmp, {__index = ActionNode})
        tmp.__index = tmp
        return tmp
end

function ActionNode:Proc(entity)
        return false;
end

----- DecoratorNode Class -----
local DecoratorNode = BTNode:new()

function DecoratorNode:new()
        local tmp = {}
        setmetatable(tmp, {__index = DecoratorNode})
        tmp.__index = tmp
        return tmp
end

function DecoratorNode:Proc(entity)
        local rst = self.child:Proc(entity) ---不用尾调用
        return rst
end

function DecoratorNode:AddChild(node)
        self.child = node
end

----- CompositeNode Class ------
local CompositeNode = BTNode:new()

function CompositeNode:new()
        local tmp = {}
        setmetatable(tmp, {__index = CompositeNode})
        tmp.__index = tmp
        return tmp
end

function CompositeNode:Proc(entity)
        --todo 由子类实现
        return true
end

function CompositeNode:AddChild(node)
        if not self.children then
            self.children = {}
        end
        table.insert(self.children, node)
end

----- SequenceNode Class -----
local SequenceNode = CompositeNode:new()

function SequenceNode:new()
        local tmp = {}
        setmetatable(tmp, {__index = SequenceNode})
        tmp.__index = tmp
        return tmp
end

function SequenceNode:Proc(entity)
        for k, v in pairs(self.children) do
                if not v:Proc(entity) then
                        return false;
                end
        end
        return true
end

----- SelectorNode Class -----
local SelectorNode = CompositeNode:new()

function SelectorNode:new()
        local tmp = {}
        setmetatable(tmp, {__index = SelectorNode})
        tmp.__index = tmp
        return tmp
end

function SelectorNode:Proc(entity)
    for k, v in pairs(self.children) do
        if v:Proc(entity) then
            return true;
        end
    end

    return false
end

NF = {}
NF.AI = {BehaviorTreeRoot = BehaviorTreeRoot,
                 DecoratorNode = DecoratorNode,
                 ConditionNode = ConditionNode,
                 ActionNode = ActionNode,
                 SequenceNode = SequenceNode,
                 SelectorNode = SelectorNode,
                 AIState = AIState,
                 AIEvent = AIEvent,
                 BlackBoard = BlackBoard,
                }
                
return NF
