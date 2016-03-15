ResourceMgr = {};
local this = ResourceMgr;

function ResourceMgr.New()
	-- body
	return this;
end


function ResourceMgr.GetModel(modelIdx)
	-- body
	local sprtable = {};

	table.insert(sprtable,string.format("model/%d/%d_stand.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_run.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_attack.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_attack_1.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_attack_2.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_attack_3.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_attack_4.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_attack_5.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_hurt.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_skill.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_attack_effect.png",modelIdx,modelIdx));
	table.insert(sprtable,string.format("model/%d/%d_skill_effect.png",modelIdx,modelIdx));

	return sprtable;
end


