--last update: added blitz, improve minion collision, added menulib, added more functions

require 'GeometryLib'
require 'FF15menu'
Annie = {}
Brand = {}
Blitzcrank = {}
Orbwalk = {}
Prediction = {}
Utils = {}
local mh = myHero

function OnLoad()
	if mh.charName == "Brand" then
		Brand:Init()
		PrintChat("<b><font color=\"#ff6600\">MasterSeries: </font></b><font color=\"#FFFFFF\"> Brand Loaded. Welcome :)</font>")
	elseif mh.charName == "Annie" then
		Annie:Init()
		PrintChat("<b><font color=\"#ff6600\">MasterSeries: </font></b><font color=\"#FFFFFF\"> Annie Loaded. Welcome :)</font>")
	elseif mh.charName == "Blitzcrank" then
		Blitzcrank:Init()
		PrintChat("<b><font color=\"#ff6600\">MasterSeries: </font></b><font color=\"#FFFFFF\"> Blitzcrank Loaded. Welcome :)</font>")
	end
	Orbwalk:Init()
end

---------------------------------
---------------------------------
----------- BRAND ---------------
---------------------------------
---------------------------------
function Brand:Menu()
	menu = Menu("MasterSeries", "MasterSeries-Brand")
	menu:sub("combosettings", "Combo Settings")
	menu:sub("harasssettings", "Harass Settings")
	menu:sub("clearsettings", "Clear Settings")
	menu:sub("killstealsettings", "KillSteal Settings")
	menu:sub("drawsettings", "Draw Settings")
	-------------
	menu.combosettings:checkbox("useq", "Use (Q)", true)
	menu.combosettings:checkbox("usew", "Use (W)", true)
	menu.combosettings:checkbox("usee", "Use (E)", true)
	menu.combosettings:checkbox("user", "Use (R)", true)
	menu.combosettings:key("combokey", "Combo Key:", 32)
	-------------
	menu.harasssettings:checkbox("useq", "Use (Q)", true)
	menu.harasssettings:checkbox("usew", "Use (W)", true)
	menu.harasssettings:checkbox("usee", "Use (E)", true)
	menu.harasssettings:key("harasskey", "Harass Key:", 67)
	------------
	menu.clearsettings:checkbox("useq", "Use (Q)", true)
	menu.clearsettings:checkbox("usew", "Use (W)", true)
	menu.clearsettings:checkbox("usee", "Use (E)", true)
	menu.clearsettings:key("clearkey", "Clear Key:", 86)
	-------------
	menu.killstealsettings:checkbox("useq", "Use (Q)", true)
	menu.killstealsettings:checkbox("usew", "Use (W)", true)
	menu.killstealsettings:checkbox("usee", "Use (E)", true)
	menu.killstealsettings:checkbox("usei", "Use Ignite", true)
	-------------
	menu.drawsettings:checkbox("drawq", "Draw (Q) Circle", true)
	menu.drawsettings:checkbox("draww", "Draw (W) Circle", true)
	menu.drawsettings:checkbox("drawe", "Draw (E) Circle", true)
	menu.drawsettings:checkbox("drawr", "Draw (R) Circle", true)
end

function Brand:Init()
	self.FiredEnemies = {}, {}
	self.target, self.tsrange = nil, 1200
	self.I = {
		slot = mh.spellbook:Spell(4).name:find("SummonerDot") and 4 or mh.spellbook:Spell(5).name:find("SummonerDot") and 5 or nil,
		ready = function() return self.I.slot and mh.spellbook:CanUseSpell(self.I.slot) == 0  or false end,
		range = 600,
	}
	self.Q = {
		slot = mh.spellbook:Spell(SpellSlot.Q),
		ready = function() return mh.spellbook:CanUseSpell(0) == 0 end,
		range = 1050,
		pred = {
			delay = 0.25,
			width = 70,
			speed = 1550,
			collision = true,
		},
	}
	self.W = {
		slot = mh.spellbook:Spell(SpellSlot.W),
		ready = function() return mh.spellbook:CanUseSpell(1) == 0 end,
		range = 900,
		pred = {
			delay = 0.75,
			radius = 250,
			speed = math.huge,
			boundingRadiusMod = 0,
			collision = false,
		},
	}
	self.E = {
		slot = mh.spellbook:Spell(SpellSlot.E),
		ready = function() return mh.spellbook:CanUseSpell(2) == 0 end,
		range = 625,
	}
	self.R = {
		slot = mh.spellbook:Spell(SpellSlot.R),
		ready = function() return mh.spellbook:CanUseSpell(3) == 0 end,
		range = 775,
	}
	AddEvent(Events.OnBuffGain, function(unit, buff) self:OnGainBuff(unit, buff) end)
	AddEvent(Events.OnBuffLost, function(unit, buff) self:OnRemoveBuff(unit, buff) end)
	AddEvent(Events.OnTick, function() self:OnTick() end)
	AddEvent(Events.OnDraw, function() self:OnDraw() end)
	self:Menu()
end

function Brand:OnTick()
	if self.Q.ready() then
		self.tsrange = self.Q.range
	elseif not self.Q.ready() and self.W.ready() then
		self.tsrange = self.W.range
	elseif not self.W.ready() and self.R.ready() then
		self.tsrange = self.R.range
	elseif not self.R.ready() and self.E.ready() then
		self.tsrange = self.E.range
	end
	self.target = Utils:GetTarget(self.tsrange)
	if menu.combosettings.combokey:get() then 
		Orbwalk:Orbwalk()
		self:Combo()
	end
	if menu.harasssettings.harasskey:get() then 
		Orbwalk:Orbwalk()
		self:Harass()
	end
	if menu.clearsettings.clearkey:get() then 
		Orbwalk:Orbwalk()
		self:Clear()
	end
	self:KillSteal()
end

function Brand:OnGainBuff(unit, buff)
	if unit.team ~= mh.enemy and not unit.isDead and buff and buff.isValid and buff.scriptBaseBuff.name == "BrandAblaze" then
		self.FiredEnemies[unit.networkId] = unit
	end
end

function Brand:OnRemoveBuff(unit, buff)
	if unit and self.FiredEnemies[unit.networkID] and buff and buff.scriptBaseBuff.name == "BrandAblaze" then
		self.FiredEnemies[unit.networkId] = nil
	end
end

function Brand:Combo()
	if not Utils:ValidTarget(self.target) then return end
	if menu.combosettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.combosettings.usew:get() and self.W.ready() then
		self:CastW(self.target)
	end
	if menu.combosettings.usee:get() and self.E.ready() then
		self:CastE(self.target)
	end
	if menu.combosettings.user:get() and self.R.ready() then
		local dmg = math.floor(Utils:GetDmg(self.target, "Q")) + math.floor(Utils:GetDmg(self.target, "W")) + math.floor(Utils:GetDmg(self.target, "E")) + math.floor(Utils:GetDmg(self.target, "R"))
		if self.target.health < dmg then
			self:CastR(self.target)
		end
	end
end

function Brand:Harass()
	if not Utils:ValidTarget(self.target) then return end
	if menu.harasssettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.harasssettings.usew:get() and self.W.ready() then
		self:CastW(self.target)
	end
	if menu.harasssettings.usee:get() and self.E.ready() then
		self:CastE(self.target)
	end
end

function Brand:Clear()
	for i, minion in pairs(ObjectManager:GetEnemyMinions()) do
		if Utils:ValidTarget(minion, 1300) then
			if menu.clearsettings.useq:get() and Utils:GetDistance(minion, mh) <= self.Q.range then
				self:CastQ(minion)
			end
			if menu.clearsettings.usew:get() and Utils:GetDistance(minion, mh) <= self.W.range then
				local Pos, Hit = Utils:GetBestCircleFarmPosition(self.W.range, self.W.pred.radius, ObjectManager:GetEnemyMinions())
				if Pos and Hit >= 3 and Utils:GetDistance(Pos) < self.W.range then 
					mh.spellbook:CastSpell(1, D3DXVECTOR3(Pos.x, Pos.y, Pos.z))	
				end
			end
			if menu.clearsettings.useq:get() and Utils:GetDistance(minion, mh) <= self.E.range and self.FiredEnemies[minion.networkId] then
				self:CastE(minion)
			end
		end
	end
end

function Brand:KillSteal()
	for k, enemy in pairs(ObjectManager:GetEnemyHeroes()) do
		if Utils:ValidTarget(enemy) and Utils:GetDistance(enemy, mh) < self.Q.range then
			local qdmg = Utils:GetDmg(enemy, "Q")
			local wdmg = Utils:GetDmg(enemy, "W")
			local edmg = Utils:GetDmg(enemy, "E")
			local idmg = Utils:GetDmg(enemy, "Ignite")
			if menu.killstealsettings.useq:get() and self.Q.ready() and enemy.health < qdmg then
				self:CastQ(enemy)
			elseif menu.killstealsettings.usew:get() and self.W.ready() and enemy.health < wdmg then
				self:CastW(enemy)
			elseif menu.killstealsettings.usee:get() and self.E.ready() and enemy.health < edmg then
				self:CastE(enemy)
			elseif menu.killstealsettings.usei:get() and self.I.ready() and enemy.health < idmg then
				mh.spellbook:CastSpell(self.I.slot, enemy.networkId)	
			end
		end
	end
end

function Brand:CastQ(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.Q.range then
		local x, y = Prediction:prediction(unit, self.Q.pred.delay, self.Q.pred.speed, self.Q.range, self.Q.pred.width, self.Q.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(0, D3DXVECTOR3(x.x, x.y, x.z))			
		end
	end
end

function Brand:CastW(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.W.range then
		local x, y = Prediction:prediction(unit, self.W.pred.delay, self.W.pred.speed, self.W.range, self.W.pred.radius, self.W.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(1, D3DXVECTOR3(x.x, x.y, x.z))			
		end				
	end
end

function Brand:CastE(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.E.range then
		mh.spellbook:CastSpell(2, unit.networkId)			
	end
end

function Brand:CastR(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.R.range then
		mh.spellbook:CastSpell(3, unit.networkId)				
	end
end

function Brand:GetRAoeNear(unit)
	local obj = Utils:TableMerge(ObjectManager:GetEnemyMinions(), ObjectManager:GetEnemyHeroes())
	local obj2 = Utils:TableMerge(obj, Utils:GetJungleMinions())
	local count = 0
  	for i, target in pairs(obj2) do
  		if not target.name:find("Plant") then
    		if Utils:GetDistance(target, unit) < 450 and target.name ~= unit.name then
      			count = count + 1
    		end
    	end
  	end
  	return count
end

function Brand:GetBounces(unit)
	local m = self:GetRAoeNear(unit)
	local bounces = 1
	if m >= 1 then 
		bounces = 3
	end
	return bounces
end

function Brand:OnDraw()
	if menu.drawsettings.drawq:get() and self.Q.ready() then
		DrawHandler:Circle3D(myHero.position, self.Q.range, 0xff00ff00)
	end
	if menu.drawsettings.draww:get() and self.W.ready() then
		DrawHandler:Circle3D(myHero.position, self.W.range, 0xff00ff00)
	end
	if menu.drawsettings.drawe:get() and self.E.ready() then
		DrawHandler:Circle3D(myHero.position, self.E.range, 0xff00ff00)
	end
	if menu.drawsettings.drawr:get() and self.R.ready() then
		DrawHandler:Circle3D(myHero.position, self.R.range, 0xff00ff00)
	end
end

---------------------------------
---------------------------------
----------- ANNIE ---------------
---------------------------------
---------------------------------
function Annie:Menu()
	menu = Menu("MasterSeries", "MasterSeries-Annie")
	menu:sub("combosettings", "Combo Settings")
	menu:sub("harasssettings", "Harass Settings")
	menu:sub("clearsettings", "Clear Settings")
	menu:sub("killstealsettings", "KillSteal Settings")
	menu:sub("drawsettings", "Draw Settings")
	-------------
	menu.combosettings:checkbox("useq", "Use (Q)", true)
	menu.combosettings:checkbox("usew", "Use (W)", true)
	menu.combosettings:checkbox("usee", "Use (E)", true)
	menu.combosettings:checkbox("user", "Use (R)", true)
	menu.combosettings:key("combokey", "Combo Key:", 32)
	-------------
	menu.harasssettings:checkbox("useq", "Use (Q)", true)
	menu.harasssettings:checkbox("usew", "Use (W)", true)
	menu.harasssettings:key("harasskey", "Harass Key:", 67)
	------------
	menu.clearsettings:checkbox("useq", "Use (Q)", true)
	menu.clearsettings:checkbox("usew", "Use (W)", true)
	menu.clearsettings:key("clearkey", "Clear Key:", 86)
	-------------
	menu.killstealsettings:checkbox("useq", "Use (Q)", true)
	menu.killstealsettings:checkbox("usew", "Use (W)", true)
	menu.killstealsettings:checkbox("usei", "Use Ignite", true)
	-------------
	menu.drawsettings:checkbox("drawq", "Draw (Q&W) Circle", true)
	menu.drawsettings:checkbox("drawr", "Draw (R) Circle", true)
end

function Annie:Init()
	self.passive = false
	self.target, self.tsrange = nil, 650
	self.I = {
		slot = mh.spellbook:Spell(4).name:find("SummonerDot") and 4 or mh.spellbook:Spell(5).name:find("SummonerDot") and 5 or nil,
		ready = function() return self.I.slot and mh.spellbook:CanUseSpell(self.I.slot) == 0  or false end,
		range = 600,
	}
	self.Q = {
		slot = mh.spellbook:Spell(SpellSlot.Q),
		ready = function() return mh.spellbook:CanUseSpell(0) == 0 end,
		range = 650,
	}
	self.W = {
		slot = mh.spellbook:Spell(SpellSlot.W),
		ready = function() return mh.spellbook:CanUseSpell(1) == 0 end,
		range = 650,
		pred = {
			delay = 0.6,
			radius = 180,
			speed = math.huge,
			boundingRadiusMod = 0,
			collision = false,
			},
	}
	self.R = {
		slot = mh.spellbook:Spell(SpellSlot.R),
		ready = function() return mh.spellbook:CanUseSpell(3) == 0 end,
		range = 575,
		pred = {
			delay = 0.25,
			radius = 200,
			speed = math.huge,
			boundingRadiusMod = 0,
			collision = false,
		},
	}
	AddEvent(Events.OnBuffGain, function(unit, buff) self:OnGainBuff(unit, buff) end)
	AddEvent(Events.OnBuffLost, function(unit, buff) self:OnRemoveBuff(unit, buff) end)
	AddEvent(Events.OnTick, function() self:OnTick() end)
	AddEvent(Events.OnDraw, function() self:OnDraw() end)
	self:Menu()
end

function Annie:OnTick()
	if self.Q.ready() or self.W.ready() then
		self.tsrange = self.Q.range
	elseif not self.Q.ready() and not self.W.ready() then
		self.tsrange = self.R.range
	end
	self.target = Utils:GetTarget(self.tsrange)
	if menu.combosettings.combokey:get() then 
		Orbwalk:Orbwalk()
		self:Combo()
	end
	if menu.harasssettings.harasskey:get() then 
		Orbwalk:Orbwalk()
		self:Harass()
	end
	if menu.clearsettings.clearkey:get() then 
		Orbwalk:Orbwalk()
		self:Clear()
	end
	self:KillSteal()
end

function Annie:OnGainBuff(unit, buff)
	if unit and unit == mh and buff and (buff.scriptBaseBuff.name == "pyromania_particle") then
		self.passive = true
	end 
end

function Annie:OnRemoveBuff(unit, buff)
	if unit and unit == mh and buff and (buff.scriptBaseBuff.name == "pyromania_particle") then
		self.passive = false
	end 
end

function Annie:Combo()
	if not Utils:ValidTarget(self.target) then return end
	if menu.combosettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.combosettings.usew:get() and self.W.ready() then
		self:CastW(self.target)
	end
	if menu.combosettings.usee:get() and self.E.ready() then
		self:CastE()
	end
	if menu.combosettings.user:get() and self.R.ready() then
		local dmg = math.floor(Utils:GetDmg(self.target, "Q")) + math.floor(Utils:GetDmg(self.target, "W")) + math.floor(Utils:GetDmg(self.target, "R"))
		if self.target.health < dmg then
			self:CastR(self.target)
		end
	end
end

function Annie:Harass()
	if not Utils:ValidTarget(self.target) then return end
	if menu.harasssettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.harasssettings.usew:get() and self.W.ready() then
		self:CastW(self.target)
	end
end

function Annie:Clear()
	for i, minion in pairs(ObjectManager:GetEnemyMinions()) do
		if Utils:ValidTarget(minion, 1300) then
			if menu.clearsettings.useq:get() and Utils:GetDistance(minion, mh) <= self.Q.range then
				self:CastQ(minion)
			end
			if menu.clearsettings.usew:get() and Utils:GetDistance(minion, mh) <= self.W.range then
				local Pos, Hit = Utils:GetBestCircleFarmPosition(self.W.range, self.W.pred.radius, ObjectManager:GetEnemyMinions())
				if Pos and Hit >= 2 and Utils:GetDistance(Pos) < self.W.range then 
					mh.spellbook:CastSpell(1, D3DXVECTOR3(Pos.x, Pos.y, Pos.z))	
				end
			end
		end
	end
end

function Annie:KillSteal()
	for k, enemy in pairs(ObjectManager:GetEnemyHeroes()) do
		if Utils:ValidTarget(enemy) and Utils:GetDistance(enemy, mh) < self.Q.range then
			local qdmg = Utils:GetDmg(enemy, "Q")
			local wdmg = Utils:GetDmg(enemy, "W")
			local idmg = Utils:GetDmg(enemy, "Ignite")
			if menu.killstealsettings.useq:get() and self.Q.ready() and enemy.health < qdmg then
				self:CastQ(enemy)
			elseif menu.killstealsettings.usew:get() and self.W.ready() and enemy.health < wdmg then
				self:CastW(enemy)
			elseif menu.killstealsettings.usei:get() and self.I.ready() and enemy.health < idmg then
				mh.spellbook:CastSpell(self.I.slot, enemy.networkId)	
			end
		end
	end
end

function Annie:CastQ(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.Q.range then
		mh.spellbook:CastSpell(0, unit.networkId)	
	end
end

function Annie:CastW(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.W.range then
		local x, y = Prediction:prediction(unit, self.W.pred.delay, self.W.pred.speed, self.W.range, self.W.pred.radius, self.W.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(1, D3DXVECTOR3(x.x, x.y, x.z))			
		end				
	end
end

function Annie:CastE(unit)
	mh.spellbook:CastSpell(2, mh.networkId)			
end

function Annie:CastR(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.R.range then
		local x, y = Prediction:prediction(unit, self.R.pred.delay, self.R.pred.speed, self.R.range, self.R.pred.radius, self.R.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(3, D3DXVECTOR3(x.x, x.y, x.z))			
		end				
	end
end

function Annie:OnDraw()
	if menu.drawsettings.drawq:get() and self.Q.ready() or self.W.ready() then
		DrawHandler:Circle3D(myHero.position, self.Q.range, 0xff00ff00)
	end
	if menu.drawsettings.drawr:get() and self.R.ready() then
		DrawHandler:Circle3D(myHero.position, self.R.range, 0xff00ff00)
	end
end


---------------------------------
---------------------------------
--------- BLITZCRANK ------------
---------------------------------
---------------------------------
function Blitzcrank:Menu()
	menu = Menu("MasterSeries", "MasterSeries-Blitzcrank")
	menu:sub("combosettings", "Combo Settings")
	menu:sub("harasssettings", "Harass Settings")
	menu:sub("clearsettings", "Clear Settings")
	menu:sub("killstealsettings", "KillSteal Settings")
	menu:sub("drawsettings", "Draw Settings")
	-------------
	menu.combosettings:checkbox("useq", "Use (Q)", true)
	menu.combosettings:checkbox("usew", "Use (W)", true)
	menu.combosettings:checkbox("usee", "Use (E)", true)
	menu.combosettings:checkbox("user", "Use (R)", false)
	menu.combosettings:key("combokey", "Combo Key:", 32)
	-------------
	menu.harasssettings:checkbox("useq", "Use (Q)", true)
	menu.harasssettings:checkbox("usee", "Use (E)", true)
	menu.harasssettings:key("harasskey", "Harass Key:", 67)
	------------
	menu.clearsettings:checkbox("useq", "Use (Q)", true)
	menu.clearsettings:checkbox("usew", "Use (W)", false)
	menu.clearsettings:checkbox("usee", "Use (E)", true)
	menu.clearsettings:key("clearkey", "Clear Key:", 86)
	-------------
	menu.killstealsettings:checkbox("useq", "Use (Q)", true)
	menu.killstealsettings:checkbox("user", "Use (R)", true)
	menu.killstealsettings:checkbox("usei", "Use Ignite", true)
	-------------
	menu.drawsettings:checkbox("drawq", "Draw (Q) Circle", true)
	menu.drawsettings:checkbox("drawe", "Draw (E) Circle", true)
	menu.drawsettings:checkbox("drawr", "Draw (R) Circle", true)
end

function Blitzcrank:Init()
	self.target, self.tsrange = nil, 1050
	self.I = {
		slot = mh.spellbook:Spell(4).name:find("SummonerDot") and 4 or mh.spellbook:Spell(5).name:find("SummonerDot") and 5 or nil,
		ready = function() return self.I.slot and mh.spellbook:CanUseSpell(self.I.slot) == 0  or false end,
		range = 600,
	}
	self.Q = {
		slot = mh.spellbook:Spell(SpellSlot.Q),
		ready = function() return mh.spellbook:CanUseSpell(0) == 0 end,
		range = 1050,
		pred = {
			delay = 0.25,
			radius = 70,
			speed = 1800,
			boundingRadiusMod = 0,
			collision = true,
		},
	}
	self.W = {
		slot = mh.spellbook:Spell(SpellSlot.W),
		ready = function() return mh.spellbook:CanUseSpell(1) == 0 end,
	}
	self.E = {
		slot = mh.spellbook:Spell(SpellSlot.E),
		ready = function() return mh.spellbook:CanUseSpell(2) == 0 end,
		range = mh.characterIntermediate.attackRange+150,
	}
	self.R = {
		slot = mh.spellbook:Spell(SpellSlot.R),
		ready = function() return mh.spellbook:CanUseSpell(3) == 0 end,
		range = 600,
	}
	AddEvent(Events.OnBuffGain, function(unit, buff) self:OnGainBuff(unit, buff) end)
	AddEvent(Events.OnTick, function() self:OnTick() end)
	AddEvent(Events.OnDraw, function() self:OnDraw() end)
	self:Menu()
end

function Blitzcrank:OnTick()
	if self.Q.ready() then
		self.tsrange = self.Q.range
	elseif not self.Q.ready() and self.R.ready() then
		self.tsrange = self.R.range
	elseif not self.Q.ready() and not self.R.ready() then
		self.tsrange = self.E.range
	end
	self.target = Utils:GetTarget(self.tsrange)
	if menu.combosettings.combokey:get() then 
		Orbwalk:Orbwalk()
		self:Combo()
	end
	if menu.harasssettings.harasskey:get() then 
		Orbwalk:Orbwalk()
		self:Harass()
	end
	if menu.clearsettings.clearkey:get() then 
		Orbwalk:Orbwalk()
		self:Clear()
	end
	self:KillSteal()
end

function Blitzcrank:OnGainBuff(unit, buff)
	if unit.team ~= mh.enemy and not unit.isDead and buff and buff.isValid and buff.scriptBaseBuff.name == "rocketgrab2" then
		if ((menu.combosettings.combokey:get() and menu.combosettings.usee:get()) or (menu.harasssettings.harasskey:get() and menu.harasssettings.usee:get())) and self.E.ready() then
			self:CastE(self.target)
		end
	end
end

function Blitzcrank:Combo()
	if not Utils:ValidTarget(self.target) then return end
	if menu.combosettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.combosettings.usew:get() and self.W.ready() then
		self:CastW(self.target)
	end
	if menu.combosettings.usee:get() and self.E.ready() and not self.Q.ready() and Utils:GetDistance(self.target, mh) <= self.E.range then
		self:CastE(self.target)
	end
	if menu.combosettings.user:get() and self.R.ready() then
		local dmg = math.floor(Utils:GetDmg(self.target, "Q")) + math.floor(Utils:GetDmg(self.target, "R"))
		if self.target.health < dmg then
			self:CastR(self.target)
		end
	end
end

function Blitzcrank:Harass()
	if not Utils:ValidTarget(self.target) then return end
	if menu.harasssettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.harasssettings.usee:get() and self.E.ready() and not self.Q.ready() and Utils:GetDistance(self.target, mh) <= self.E.range then
		self:CastE(self.target)
	end
end

function Blitzcrank:Clear()
	for i, minion in pairs(ObjectManager:GetEnemyMinions()) do
		if Utils:ValidTarget(minion, self.Q.range) then
			if menu.clearsettings.useq:get() and Utils:GetDistance(minion, mh) <= self.Q.range then
				self:CastQ(minion)
			end
			if menu.clearsettings.usew:get() and Utils:GetDistance(minion, mh) <= self.E.range then
				self:CastW(minion)
			end
			if menu.clearsettings.usee:get() and Utils:GetDistance(minion, mh) <= self.E.range then
				self:CastE()
			end
		end
	end
end

function Blitzcrank:KillSteal()
	for k, enemy in pairs(ObjectManager:GetEnemyHeroes()) do
		if Utils:ValidTarget(enemy) and Utils:GetDistance(enemy, mh) < self.Q.range then
			local qdmg = Utils:GetDmg(enemy, "Q")
			local rdmg = Utils:GetDmg(enemy, "R")
			local idmg = Utils:GetDmg(enemy, "Ignite")
			if menu.killstealsettings.useq:get() and self.Q.ready() and enemy.health < qdmg then
				self:CastQ(enemy)
			elseif menu.killstealsettings.user:get() and self.R.ready() and enemy.health < rdmg then
				self:CastR(enemy)
			elseif menu.killstealsettings.usei:get() and self.I.ready() and enemy.health < idmg then
				mh.spellbook:CastSpell(self.I.slot, enemy.networkId)	
			end
		end
	end
end

function Blitzcrank:CastQ(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.Q.range then
		local x, y = Prediction:prediction(unit, self.Q.pred.delay, self.Q.pred.speed, self.Q.range, self.Q.pred.radius, self.Q.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(0, D3DXVECTOR3(x.x, x.y, x.z))			
		end				
	end
end

function Blitzcrank:CastW(unit)
	if Utils:GetDistance(mh, unit) <= self.Q.range/2 then
		mh.spellbook:CastSpell(1, mh.networkId)		
	end
end

function Blitzcrank:CastE()
	mh.spellbook:CastSpell(2, mh.networkId)			
end

function Blitzcrank:CastR(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.R.range then
		mh.spellbook:CastSpell(3, mh.networkId)						
	end
end

function Blitzcrank:OnDraw()
	if menu.drawsettings.drawq:get() and self.Q.ready() then
		DrawHandler:Circle3D(myHero.position, self.Q.range, 0xff00ff00)
	end
	if menu.drawsettings.drawe:get() and self.E.ready() then
		DrawHandler:Circle3D(myHero.position, self.E.range, 0xff00ff00)
	end
	if menu.drawsettings.drawr:get() and self.R.ready() then
		DrawHandler:Circle3D(myHero.position, self.R.range, 0xff00ff00)
	end
end


---------------------------------
---------------------------------
----------- UTILS ---------------
---------------------------------
---------------------------------
function Utils:GetDmg(unit, spell)
	if spell == "AD" then
		return self:CalcPhysic(unit, mh.characterIntermediate.flatPhysicalDamageMod + mh.characterIntermediate.baseAttackDamage) or 0
	end
	if spell == "Ignite" then
		return (50 + (20 * mh.experience.level)) or 0
	end
	if mh.charName == "Annie" then
		if spell == "Q" and Annie.Q.ready() then
			return self:CalcMagic(unit, (35 * mh.spellbook:Spell(Q).level + 45) + (mh.characterIntermediate.baseAbilityDamage * 0.8)) or 0
		elseif spell == "W" and Annie.W.ready() then
			return self:CalcMagic(unit, (45 * mh.spellbook:Spell(W).level + 25) + (mh.characterIntermediate.baseAbilityDamage * 0.85)) or 0
		elseif spell == "R" and Annie.R.ready() then
			return self:CalcMagic(unit, (125 * mh.spellbook:Spell(R).level + 25) + (mh.characterIntermediate.baseAbilityDamage * 0.65)) or 0
		end
	elseif mh.charName == "Brand" then
		if spell == "Q" and Brand.Q.ready() then
			return self:CalcMagic(unit, (30 * mh.spellbook:Spell(Q).level + 50) + (mh.characterIntermediate.baseAbilityDamage * 0.55)) or 0
		elseif spell == "W" and Brand.W.ready() then
			if Brand.FiredEnemies[unit.networkId] then
				return self:CalcMagic(unit, (55 * mh.spellbook:Spell(W).level + 40) + (mh.characterIntermediate.baseAbilityDamage * 0.75)) or 0
			else
				return self:CalcMagic(unit, (45 * mh.spellbook:Spell(W).level + 30) + (mh.characterIntermediate.baseAbilityDamage * 0.6)) or 0
			end
		elseif spell == "E" and Brand.E.ready() then
			return self:CalcMagic(unit, (20 * mh.spellbook:Spell(E).level + 50) + (mh.characterIntermediate.baseAbilityDamage * 0.35)) or 0
		elseif spell == "R" and Brand.R.ready() then
			return self:CalcMagic(unit, (100 * mh.spellbook:Spell(R).level) + (mh.characterIntermediate.baseAbilityDamage * 0.25)) * Brand:GetBounces(unit) or 0
		end
	elseif mh.charName == "Blitzcrank" then
		if spell == "Q" and Blitzcrank.Q.ready() then
			return self:CalcMagic(unit, (({80, 135, 190, 245, 300})[mh.spellbook:Spell(Q).level]) + (mh.characterIntermediate.baseAbilityDamage)) or 0
		elseif spell == "E" and Blitzcrank.E.ready() then
			return self:CalcPhysic(unit, mh.characterIntermediate.flatPhysicalDamageMod + mh.characterIntermediate.baseAttackDamage) or 0
		elseif spell == "R" and Blitzcrank.R.ready() then
			return self:CalcMagic(unit, (125 * mh.spellbook:Spell(R).level + 125) + (mh.characterIntermediate.baseAbilityDamage)) or 0
		end
	end
end

function Utils:CalcMagic(unit, dmg)
	local baseMR = unit.characterIntermediate.spellBlock
	local fMagicPen = mh.characterIntermediate.flatMagicPenetration
	if baseMR<fMagicPen then return dmg end
	baseMR = baseMR - fMagicPen
	return dmg * (100 / (100 + (baseMR - mh.characterIntermediate.percentMagicPenetration*baseMR / 100)))
end

function Utils:CalcPhysic(unit, dmg)
	local baseArmor = unit.characterIntermediate.armor
	local Lethality = mh.characterIntermediate.physicalLethality * (0.6 + 0.4 * mh.experience.level / 18)
	local armorpenprecent = unit.type == mh.type and mh.characterIntermediate.percentArmorPenetration or 1
	if baseArmor<Lethality then return dmg end
	baseArmor = baseArmor - Lethality
	return dmg * (100 / (100 + (baseArmor - (armorpenprecent*baseArmor) / 100)))
end

function Utils:GetDistanceSqr(p1, p2)
	p2 = p2 or mh
	p1 = p1.position or p1
	p2 = p2.position or p2
	local dx = p1.x - p2.x
	local dz = p1.z - p2.z
	return dx*dx + dz*dz
end

function Utils:GetDistance(p1, p2)
    return math.sqrt(self:GetDistanceSqr(p1, p2))
end

function Utils:ValidTarget(target)
	return target and target.isValid and (target.team ~= mh.team) and not target.isInvulnerable and not target.isDead and target.isVisible
end

function Utils:GetTarget(range)
	for k, v in pairs(ObjectManager:GetEnemyHeroes()) do
		if self:ValidTarget(v) and self:GetDistance(v, mh) < range then
			return v
		end
	end
end

function Utils:GetMinion(range)
	for k, v in pairs(ObjectManager:GetEnemyMinions()) do
		if self:ValidTarget(v) and self:GetDistance(v, mh) < range then
			return v
		end
	end
end

function Utils:CountObjectsNearPos(pos, radius, objects)
    local n = 0
    for i, object in ipairs(objects) do
        if self:GetDistance(pos, object) <= radius then
            n = n + 1
        end
    end
    return n
end

function Utils:GetBestCircleFarmPosition(range, radius, objects)
    local BestPos 
    local BestHit = 0
    for i, object in ipairs(objects) do
		if self:GetDistance(object) < range then
			local hit = self:CountObjectsNearPos(object, radius, objects)
			if hit > BestHit then
				BestHit = hit
				BestPos = object
				if BestHit == #objects then
				   break
				end
			end
		end
    end
    return self:Convert(BestPos), BestHit
end

function Utils:TableMerge(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

function Utils:GetJungleMinions()
	local jungleminions = {}
	local minions = ObjectManager:GetEnemyMinions()
	for i = 1, #minions do
		local minion = minions[i]
		if minion.team == 3 and Utils:GetDistance(minion, mh) < 1200 then
			jungleminions[#jungleminions + 1] = minion
		end
	end
	return jungleminions
end
  
function Utils:Convert(pos)
	pos = pos.position or pos
	local x = {['x'] = pos.x, ['y'] = pos.y, ['z'] = pos.z}
	return x
end

---------------------------------
---------------------------------
------- ORBWALKER ---------------
---------------------------------
---------------------------------
function Orbwalk:Init()
	self.LastAA = 0
	AddEvent(Events.OnBasicAttack,function(Source, Spell) self:OnBasicAttack(Source, Spell) end)
end

function Orbwalk:Orbwalk()
	local Target = nil
	if IsKeyDown(0x20) then 
		Target = Utils:GetTarget(mh.characterIntermediate.attackRange)
	elseif IsKeyDown(0x43) then
		local minion = Utils:GetMinion(mh.characterIntermediate.attackRange)
		if minion and minion.health <= math.floor(Utils:GetDmg(minion, "AD")) then
			Target = minion
		else
			Target = Utils:GetTarget(mh.characterIntermediate.attackRange)
		end
	elseif IsKeyDown(0x56) then
		Target = Utils:GetMinion(mh.characterIntermediate.attackRange)
	end	
	if mh.canAttack then
		if GetTickCount() + (NetClient.ping / 2) + 25 >= self.LastAA + (mh.attackDelay * 1000) then
			if Target ~= nil then
				self.LastAA = GetTickCount() + NetClient.ping + 100 - (mh.attackCastDelay * 1000)
				mh:IssueOrder(GameObjectOrder.AttackUnit,Target)    
			end
		end
	end
	if GetTickCount() + (NetClient.ping / 2) >= self.LastAA + (mh.attackCastDelay * 1000) + 90 then
        mh:IssueOrder(GameObjectOrder.MoveTo,pwHud.hudManager.activeVirtualCursorPos)
    end
end

function Orbwalk:OnBasicAttack(Source, Spell)
	if Source.isValid and Source.type == GameObjectType.AIHeroClient and Source.networkId == mh.networkId  then
		self.LastAA = GetTickCount() - (NetClient.ping / 2)
	end
end

---------------------------------
---------------------------------
------ PREDICTION ---------------
---------------------------------
---------------------------------
function Prediction:prediction(unit, delay, speed, range, width, collision)
	local hit = 2
	speed = speed or math.huge
	local pathes = unit.aiManagerClient.navPath
	if pathes.isMoving then  
		local pathPot = (unit.characterIntermediate.movementSpeed*((Utils:GetDistance(mh, unit)/speed)+delay))*.99
		local pStart = Vector(unit.position.x, unit.position.y, unit.position.z)
		local pEnd = Vector(pathes.paths[2].x, pathes.paths[2].y, pathes.paths[2].z)
		local iPathDist = Utils:GetDistance(pEnd, pStart) 
		if pathPot > iPathDist then
			pathPot = pathPot-iPathDist
		else 
			local v = Vector(pStart) + (Vector(pEnd) - Vector(pStart)):normalized()* pathPot
			local collision2 = self:MinionCollision(myHero.position, v, delay, speed, width, range, 1)
			if collision and collision2 then
				hit = 0
			end
			return v, hit
		end
	else
		local collision2 = self:MinionCollision(myHero.position, unit.position, delay, speed, width, range, 1)
		if collision and collision2 then 
			hit = 0
		end
		return unit.position, hit
	end
end

function Prediction:MinionCollision(from, endpos, delay, speed, width, range, n)
	local result, threshold = { }, math.huge
	local source, sq_range = from, range and range * range or math.huge
	for index, minion in pairs(ObjectManager:GetEnemyMinions()) do
		if Utils:ValidTarget(minion, range+100) then
			local p = minion.position
			if sq_range == math.huge or (p.x - source.x) ^ 2 + (p.z - source.z) ^ 2 - self:GetHitBox(minion) ^ 2 < sq_range then
				local t = self:CheckColl(source, endpos, minion, delay, speed, width)
				if t and t > 0 then--and GetHealthPrediction(minion, delay + t) > 0 then
					if n and #result + 1 > n then 
						return true 
					end
					table.insert(result, t < threshold and 1 or #result, minion)
				end
			end
		end
	end
	return #result > 0 and result
end

function Prediction:CheckColl(startPos, endPos, unit, delay, speed, width)
	local startPath = unit.position
	local v1 = { ['x'] = endPos.x - startPos.x, ['y'] = endPos.z - startPos.z }
	local d1 = math.sqrt(v1.x * v1.x + v1.y * v1.y)
	if unit.aiManagerClient.navPath.isMoving then
		local endPath = unit.aiManagerClient.navPath.paths[1]
		v1.x, v1.y = (v1.x / d1) * speed, (v1.y / d1) * speed
		local v2 = { x = endPath.x - startPath.x, y = endPath.z - startPath.z }
		local d2 = math.sqrt(v2.x * v2.x + v2.y * v2.y)
		local mS = unit.characterIntermediate.movementSpeed
		v2.x, v2.y = (v2.x / d2) * mS, (v2.y / d2) * mS
		local p = { x = startPos.x - endPath.x, y = startPos.z - endPath.z }
		if p.x * p.x + p.y * p.y < d1 * d1 then
			local v = { x = v1.x - v2.x, y = v1.y - v2.y }
			local a = (v.x * v.x) + (v.y * v.y)
			local b = 2 * ((p.x * v.x) + (p.y * v.y))
			local c = ((p.x * p.x) + (p.y * p.y)) - (width + self:GetHitBox(unit)) ^ 2
			local discriminant = b * b - 4 * a * c
			if discriminant >= 0 then
				local t1 = (-b + math.sqrt(discriminant)) / (2 * a)
				local t2 = (-b - math.sqrt(discriminant)) / (2 * a)
				local t = math.min(t1, t2)
				return t > 0 and t
			end
		end
	else
		local d2 = math.sqrt((startPath.x - startPos.x) ^ 2 + (startPath.z - startPos.z) ^ 2)
		if d2 < d1 then
			v1.x, v1.y = (v1.x / d1) * d2, (v1.y / d1) * d2
			if (startPath.x - (startPos.x + v1.x)) ^ 2 + (startPath.z - (startPos.z + v1.y)) < (self:GetHitBox(unit) + width) ^ 2 then
				return d2 / speed
			end
		end
	end
end

function Prediction:GetHitBox(unit)
	return unit.boundingRadius
end