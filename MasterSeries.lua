--last update: fixed bug in auto interrupt & anti gapcloser, Morgana added auto shield(addd more spells list in future)

require ('damageLib\\damageLib')
require 'GeometryLib'
require 'FF15menu'
Annie = {}
Brand = {}
Blitzcrank = {}
Syndra = {}
Lux = {}
Fizz = {}
Morgana = {}
Orbwalk = {}
Prediction = {}
Utils = {}
local mh = myHero
local huge, flor, sqrtt, minn = math.huge, math.floor, math.sqrt, math.min
local Enemies = ObjectManager:GetEnemyHeroes()
local gapcloserspells = {
		["Aatrox"]                      = {"Q"},
		["Akali"]                       = {"R"},
		["Alistar"]                     = {"W"},
		["Amumu"]                       = {"Q"},
		["Corki"]                       = {"W"},
		["Diana"]                       = {"R"},
		["Elise"]                       = {"Q", "E"},
		["FiddleSticks"]                = {"R"},
		["Ezreal"]                      = {"E"},
		["Fiora"]                       = {"Q"},
		["Fizz"]                        = {"Q"},
		["Galio"]                       = {"E"},
		["Gnar"]                        = {"E"},
		["Gragas"]                      = {"E"},
		["Graves"]                      = {"E"},
		["Hecarim"]                     = {"R"},
		["Irelia"]                      = {"Q"},
		["JarvanIV"]                    = {"Q", "R"},
		["Jax"]                         = {"Q"},
		["Jayce"]                       = {"Q"},
		["Kaisa"]                       = {"E", "R"},
		["Katarina"]                    = {"E"},
		["Kassadin"]                    = {"R"},
		["Kayn"]                        = {"Q"},
		["Kennen"]                      = {"E"},
		["KhaZix"]                      = {"E"},
		["Lissandra"]                   = {"E"},
		["LeBlanc"]                     = {"W", "R"},
		["LeeSin"]                      = {"Q", "W"},
		["Leona"]                       = {"E"},
		["Lucian"]                      = {"E"},
		["Malphite"]                    = {"R"},
		["MasterYi"]                    = {"Q"},
		["MonkeyKing"]                  = {"E"},
		["Nautilus"]                    = {"Q"},
		["Nocturne"]                    = {"R"},
		["Olaf"]                        = {"R"},
		["Ornn"]                        = {"E"},
		["Pantheon"]                    = {"W", "R"},
		["Poppy"]                       = {"E"},
		["RekSai"]                      = {"E"},
		["Renekton"]                    = {"E"},
		["Riven"]                       = {"Q", "E"},
		["Rengar"]                      = {"R"},
		["Sejuani"]                     = {"Q"},
		["Sion"]                        = {"R"},
		["Shen"]                        = {"E"},
		["Shyvana"]                     = {"R"},
		["Talon"]                       = {"E"},
		["Thresh"]                      = {"Q"},
		["Tristana"]                    = {"W"},
		["Tryndamere"]                  = {"E"},
		["Udyr"]                        = {"E"},
		["Urgot"]                       = {"E"},
		["Volibear"]                    = {"Q"},
		["Vi"]                          = {"Q"},
		["XinZhao"]                     = {"E"},
		["Yasuo"]                       = {"E"},
		["Zac"]                         = {"E"},
		["Ziggs"]                       = {"W"},
		["Zoe"]                         = {"R"},
}
local chanellingspells = {
    ["Caitlyn"]                     = {"R"},
    ["Darius"]                      = {"R"},
    ["FiddleSticks"]                = {"W", "R"},
    ["Galio"]                       = {"W"},
    ["Gragas"]                      = {"W"},
    ["Janna"]                       = {"R"},
    ["Karthus"]                     = {"R"},
    ["Katarina"]                    = {"R"},
    ["Lucian"]                      = {"R"},
    ["Malzahar"]                    = {"R"},
    ["MasterYi"]                    = {"W"},
    ["MissFortune"]                 = {"R"},
    ["Nunu"]                        = {"R"},
    ["Pantheon"]                    = {"E", "R"},
    ["Shen"]                        = {"R"},
    ["Sion"]                        = {"Q"},
    ["TahmKench"]                   = {"R"},
    ["TwistedFate"]                 = {"R"},
    ["Warwick"]                     = {"R"},
    ["Varus"]                       = {"Q"},
    ["VelKoz"]                      = {"R"},
    ["Vi"]                          = {"Q"},
    ["Xerath"]                      = {"Q", "R"},
    ["Zac"]                         = {"E"},
}


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
	elseif mh.charName == "Syndra" then
		Syndra:Init()
		PrintChat("<b><font color=\"#ff6600\">MasterSeries: </font></b><font color=\"#FFFFFF\"> Syndra Loaded. Welcome :)</font>")
	elseif mh.charName == "Lux" then
		Lux:Init()
		PrintChat("<b><font color=\"#ff6600\">MasterSeries: </font></b><font color=\"#FFFFFF\"> Lux Loaded. Welcome :)</font>")
	elseif mh.charName == "Fizz" then
		Fizz:Init()
		PrintChat("<b><font color=\"#ff6600\">MasterSeries: </font></b><font color=\"#FFFFFF\"> Fizz Loaded. Welcome :)</font>")
	elseif mh.charName == "Morgana" then
		Morgana:Init()
		PrintChat("<b><font color=\"#ff6600\">MasterSeries: </font></b><font color=\"#FFFFFF\"> Morgana Loaded. Welcome :)</font>")
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
	menu:sub("ultsettings", "Ultimate Black List")
	menu:sub("gapclosersettings", "Anti Gap-Closer Settings")
	menu:sub("interruptsettings", "Auto-Interrupt Settings")
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
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		menu.ultsettings:checkbox(enemy.charName, "Disable for " .. enemy.charName, false)
	end
	-------------
	menu.gapclosersettings:label("str", "Spells List:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitGapcloserSpells = gapcloserspells[enemy.charName]
		if UnitGapcloserSpells then
			for i, slot in pairs(UnitGapcloserSpells) do
				menu.gapclosersettings:checkbox(enemy.charName.."."..slot, "GapCloser "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.gapclosersettings:label("str2", "-----------")
	menu.gapclosersettings:checkbox("enable", "Enable Anti-Gaploser", true)
	-------------
	menu.interruptsettings:label("str", "Spells List:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitInterruptSpells = chanellingspells[enemy.charName]
		if UnitInterruptSpells then
			for i, slot in pairs(UnitInterruptSpells) do
				menu.interruptsettings:checkbox(enemy.charName.."."..slot, "Interrupt "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.interruptsettings:label("str2", "-----------")
	menu.interruptsettings:checkbox("enable", "Enable Auto-Interrupt", true)
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
		slot = mh.spellbook:Spell(Q),
		ready = function() return mh.spellbook:CanUseSpell(0) == 0 end,
		range = 1050,
		pred = {
			delay = 0.25,
			width = 80,
			speed = 1500,
			collision = true,
		},
	}
	self.W = {
		slot = mh.spellbook:Spell(W),
		ready = function() return mh.spellbook:CanUseSpell(1) == 0 end,
		range = 900,
		pred = {
			delay = 0.75,
			radius = 250,
			speed = huge,
			collision = false,
		},
	}
	self.E = {
		slot = mh.spellbook:Spell(E),
		ready = function() return mh.spellbook:CanUseSpell(2) == 0 end,
		range = 625,
	}
	self.R = {
		slot = mh.spellbook:Spell(R),
		ready = function() return mh.spellbook:CanUseSpell(3) == 0 end,
		range = 775,
	}
	AddEvent(Events.OnBuffGain, function(unit, buff) self:OnGainBuff(unit, buff) end)
	AddEvent(Events.OnBuffLost, function(unit, buff) self:OnRemoveBuff(unit, buff) end)
	AddEvent(Events.OnTick, function() self:OnTick() end)
	AddEvent(Events.OnDraw, function() self:OnDraw() end)
	AddEvent(Events.OnProcessSpell, function(unit, spell) self:OnProcessSpell(unit, spell) end)
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
	if self.target then print(self.target.charName) end
end

function Brand:OnGainBuff(unit, buff)
	if unit.team ~= mh.enemy and not unit.isDead and buff and buff and buff.name == "BrandAblaze" then
		self.FiredEnemies[unit.networkId] = unit
	end
end

function Brand:OnRemoveBuff(unit, buff)
	if unit and self.FiredEnemies[unit.networkID] and buff and buff.name == "BrandAblaze" then
		self.FiredEnemies[unit.networkId] = nil
	end
end

function Brand:OnProcessSpell(unit, spell)
	if menu.gapclosersettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit, self.Q.range) then
				if self.Q.ready() and self.E.ready() then
					local UnitGapcloserSpells = gapcloserspells[unit.charName]
					if UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.spellSlot == Utils:StringToSlot(slot) and menu.gapclosersettings[unit.charName .. "." .. slot]:get() then 
								if spell.target and spell.target == mh then
									self:CastE(unit)
									mh.spellbook:CastSpell(0, D3DXVECTOR3(unit.x, unit.y, unit.z))	
								elseif not spell.target then
									local endPos1 = Vector(unit) + 300 * (Vector(spell.endPos) - Vector(unit)):normalized()
									local endPos2 = Vector(unit) + 100 * (Vector(spell.endPos) - Vector(unit)):normalized()
									if (Utils:GetDistance(mh, unit) > Utils:GetDistance(mh, endPos1) or Utils:GetDistance(mh, unit) > Utils:GetDistance(mh, endPos2)) then
										self:CastE(unit)
										mh.spellbook:CastSpell(0, D3DXVECTOR3(unit.x, unit.y, unit.z))	
									end
								end
							end
						end
					end
				end
			end
		end
    end
	if menu.interruptsettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit, self.E.range) then
				if self.Q.ready() and self.E.ready() then
					local UnitInterruptSpells = chanellingspells[unit.charName]
					if UnitInterruptSpells then
						for _, slot in pairs(UnitInterruptSpells) do
							if spell.spellSlot == Utils:StringToSlot(slot) and menu.interruptsettings[unit.charName .. "." .. slot]:get() then 
								self:CastE(unit)
								mh.spellbook:CastSpell(0, D3DXVECTOR3(unit.x, unit.y, unit.z))	
							end
						end
					end
				end
			end
		end
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
	if menu.combosettings.user:get() and self.R.ready() and not menu.ultsettings[self.target.charName] then
		local dmg = flor(GetSpellDamage(mh, self.target, SpellSlot.Q)) + flor(GetSpellDamage(mh, self.target, SpellSlot.W)) + flor(GetSpellDamage(mh, self.target, SpellSlot.E)) + flor(GetSpellDamage(mh, self.target, SpellSlot.R))
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
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		if Utils:ValidTarget(enemy) and Utils:GetDistance(enemy, mh) < self.Q.range then
			local qdmg = GetSpellDamage(mh, enemy, SpellSlot.Q)
			local wdmg = GetSpellDamage(mh, enemy, SpellSlot.W)
			local edmg = GetSpellDamage(mh, enemy, SpellSlot.E)
			local idmg = Utils:GetDmg(enemy, "Ignite")
			if menu.killstealsettings.useq:get() and self.Q.ready() and enemy.health < qdmg then
				self:CastQ(enemy)
			elseif menu.killstealsettings.usew:get() and self.W.ready() and enemy.health < wdmg then
				self:CastW(enemy)
			elseif menu.killstealsettings.usee:get() and self.E.ready() and enemy.health < edmg then
				self:CastE(enemy)
			elseif menu.killstealsettings.usei:get() and self.I.ready() and enemy.health < idmg and Utils:GetDistance(enemy, mh) < self.I.range then
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
	local obj2 = Utils:TableMerge(obj, Utils:GetJungleMinions(self.R.range+200))
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
	menu:sub("ultsettings", "Ultimate Black List")
	menu:sub("gapclosersettings", "Anti Gap-Closer Settings")
	menu:sub("interruptsettings", "Auto-Interrupt Settings")
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
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		menu.ultsettings:checkbox(enemy.charName, "Disable for " .. enemy.charName, false)
	end
	-------------
	menu.gapclosersettings:label("str", "Spells List:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitGapcloserSpells = gapcloserspells[enemy.charName]
		if UnitGapcloserSpells then
			for i, slot in pairs(UnitGapcloserSpells) do
				menu.gapclosersettings:checkbox(enemy.charName.."."..slot, "GapCloser "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.gapclosersettings:label("str2", "-----------")
	menu.gapclosersettings:checkbox("enable", "Enable Anti-Gaploser", true)
	-------------
	menu.interruptsettings:label("str", "Spells List:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitInterruptSpells = chanellingspells[enemy.charName]
		if UnitInterruptSpells then
			for i, slot in pairs(UnitInterruptSpells) do
				menu.interruptsettings:checkbox(enemy.charName.."."..slot, "Interrupt "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.interruptsettings:label("str2", "-----------")
	menu.interruptsettings:checkbox("enable", "Enable Auto-Interrupt", true)
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
		slot = mh.spellbook:Spell(Q),
		ready = function() return mh.spellbook:CanUseSpell(0) == 0 end,
		range = 650,
	}
	self.W = {
		slot = mh.spellbook:Spell(W),
		ready = function() return mh.spellbook:CanUseSpell(1) == 0 end,
		range = 650,
		pred = {
			delay = 0.6,
			radius = 180,
			speed = huge,
			collision = false,
			},
	}
	self.E = {
		slot = mh.spellbook:Spell(E),
		ready = function() return mh.spellbook:CanUseSpell(2) == 0 end,
	}
	self.R = {
		slot = mh.spellbook:Spell(R),
		ready = function() return mh.spellbook:CanUseSpell(3) == 0 end,
		range = 575,
		pred = {
			delay = 0.25,
			radius = 200,
			speed = huge,
			collision = false,
		},
	}
	AddEvent(Events.OnBuffGain, function(unit, buff) self:OnGainBuff(unit, buff) end)
	AddEvent(Events.OnBuffLost, function(unit, buff) self:OnRemoveBuff(unit, buff) end)
	AddEvent(Events.OnBasicAttack, function(unit, spell) self:OnBasicAttack(unit, spell) end)
	AddEvent(Events.OnProcessSpell, function(unit, spell) self:OnProcessSpell(unit, spell) end)
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
	if unit and unit == mh and buff and (buff.name == "pyromania_particle") then
		self.passive = true
	end 
end

function Annie:OnRemoveBuff(unit, buff)
	if unit and unit == mh and buff and (buff.name == "pyromania_particle") then
		self.passive = false
	end 
end

function Annie:OnBasicAttack(unit, spell)
	if menu.combosettings.combokey:get() and unit and spell and unit.type == GameObjectType.AIHeroClient and spell.target.networkId == mh.networkId then
		if menu.combosettings.usee:get() and self.E.ready() then
			self:CastE()
		end
	end
end

function Annie:OnProcessSpell(unit, spell)
	if menu.gapclosersettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit, self.Q.range) then
				if self.passive and (self.Q.ready() or self.W.ready()) then
					local UnitGapcloserSpells = gapcloserspells[unit.charName]
					if UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.spellSlot == Utils:StringToSlot(slot) and menu.gapclosersettings[unit.charName .. "." .. slot]:get() then 
								if spell.target and spell.target == mh then
									if self.Q.ready() then
										self:CastQ(unit)
									elseif self.W.ready() then
										self:CastW(unit)
									end
								elseif not spell.target then
									local endPos1 = Vector(unit) + 300 * (Vector(spell.endPos) - Vector(unit)):normalized()
									local endPos2 = Vector(unit) + 100 * (Vector(spell.endPos) - Vector(unit)):normalized()
									if (Utils:GetDistance(mh, unit) > Utils:GetDistance(mh, endPos1) or Utils:GetDistance(mh, unit) > Utils:GetDistance(mh, endPos2)) then
										if self.Q.ready() then
											self:CastQ(unit)
										elseif self.W.ready() then
											self:CastW(unit)
										end
									end
								end
							end
						end
					end
				end
			end
		end
    end
	if menu.interruptsettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit, self.Q.range) then
				if self.passive and (self.Q.ready() or self.W.ready()) then
					local UnitInterruptSpells = chanellingspells[unit.charName]
					if UnitInterruptSpells then
						for _, slot in pairs(UnitInterruptSpells) do
							if spell.spellSlot == Utils:StringToSlot(slot) and menu.interruptsettings[unit.charName .. "." .. slot]:get() then 
								if self.Q.ready() then
									self:CastQ(unit)
								elseif self.W.ready() then
									self:CastW(unit)
								end
							end
						end
					end
				end
			end
		end
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
	if menu.combosettings.user:get() and self.R.ready() and not menu.ultsettings[self.target.charName] then
		local dmg = flor(GetSpellDamage(mh, self.target, SpellSlot.Q)) + flor(GetSpellDamage(mh, self.target, SpellSlot.W)) + flor(GetSpellDamage(mh, self.target, SpellSlot.R))
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
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		if Utils:ValidTarget(enemy) and Utils:GetDistance(enemy, mh) < self.Q.range then
			local qdmg = GetSpellDamage(mh, enemy, SpellSlot.Q)
			local wdmg = GetSpellDamage(mh, enemy, SpellSlot.W)
			local idmg = Utils:GetDmg(enemy, "Ignite")
			if menu.killstealsettings.useq:get() and self.Q.ready() and enemy.health < qdmg then
				self:CastQ(enemy)
			elseif menu.killstealsettings.usew:get() and self.W.ready() and enemy.health < wdmg then
				self:CastW(enemy)
			elseif menu.killstealsettings.usei:get() and self.I.ready() and enemy.health < idmg and Utils:GetDistance(enemy, mh) < self.I.range then
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
	menu:sub("ultsettings", "Ultimate Black List")
	menu:sub("interruptsettings", "Auto-Interrupt Settings")
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
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		menu.ultsettings:checkbox(enemy.charName, "Disable for " .. enemy.charName, false)
	end
	-------------
	menu.interruptsettings:label("str", "Spells List:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitInterruptSpells = chanellingspells[enemy.charName]
		if UnitInterruptSpells then
			for i, slot in pairs(UnitInterruptSpells) do
				menu.interruptsettings:checkbox(enemy.charName.."."..slot, "Interrupt "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.interruptsettings:label("str2", "-----------")
	menu.interruptsettings:checkbox("enable", "Enable Auto-Interrupt", true)
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
		slot = mh.spellbook:Spell(Q),
		ready = function() return mh.spellbook:CanUseSpell(0) == 0 end,
		range = 1050,
		pred = {
			delay = 0.25,
			radius = 70,
			speed = 1800,
			collision = true,
		},
	}
	self.W = {
		slot = mh.spellbook:Spell(W),
		ready = function() return mh.spellbook:CanUseSpell(1) == 0 end,
	}
	self.E = {
		slot = mh.spellbook:Spell(E),
		ready = function() return mh.spellbook:CanUseSpell(2) == 0 end,
		range = mh.characterIntermediate.attackRange+150,
	}
	self.R = {
		slot = mh.spellbook:Spell(R),
		ready = function() return mh.spellbook:CanUseSpell(3) == 0 end,
		range = 600,
	}
	AddEvent(Events.OnBuffGain, function(unit, buff) self:OnGainBuff(unit, buff) end)
	AddEvent(Events.OnProcessSpell, function(unit, spell) self:OnProcessSpell(unit, spell) end)
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
	if unit.team ~= mh.enemy and not unit.isDead and buff and buff.isValid and buff.name == "rocketgrab2" then
		if ((menu.combosettings.combokey:get() and menu.combosettings.usee:get()) or (menu.harasssettings.harasskey:get() and menu.harasssettings.usee:get())) and self.E.ready() then
			self:CastE(self.target)
		end
	end
end

function Blitzcrank:OnProcessSpell(unit, spell)
	if menu.interruptsettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit, self.Q.range) then
				if self.Q.ready() or self.R.ready() then
					local UnitInterruptSpells = chanellingspells[unit.charName]
					if UnitInterruptSpells then
						for _, slot in pairs(UnitInterruptSpells) do
							if spell.spellSlot == Utils:StringToSlot(slot) and menu.interruptsettings[unit.charName .. "." .. slot]:get() then 
								if self.R.ready() then
									self:CastR(unit)
								elseif self.Q.ready() then
									self:CastQ(unit)
								end
							end
						end
					end
				end
			end
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
	if menu.combosettings.user:get() and self.R.ready() and not menu.ultsettings[self.target.charName] then
		local dmg = flor(GetSpellDamage(mh, self.target, SpellSlot.Q)) + flor(GetSpellDamage(mh, self.target, SpellSlot.R))
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
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		if Utils:ValidTarget(enemy) and Utils:GetDistance(enemy, mh) < self.Q.range then
			local qdmg = GetSpellDamage(mh, enemy, SpellSlot.Q)
			local rdmg = GetSpellDamage(mh, enemy, SpellSlot.R)
			local idmg = Utils:GetDmg(enemy, "Ignite")
			if menu.killstealsettings.useq:get() and self.Q.ready() and enemy.health < qdmg then
				self:CastQ(enemy)
			elseif menu.killstealsettings.user:get() and self.R.ready() and enemy.health < rdmg then
				self:CastR(enemy)
			elseif menu.killstealsettings.usei:get() and self.I.ready() and enemy.health < idmg and Utils:GetDistance(enemy, mh) < self.I.range then
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
----------- SYNDRA --------------
---------------------------------
---------------------------------
function Syndra:Menu()
	menu = Menu("MasterSeries", "MasterSeries-Syndra")
	menu:sub("combosettings", "Combo Settings")
	menu:sub("harasssettings", "Harass Settings")
	menu:sub("clearsettings", "Clear Settings")
	menu:sub("killstealsettings", "KillSteal Settings")
	menu:sub("ultsettings", "Ultimate Black List")
	menu:sub("gapclosersettings", "Anti Gap-Closer Settings")
	menu:sub("interruptsettings", "Auto-Interrupt Settings")
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
	menu.killstealsettings:checkbox("user", "Use (R)", true)
	menu.killstealsettings:checkbox("usei", "Use Ignite", true)
	-------------
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		menu.ultsettings:checkbox(enemy.charName, "Disable for " .. enemy.charName, false)
	end
	-------------
	menu.gapclosersettings:label("str", "Spells List:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitGapcloserSpells = gapcloserspells[enemy.charName]
		if UnitGapcloserSpells then
			for i, slot in pairs(UnitGapcloserSpells) do
				menu.gapclosersettings:checkbox(enemy.charName.."."..slot, "GapCloser "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.gapclosersettings:label("str2", "-----------")
	menu.gapclosersettings:checkbox("enable", "Enable Anti-Gaploser", true)
	-------------
	menu.interruptsettings:label("str", "Spells List:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitInterruptSpells = chanellingspells[enemy.charName]
		if UnitInterruptSpells then
			for i, slot in pairs(UnitInterruptSpells) do
				menu.interruptsettings:checkbox(enemy.charName.."."..slot, "Interrupt "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.interruptsettings:label("str2", "-----------")
	menu.interruptsettings:checkbox("enable", "Enable Auto-Interrupt", true)
	-------------
	menu.drawsettings:checkbox("drawq", "Draw (Q) Circle", true)
	menu.drawsettings:checkbox("draww", "Draw (W) Circle", true)
	menu.drawsettings:checkbox("drawe", "Draw (E) Circle", true)
	menu.drawsettings:checkbox("drawr", "Draw (R) Circle", true)
end

function Syndra:Init()
	self.Pets = {"annietibbers", "shacobox", "malzaharvoidling", "heimertyellow", "heimertblue", "yorickdecayedghoul"}
	self.Balls = {}
	self.eHitTimer = 0
	self.qcasted, self.wcasted, self.ecasted = false, false, false
	self.target, self.tsrange = nil, 1200
	self.I = {
		slot = mh.spellbook:Spell(4).name:find("SummonerDot") and 4 or mh.spellbook:Spell(5).name:find("SummonerDot") and 5 or nil,
		ready = function() return self.I.slot and mh.spellbook:CanUseSpell(self.I.slot) == 0  or false end,
		range = 600,
	}
	self.Q = {
		slot = mh.spellbook:Spell(Q),
		ready = function() return mh.spellbook:CanUseSpell(0) == 0 end,
		range = 800,
		pred = {
			delay = 0.5,
			width = 165,
			speed = huge,
			collision = false,
		},
	}
	self.W = {
		slot = mh.spellbook:Spell(W),
		ready = function() return mh.spellbook:CanUseSpell(1) == 0 end,
		range = 950,
		pred = {
			delay = 0.25,
			radius = 140,
			speed = 1500,
			collision = false,
		},
	}
	self.E = {
		slot = mh.spellbook:Spell(E),
		ready = function() return mh.spellbook:CanUseSpell(2) == 0 end,
		range = 700,
		pred = {
			delay = 0.25,
			radius = 45,
			speed = 2500,
			collision = false,
		},
	}
	self.R = {
		slot = mh.spellbook:Spell(R),
		ready = function() return mh.spellbook:CanUseSpell(3) == 0 end,
		range = 675,
	}
	AddEvent(Events.OnProcessSpell, function(unit, spell) self:OnProcessSpell(unit, spell) end)
	AddEvent(Events.OnTick, function() self:OnTick() end)
	AddEvent(Events.OnDraw, function() self:OnDraw() end)
	self:Menu()
end

function Syndra:OnTick()
	if self.Q.ready() and self.E.ready() then
		self.tsrange = 1300
	elseif self.Q.ready() and not self.E.ready() then
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
	self:DeleteOldBalls()
	if self.qcasted and not self.Q.ready() then
		self.qcasted = false
	end
	if self.wcasted and not self.W.ready() then
		self.wcasted = false
	end
	if self.ecasted and not self.E.ready() then
		self.ecasted = false
	end
end

function Syndra:Combo()
	if not Utils:ValidTarget(self.target) then return end
	if menu.combosettings.useq:get() and menu.combosettings.usee:get() then
		self:QECast(self.target)
	end
	if menu.combosettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.combosettings.usew:get() and self.W.ready() then
		self:CastW(self.target)
	end
	if menu.combosettings.usee:get() and self.E.ready() then
		self:CastE(self.target)
	end
	if menu.combosettings.user:get() and self.R.ready() and not menu.ultsettings[self.target.charName] then
		local dmg = flor(GetSpellDamage(mh, self.target, SpellSlot.Q)) + flor(GetSpellDamage(mh, self.target, SpellSlot.W)) + flor(GetSpellDamage(mh, self.target, SpellSlot.E)) + flor(GetSpellDamage(mh, self.target, SpellSlot.R))
		if self.target.health < dmg then
			self:CastR(self.target)
		end
	end
end

function Syndra:Harass()
	if not Utils:ValidTarget(self.target) then return end
	if menu.harasssettings.useq:get() and menu.harasssettings.usee:get() then
		self:QECast(self.target)
	end
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

function Syndra:Clear()
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
			if menu.clearsettings.usee:get() and Utils:GetDistance(minion, mh) <= self.E.range then
				self:CastE(minion)
			end
		end
	end
end

function Syndra:KillSteal()
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		if Utils:ValidTarget(enemy) and Utils:GetDistance(enemy, mh) < self.Q.range then
			local qdmg = GetSpellDamage(mh, enemy, SpellSlot.Q)
			local wdmg = GetSpellDamage(mh, enemy, SpellSlot.W)
			local rdmg = GetSpellDamage(mh, enemy, SpellSlot.R)
			local idmg = Utils:GetDmg(enemy, "Ignite")
			if menu.killstealsettings.useq:get() and self.Q.ready() and enemy.health < qdmg then
				self:CastQ(enemy)
			elseif menu.killstealsettings.usew:get() and self.W.ready() and enemy.health < wdmg then
				self:CastW(enemy)
			elseif menu.killstealsettings.user:get() and self.R.ready() and enemy.health < rdmg then
				self:CastR(enemy)
			elseif menu.killstealsettings.usei:get() and self.I.ready() and enemy.health < idmg and Utils:GetDistance(enemy, mh) < self.I.range then
				mh.spellbook:CastSpell(self.I.slot, enemy.networkId)	
			end
		end
	end
end

function Syndra:CastQ(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.Q.range then
		local x, y = Prediction:prediction(unit, self.Q.pred.delay, self.Q.pred.speed, self.Q.range, self.Q.pred.width, self.Q.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(0, D3DXVECTOR3(x.x, x.y, x.z))			
		end
	end
end

function Syndra:CastW(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.W.range then	
		if mh.spellbook:Spell(W).toggleState == 1 then
			local orbb = self:GetOrb()
			local pet = self:GetPet()
			if orbb and self:CanGrabOrb() then
				mh.spellbook:CastSpell(1, D3DXVECTOR3(orbb.x, orbb.y, orbb.z))	
			elseif pet then
				mh.spellbook:CastSpell(1, D3DXVECTOR3(pet.x, pet.y, pet.z))	
			elseif not pet and not orbb then
				local minion = Utils:GetMinion(925)
				if minion and Utils:ValidTarget(minion, 925) and Utils:GetDistance(minion) <= 925 then
					mh.spellbook:CastSpell(1, D3DXVECTOR3(minion.position.x, minion.position.y, minion.position.z))	
				end
			end
		end
		if mh.spellbook:Spell(W).toggleState == 2 then
			local x, y = Prediction:prediction(unit, self.W.pred.delay, self.W.pred.speed, self.W.range, self.W.pred.radius, self.W.pred.collision)
			if x and y >= 2 then
				mh.spellbook:CastSpell(1, D3DXVECTOR3(x.x, x.y, x.z))			
			end	
		end	
	end
end

function Syndra:CastE(unit)
	if Utils:ValidTarget(unit) then		
		local StunBall = self:GetStunBall(mh, unit)
		if StunBall and Utils:GetDistance(StunBall) < self.E.range then
			mh.spellbook:CastSpell(2, D3DXVECTOR3(StunBall.x, unit.position.y, StunBall.z))
		end
	end
end

function Syndra:CastR(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.R.range then
		mh.spellbook:CastSpell(3, unit.networkId)				
	end
end

function Syndra:QECast(unit)
	if mh.spellbook:Spell(W).name == "SyndraWCast" and mh.mana > mh.spellbook:Spell(W).spellData.spellDataInfo.mana + mh.spellbook:Spell(E).spellData.spellDataInfo.mana then
		local Position, y = Prediction:prediction(unit, 0.5, 1600, 1300, 100, false)
		if Position and self.E.ready() then
			if Utils:GetDistance(unit) < self.W.range then
				mh.spellbook:CastSpell(1, D3DXVECTOR3(Position.x, Position.y, Position.z))
				if self.wcasted then
					mh.spellbook:CastSpell(2, D3DXVECTOR3(Position.x, Position.y, Position.z))
				end
			else
				local pos = mh.position + 930 * (Vector(Position) - Vector(mh.position)):normalized()
				mh.spellbook:CastSpell(1, D3DXVECTOR3(pos.x, pos.y, pos.z))
				if self.wcasted then
					mh.spellbook:CastSpell(2, D3DXVECTOR3(pos.x, pos.y, pos.z))
				end
			end
		end
	elseif mh.spellbook:Spell(W).name == "SyndraW" and mh.mana > mh.spellbook:Spell(Q).spellData.spellDataInfo.mana + mh.spellbook:Spell(E).spellData.spellDataInfo.mana then
		if self.Q.ready() then
			local Position, y = Prediction:prediction(unit, 0.5, 1600, 1300, 100, false)
			if Position and self.E.ready() then
				if Utils:GetDistance(unit) < self.Q.range then
					mh.spellbook:CastSpell(0, D3DXVECTOR3(Position.x, Position.y, Position.z))
					mh.spellbook:CastSpell(2, D3DXVECTOR3(Position.x, Position.y, Position.z))
				else
					local pos = mh.position + 780 * (Vector(Position) - Vector(mh.position)):normalized()
					mh.spellbook:CastSpell(0, D3DXVECTOR3(pos.x, pos.y, pos.z))
					mh.spellbook:CastSpell(2, D3DXVECTOR3(pos.x, pos.y, pos.z))
				end
			end
		end
	end
end

function Syndra:OnDraw()
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

function Syndra:OnProcessSpell(unit, spell)
	if unit and spell and unit == mh then
		if spell.spellData.name == "SyndraQ" then
			self.qcasted = true
		elseif spell.spellData.name == "SyndraW" then
			self.wcasted = true
		elseif spell.spellData.name == "SyndraE" then
			self.ecasted = true
			self.eHitTimer = RiotClock.time + 0.5
		end
	end
	if unit and spell and unit == mh and spell.spellData.name == "SyndraQ" then
		self.Balls[#self.Balls + 1] = {
			Object = {valid = true, x = spell.endPos.x, y = mh.position.y, z = spell.endPos.z},
			InUse = false,
			Timer = RiotClock.time + 6,
			EndT = os.clock() + 6.9 + 0.6 - NetClient.ping/2000
		}
	end
	if menu.gapclosersettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit, self.E.range) then
				if self.E.ready() then
					local UnitGapcloserSpells = gapcloserspells[unit.charName]
					if UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.spellSlot == Utils:StringToSlot(slot) and menu.gapclosersettings[unit.charName .. "." .. slot]:get() then 
								if spell.target and spell.target == mh then
									mh.spellbook:CastSpell(2, D3DXVECTOR3(unit.x, unit.y, unit.z))	
								elseif not spell.target then
									local endPos1 = Vector(unit) + 300 * (Vector(spell.endPos) - Vector(unit)):normalized()
									local endPos2 = Vector(unit) + 100 * (Vector(spell.endPos) - Vector(unit)):normalized()
									if (Utils:GetDistance(mh, unit) > Utils:GetDistance(mh, endPos1) or Utils:GetDistance(mh, unit) > Utils:GetDistance(mh, endPos2)) then
										mh.spellbook:CastSpell(2, D3DXVECTOR3(unit.x, unit.y, unit.z))	
									end
								end
							end
						end
					end
				end
			end
		end
    end
	if menu.interruptsettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit, self.E.range) then
				if self.E.ready() then
					local UnitInterruptSpells = chanellingspells[unit.charName]
					if UnitInterruptSpells then
						for _, slot in pairs(UnitInterruptSpells) do
							if spell.spellSlot == Utils:StringToSlot(slot) and menu.interruptsettings[unit.charName .. "." .. slot]:get() then 
								mh.spellbook:CastSpell(2, D3DXVECTOR3(unit.x, unit.y, unit.z))	
							end
						end
					end
				end
			end
		end
    end
end

function Syndra:DeleteOldBalls()
	if #self.Balls == 0 then return end
	for i = #self.Balls, 1, -1 do
		if self.Balls[i].EndT <= os.clock() then
			table.remove(self.Balls, i)
		end
	end
end

function Syndra:OrbCount()
	local count = 0
	for i, o in pairs(self.Balls) do
		count = count + 1
	end
	return count
end

function Syndra:GetOrb()
	local orb
	if self:OrbCount() == 0 then
		return orb
	end
	local orbt1 = 0
	for i, kul in pairs(self.Balls) do
		if not kul.InUse and Utils:GetDistance(kul.Object) <= 925 then
			local obrti = kul.Timer
			if orbt1 == 0 then
				orb = kul.Object
				orbt1 = obrti
			elseif obrti < orbt1 then
				orb = kul.Object
				orbt1 = obrti
			end
		end
	end
	return orb
end

function Syndra:CanGrabOrb()
	if self.eHitTimer > 0 and RiotClock.time > self.eHitTimer or self.eHitTimer == 0 then
		self.eHitTimer = 0
		return true
	else
		return false
	end
end

function Syndra:GetStunBall(pStart, pEnd)
	for i, kula in pairs(self.Balls) do
		if kula.Object and Utils:GetDistance(kula.Object, mh) < self.E.range then
			local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Utils:Convert(pStart), Utils:Convert(pEnd), kula.Object)
			if isOnSegment then
				local x = {['x'] = pointSegment.x, ['y'] = mh.position.y, ['z'] = pointSegment.y}
				if Utils:GetDistance(x, kula.Object) < 100 then
					return kula.Object
				end
			end
			
		end
    end
end

function Syndra:GetPet()
	for i, object in ipairs(ObjectManager:GetEnemyMinions()) do
		if object and object.valid and object.team ~= mh.team and self:CheckPetName(object.charName) then
			return object
		end
	end
end

function Syndra:CheckPetName(name) 
	return table.contains(self.Pets, name:lower())
end


---------------------------------
---------------------------------
------------ LUX ----------------
---------------------------------
---------------------------------
function Lux:Menu()
	menu = Menu("MasterSeries", "MasterSeries-Lux")
	menu:sub("combosettings", "Combo Settings")
	menu:sub("harasssettings", "Harass Settings")
	menu:sub("clearsettings", "Clear Settings")
	menu:sub("killstealsettings", "KillSteal Settings")
	menu:sub("ultsettings", "Ultimate Black List")
	menu:sub("gapclosersettings", "Anti Gap-Closer Settings")
	menu:sub("drawsettings", "Draw Settings")
	-------------
	menu.combosettings:checkbox("useq", "Use (Q)", true)
	menu.combosettings:checkbox("usew", "Use (W)", true)
	menu.combosettings:checkbox("usee", "Use (E)", true)
	menu.combosettings:checkbox("user", "Use (R)", true)
	menu.combosettings:key("combokey", "Combo Key:", 32)
	-------------
	menu.harasssettings:checkbox("useq", "Use (Q)", true)
	menu.harasssettings:checkbox("usee", "Use (E)", true)
	menu.harasssettings:key("harasskey", "Harass Key:", 67)
	------------
	menu.clearsettings:checkbox("useq", "Use (Q)", true)
	menu.clearsettings:checkbox("usee", "Use (E)", true)
	menu.clearsettings:key("clearkey", "Clear Key:", 86)
	-------------
	menu.killstealsettings:checkbox("useq", "Use (Q)", true)
	menu.killstealsettings:checkbox("usee", "Use (E)", true)
	menu.killstealsettings:checkbox("user", "Use (R)", true)
	menu.killstealsettings:checkbox("usei", "Use Ignite", true)
	-------------
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		menu.ultsettings:checkbox(enemy.charName, "Disable for " .. enemy.charName, false)
	end
	-------------
	menu.gapclosersettings:label("str", "Spells List:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitGapcloserSpells = gapcloserspells[enemy.charName]
		if UnitGapcloserSpells then
			for i, slot in pairs(UnitGapcloserSpells) do
				menu.gapclosersettings:checkbox(enemy.charName.."."..slot, "GapCloser "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.gapclosersettings:label("str2", "-----------")
	menu.gapclosersettings:checkbox("enable", "Enable Anti-Gaploser", true)
	-------------
	menu.drawsettings:checkbox("drawq", "Draw (Q) Circle", true)
	menu.drawsettings:checkbox("draww", "Draw (W) Circle", true)
	menu.drawsettings:checkbox("drawe", "Draw (E) Circle", true)
	menu.drawsettings:checkbox("drawr", "Draw (R) Circle", true)
end

function Lux:Init()
	self.target, self.tsrange, self.eobject = nil, 1250, nil
	self.I = {
		slot = mh.spellbook:Spell(4).name:find("SummonerDot") and 4 or mh.spellbook:Spell(5).name:find("SummonerDot") and 5 or nil,
		ready = function() return self.I.slot and mh.spellbook:CanUseSpell(self.I.slot) == 0  or false end,
		range = 600,
	}
	self.Q = {
		slot = mh.spellbook:Spell(0),
		ready = function() return mh.spellbook:CanUseSpell(0) == 0 end,
		range = 1250,
		pred = {
			delay = 0.25,
			width = 80,
			speed = 1200,
			collision = true,
		},
	}
	self.W = {
		slot = mh.spellbook:Spell(1),
		ready = function() return mh.spellbook:CanUseSpell(1) == 0 end,
		range = 850,
		pred = {
			delay = 0.25,
			radius = 150,
			speed = 1800,
			collision = false,
		},
	}
	self.E = {
		slot = mh.spellbook:Spell(2),
		ready = function() return mh.spellbook:CanUseSpell(2) == 0 end,
		range = 1100,
		pred = {
			delay = 0.25,
			radius = 310,
			speed = 1200,
			collision = false,
		},
	}
	self.R = {
		slot = mh.spellbook:Spell(3),
		ready = function() return mh.spellbook:CanUseSpell(3) == 0 end,
		range = 3340,
		pred = {
			delay = 1,
			radius = 160,
			speed = huge,
			collision = false,
		},
	}
	AddEvent(Events.OnCreateObject, function(obj) self:OnCreateObject(obj, id) end)
	AddEvent(Events.OnDeleteObject, function(obj) self:OnDeleteObject(obj) end)
	AddEvent(Events.OnProcessSpell, function(unit, spell) self:OnProcessSpell(unit, spell) end)
	AddEvent(Events.OnTick, function() self:OnTick() end)
	AddEvent(Events.OnDraw, function() self:OnDraw() end)
	self:Menu()
end

function Lux:OnTick()
	if self.Q.ready() then
		self.tsrange = self.Q.range
	elseif not self.Q.ready() and self.E.ready() then
		self.tsrange = self.E.range
	elseif not self.Q.ready() and not self.E.ready() then
		self.tsrange = self.W.range
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

function Lux:Combo()
	if not Utils:ValidTarget(self.target) then return end
	print(GetSpellDamage(mh, self.target, SpellSlot.R))
	if menu.combosettings.usee:get() and self.E.ready() then
		self:CastE(self.target)
	end
	if menu.combosettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.combosettings.usew:get() and self.W.ready() then
		self:CastW()
	end
	if menu.combosettings.user:get() and self.R.ready() and not menu.ultsettings[self.target.charName] then
		local dmg = flor(GetSpellDamage(mh, self.target, SpellSlot.Q)) + flor(GetSpellDamage(mh, self.target, SpellSlot.E)) + flor(GetSpellDamage(mh, self.target, SpellSlot.R))
		if self.target.health < dmg then
			self:CastR(self.target)
		end
	end
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		if Utils:ValidTarget(enemy, 1000) then
			if self.eobject and Utils:GetDistance(self.eobject, enemy) <= self.E.pred.radius then
				mh.spellbook:CastSpell(2, mh.networkId)
			end
		end
	end
end

function Lux:Harass()
	if not Utils:ValidTarget(self.target) then return end
	if menu.harasssettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.harasssettings.usee:get() and self.E.ready() then
		self:CastE(self.target)
	end
end

function Lux:Clear()
	for i, minion in pairs(ObjectManager:GetEnemyMinions()) do
		if Utils:ValidTarget(minion, 1250) then
			if menu.clearsettings.useq:get() and Utils:GetDistance(minion, mh) <= self.Q.range then
				self:CastQ(minion)
			end
			if menu.clearsettings.usee:get() and Utils:GetDistance(minion, mh) <= self.E.range then
				local Pos, Hit = Utils:GetBestCircleFarmPosition(self.E.range, self.E.pred.radius, ObjectManager:GetEnemyMinions())
				if Pos and Hit >= 3 and Utils:GetDistance(Pos) < self.E.range then 
					mh.spellbook:CastSpell(2, D3DXVECTOR3(Pos.x, Pos.y, Pos.z))	
				end
			end
		end
	end
end

function Lux:KillSteal()
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		if Utils:ValidTarget(enemy) and Utils:GetDistance(enemy, mh) < self.R.range then
			local qdmg = GetSpellDamage(mh, enemy, SpellSlot.Q)
			local edmg = GetSpellDamage(mh, enemy, SpellSlot.E)
			local rdmg = GetSpellDamage(mh, enemy, SpellSlot.R)
			local idmg = Utils:GetDmg(enemy, "Ignite")
			if menu.killstealsettings.useq:get() and self.Q.ready() and enemy.health < qdmg then
				self:CastQ(enemy)
			elseif menu.killstealsettings.usee:get() and self.E.ready() and enemy.health < edmg then
				self:CastE(enemy)
			elseif menu.killstealsettings.user:get() and self.R.ready() and enemy.health < rdmg then
				self:CastR(enemy)
			elseif menu.killstealsettings.usei:get() and self.I.ready() and enemy.health < idmg and Utils:GetDistance(enemy, mh) < self.I.range then
				mh.spellbook:CastSpell(self.I.slot, enemy.networkId)	
			end
		end
	end
end

function Lux:CastQ(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.Q.range then
		local x, y = Prediction:prediction(unit, self.Q.pred.delay, self.Q.pred.speed, self.Q.range, self.Q.pred.width, self.Q.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(0, D3DXVECTOR3(x.x, x.y, x.z))			
		end
	end
end

function Lux:CastW()
	if Utils:ValidTarget(self.target) and Utils:GetDistance(mh, self.target) <= 500 then
		local enemyprecenthp = ((self.target.health/self.target.maxHealth)*100)
		local myprecenthp = ((mh.health/mh.maxHealth)*100)
		if myprecenthp < 65 and myprecenthp < enemyprecenthp then
			mh.spellbook:CastSpell(1, D3DXVECTOR3(mh.position.x, mh.position.y, mh.position.z))	
		end
	end
end

function Lux:CastE(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.E.range then
		local x, y = Prediction:prediction(unit, self.E.pred.delay, self.E.pred.speed, self.E.range, self.E.pred.radius, self.E.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(2, D3DXVECTOR3(x.x, x.y, x.z))			
		end				
	end
end

function Lux:CastR(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.R.range then
		local x, y = Prediction:prediction(unit, self.R.pred.delay, self.R.pred.speed, self.R.range, self.R.pred.radius, self.R.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(3, D3DXVECTOR3(x.x, x.y, x.z))			
		end				
	end
end

function Lux:OnDraw()
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

function Lux:OnCreateObject(object, id)
	if object and object.name == "LuxLightStrikeKugel" and object.asMissile.spellCaster.networkId == myHero.networkId then
		self.eobject = object
	end
end		
		
function Lux:OnDeleteObject(object)
	if object and object.name:find("Lux_Base_E_tar_nova") and self.eobject then
		self.eobject = nil
	end
end

function Lux:OnProcessSpell(unit, spell)
	if menu.gapclosersettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit, self.Q.range) then
				if self.Q.ready() then
					local UnitGapcloserSpells = gapcloserspells[unit.charName]
					if UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.spellSlot == Utils:StringToSlot(slot) and menu.gapclosersettings[unit.charName .. "." .. slot]:get() then 
								if spell.target and spell.target == mh then
									self:CastQ(unit)
								elseif not spell.target then
									local endPos1 = Vector(unit) + 300 * (Vector(spell.endPos) - Vector(unit)):normalized()
									local endPos2 = Vector(unit) + 100 * (Vector(spell.endPos) - Vector(unit)):normalized()
									if (Utils:GetDistance(mh, unit) > Utils:GetDistance(mh, endPos1) or Utils:GetDistance(mh, unit) > Utils:GetDistance(mh, endPos2)) then
										self:CastQ(unit)
									end
								end
							end
						end
					end
				end
			end
		end
    end
end

---------------------------------
---------------------------------
----------- FIZZ ----------------
---------------------------------
---------------------------------
function Fizz:Menu()
	menu = Menu("MasterSeries", "MasterSeries-Fizz")
	menu:sub("combosettings", "Combo Settings")
	menu:sub("harasssettings", "Harass Settings")
	menu:sub("clearsettings", "Clear Settings")
	menu:sub("killstealsettings", "KillSteal Settings")
	menu:sub("ultsettings", "Ultimate Black List")
	menu:sub("drawsettings", "Draw Settings")
	-------------
	menu.combosettings:checkbox("useq", "Use (Q)", true)
	menu.combosettings:checkbox("usew", "Use (W)", true)
	menu.combosettings:checkbox("usee", "Use (E)", true)
	menu.combosettings:checkbox("user", "Use (R)", true)
	menu.combosettings:key("combokey", "Combo Key:", 32)
	-------------
	menu.harasssettings:checkbox("useq", "Use (Q)", true)
	menu.harasssettings:checkbox("usee", "Use (E)", true)
	menu.harasssettings:key("harasskey", "Harass Key:", 67)
	------------
	menu.clearsettings:checkbox("useq", "Use (Q)", true)
	menu.clearsettings:checkbox("usew", "Use (W)", true)
	menu.clearsettings:checkbox("usee", "Use (E)", true)
	menu.clearsettings:key("clearkey", "Clear Key:", 86)
	-------------
	menu.killstealsettings:checkbox("useq", "Use (Q)", true)
	menu.killstealsettings:checkbox("usee", "Use (E)", true)
	menu.killstealsettings:checkbox("user", "Use (R)", true)
	menu.killstealsettings:checkbox("usei", "Use Ignite", true)
	-------------
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		menu.ultsettings:checkbox(enemy.charName, "Disable for " .. enemy.charName, false)
	end
	-------------
	menu.drawsettings:checkbox("drawq", "Draw (Q) Circle", true)
	menu.drawsettings:checkbox("draww", "Draw (W) Circle", true)
	menu.drawsettings:checkbox("drawe", "Draw (E) Circle", true)
	menu.drawsettings:checkbox("drawr", "Draw (R) Circle", true)
end

function Fizz:Init()
	self.target, self.tsrange = nil, 650
	self.I = {
		slot = mh.spellbook:Spell(4).name:find("SummonerDot") and 4 or mh.spellbook:Spell(5).name:find("SummonerDot") and 5 or nil,
		ready = function() return self.I.slot and mh.spellbook:CanUseSpell(self.I.slot) == 0  or false end,
		range = 600,
	}
	self.Q = {
		slot = mh.spellbook:Spell(Q),
		ready = function() return mh.spellbook:CanUseSpell(0) == 0 end,
		range = 550,
	}
	self.W = {
		slot = mh.spellbook:Spell(W),
		ready = function() return mh.spellbook:CanUseSpell(1) == 0 end,
		range = 300,
	}
	self.E = {
		slot = mh.spellbook:Spell(E),
		ready = function() return mh.spellbook:CanUseSpell(2) == 0 end,
		range = 400,
		pred = {
			delay = 0.25,
			radius = 270,
			speed = huge,
			collision = false,
		},
	}
	self.R = {
		slot = mh.spellbook:Spell(R),
		ready = function() return mh.spellbook:CanUseSpell(3) == 0 end,
		range = 1300,
		pred = {
			delay = 0.25,
			radius = 80,
			speed = 1200,
			collision = false,
		},
	}
	AddEvent(Events.OnTick, function() self:OnTick() end)
	AddEvent(Events.OnDraw, function() self:OnDraw() end)
	self:Menu()
end

function Fizz:OnTick()
	if self.R.ready() then
		self.tsrange = self.R.range
	elseif not self.R.ready() and self.Q.ready() then
		self.tsrange = self.Q.range
	elseif not self.R.ready() and not self.Q.ready() then
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

function Fizz:Combo()
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
	if menu.combosettings.user:get() and self.R.ready() and not menu.ultsettings[self.target.charName] then
		local dmg = flor(GetSpellDamage(mh, self.target, SpellSlot.Q)) + flor(GetSpellDamage(mh, self.target, SpellSlot.W)) + flor(GetSpellDamage(mh, self.target, SpellSlot.E)) + flor(GetSpellDamage(mh, self.target, SpellSlot.R))
		if self.target.health < dmg then
			self:CastR(self.target)
		end
	end
end

function Fizz:Harass()
	if not Utils:ValidTarget(self.target) then return end
	if menu.harasssettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.harasssettings.usee:get() and self.E.ready() then
		self:CastE(self.target)
	end
end

function Fizz:Clear()
	for i, minion in pairs(ObjectManager:GetEnemyMinions()) do
		if Utils:ValidTarget(minion, 1300) then
			if menu.clearsettings.useq:get() and Utils:GetDistance(minion, mh) <= self.Q.range then
				self:CastQ(minion)
			end
			if menu.clearsettings.usew:get() and Utils:GetDistance(minion, mh) <= self.W.range then
				self:CastW(minion)
			end
			if menu.clearsettings.usee:get() and Utils:GetDistance(minion, mh) <= self.E.range then
				local Pos, Hit = Utils:GetBestCircleFarmPosition(self.E.range, self.E.pred.radius, ObjectManager:GetEnemyMinions())
				if Pos and Hit >= 3 and Utils:GetDistance(Pos) < self.E.range then 
					mh.spellbook:CastSpell(2, D3DXVECTOR3(Pos.x, Pos.y, Pos.z))	
				end
			end
		end
	end
end

function Fizz:KillSteal()
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		if Utils:ValidTarget(enemy) and Utils:GetDistance(enemy, mh) < self.Q.range then
			local qdmg = GetSpellDamage(mh, enemy, SpellSlot.Q)
			local edmg = GetSpellDamage(mh, enemy, SpellSlot.E)
			local rdmg = GetSpellDamage(mh, enemy, SpellSlot.R)
			local idmg = Utils:GetDmg(enemy, "Ignite")
			if menu.killstealsettings.useq:get() and self.Q.ready() and enemy.health < qdmg then
				self:CastQ(enemy)
			elseif menu.killstealsettings.usee:get() and self.E.ready() and enemy.health < edmg then
				self:CastE(enemy)
			elseif menu.killstealsettings.user:get() and self.R.ready() and enemy.health < rdmg then
				self:CastR(enemy)
			elseif menu.killstealsettings.usei:get() and self.I.ready() and enemy.health < idmg and Utils:GetDistance(enemy, mh) < self.I.range then
				mh.spellbook:CastSpell(self.I.slot, enemy.networkId)	
			end
		end
	end
end

function Fizz:CastQ(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.Q.range then
		mh.spellbook:CastSpell(0, unit.networkId)	
	end
end

function Fizz:CastW(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.W.range then
		mh.spellbook:CastSpell(1, mh.networkId)	
	end
end

function Fizz:CastE(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.E.range then
		local x, y = Prediction:prediction(unit, self.E.pred.delay, self.E.pred.speed, self.E.range, self.E.pred.radius, self.E.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(2, D3DXVECTOR3(x.x, x.y, x.z))			
		end				
	end	
end

function Fizz:CastR(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.R.range then
		local x, y = Prediction:prediction(unit, self.R.pred.delay, self.R.pred.speed, self.R.range, self.R.pred.radius, self.R.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(3, D3DXVECTOR3(x.x, x.y, x.z))			
		end				
	end
end

function Fizz:OnDraw()
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
---------- MORGANA --------------
---------------------------------
---------------------------------
function Morgana:Menu()
	menu = Menu("MasterSeries", "MasterSeries-Morgana")
	menu:sub("combosettings", "Combo Settings")
	menu:sub("harasssettings", "Harass Settings")
	menu:sub("shieldsettings", "Auto Shield Settings")
	menu:sub("clearsettings", "Clear Settings")
	menu:sub("killstealsettings", "KillSteal Settings")
	menu:sub("ultsettings", "Ultimate Black List")
	menu:sub("gapclosersettings", "Anti Gap-Closer Settings")
	menu:sub("interruptsettings", "Auto-Interrupt Settings")
	menu:sub("drawsettings", "Draw Settings")
	-------------
	menu.combosettings:checkbox("useq", "Use (Q)", true)
	menu.combosettings:checkbox("usew", "Use (W)", true)
	menu.combosettings:checkbox("usee", "Use (E)", true)
	menu.combosettings:checkbox("user", "Use (R)", true)
	menu.combosettings:slider("user2", "Enemy Count To Use 'R'", 1, 5, 4, 1)
	menu.combosettings:key("combokey", "Combo Key:", 32)
	-------------
	menu.harasssettings:checkbox("useq", "Use (Q)", true)
	menu.harasssettings:checkbox("usew", "Use (W)", true)
	menu.harasssettings:key("harasskey", "Harass Key:", 67)
	------------
	menu.shieldsettings:sub("shieldspells", "Spells To Shield:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitShieldSpells = self.shieldspells[enemy.charName]
		if UnitShieldSpells then
			for i, slot in pairs(UnitShieldSpells) do
				menu.shieldsettings.shieldspells:checkbox(enemy.charName.."."..slot, "Auto Shield "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.shieldsettings:checkbox("enable", "Enable Auto Shield", true)
	------------
	menu.clearsettings:checkbox("useq", "Use (Q)", true)
	menu.clearsettings:checkbox("usew", "Use (W)", true)
	menu.clearsettings:key("clearkey", "Clear Key:", 86)
	-------------
	menu.killstealsettings:checkbox("useq", "Use (Q)", true)
	menu.killstealsettings:checkbox("usew", "Use (W)", true)
	menu.killstealsettings:checkbox("user", "Use (R)", true)
	menu.killstealsettings:checkbox("usei", "Use Ignite", true)
	-------------
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		menu.ultsettings:checkbox(enemy.charName, "Disable for " .. enemy.charName, false)
	end
	-------------
	menu.gapclosersettings:label("str", "Spells List:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitGapcloserSpells = gapcloserspells[enemy.charName]
		if UnitGapcloserSpells then
			for i, slot in pairs(UnitGapcloserSpells) do
				menu.gapclosersettings:checkbox(enemy.charName.."."..slot, "GapCloser "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.gapclosersettings:label("str2", "-----------")
	menu.gapclosersettings:checkbox("enable", "Enable Anti-Gaploser", true)
	-------------
	menu.interruptsettings:label("str", "Spells List:")
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		local UnitInterruptSpells = chanellingspells[enemy.charName]
		if UnitInterruptSpells then
			for i, slot in pairs(UnitInterruptSpells) do
				menu.interruptsettings:checkbox(enemy.charName.."."..slot, "Interrupt "..enemy.charName.." "..slot, true)
			end
		end
	end
	menu.interruptsettings:label("str2", "-----------")
	menu.interruptsettings:checkbox("enable", "Enable Auto-Interrupt", true)
	-------------
	menu.drawsettings:checkbox("drawq", "Draw (Q) Circle", true)
	menu.drawsettings:checkbox("draww", "Draw (W) Circle", true)
	menu.drawsettings:checkbox("drawe", "Draw (E) Circle", true)
	menu.drawsettings:checkbox("drawr", "Draw (R) Circle", true)
end

function Morgana:Init()
	self.shieldspells = {
		["Aatrox"] = {"Q", "E"},
		["Aatrox"] = {"Q"},
		["Ahri"] = {"E"},
		["Alistar"] = {"Q", "W"},
		["Amumu"] = {"Q", "R"},
		["Anivia"] = {"Q"},
		["Blitzcrank"] = {"Q", "R"},
		["Braum"] = {"R"},
		["Cassiopeia"] = {"R"},
		["Chogath"] = {"Q"},
		["Darius"] = {"E"},
		["Diana"] = {"E"},
		["Draven"] = {"E"},
		["Elise"] = {"E"},
		["Evelynn"] = {"W"},
		["Fiddlesticks"] = {"W"},
		["Galio"] = {"E"},
		["Garen"] = {"Q"},
		["Gragas"] = {"E"},
		["Hecarim"] = {"R"},
		["Jax"] = {"E"},
		["Jayce"] = {"E"},
		["Kayle"] = {"Q"},
		["LeBlanc"] = {"E"},
		["LeeSin"] = {"R"},
		["Leona"] = {"Q", "E", "R"},
		["Lissandra"] = {"R"},
		["Lux"] = {"Q"},
		["Malphite"] = {"Q", "R"},
		["Malzahar"] = {"R"},
		["Morgana"] = {"Q"},
		["Nami"] = {"Q"},
		["Nasus"] = {"W"},
		["Nautilus"] = {"R"},
		["Nunu"] = {"E", "R"},
		["Orianna"] = {"R"},
		["Pantheon"] = {"W"},
		["Poppy"] = {"E", "R"},
		["Rammus"] = {"E"},
		["Renekton"] = {"W"},
		["Rengar"] = {"E"},
		["Riven"] = {"W"},
		["Rumble"] = {"R"},
		["Ryze"] = {"W"},
		["Sejuani"] = {"Q", "R"},
		["Shaco"] = {"E"},
		["Shen"] = {"E"},
		["Shyvana"] = {"R"},
		["Skarner"] = {"R"},
		["Sona"] = {"R"},
		["Syndra"] = {"E"},
		["Taric"] = {"E"},
		["Thresh"] = {"Q", "E"},
		["Tristana"] = {"R"},
		["Varus"] = {"R"},
		["Vayne"] = {"E"},
		["Veigar"] = {"E"},
		["Velkoz"] = {"E"},
		["Vi"] = {"Q", "R"},
		["Volibear"] = {"Q", "E"},
		["Warwick"] = {"R"},
		["MonkeyKing"] = {"R"},
		["Xerath"] = {"E"},
		["Yasuo"] = {"Q", "R"},
		["Zac"] = {"E", "R"},
		["Zyra"] = {"E"},
	}
	self.target, self.tsrange = nil, 650
	self.I = {
		slot = mh.spellbook:Spell(4).name:find("SummonerDot") and 4 or mh.spellbook:Spell(5).name:find("SummonerDot") and 5 or nil,
		ready = function() return self.I.slot and mh.spellbook:CanUseSpell(self.I.slot) == 0  or false end,
		range = 600,
	}
	self.Q = {
		slot = mh.spellbook:Spell(Q),
		ready = function() return mh.spellbook:CanUseSpell(0) == 0 end,
		range = 1200,
		pred = {
			delay = 0.25,
			radius = 60,
			speed = 1200,
			collision = true,
			},
	}
	self.W = {
		slot = mh.spellbook:Spell(W),
		ready = function() return mh.spellbook:CanUseSpell(1) == 0 end,
		range = 925,
		pred = {
			delay = 0.25,
			radius = 325,
			speed = huge,
			collision = false,
			},
	}
	self.E = {
		slot = mh.spellbook:Spell(E),
		ready = function() return mh.spellbook:CanUseSpell(2) == 0 end,
		range = 800,
	}
	self.R = {
		slot = mh.spellbook:Spell(R),
		ready = function() return mh.spellbook:CanUseSpell(3) == 0 end,
		range = 625,
	}
	AddEvent(Events.OnProcessSpell, function(unit, spell) self:OnProcessSpell(unit, spell) end)
	AddEvent(Events.OnTick, function() self:OnTick() end)
	AddEvent(Events.OnDraw, function() self:OnDraw() end)
	self:Menu()
end

function Morgana:OnTick()
	if self.Q.ready() then
		self.tsrange = self.Q.range
	elseif not self.Q.ready() and self.W.ready() then
		self.tsrange = self.W.range
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

function Morgana:OnProcessSpell(unit, spell)
	if menu.gapclosersettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit, self.Q.range) then
				if self.Q.ready() then
					local UnitGapcloserSpells = gapcloserspells[unit.charName]
					if UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.spellSlot == Utils:StringToSlot(slot) and menu.gapclosersettings[unit.charName .. "." .. slot]:get() then 
								if spell.target and spell.target == mh then
									self:CastQ(unit)
								elseif not spell.target then
									local endPos1 = Vector(unit) + 300 * (Vector(spell.endPos) - Vector(unit)):normalized()
									local endPos2 = Vector(unit) + 100 * (Vector(spell.endPos) - Vector(unit)):normalized()
									if (Utils:GetDistance(mh, unit) > Utils:GetDistance(mh, endPos1) or Utils:GetDistance(mh, unit) > Utils:GetDistance(mh, endPos2)) then
										self:CastQ(unit)
									end
								end
							end
						end
					end
				end
			end
		end
    end
	if menu.interruptsettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit, self.Q.range) then
				if self.Q.ready() then
					local UnitInterruptSpells = chanellingspells[unit.charName]
					if UnitInterruptSpells then
						for _, slot in pairs(UnitInterruptSpells) do
							if spell.spellSlot == Utils:StringToSlot(slot) and menu.interruptsettings[unit.charName .. "." .. slot]:get() then 
								self:CastQ(unit)
							end
						end
					end
				end
			end
		end
    end
	if menu.shieldsettings.enable:get() then
		if unit and unit.team ~= mh.team and unit.type == mh.type and spell then
			if Utils:ValidTarget(unit) and self.E.ready() then
				local UnitShieldSpells = self.shieldspells[unit.charName]
				if UnitShieldSpells then
					for _, slot in pairs(UnitShieldSpells) do
						if spell.spellSlot == Utils:StringToSlot(slot) and menu.shieldsettings.shieldspells[unit.charName .. "." .. slot]:get() then 
							if spell.target and spell.target == mh then
								self:CastE(mh)
							else
								if Utils:GetDistance(mh, spell.endPos) <= 65 then
									self:CastE(mh)
								end
							end
						end
					end
				end
			end
		end
    end
end

function Morgana:Combo()
	if not Utils:ValidTarget(self.target) then return end
	if menu.combosettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.combosettings.usew:get() and self.W.ready() then
		self:CastW(self.target)
	end
	if menu.combosettings.user:get() and self.R.ready() and not menu.ultsettings[self.target.charName] and Utils:EnemyCount(mh, self.R.range) >= menu.combosettings.user2:get() then
		self:CastR(self.target)
	end
end

function Morgana:Harass()
	if not Utils:ValidTarget(self.target) then return end
	if menu.harasssettings.useq:get() and self.Q.ready() then
		self:CastQ(self.target)
	end
	if menu.harasssettings.usew:get() and self.W.ready() then
		self:CastW(self.target)
	end
end

function Morgana:Clear()
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

function Morgana:KillSteal()
	for i = 1, #Enemies do
        local enemy = Enemies[i]
		if Utils:ValidTarget(enemy) and Utils:GetDistance(enemy, mh) < self.Q.range then
			local qdmg = GetSpellDamage(mh, enemy, SpellSlot.Q)
			local wdmg = GetSpellDamage(mh, enemy, SpellSlot.W)
			local rdmg = GetSpellDamage(mh, enemy, SpellSlot.R)
			local idmg = Utils:GetDmg(enemy, "Ignite")
			if menu.killstealsettings.useq:get() and self.Q.ready() and enemy.health < qdmg then
				self:CastQ(enemy)
			elseif menu.killstealsettings.usew:get() and self.W.ready() and enemy.health < wdmg then
				self:CastW(enemy)
			elseif menu.killstealsettings.user:get() and self.R.ready() and enemy.health < rdmg then
				self:CastR(enemy)
			elseif menu.killstealsettings.usei:get() and self.I.ready() and enemy.health < idmg and Utils:GetDistance(enemy, mh) < self.I.range then
				mh.spellbook:CastSpell(self.I.slot, enemy.networkId)	
			end
		end
	end
end

function Morgana:CastQ(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.Q.range then
		local x, y = Prediction:prediction(unit, self.Q.pred.delay, self.Q.pred.speed, self.Q.range, self.Q.pred.radius, self.Q.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(0, D3DXVECTOR3(x.x, x.y, x.z))			
		end	
	end
end

function Morgana:CastW(unit)
	if Utils:ValidTarget(unit) and Utils:GetDistance(mh, unit) <= self.W.range then
		local x, y = Prediction:prediction(unit, self.W.pred.delay, self.W.pred.speed, self.W.range, self.W.pred.radius, self.W.pred.collision)
		if x and y >= 2 then
			mh.spellbook:CastSpell(1, D3DXVECTOR3(x.x, x.y, x.z))			
		end				
	end
end

function Morgana:CastE(unit)
	mh.spellbook:CastSpell(2, unit.networkId)			
end

function Morgana:CastR(unit)
	mh.spellbook:CastSpell(3, mh.networkId)	
end

function Morgana:OnDraw()
	if menu.drawsettings.drawq:get() and self.Q.ready() then
		DrawHandler:Circle3D(myHero.position, self.Q.range, 0xff00ff00)
	end
	if menu.drawsettings.drawq:get() and self.W.ready() then
		DrawHandler:Circle3D(myHero.position, self.W.range, 0xff00ff00)
	end
	if menu.drawsettings.drawq:get() and self.E.ready() then
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
	if spell == "Ignite" then
		return (50 + (20 * mh.experience.level)) or 0
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

function Utils:EnemyCount(point, range)
	local x = 0
	for i = 1, #Enemies do
        local target = Enemies[i]
		if Utils:ValidTarget(target) and Utils:GetDistance(point, target) <= range then
			x = x+1
		end
	end
	return x
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
    return sqrtt(self:GetDistanceSqr(p1, p2))
end

function Utils:ValidTarget(target, distance)
	return target and target.isValid and (target.team ~= mh.team) and not target.isInvulnerable and not target.isDead and target.isVisible and (distance == nil or self:GetDistance(target) <= distance)
end

function Utils:GetTarget(range)
	local currenttarget = {target = nil, value = 0}
	local function Priority(charName)
		local p1 = {"Alistar", "Amumu", "Blitzcrank", "Braum", "Cho'Gath", "Dr. Mundo", "Garen", "Gnar", "Maokai", "Hecarim", "Leona", "Lulu", "Malphite", "Nasus", "Nautilus", "Nunu", "Olaf", "Rammus", "Renekton", "Sejuani", "Shen", "Shyvana", "Singed", "Sion", "Skarner", "Taric", "TahmKench", "Thresh", "Volibear", "Warwick", "MonkeyKing", "Yorick", "Zac", "Poppy", "Ornn"}
		local p2 = {"Aatrox", "Darius", "Elise", "Evelynn", "Galio", "Gragas", "Irelia", "Jax", "Lee Sin", "Morgana", "Janna", "Nocturne", "Pantheon", "Rengar", "Rumble", "Swain", "Trundle", "Tryndamere", "Udyr", "Urgot", "Vi", "XinZhao", "RekSai", "Bard", "Nami", "Sona", "Camille", "Jarvan IV"}
		local p3 = {"Akali", "Diana", "Ekko", "FiddleSticks", "Fiora", "Gangplank", "Fizz", "Heimerdinger", "Jayce", "Kassadin", "Kayle", "Kha'Zix", "Lissandra", "Mordekaiser", "Nidalee", "Riven", "Shaco", "Vladimir", "Yasuo", "Zilean", "Zyra", "Ryze"}
		local p4 = {"Ahri", "Anivia", "Annie", "Ashe", "Azir", "Brand", "Caitlyn", "Cassiopeia", "Corki", "Draven", "Ezreal", "Graves", "Jinx", "Kalista", "Karma", "Karthus", "Katarina", "Kennen", "KogMaw", "Kindred", "Leblanc", "Lucian", "Lux", "Malzahar", "MasterYi", "MissFortune", "Orianna", "Quinn", "Sivir", "Syndra", "Talon", "Teemo", "Tristana", "TwistedFate", "Twitch", "Varus", "Vayne", "Veigar", "Velkoz", "Viktor", "Xerath", "Zed", "Ziggs", "Jhin", "Soraka", "Zoe", "Kayn"}
		for i,n in pairs(p1) do if n == charName then return 4 end end 
		for i,n in pairs(p2) do if n == charName then return 3 end end 
		for i,n in pairs(p3) do if n == charName then return 2 end end 
		for i,n in pairs(p4) do if n == charName then return 1 end end 
		return .5
	end
	for i = 1, #Enemies do
        local v = Enemies[i]
		if self:ValidTarget(v, range) and self:GetDistance(v, mh) < range then
			local prior = 100 / Priority(v.charName)
			local heroValue = v.health / prior
			if not currenttarget.target or heroValue < currenttarget.value then 
				currenttarget.target, currenttarget.value = v, heroValue 
			end
		end
	end 
	return currenttarget.target
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
		if self:ValidTarget(object) and self:GetDistance(object) < range then
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

function Utils:GetJungleMinions(range)
	local jungleminions = {}
	local minions = ObjectManager:GetEnemyMinions()
	for i = 1, #minions do
		local minion = minions[i]
		if minion.team == 3 and Utils:GetDistance(minion, mh) < range then
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

function Utils:StringToSlot(slot)
	if slot == "Q" then
		return 0
	elseif slot == "W" then
		return 1
	elseif slot == "E" then
		return 2
	elseif slot == "R" then
		return 3
	end
end

delayedActions = {}
function Utils:DelayAction(func, delay, args)
    if not delayedActionsExecuter then
            function delayedActionsExecuter()
                    for i, funcs in pairs(delayedActions) do
                            if i <= RiotClock.time then
                                    for _, f in ipairs(funcs) do
                                            f.func(unpack(f.args or {}))
                                    end
                                    delayedActions[i] = nil
                            end
                    end
            end
            AddEvent(Events.OnTick , delayedActionsExecuter)
    end
    local time = RiotClock.time + (delay or 0)
    if delayedActions[time] then
            table.insert(delayedActions[time], { func = func, args = args })
    else
            delayedActions[time] = { { func = func, args = args } }
    end
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
		if minion and minion.health <= flor(GetAutoAttackDamage(mh, minion)) then
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
	speed = speed or huge
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
	local result, threshold = { }, huge
	local source, sq_range = from, range and range * range or huge
	for index, minion in pairs(ObjectManager:GetEnemyMinions()) do
		if Utils:ValidTarget(minion, range+100) then
			local p = minion.position
			if sq_range == huge or (p.x - source.x) ^ 2 + (p.z - source.z) ^ 2 - self:GetHitBox(minion) ^ 2 < sq_range then
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
	local d1 = sqrtt(v1.x * v1.x + v1.y * v1.y)
	if unit.aiManagerClient.navPath.isMoving then
		local endPath = unit.aiManagerClient.navPath.paths[1]
		v1.x, v1.y = (v1.x / d1) * speed, (v1.y / d1) * speed
		local v2 = { x = endPath.x - startPath.x, y = endPath.z - startPath.z }
		local d2 = sqrtt(v2.x * v2.x + v2.y * v2.y)
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
				local t1 = (-b + sqrtt(discriminant)) / (2 * a)
				local t2 = (-b - sqrtt(discriminant)) / (2 * a)
				local t = minn(t1, t2)
				return t > 0 and t
			end
		end
	else
		local d2 = sqrtt((startPath.x - startPos.x) ^ 2 + (startPath.z - startPos.z) ^ 2)
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





