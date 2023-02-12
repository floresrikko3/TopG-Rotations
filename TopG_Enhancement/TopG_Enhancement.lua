local function MyRoutine()
	local Author = 'ErikEnhancement'
	local SpecID = 263 --Protection Warrior  --https://wowpedia.fandom.com/wiki/API_GetSpecializationInfo

	local StdUi = LibStub('StdUi')
	--HR HEADER
	-- Addon
	local MainAddon = LibStub("AceAddon-3.0"):GetAddon(Z_AddonName)
	-- HeroDBC
	local DBC = HeroDBC.DBC
	-- HeroLib
	local HL = HeroLibEx
	local Cache = HeroCache
	---@type Unit
	local Unit = HL.Unit
	---@type Player : Unit
	local Player = Unit.Player
	---@type Unit
	local Target = Unit.Target
	---@type Unit
	local Arena = Unit.Arena
	---@type Unit
	local Party = Unit.Party
	---@type Pet : Unit
	local Pet = Unit.Pet
	---@type Spell
	local Spell = HL.Spell
	local MultiSpell = HL.MultiSpell
	local Item = HL.Item
	-- HeroRotation
	local Cast = MainAddon.Cast
	local CastCycle = MainAddon.CastCycle
	local CastTargetIf = MainAddon.CastTargetIf
	local AoEON = MainAddon.AoEON
	local CDsON = MainAddon.CDsON
	-- lua
	local GetWeaponEnchantInfo = GetWeaponEnchantInfo
	local max        = math.max
	local strmatch   = string.match

	local function Init()
		message( 'TopG Rotation', 1)
		MainAddon:Print('Author: rollfacedk')
	end


	--GUI CONFIG
	local UnholyColor = 'c41f3b'
	local ErikEnhancement = {
		--YO CHANGE THIS TO
		key = 'ErikEnhancement',
		title = 'ErikEnhancement',
		subtitle = '1.0',
		width = 300,
		height = 250,
		profiles = true,
		config = {
			-- { type = 'header', text = 'Unholy', size = 24, align = 'Center', color = UnholyColor},
			-- { type = 'spacer' },{ type = 'ruler' },{ type = 'spacer' },
			-- { type = 'header', text = 'Defensives',  color = UnholyColor },
			-- { type = 'checkspin', text = 'Death Strike: Smart Use', key = 'smartds', min = 1, max = 100, default = 15},
			-- { type = 'checkspin', text = 'Death Strike: Deficit', key = 'deficitds', min = 1, max = 100, default = 20},
			-- { type = 'checkspin', text = 'Death Strike: Emergency', key = 'dsemergency', min = 1, max = 100, default = 50},
			-- { type = 'checkspin', text = 'Icebound Fortitude', key = 'ibfortitude', min = 1, max = 100, default = 30},
			-- { type = 'checkspin', text = 'Rune Tap', key = 'runetap', min = 1, max = 100, default = 35},
			-- { type = 'checkspin', text = 'Vampiric Blood', key = 'vp', min = 1, max = 100, default = 50},
			-- { type = 'spacer' },
			-- { type = 'header', text = 'Class',  color = UnholyColor },
			-- { type = 'checkbox', text = 'Lichborne (Anti-Fear)', key = 'lichborne', default = true},
		}
	}
	MainAddon.SetCustomConfig(Author, SpecID, ErikEnhancement)

	local S = {
		-- Racials
		AncestralCall                         = Spell(274738),
		BagofTricks                           = Spell(312411),
		Berserking                            = Spell(26297),
		BloodFury                             = Spell(33697),
		Fireblood                             = Spell(265221),
		-- Abilities
		HealingStreamTotem 					  = Spell(5394),
		HealingSurge 						  = Spell(8004),
		GhostWolf				              = Spell(2645),
		Bloodlust                             = MultiSpell(2825,32182), -- Bloodlust/Heroism
		FlameShock                            = Spell(188389),
		FlamentongueWeapon                    = Spell(318038),
		FrostShock                            = Spell(196840),
		LightningBolt                         = Spell(188196),
		LightningShield                       = Spell(192106),
		-- Talents
		AstralShift                           = Spell(108271),
		CapacitorTotem                        = Spell(192058),
		ChainLightning                        = Spell(188443),
		EarthElemental                        = Spell(198103),
		EarthShield                           = Spell(974),
		ElementalBlast                        = Spell(117014),
		LavaBurst                             = Spell(51505),
		DeeplyRootedElements                  = Spell(378270),
		NaturesSwiftness                      = Spell(378081),
		PrimordialWave                        = Spell(375982),
		SpiritwalkersGrace                    = Spell(79206),
		TotemicRecall                         = Spell(108285),
		WindShear                             = Spell(57994),
		-- Buffs
		LightningShieldBuff                   = Spell(192106),
		PrimordialWaveBuff                    = Spell(375986),
		SpiritwalkersGraceBuff                = Spell(79206),
		SplinteredElementsBuff                = Spell(382043),
		-- Debuffs
		FlameShockDebuff                      = Spell(188389),
		-- Trinket Effects
		AcquiredSwordBuff                     = Spell(368657),
		ScarsofFraternalStrifeBuff4           = Spell(368638),
		-- Misc
		Pool                                  = Spell(999910),

		-- Abilities
		Windstrike                            = Spell(115356),
		-- Talents
		Ascendance                            = Spell(114051),
		AshenCatalyst                         = Spell(390370),
		CrashLightning                        = Spell(187874),
		CrashingStorms                        = Spell(334308),
		DoomWinds                             = Spell(384352),
		ElementalSpirits                      = Spell(262624),
		FeralSpirit                           = Spell(51533),
		FireNova                              = Spell(333974),
		Hailstorm                             = Spell(334195),
		HotHand                               = Spell(201900),
		IceStrike                             = Spell(342240),
		LashingFlames                         = Spell(334046),
		LavaLash                              = Spell(60103),
		OverflowingMaelstrom                  = Spell(384149),
		Stormflurry                           = Spell(344357),
		Stormstrike                           = Spell(17364),
		Sundering                             = Spell(197214),
		SwirlingMaelstrom                     = Spell(384359),
		ThorimsInvocation                     = Spell(384444),
		WindfuryTotem                         = Spell(8512),
		WindfuryWeapon                        = Spell(33757),
		MoltenAssault							= Spell(334033),
		ConvergingStorms                      = Spell(384363),
		-- Buffs
		AscendanceBuff                        = Spell(114051),
		AshenCatalystBuff                     = Spell(390371),
		CrashLightningBuff                    = Spell(187878),
		CLCrashLightningBuff                  = Spell(333964),
		DoomWindsBuff                         = Spell(384352),
		FeralSpiritBuff                       = Spell(333957),
		GatheringStormsBuff                   = Spell(198300),
		HailstormBuff                         = Spell(334196),
		HotHandBuff                           = Spell(215785),
		MaelstromWeaponBuff                   = Spell(344179),
		StormbringerBuff                      = Spell(201846),
		WindfuryTotemBuff                     = Spell(327942),
		-- Debuffs
		LashingFlamesDebuff                   = Spell(334168),
		-- Elemental Spirits Buffs
		CracklingSurgeBuff                    = Spell(224127),
		EarthenWeaponBuff                     = Spell(392375),
		LegacyoftheFrostWitch                 = Spell(335901),
		IcyEdgeBuff                           = Spell(224126),
		MoltenWeaponBuff                      = Spell(224125),
		-- Tier 29 Buffs
		MaelstromofElementsBuff               = Spell(394677),

	}

	local I = {
	  -- Trinkets
	  CacheofAcquiredTreasures              = Item(188265, {13, 14}),
	  ScarsofFraternalStrife                = Item(188253, {13, 14}),
	  TheFirstSigil                         = Item(188271, {13, 14}),
	  AlgetharPuzzleBox                     = Item(193701, {13, 14}),
	}

	-- Create table to exclude above trinkets from On Use function
	local OnUseExcludes = {
		I.CacheofAcquiredTreasures:ID(),
		I.ScarsofFraternalStrife:ID(),
		I.TheFirstSigil:ID(),
		I.AlgetharPuzzleBox:ID(),
	}
	-- Rotation Var
	local HasMainHandEnchant, HasOffHandEnchant
	local MHEnchantTimeRemains, OHEnchantTimeRemains
	local Enemies10y, Enemies10yCount
	local MaxEBCharges = S.LavaBurst:IsAvailable() and 2 or 1
	local TIAction = S.LightningBolt
	local BossFightRemains = 11111
	local FightRemains = 11111

	HL:RegisterForEvent(function()
		MaxEBCharges = S.LavaBurst:IsAvailable() and 2 or 1
	end, "PLAYER_TALENT_UPDATE")

	HL:RegisterForEvent(function()
		TIAction = S.LightningBolt
		BossFightRemains = 11111
		FightRemains = 11111
	end, "PLAYER_REGEN_ENABLED")

	local function TotemFinder()
		for i = 1, 6, 1 do
		  if strmatch(Player:TotemName(i), 'Totem') then
			return i
		  end
		end
	end
	  
	local function EvaluateCycleFlameShock(TargetUnit)
		return (TargetUnit:DebuffRefreshable(S.FlameShockDebuff))
	end
	
	local function EvaluateCycleLavaLash(TargetUnit)
		return (TargetUnit:DebuffRefreshable(S.LashingFlamesDebuff))
	end
	
	local function EvaluateTargetIfFilterPrimordialWave(TargetUnit)
		return (TargetUnit:DebuffRemains(S.FlameShockDebuff))
	end
	
	local function EvaluateTargetIfPrimordialWave(TargetUnit)
		return (Player:BuffDown(S.PrimordialWaveBuff))
	end
	
	local function EvaluateTargetIfFilterLavaLash(TargetUnit)
		return (Target:DebuffRemains(S.LashingFlamesDebuff))
	end
	
	local function EvaluateTargetIfLavaLash(TargetUnit)
		return (S.LashingFlames:IsAvailable())
	end
	
	local function EvaluateTargetIfLavaLash2(TargetUnit)
		return (TargetUnit:DebuffUp(S.FlameShockDebuff) and (S.FlameShockDebuff:AuraActiveCount() < Enemies10yCount and S.FlameShockDebuff:AuraActiveCount() < 6))
	end

	local function Precombat()
		-- flask
		-- food
		-- augmentation
		-- windfury_weapon
		if ((not HasMainHandEnchant) or MHEnchantTimeRemains < 600000) and S.WindfuryWeapon:IsCastable() then
		  if Cast(S.WindfuryWeapon) then return "windfury_weapon enchant"; end
		end
		-- flametongue_weapon
		if ((not HasOffHandEnchant) or OHEnchantTimeRemains < 600000) and S.FlamentongueWeapon:IsCastable() then
		  if Cast(S.FlamentongueWeapon) then return "flametongue_weapon enchant"; end
		end
		-- lightning_shield
		-- Note: Moved to top of APL()
		-- windfury_totem
		if S.WindfuryTotem:IsReady() and (Player:BuffDown(S.WindfuryTotemBuff)) then
		  if Cast(S.WindfuryTotem) then return "windfury_totem precombat 4"; end
		end
		-- variable,name=trinket1_is_weird,value=trinket.1.is.the_first_sigil|trinket.1.is.scars_of_fraternal_strife|trinket.1.is.cache_of_acquired_treasures
		-- variable,name=trinket2_is_weird,value=trinket.2.is.the_first_sigil|trinket.2.is.scars_of_fraternal_strife|trinket.2.is.cache_of_acquired_treasures
		-- Note: These variables just exclude these three trinkets from the generic use_items. We'll just use HR's OnUseExcludes instead.
		-- snapshot_stats
		if Player:BuffDown(S.GhostWolf) then
		 if Cast(S.GhostWolf) then return end
		end
	end

	local function Single()
		-- windstrike,if=talent.thorims_invocation.enabled&buff.maelstrom_weapon.stack>=1
		if S.Windstrike:IsReady() and Target:IsSpellInRange(S.Windstrike) and (S.ThorimsInvocation:IsAvailable() and Player:BuffStack(S.MaelstromWeaponBuff) >= 1) then
		  if Cast(S.Windstrike) then return "windstrike single 2"; end
		end
		-- lava_lash,if=buff.hot_hand.up|buff.ashen_catalyst.stack=8|(buff.ashen_catalyst.stack>=5&buff.maelstrom_of_elements.up&buff.maelstrom_weapon.stack<=6)
		if S.LavaLash:IsReady() and Target:IsSpellInRange(S.LavaLash) and (Player:BuffUp(S.HotHandBuff) or Player:BuffStack(S.AshenCatalystBuff) == 8 or (Player:BuffStack(S.AshenCatalystBuff) >= 5 and Player:BuffUp(S.MaelstromofElementsBuff) and Player:BuffStack(S.MaelstromWeaponBuff) <= 6)) then
		  if Cast(S.LavaLash) then return "lava_lash single 4"; end
		end
		-- windfury_totem,if=!buff.windfury_totem.up
		if S.WindfuryTotem:IsReady() and (Player:BuffDown(S.WindfuryTotemBuff)) then
		  if Cast(S.WindfuryTotem) then return "windfury_totem single 6"; end
		end
		if (Player:BuffUp(S.DoomWindsBuff)) then
		  -- stormstrike,if=buff.doom_winds_talent.up
		  if S.Stormstrike:IsReady() and Target:IsSpellInRange(S.Stormstrike) then
			if Cast(S.Stormstrike) then return "stormstrike single 8"; end
		  end
		  -- crash_lightning,if=buff.doom_winds_talent.up
		  if S.CrashLightning:IsReady() and Target:IsInMeleeRange(8) then
			if Cast(S.CrashLightning) then return "crash_lightning single 10"; end
		  end
		  -- ice_strike,if=buff.doom_winds_talent.up
		  if S.IceStrike:IsReady() and Target:IsInMeleeRange(5) then
			if Cast(S.IceStrike) then return "ice_strike single 12"; end
		  end
		  -- sundering,if=buff.doom_winds_talent.up
		  if S.Sundering:IsReady() and Target:IsInRange(11) then
			if Cast(S.Sundering) then return "sundering single 14"; end
		  end
		end
		-- primordial_wave,if=buff.primordial_wave.down&(raid_event.adds.in>42|raid_event.adds.in<6)
		if S.PrimordialWave:IsCastable() and Target:IsSpellInRange(S.PrimordialWave) and (Player:BuffDown(S.PrimordialWaveBuff)) then
		  if Cast(S.PrimordialWave) then return "primordial_wave single 16"; end
		end
		-- flame_shock,if=!ticking
		if S.FlameShock:IsReady() and Target:IsSpellInRange(S.FlameShock) and (Target:DebuffDown(S.FlameShockDebuff)) then
		  if Cast(S.FlameShock) then return "flame_shock single 18"; end
		end
		-- lightning_bolt,if=buff.maelstrom_weapon.stack>=5&buff.primordial_wave.up&raid_event.adds.in>buff.primordial_wave.remains&(!buff.splintered_elements.up|fight_remains<=12)
		if S.LightningBolt:IsCastable() and Target:IsSpellInRange(S.LightningBolt) and (Player:BuffStack(S.MaelstromWeaponBuff) >= 5 and Player:BuffUp(S.PrimordialWaveBuff) and (Player:BuffDown(S.SplinteredElementsBuff) or FightRemains <= 12)) then
		  if Cast(S.LightningBolt) then return "lightning_bolt single 20"; end
		end
		-- ice_strike,if=talent.hailstorm.enabled
		if S.IceStrike:IsReady() and Target:IsInMeleeRange(5) and (S.Hailstorm:IsAvailable()) then
		  if Cast(S.IceStrike) then return "ice_strike single 22"; end
		end
		-- stormstrike,if=set_bonus.tier29_2pc&buff.maelstrom_of_elements.down&buff.maelstrom_weapon.stack<=5
		if S.Stormstrike:IsCastable() and Target:IsSpellInRange(S.Stormstrike) and (Player:HasTier(29, 2) and Player:BuffDown(S.MaelstromofElementsBuff) and Player:BuffStack(S.MaelstromWeaponBuff) <= 5) then
		  if Cast(S.Stormstrike) then return "stormstrike single 28"; end
		end
		-- frost_shock,if=buff.hailstorm.up
		if S.FrostShock:IsReady() and Target:IsSpellInRange(S.FrostShock) and (Player:BuffUp(S.HailstormBuff)) then
		  if Cast(S.FrostShock) then return "frost_shock single 24"; end
		end
		-- lava_lash,if=talent.molten_assault.enabled&dot.flame_shock.refreshable
		if S.LavaLash:IsCastable() and Target:IsSpellInRange(S.LavaLash) and (S.MoltenAssault:IsAvailable() and Target:DebuffRefreshable(S.FlameShockDebuff)) then
		  if Cast(S.LavaLash) then return "lava_lash single 26"; end
		end
		-- windstrike,if=talent.deeply_rooted_elements.enabled|buff.earthen_weapon.up|buff.legacy_of_the_frost_witch.up
		if S.Windstrike:IsCastable() and Target:IsSpellInRange(S.Windstrike) and (S.DeeplyRootedElements:IsAvailable() or Player:BuffUp(S.EarthenWeaponBuff) or Player:BuffUp(S.LegacyoftheFrostWitch)) then
		  if Cast(S.Windstrike) then return "stormstrike single 28"; end
		end
		-- stormstrike,if=talent.deeply_rooted_elements.enabled|buff.earthen_weapon.up|buff.legacy_of_the_frost_witch.up
		if S.Stormstrike:IsCastable() and Target:IsSpellInRange(S.Stormstrike) and (S.DeeplyRootedElements:IsAvailable() or Player:BuffUp(S.EarthenWeaponBuff) or Player:BuffUp(S.LegacyoftheFrostWitch)) then
		  if Cast(S.Stormstrike) then return "stormstrike single 28"; end
		end
		-- elemental_blast,if=(talent.elemental_spirits.enabled&buff.maelstrom_weapon.stack=10)|(!talent.elemental_spirits.enabled&buff.maelstrom_weapon.stack>=5)
		if S.ElementalBlast:IsReady() and Target:IsSpellInRange(S.ElementalBlast) and ((S.ElementalSpirits:IsAvailable() and Player:BuffStack(S.MaelstromWeaponBuff) == 10) or ((not S.ElementalSpirits:IsAvailable()) and Player:BuffStack(S.MaelstromWeaponBuff) >= 5)) then
		  if Cast(S.ElementalBlast) then return "elemental_blast single 30"; end
		end
		-- lava_burst,if=buff.maelstrom_weapon.stack>=5
		if S.LavaBurst:IsReady() and Target:IsSpellInRange(S.LavaBurst) and (Player:BuffStack(S.MaelstromWeaponBuff) >= 5) then
		  if Cast(S.LavaBurst) then return "lava_burst single 34"; end
		end
		-- lightning_bolt,if=buff.maelstrom_weapon.stack=10&buff.primordial_wave.down
		if S.LightningBolt:IsReady() and Target:IsSpellInRange(S.LightningBolt) and (Player:BuffStack(S.MaelstromWeaponBuff) == 10 and Player:BuffDown(S.PrimordialWaveBuff)) then
		  if Cast(S.LightningBolt) then return "lightning_bolt single 36"; end
		end
		-- windstrike
		if S.Windstrike:IsCastable() and Target:IsSpellInRange(S.Windstrike) then
		  if Cast(S.Windstrike) then return "windstrike single 37"; end
		end
		-- stormstrike
		if S.Stormstrike:IsReady() and Target:IsSpellInRange(S.Stormstrike) then
		  if Cast(S.Stormstrike) then return "stormstrike single 38"; end
		end
		-- windfury_totem,if=buff.windfury_totem.remains<10
		if S.WindfuryTotem:IsReady() and (Player:BuffDown(S.WindfuryTotemBuff)) then
		  if Cast(S.WindfuryTotem) then return "windfury_totem single 42"; end
		end
		-- ice_strike
		if S.IceStrike:IsReady() and Target:IsInMeleeRange(5) then
		  if Cast(S.IceStrike) then return "ice_strike single 44"; end
		end
		-- lava_lash
		if S.LavaLash:IsReady() and Target:IsSpellInRange(S.LavaLash) then
		  if Cast(S.LavaLash) then return "lava_lash single 46"; end
		end
		-- elemental_blast,if=talent.elemental_spirits.enabled&(charges=max_charges|buff.feral_spirit.up)&buff.maelstrom_weapon.stack>=5
		if S.ElementalBlast:IsReady() and Target:IsSpellInRange(S.ElementalBlast) and (S.ElementalSpirits:IsAvailable() and (S.ElementalBlast:Charges() == S.ElementalBlast:MaxCharges() or Player:BuffUp(S.FeralSpiritBuff)) and Player:BuffStack(S.MaelstromWeaponBuff) >= 5) then
		  if Cast(S.ElementalBlast) then return "elemental_blast single 47"; end
		end
		-- bag_of_tricks
		if S.BagofTricks:IsCastable() and CDsON() then
		  if Cast(S.BagofTricks) then return "bag_of_tricks single 48"; end
		end
		-- lightning_bolt,if=buff.maelstrom_weapon.stack>=5&buff.primordial_wave.down
		if S.LightningBolt:IsCastable() and Target:IsSpellInRange(S.LightningBolt) and (Player:BuffStack(S.MaelstromWeaponBuff) >= 5 and Player:BuffDown(S.PrimordialWaveBuff)) then
		  if Cast(S.LightningBolt) then return "lightning_bolt single 50"; end
		end
		-- sundering,if=raid_event.adds.in>=40
		if S.Sundering:IsReady() and Target:IsInRange(11) then
		  if Cast(S.Sundering) then return "sundering single 52"; end
		end
		-- fire_nova,if=talent.swirling_maelstrom.enabled&active_dot.flame_shock
		if S.FireNova:IsReady() and Target:IsInMeleeRange(5) and (S.SwirlingMaelstrom:IsAvailable() and Target:DebuffUp(S.FlameShockDebuff)) then
		  if Cast(S.FireNova) then return "fire_nova single 54"; end
		end
		-- frost_shock
		if S.FrostShock:IsReady() and Target:IsSpellInRange(S.FrostShock) then
		  if Cast(S.FrostShock) then return "frost_shock single 56"; end
		end
		-- crash_lightning
		if S.CrashLightning:IsReady() and Target:IsInRange(8) then
		  if Cast(S.CrashLightning) then return "crash_lightning single 58"; end
		end
		-- fire_nova,if=active_dot.flame_shock
		if S.FireNova:IsReady() and (Target:DebuffUp(S.FlameShockDebuff)) then
		  if Cast(S.FireNova) then return "fire_nova single 60"; end
		end
		-- earth_elemental
		if S.EarthElemental:IsCastable() then
		  if Cast(S.EarthElemental) then return "earth_elemental single 64"; end
		end
		-- flame_shock
		if S.FlameShock:IsCastable() and Target:IsSpellInRange(S.FlameShock) then
		  if Cast(S.FlameShock) then return "flame_shock single 66"; end
		end
		-- windfury_totem,if=buff.windfury_totem.remains<30
		if S.WindfuryTotem:IsReady() and (Player:BuffDown(S.WindfuryTotemBuff)) then
		  if Cast(S.WindfuryTotem) then return "windfury_totem single 68"; end
		end
	end

	local function Aoe()
		-- crash_lightning,if=buff.doom_winds_talent.up|!buff.crash_lightning.up
		if S.CrashLightning:IsReady() and Target:IsInRange(8) and (Player:BuffUp(S.DoomWindsBuff) or Player:BuffDown(S.CrashLightningBuff)) then
		  if Cast(S.CrashLightning) then return "crash_lightning aoe 2"; end
		end
		-- lightning_bolt,if=(active_dot.flame_shock=active_enemies|active_dot.flame_shock=6)&buff.primordial_wave.up&buff.maelstrom_weapon.stack>=(5+5*talent.overflowing_maelstrom.enabled)&(!buff.splintered_elements.up|fight_remains<=12|raid_event.adds.remains<=gcd)
		if S.LightningBolt:IsReady() and Target:IsSpellInRange(S.LightningBolt) and ((S.FlameShockDebuff:AuraActiveCount() == Enemies10yCount or S.FlameShockDebuff:AuraActiveCount() >= 6) and Player:BuffUp(S.PrimordialWaveBuff) and Player:BuffStack(S.MaelstromWeaponBuff) >= (5 + 5 * num(S.OverflowingMaelstrom:IsAvailable())) and (Player:BuffDown(S.SplinteredElementsBuff) or FightRemains <= 12)) then
		  if Cast(S.LightningBolt) then return "lightning_bolt aoe 4"; end
		end
		-- sundering,if=buff.doom_winds_talent.up
		if S.Sundering:IsReady() and Target:IsInRange(11) and (Player:BuffUp(S.DoomWindsBuff)) then
		  if Cast(S.Sundering) then return "sundering aoe 8"; end
		end
		-- fire_nova,if=active_dot.flame_shock=6|(active_dot.flame_shock>=4&active_dot.flame_shock=active_enemies)
		if S.FireNova:IsReady() and (S.FlameShockDebuff:AuraActiveCount() == 6 or (S.FlameShockDebuff:AuraActiveCount() >= 4 and S.FlameShockDebuff:AuraActiveCount() >= Enemies10yCount)) then
		  if Cast(S.FireNova) then return "fire_nova aoe 10"; end
		end
		-- primordial_wave,target_if=min:dot.flame_shock.remains,cycle_targets=1,if=!buff.primordial_wave.up
		if S.PrimordialWave:IsReady() and Target:IsSpellInRange(S.PrimordialWave) and (Player:BuffDown(S.PrimordialWaveBuff)) then
		  if CastTargetIf(S.PrimordialWave, Enemies10y, "min", EvaluateTargetIfFilterPrimordialWave, EvaluateTargetIfPrimordialWave) then return "primordial_wave aoe 12"; end
		end
		-- windstrike,if=talent.thorims_invocation.enabled&ti_chain_lightning&buff.maelstrom_weapon.stack>1
		if S.Windstrike:IsReady() and Target:IsSpellInRange(S.Windstrike) and (S.ThorimsInvocation:IsAvailable() and TIAction == S.ChainLightning and Player:BuffStack(S.MaelstromWeaponBuff) > 1) then
		  if Cast(S.Windstrike) then return "windstrike aoe 14"; end
		end
		-- lava_lash,target_if=min:debuff.lashing_flames.remains,cycle_targets=1,if=talent.lashing_flames.enabled&dot.flame_shock.ticking&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
		if S.LavaLash:IsReady() and Target:IsSpellInRange(S.LavaLash) and (S.LashingFlames:IsAvailable()) then
		  if CastTargetIf(S.LavaLash, Enemies10y, "min", EvaluateTargetIfFilterLavaLash, EvaluateTargetIfLavaLash2) then return "lava_lash aoe 16"; end
		end
		-- lava_lash,if=talent.molten_assault.enabled&dot.flame_shock.ticking&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
		if S.LavaLash:IsReady() and Target:IsSpellInRange(S.LavaLash) and (S.MoltenAssault:IsAvailable() and Target:DebuffUp(S.FlameShockDebuff) and (S.FlameShockDebuff:AuraActiveCount() < Enemies10yCount) and S.FlameShockDebuff:AuraActiveCount() < 6) then
		  if Cast(S.LavaLash) then return "lava_lash aoe 17"; end
		end
		-- flame_shock,if=!ticking
		if S.FlameShock:IsReady() and Target:IsSpellInRange(S.FlameShock) and (Target:DebuffDown(S.FlameShockDebuff)) then
		  if Cast(S.FlameShock) then return "flame_shock aoe 18"; end
		end
		-- flame_shock,target_if=min:dot.flame_shock.remains,cycle_targets=1,if=talent.fire_nova.enabled&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
		if S.FlameShock:IsReady() and Target:IsSpellInRange(S.FlameShock) and (S.FireNova:IsAvailable() and S.FlameShockDebuff:AuraActiveCount() < Enemies10yCount and S.FlameShockDebuff:AuraActiveCount() < 6) then
		  if CastCycle(S.FlameShock, Enemies10y, EvaluateCycleFlameShock) then return "flame_shock aoe 20"; end
		end
		-- ice_strike,if=talent.hailstorm.enabled
		if S.IceStrike:IsReady() and Target:IsInMeleeRange(5) and (S.Hailstorm:IsAvailable()) then
		  if Cast(S.IceStrike) then return "ice_strike aoe 22"; end
		end
		-- frost_shock,if=talent.hailstorm.enabled&buff.hailstorm.up
		if S.FrostShock:IsReady() and Target:IsSpellInRange(S.FrostShock) and (S.Hailstorm:IsAvailable() and Player:BuffUp(S.HailstormBuff)) then
		  if Cast(S.FrostShock) then return "frost_shock aoe 24"; end
		end
		-- sundering
		if S.Sundering:IsReady() and Target:IsInRange(11) then
		  if Cast(S.Sundering) then return "sundering aoe 26"; end
		end
		-- fire_nova,if=active_dot.flame_shock>=4
		if S.FireNova:IsReady() and (S.FlameShockDebuff:AuraActiveCount() >= 4) then
		  if Cast(S.FireNova) then return "fire_nova aoe 28"; end
		end
		-- lava_lash,target_if=min:debuff.lashing_flames.remains,cycle_targets=1,if=talent.lashing_flames.enabled
		if S.LavaLash:IsReady() and Target:IsSpellInRange(S.LavaLash) and (S.LashingFlames:IsAvailable()) then
		  if CastTargetIf(S.LavaLash, Enemies10y, "min", EvaluateTargetIfFilterLavaLash, EvaluateTargetIfLavaLash) then return "lava_lash aoe 32"; end
		end
		-- fire_nova,if=active_dot.flame_shock>=3
		if S.FireNova:IsReady() and (S.FlameShockDebuff:AuraActiveCount() >= 3) then
		  if Cast(S.FireNova) then return "fire_nova aoe 34"; end
		end
		-- elemental_blast,if=(!talent.elemental_spirits.enabled|(talent.elemental_spirits.enabled&(charges=max_charges|buff.feral_spirit.up)))&buff.maelstrom_weapon.stack=10&(!talent.crashing_storms.enabled|active_enemies<=3)
		if S.ElementalBlast:IsReady() and Target:IsSpellInRange(S.ElementalBlast) and (((not S.ElementalSpirits:IsAvailable()) or (S.ElementalSpirits:IsAvailable() and (S.ElementalBlast:Charges() == MaxEBCharges or Player:BuffUp(S.FeralSpiritBuff)))) and Player:BuffStack(S.MaelstromWeaponBuff) == 10 and ((not S.CrashingStorms) or Enemies10yCount <= 3)) then
		  if Cast(S.ElementalBlast) then return "elemental_blast aoe 36"; end
		end
		-- chain_lightning,if=buff.maelstrom_weapon.stack=10
		if S.ChainLightning:IsReady() and Target:IsSpellInRange(S.ChainLightning) and (Player:BuffStack(S.MaelstromWeaponBuff) == 10) then
		  if Cast(S.ChainLightning) then return "chain_lightning aoe 38"; end
		end
		-- crash_lightning,if=buff.cl_crash_lightning.up
		if S.CrashLightning:IsReady() and Target:IsInMeleeRange(5) and (Player:BuffUp(S.CLCrashLightningBuff)) then
		  if Cast(S.CrashLightning) then return "crash_lightning aoe 40"; end
		end
		if Player:BuffUp(S.CrashLightningBuff) then
		  -- lava_lash,if=buff.crash_lightning.up&buff.ashen_catalyst.stack=8
		  if S.LavaLash:IsReady() and Target:IsInMeleeRange(5) and (Player:BuffStack(S.AshenCatalystBuff) == 8) then
			if Cast(S.LavaLash) then return "lava_lash aoe 42"; end
		  end
		  -- windstrike,if=buff.crash_lightning.up
		  if S.Windstrike:IsReady() and Target:IsSpellInRange(S.Windstrike) then
			if Cast(S.Windstrike) then return "windstrike aoe 44"; end
		  end
		  -- stormstrike,if=buff.crash_lightning.up&(buff.converging_storms.stack=6|(set_bonus.tier29_2pc&buff.maelstrom_of_elements.down&buff.maelstrom_weapon.stack<=5))
		  if S.Stormstrike:IsReady() and Target:IsInMeleeRange(5) and (Player:BuffStack(S.ConvergingStorms) == 6 or (Player:HasTier(29, 2) and Player:BuffDown(S.MaelstromofElementsBuff) and Player:BuffStack(S.MaelstromWeaponBuff) <= 5)) then
			if Cast(S.Stormstrike) then return "stormstrike aoe 46"; end
		  end
		  -- lava_lash,if=buff.crash_lightning.up,if=talent.molten_assault.enabled
		  if S.LavaLash:IsReady() and Target:IsInMeleeRange(5) and (S.MoltenAssault:IsAvailable()) then
			if Cast(S.LavaLash) then return "lava_lash aoe 48"; end
		  end
		  -- ice_strike,if=buff.crash_lightning.up,if=talent.swirling_maelstrom.enabled
		  if S.IceStrike:IsReady() and Target:IsInMeleeRange(5) and (S.SwirlingMaelstrom:IsAvailable()) then
			if Cast(S.IceStrike) then return "ice_strike aoe 50"; end
		  end
		  -- stormstrike,if=buff.crash_lightning.up
		  if S.Stormstrike:IsReady() and Target:IsInMeleeRange(5) then
			if Cast(S.Stormstrike) then return "stormstrike aoe 52"; end
		  end
		  -- ice_strike,if=buff.crash_lightning.up
		  if S.IceStrike:IsReady() and Target:IsInMeleeRange(5) then
			if Cast(S.IceStrike) then return "ice_strike aoe 50"; end
		  end
		  -- lava_lash,if=buff.crash_lightning.up
		  if S.LavaLash:IsReady() and Target:IsInMeleeRange(5) then
			if Cast(S.LavaLash) then return "lava_lash aoe 48"; end
		  end
		end
		-- elemental_blast,if=(!talent.elemental_spirits.enabled|(talent.elemental_spirits.enabled&(charges=max_charges|buff.feral_spirit.up)))&buff.maelstrom_weapon.stack>=5&(!talent.crashing_storms.enabled|active_enemies<=3)
		if S.ElementalBlast:IsReady() and Target:IsSpellInRange(S.ElementalBlast) and (((not S.ElementalSpirits:IsAvailable()) or (S.ElementalSpirits:IsAvailable() and (S.ElementalBlast:Charges() == MaxEBCharges or Player:BuffUp(S.FeralSpiritBuff)))) and Player:BuffStack(S.MaelstromWeaponBuff) >= 5 and ((not S.CrashingStorms:IsAvailable()) or Enemies10yCount <= 3)) then
		  if Cast(S.ElementalBlast) then return "elemental_blast aoe 54"; end
		end
		-- fire_nova,if=active_dot.flame_shock>=2
		if S.FireNova:IsReady() and (S.FlameShockDebuff:AuraActiveCount() >= 2) then
		  if Cast(S.FireNova) then return "fire_nova aoe 56"; end
		end
		-- crash_lightning
		if S.CrashLightning:IsReady() and Target:IsInRange(8) then
		  if Cast(S.CrashLightning) then return "crash_lightning aoe 58"; end
		end
		-- windstrike
		if S.Windstrike:IsReady() and Target:IsSpellInRange(S.Windstrike) then
		  if Cast(S.Windstrike) then return "windstrike aoe 60"; end
		end
		-- lava_lash,if=talent.molten_assault.enabled
		if S.LavaLash:IsReady() and Target:IsInMeleeRange(5) and (S.MoltenAssault:IsAvailable()) then
		  if Cast(S.LavaLash) then return "lava_lash aoe 62"; end
		end
		-- ice_strike,if=talent.swirling_maelstrom.enabled
		if S.IceStrike:IsReady() and Target:IsInMeleeRange(5) and (S.SwirlingMaelstrom:IsAvailable()) then
		  if Cast(S.IceStrike) then return "ice_strike aoe 64"; end
		end
		-- stormstrike
		if S.Stormstrike:IsReady() and Target:IsSpellInRange(S.Stormstrike) then
		  if Cast(S.Stormstrike) then return "stormstrike aoe 66"; end
		end
		-- ice_strike
		if S.IceStrike:IsReady() and Target:IsInMeleeRange(5) then
		  if Cast(S.IceStrike) then return "ice_strike aoe 64"; end
		end
		-- lava_lash
		if S.LavaLash:IsReady() and Target:IsInMeleeRange(5) then
		  if Cast(S.LavaLash) then return "lava_lash aoe 48"; end
		end
		-- flame_shock,target_if=refreshable,cycle_targets=1
		if S.FlameShock:IsReady() and Target:IsSpellInRange(S.FlameShock) then
		  if CastCycle(S.FlameShock, Enemies10y, EvaluateCycleFlameShock) then return "flame_shock aoe 68"; end
		end
		-- frost_shock
		if S.FrostShock:IsReady() and Target:IsSpellInRange(S.FrostShock) then
		  if Cast(S.FrostShock) then return "frost_shock aoe 70"; end
		end
		-- chain_lightning,if=buff.maelstrom_weapon.stack>=5
		if S.ChainLightning:IsReady() and Target:IsSpellInRange(S.ChainLightning) and (Player:BuffStack(S.MaelstromWeaponBuff) >= 5) then
		  if Cast(S.ChainLightning) then return "chain_lightning aoe 72"; end
		end
		-- earth_elemental
		if S.EarthElemental:IsCastable() then
		  if Cast(S.EarthElemental) then return "earth_elemental aoe 74"; end
		end
		-- windfury_totem,if=buff.windfury_totem.remains<30
		if S.WindfuryTotem:IsReady() and (Player:BuffDown(S.WindfuryTotemBuff)) then
		  if Cast(S.WindfuryTotem) then return "windfury_totem aoe 76"; end
		end
	end

	local function MainRotation()
		-- Check weapon enchants
		HasMainHandEnchant, MHEnchantTimeRemains, _, _, HasOffHandEnchant, OHEnchantTimeRemains = GetWeaponEnchantInfo()

		-- Unit Update
		if AoEON() then
			Enemies10y = Player:GetEnemiesInMeleeRange(10)
			Enemies10yCount = #Enemies10y
		else
			Enemies10y = {}
			Enemies10yCount = 1
		end

		-- Calculate fight_remains
		if Player:AffectingCombat() then
			-- Calculate fight_remains
			BossFightRemains = HL.BossFightRemains(nil, true)
			FightRemains = BossFightRemains
			if FightRemains == 11111 then
			FightRemains = HL.FightRemains(Enemies10y, false)
			end
		end

		-- Update Thorim's Invocation
		if Player:AffectingCombat() and Player:BuffUp(S.AscendanceBuff) then
			if Player:PrevGCD(1, S.ChainLightning) then
			TIAction = S.ChainLightning
			elseif Player:PrevGCD(1, S.LightningBolt) then
			TIAction = S.LightningBolt
			end
		end
		-- Moved from Precombat: lightning_shield
		-- Manually added: earth_shield if available and PreferEarthShield setting is true
		-- -- if S.EarthShield:IsReady() and (Player:BuffDown(S.EarthShield) or (not Player:AffectingCombat() and Player:BuffStack(S.EarthShield) < 5)) then
		-- if Cast(S.EarthShield) then return "earth_shield main 2"; end
		if S.LightningShield:IsReady() and Player:BuffDown(S.LightningShield) and (Player:BuffDown(S.EarthShield)) then
		  if Cast(S.LightningShield) then return "lightning_shield main 2"; end
		end
		--------------------------------------
		if S.AstralShift:IsReady() and Player:HealthPercentage() < 50 then
			if Cast(S.AstralShift) then return end
		end
		if S.HealingStreamTotem:IsReady() and Player:HealthPercentage() < 60 then
			if Cast(S.HealingSurge) then return end
		end
		if S.HealingSurge:IsReady() and Player:BuffStack(S.MaelstromWeaponBuff) == 5 and Player:HealthPercentage() < 60 then
			if Cast(S.HealingSurge) then return end
		end

		--------------------------------------
		-- Precombat
		if not Player:AffectingCombat() then
			local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
		end
		if Player:AffectingCombat() then
			-- bloodlust
			-- Not adding this, as when to use Bloodlust will vary fight to fight
			-- potion,if=(talent.ascendance.enabled&raid_event.adds.in>=90&cooldown.ascendance.remains<10)|(talent.doom_winds.enabled&buff.doom_winds.up)|(!talent.doom_winds.enabled&!talent.ascendance.enabled&talent.feral_spirit.enabled&buff.feral_spirit.up)|(!talent.doom_winds.enabled&!talent.ascendance.enabled&!talent.feral_spirit.enabled)|active_enemies>1|fight_remains<30
			-- wind_shear
			-- auto_attack
			if true then
				if I.AlgetharPuzzleBox:IsEquippedAndReady() and not Player:IsMoving() then
					if Cast(I.AlgetharPuzzleBox) then return end
				end
				-- use_item,name=the_first_sigil,if=(talent.ascendance.enabled&raid_event.adds.in>=90&cooldown.ascendance.remains<10)|(talent.hot_hand.enabled&buff.molten_weapon.up)|buff.icy_edge.up|(talent.stormflurry.enabled&buff.crackling_surge.up)|active_enemies>1|fight_remains<30
				if I.TheFirstSigil:IsEquippedAndReady() and ((S.Ascendance:IsAvailable() and S.Ascendance:CooldownRemains() < 10) or (S.HotHand:IsAvailable() and Player:BuffUp(S.MoltenWeaponBuff)) or Player:BuffUp(S.IcyEdgeBuff) or (S.Stormflurry:IsAvailable() and Player:BuffUp(S.CracklingSurgeBuff)) or Enemies10yCount > 1 or FightRemains < 30) then
					if Cast(I.TheFirstSigil) then return "the_first_sigil main 6"; end
				end
				-- use_item,name=cache_of_acquired_treasures,if=buff.acquired_sword.up|fight_remains<25
				if I.CacheofAcquiredTreasures:IsEquippedAndReady() and (Player:BuffUp(S.AcquiredSwordBuff) or FightRemains < 25) then
				if Cast(I.CacheofAcquiredTreasures) then return "cache_of_acquired_treasures main 8"; end
				end
				-- use_item,name=scars_of_fraternal_strife,if=!buff.scars_of_fraternal_strife_4.up|fight_remains<31|raid_event.adds.in<16|active_enemies>1
				if I.ScarsofFraternalStrife:IsEquippedAndReady() and (Player:BuffDown(S.ScarsofFraternalStrifeBuff4) or FightRemains < 31 or Enemies10yCount > 1) then
					if Cast(I.ScarsofFraternalStrife) then return "scars_of_fraternal_strife main 10"; end
				end

				-- use_items,slots=trinket1,if=!variable.trinket1_is_weird
				-- use_items,slots=trinket2,if=!variable.trinket2_is_weird
				-- Note: These variables just exclude the above three trinkets from the generic use_items. We'll just use HR's OnUseExcludes instead.
				-- use_items
				local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
				if TrinketToUse then
				if Cast(TrinketToUse) then return "Generic use_items for " .. TrinketToUse:Name(); end
				end
			end
			if (CDsON()) then
				-- blood_fury,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
				if S.BloodFury:IsCastable() and (not S.Ascendance:IsAvailable() or Player:BuffUp(S.AscendanceBuff) or S.Ascendance:CooldownRemains() > 50) then
				if Cast(S.BloodFury) then return "blood_fury racial"; end
				end
				-- berserking,if=!talent.ascendance.enabled|buff.ascendance.up
				if S.Berserking:IsCastable() and (not S.Ascendance:IsAvailable() or Player:BuffUp(S.AscendanceBuff)) then
				if Cast(S.Berserking) then return "berserking racial"; end
				end
				-- fireblood,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
				if S.Fireblood:IsCastable() and (not S.Ascendance:IsAvailable() or Player:BuffUp(S.AscendanceBuff) or S.Ascendance:CooldownRemains() > 50) then
				if Cast(S.Fireblood) then return "fireblood racial"; end
				end
				-- ancestral_call,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
				if S.AncestralCall:IsCastable() and (not S.Ascendance:IsAvailable() or Player:BuffUp(S.AscendanceBuff) or S.Ascendance:CooldownRemains() > 50) then
				if Cast(S.AncestralCall) then return "ancestral_call racial"; end
				end
			end
			-- feral_spirit
			if S.FeralSpirit:IsCastable() then
				if Cast(S.FeralSpirit) then return "feral_spirit main 12"; end
			end
			-- ascendance,if=(ti_lightning_bolt&active_enemies=1&raid_event.adds.in>=90)|(ti_chain_lightning&active_enemies>1)
			if S.Ascendance:IsCastable() and CDsON() and (TIAction == S.LightningBolt and Enemies10yCount == 1 or TIAction == S.ChainLightning and Enemies10yCount > 1) then
				if Cast(S.Ascendance) then return "ascendance main 18"; end
			end
			-- doom_winds,if=raid_event.adds.in>=90|active_enemies>1
			if S.DoomWinds:IsCastable() and Target:IsInMeleeRange(5) and CDsON() then
				if Cast(S.DoomWinds) then return "doom_winds main 20"; end
			end
			-- call_action_list,name=single,if=active_enemies=1
			if Enemies10yCount == 1 then
				local ShouldReturn = Single(); if ShouldReturn then return ShouldReturn; end
			end
			-- call_action_list,name=aoe,if=active_enemies>1
			if AoEON() and Enemies10yCount > 1 then
				local ShouldReturn = Aoe(); if ShouldReturn then return ShouldReturn; end
			end
			-- If nothing else to do, show the Pool icon
		end
		
	end
	MainAddon.SetCustomAPL(Author, SpecID, MainRotation, Init)
end

--Loop to wait for the addon to be ready!
local function TryLoading ()
    C_Timer.After(1, function()
		if MainAddon then
			MyRoutine()
		else
			TryLoading()
		end
    end)
end
TryLoading()


-- warrior="T29_Warrior_Protection"
-- source=default
-- spec=protection
-- level=70
-- race=dwarf
-- role=tank
-- position=front
-- professions=blacksmithing=100/jewelcrafting=100
-- talents=BkEAAAAAAAAAAAAAAAAAAAAAAIECAAAAIJJSSCSLpkkkWDRgQRAlkEAikkQLkkAEOQIAAAAAAAQEAAKlCA

-- # Default consumables
-- potion=elemental_potion_of_ultimate_power_3
-- flask=phial_of_static_empowerment_3
-- food=fated_fortune_cookie
-- augmentation=draconic
-- temporary_enchant=main_hand:howling_rune_3

-- # This default action priority list is automatically created based on your character.
-- # It is a attempt to provide you with a action list that is both simple and practicable,
-- # while resulting in a meaningful and good simulation. It may not result in the absolutely highest possible dps.
-- # Feel free to edit, adapt and improve it to your own needs.
-- # SimulationCraft is always looking for updates and improvements to the default action lists.

-- # Executed before combat begins. Accepts non-harmful actions only.
-- actions.precombat=flask
-- actions.precombat+=/food
-- actions.precombat+=/augmentation
-- actions.precombat+=/battle_stance,toggle=on
-- # Snapshot raid buffed stats before combat begins and pre-potting is done.
-- actions.precombat+=/snapshot_stats
-- actions.precombat+=/use_item,name=algethar_puzzle_box

-- # Executed every time the actor is available.
-- actions=auto_attack
-- actions+=/charge,if=time=0
-- actions+=/use_items
-- actions+=/avatar
-- actions+=/shield_wall,if=talent.immovable_object.enabled&buff.avatar.down
-- actions+=/blood_fury
-- actions+=/berserking
-- actions+=/arcane_torrent
-- actions+=/lights_judgment
-- actions+=/fireblood
-- actions+=/ancestral_call
-- actions+=/bag_of_tricks
-- actions+=/potion,if=buff.avatar.up|buff.avatar.up&target.health.pct<=20
-- actions+=/ignore_pain,if=target.health.pct>=20&(rage.deficit<=15&cooldown.shield_slam.ready|rage.deficit<=40&cooldown.shield_charge.ready&talent.champions_bulwark.enabled|rage.deficit<=20&cooldown.shield_charge.ready|rage.deficit<=30&cooldown.demoralizing_shout.ready&talent.booming_voice.enabled|rage.deficit<=20&cooldown.avatar.ready|rage.deficit<=45&cooldown.demoralizing_shout.ready&talent.booming_voice.enabled&buff.last_stand.up&talent.unnerving_focus.enabled|rage.deficit<=30&cooldown.avatar.ready&buff.last_stand.up&talent.unnerving_focus.enabled|rage.deficit<=20|rage.deficit<=40&cooldown.shield_slam.ready&buff.violent_outburst.up&talent.heavy_repercussions.enabled&talent.impenetrable_wall.enabled|rage.deficit<=55&cooldown.shield_slam.ready&buff.violent_outburst.up&buff.last_stand.up&talent.unnerving_focus.enabled&talent.heavy_repercussions.enabled&talent.impenetrable_wall.enabled|rage.deficit<=17&cooldown.shield_slam.ready&talent.heavy_repercussions.enabled|rage.deficit<=18&cooldown.shield_slam.ready&talent.impenetrable_wall.enabled),use_off_gcd=1
-- actions+=/last_stand,if=(target.health.pct>=90&talent.unnerving_focus.enabled|target.health.pct<=20&talent.unnerving_focus.enabled)|talent.bolster.enabled
-- actions+=/ravager
-- actions+=/demoralizing_shout,if=talent.booming_voice.enabled
-- actions+=/spear_of_bastion
-- actions+=/thunderous_roar
-- actions+=/shockwave,if=talent.sonic_boom.enabled&buff.avatar.up&talent.unstoppable_force.enabled&!talent.rumbling_earth.enabled
-- actions+=/shield_charge
-- actions+=/shield_block,if=buff.shield_block.duration<=18&talent.enduring_defenses.enabled|buff.shield_block.duration<=12
-- actions+=/run_action_list,name=aoe,if=spell_targets.thunder_clap>=3
-- actions+=/call_action_list,name=generic

-- actions.aoe=thunder_clap,if=dot.rend.remains<=1
-- actions.aoe+=/thunder_clap,if=buff.violent_outburst.up&spell_targets.thunderclap>5&buff.avatar.up&talent.unstoppable_force.enabled
-- actions.aoe+=/revenge,if=rage>=70&talent.seismic_reverberation.enabled&spell_targets.revenge>=3
-- actions.aoe+=/shield_slam,if=rage<=60|buff.violent_outburst.up&spell_targets.thunderclap<=4
-- actions.aoe+=/thunder_clap
-- actions.aoe+=/revenge,if=rage>=30|rage>=40&talent.barbaric_training.enabled

-- actions.generic=shield_slam
-- actions.generic+=/thunder_clap,if=dot.rend.remains<=1&buff.violent_outburst.down
-- actions.generic+=/execute,if=buff.sudden_death.up&talent.sudden_death.enabled
-- actions.generic+=/execute,if=spell_targets.revenge=1&(talent.massacre.enabled|talent.juggernaut.enabled)&rage>=50
-- actions.generic+=/revenge,if=buff.vanguards_determination.down&rage>=40
-- actions.generic+=/execute,if=spell_targets.revenge=1&rage>=50
-- actions.generic+=/thunder_clap,if=(spell_targets.thunder_clap>1|cooldown.shield_slam.remains&!buff.violent_outburst.up)
-- actions.generic+=/revenge,if=(rage>=60&target.health.pct>20|buff.revenge.up&target.health.pct<=20&rage<=18&cooldown.shield_slam.remains|buff.revenge.up&target.health.pct>20)|(rage>=60&target.health.pct>35|buff.revenge.up&target.health.pct<=35&rage<=18&cooldown.shield_slam.remains|buff.revenge.up&target.health.pct>35)&talent.massacre.enabled
-- actions.generic+=/execute,if=spell_targets.revenge=1
-- actions.generic+=/revenge
-- actions.generic+=/thunder_clap,if=(spell_targets.thunder_clap>=1|cooldown.shield_slam.remains&buff.violent_outburst.up)
-- actions.generic+=/devastate

-- head=infurious_helm_of_vengeance,id=190522,bonus_id=8836/8840/8902/8960/8809/8801,ilevel=418,gem_id=192919
-- neck=eye_of_the_vengeful_hurricane,id=195496,bonus_id=4800/4786/1498,gem_id=192919/192919/192919
-- shoulders=peaks_of_the_walking_mountain,id=200428,bonus_id=1463/8767,ilevel=421
-- back=cape_of_the_duskwatch,id=137483,bonus_id=1795/6808/4786/3300,ilevel=421,drop_level=70
-- chest=husk_of_the_walking_mountain,id=200423,bonus_id=1466/8767,ilevel=421,enchant=waking_stats_3
-- wrists=virtuous_silver_bracers,id=200421,bonus_id=4800/4786/1498,ilevel=424,gem_id=192919
-- hands=gauntlets_of_the_walking_mountain,id=200425,bonus_id=1466/8767,ilevel=421
-- waist=unstable_frostfire_belt,id=191623,bonus_id=8836/8840/8902/8960/8801,ilevel=418,gem_id=192985
-- legs=poleyns_of_the_walking_mountain,id=200427,bonus_id=1472/8767,ilevel=421,enchant=frosted_armor_kit_3
-- feet=kurogs_thunderhooves,id=195517,bonus_id=4800/4786/1498
-- finger1=seal_of_diurnas_chosen,id=195480,bonus_id=4800/4786/1498,gem_id=192919,enchant=devotion_of_haste_3
-- finger2=jeweled_signet_of_melandrus,id=134542,bonus_id=1795/6808/4786/3300/6935,ilevel=421,gem_id=192919,enchant=devotion_of_haste_3,drop_level=70
-- trinket1=manic_grieftorch,id=194308,bonus_id=7979/6652/1472/8767,ilevel=421
-- trinket2=windscar_whetstone,id=137486,bonus_id=6652/3300/8767
-- main_hand=strike_twice,id=193700,bonus_id=6808/4786/1643,enchant=frozen_devotion_3
-- off_hand=broodsworn_legionnaires_pavise,id=195520,bonus_id=4800/4786/1498

-- # Gear Summary
-- # gear_ilvl=421.00
-- # gear_strength=4913
-- # gear_stamina=13046
-- # gear_intellect=786
-- # gear_crit_rating=3647
-- # gear_haste_rating=3648
-- # gear_mastery_rating=2076
-- # gear_versatility_rating=2358
-- # gear_armor=10805
-- # gear_bonus_armor=141
-- # set_bonus=tier29_2pc=1
-- # set_bonus=tier29_4pc=1
