--
-- Author: Your Name
-- Date: 2016-03-07 22:45:53
--
local NF = require "app.BT.BTNode"
require "app.BT.DecoratorNodes"
require "app.BT.ConditionNodes"
require "app.BT.ActionNodes"

BT20001 = NF.AI.BehaviorTreeRoot:new()

function BT20001:new()
		 
			local tmp = {}
			setmetatable(tmp, {__index = BT20001})
			tmp.__index = tmp

			do
				local root = NF.AI.SelectorNode:new();
				self:SetRoot(root);
				do
					local node1 = NF.AI.SequenceNode:new();
					root:AddChild(node1);
					do
						local node3 = NF.AI.SelectorNode:new();
						node1:AddChild(node3);
						node3:AddChild(NF.AI.AOI:new());
						local node4 = NF.AI.Not:new();
						node3:AddChild(node4);
						node4:AddChild(NF.AI.EnterRest:new(1000));
					end

					do
						--是否能攻击目标--
						node1:AddChild(NF.AI.IsCanAttackTargt:new());
						--顺序节点--
						local node5 = NF.AI.SelectorNode:new();
						node1:AddChild(node5);
						do
							--释放第一个技能
							local node6 = NF.AI.SequenceNode:new();
							node5:AddChild(node6);
							node6:AddChild(NF.AI.InSkillRange:new(2));
							node6:AddChild(NF.AI.InSkillCoolDown:new(2));
							node6:AddChild(NF.AI.CastSpell:new(2));
							node6:AddChild(NF.AI.EnterCD:new(0));
						end

						do
							--释放普通攻击--
							local node7 = NF.AI.SequenceNode:new();
							node5:AddChild(node7);
							node7:AddChild(NF.AI.InSkillRange:new(1));
							node7:AddChild(NF.AI.InSkillCoolDown:new(1));
							node7:AddChild(NF.AI.CastSpell:new(1));
							node7:AddChild(NF.AI.EnterCD:new(0));
						end

						do
							--寻找目标--
							local node8 = NF.AI.SequenceNode:new();
							node5:AddChild(node8);

							node8:AddChild(NF.AI.ChooseCastPoint:new(1));
							node8:AddChild(NF.AI.MoveTo:new());
						end
					end
				end
			end

			return tmp
end

return BT20001:new()