CalcMgr = {};
local this = CalcMgr;

--计算伤害--
function CalcMgr.calDamage(attack,def)
	-- body
	local damage = attack.atr.atk - def.atr.def;

	if damage <=0 then
		--todo
		damage = 1;
	end

	damage = damage *(1+math.random());

	return damage;
end

--计算idx--
function CalcMgr.Gen()
	-- body
	if not CalcMgr.idx then
		--todo
		CalcMgr.idx = 0;
	end

	CalcMgr.idx = CalcMgr.idx + 1;

	return math.ceil(CalcMgr.idx);
end