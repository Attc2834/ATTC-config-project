-- ============================================
-- GITHUB HOSTED MOD SCRIPT (ATTC CONFIG)
-- ============================================

local function InitModMenuTab()
    local LocUtil = _G.LocUtil
    if not LocUtil and package.loaded["client.common.LocUtil"] then LocUtil = require("client.common.LocUtil") end
    if LocUtil and not LocUtil._IsModMenuHooked then
        local old_get = LocUtil.GetLocalizeResStr
        LocUtil.GetLocalizeResStr = function(id) if type(id) == "string" and not tonumber(id) then return id end return old_get(id) end
        LocUtil._IsModMenuHooked = true
    end

    local SettingPageDefine = require("client.logic.NewSetting.SettingPageDefine")
    local SettingCatalog = require("client.logic.NewSetting.SettingCatalog")
    
    if not SettingPageDefine.ModMenu then
        local AliasMap = require("client.slua.umg.NewSetting.Item.AliasMap")
        
        local WeaponStack = {
            { UI = AliasMap.Title, Text = "WEAPON HACKS" },
            { Key = "ModMenu_NoRecoil", UI = AliasMap.Switcher, Text = "NO RECOIL", GetFunc = function() return _G.Mod_NoRecoil_Enabled ~= false end, SetFunc = function(_, v) _G.Mod_NoRecoil_Enabled = v return true end },
            { Key = "ModMenu_Recoil_Title", UI = AliasMap.TitleSwitcher, Text = "RECOIL VALUE", ExpandIndex = 0, GetFunc = function() return _G.Mod_Recoil_Expand or false end, SetFunc = function(_, v) _G.Mod_Recoil_Expand = v return true end },
            { Key = "ModMenu_Recoil_Value", UI = AliasMap.Slider, Text = "   Value (0.0-0.3)", ExpandHandle = "ModMenu_Recoil_Title", MinValue = 0, MaxValue = 30, min = 0, max = 30, GetFunc = function() return (_G.Mod_Recoil_Value or 30) / 30 end, SetFunc = function(_, v) _G.Mod_Recoil_Value = math.floor(v * 30 + 0.5) return true end },
            { Key = "ModMenu_NoSpread", UI = AliasMap.Switcher, Text = "NO SPREAD", GetFunc = function() return _G.Mod_NoSpread_Enabled ~= false end, SetFunc = function(_, v) _G.Mod_NoSpread_Enabled = v return true end },
            { Key = "ModMenu_NoBreath", UI = AliasMap.Switcher, Text = "NO BREATH", GetFunc = function() return _G.Mod_NoBreath_Enabled ~= false end, SetFunc = function(_, v) _G.Mod_NoBreath_Enabled = v return true end },
            { Key = "ModMenu_AimAssist", UI = AliasMap.Switcher, Text = "AIM ASSIST", GetFunc = function() return _G.Mod_AimAssist_Enabled ~= false end, SetFunc = function(_, v) _G.Mod_AimAssist_Enabled = v return true end }
        }
        
        local PlayerStack = {
            { UI = AliasMap.Title, Text = "PLAYER HACKS" },
            { Key = "ModMenu_NoFallDamage", UI = AliasMap.Switcher, Text = "NO FALL DAMAGE", GetFunc = function() return _G.Mod_NoFallDamage_Enabled ~= false end, SetFunc = function(_, v) _G.Mod_NoFallDamage_Enabled = v return true end },
            { Key = "ModMenu_FOV", UI = AliasMap.TitleSwitcher, Text = "FOV", ExpandIndex = 0, GetFunc = function() return _G.Mod_FOV_Expand or false end, SetFunc = function(_, v) _G.Mod_FOV_Expand = v return true end },
            { Key = "ModMenu_FOV_Value", UI = AliasMap.Slider, Text = "   FOV (80-120)", ExpandHandle = "ModMenu_FOV", MinValue = 80, MaxValue = 120, min = 80, max = 120, GetFunc = function() return ((_G.Mod_FOV_Value or 100) - 80) / 40 end, SetFunc = function(_, v) _G.Mod_FOV_Value = math.floor(80 + (v * 40)) return true end },
            { Key = "ModMenu_FastParachute", UI = AliasMap.Switcher, Text = "FAST PARACHUTE", GetFunc = function() return _G.Mod_FastParachute_Enabled ~= false end, SetFunc = function(_, v) _G.Mod_FastParachute_Enabled = v return true end },
            { Key = "ModMenu_FastParachute_Title", UI = AliasMap.TitleSwitcher, Text = "PARACHUTE SPEED", ExpandIndex = 0, GetFunc = function() return _G.Mod_FastParachute_Expand or false end, SetFunc = function(_, v) _G.Mod_FastParachute_Expand = v return true end },
            { Key = "ModMenu_FastParachute_Value", UI = AliasMap.Slider, Text = "   Speed (1000-10000)", ExpandHandle = "ModMenu_FastParachute_Title", MinValue = 1000, MaxValue = 10000, min = 1000, max = 10000, GetFunc = function() return ((_G.Mod_FastParachute_Speed or 8000) - 1000) / 9000 end, SetFunc = function(_, v) _G.Mod_FastParachute_Speed = math.floor(1000 + (v * 9000)) return true end }
        }
        
        local WallhackStack = {
            { UI = AliasMap.Title, Text = "WALLHACK & ESP" },
            { Key = "ModMenu_Wallhack", UI = AliasMap.Switcher, Text = "WALLHACK", GetFunc = function() return _G.Mod_Wallhack_Enabled ~= false end, SetFunc = function(_, v) _G.Mod_Wallhack_Enabled = v return true end },
            { Key = "ModMenu_Skeleton", UI = AliasMap.Switcher, Text = "SKELETON ESP", GetFunc = function() return _G.Mod_Skeleton_Enabled ~= false end, SetFunc = function(_, v) _G.Mod_Skeleton_Enabled = v return true end }
        }
        
        local VisualStack = {
            { UI = AliasMap.Title, Text = "VISUAL" },
            { Key = "ModMenu_RemoveFog", UI = AliasMap.Switcher, Text = "REMOVE FOG", GetFunc = function() return _G.Mod_RemoveFog_Enabled ~= false end, SetFunc = function(_, v) _G.Mod_RemoveFog_Enabled = v return true end },
            { Key = "ModMenu_RemoveGrass", UI = AliasMap.Switcher, Text = "REMOVE GRASS", GetFunc = function() return _G.Mod_RemoveGrass_Enabled or false end, SetFunc = function(_, v) _G.Mod_RemoveGrass_Enabled = v return true end },
            { Key = "ModMenu_RemoveWater", UI = AliasMap.Switcher, Text = "REMOVE WATER", GetFunc = function() return _G.Mod_RemoveWater_Enabled or false end, SetFunc = function(_, v) _G.Mod_RemoveWater_Enabled = v return true end }
        }
        
        SettingPageDefine.ModMenu = {
            Key = "ModMenu", loc = "⚡ SEAS CONFIG ⚡", UIKey = "Setting_Page_Privacy",
            Category = {
                { Key = "Cat_Weapon", loc = "🔫 WEAPON HACKS", Stack = WeaponStack },
                { Key = "Cat_Player", loc = "🦸 PLAYER HACKS", Stack = PlayerStack },
                { Key = "Cat_Wallhack", loc = "👁️ WALLHACK & ESP", Stack = WallhackStack },
                { Key = "Cat_Visual", loc = "🎨 VISUAL", Stack = VisualStack }
            }
        }
        table.insert(SettingCatalog, SettingPageDefine.ModMenu)
    end

    local UIManager = _G.UIManager
    if UIManager and not UIManager._IsModMenuHooked then
        local old_ShowUI = UIManager.ShowUI
        UIManager.ShowUI = function(config, ...)
            local args = {...}
            if config and config.keyName and (string.find(string.lower(config.keyName), "setting_main") or string.find(string.lower(config.keyName), "setting")) then
                local catalog = args[1]
                if catalog and (type(catalog) == "table" or type(catalog) == "userdata") then
                    local hasModMenu = false
                    local newCatalog = {}
                    for _, page in ipairs(catalog) do table.insert(newCatalog, page) if page.Key == "ModMenu" then hasModMenu = true end end
                    if not hasModMenu then table.insert(newCatalog, SettingPageDefine.ModMenu) args[1] = newCatalog end
                end
            end
            local tu = table.unpack or unpack
            return old_ShowUI(config, tu(args))
        end
        UIManager._IsModMenuHooked = true
    end
end
InitModMenuTab()

-- Logic Helpers
local SecurityCommonUtils = require("GameLua.Mod.BaseMod.Common.Security.SecurityCommonUtils")
local GameplayData = require("GameLua.GameCore.Data.GameplayData")

local function CMD(cmd, val)
  local gi; pcall(function() gi = GameInstance.GetGameInstance() end)
  if gi then pcall(function() gi:ExecuteCMD(cmd, tostring(val)) end) end
end

local function Valid(obj) return slua.isValid(obj) end

local function isPawnAlive(p)
  if not Valid(p) then return false end
  if p.HealthStatus then return SecurityCommonUtils.IsHealthStatusAlive(p.HealthStatus) end
  if p.IsAlive then return p:IsAlive() end
  if p.GetHealth then local hp = p:GetHealth() return hp and hp > 0 end
  return false
end

local function drawEnemySkeleton()
  pcall(function()
    local pc = slua_GameFrontendHUD:GetPlayerController()
    if not Valid(pc) then return end
    local HUD = pc:GetHUD()
    if not Valid(HUD) then return end
    local myChar = pc:GetCurPawn()
    if not Valid(myChar) then return end
    local myTeamID = myChar.TeamID or 0
    local myPos = myChar:K2_GetActorLocation()
    local allPawns = Game:GetAllPlayerPawns() or {}
    for _, pawn in pairs(allPawns) do
      if Valid(pawn) and pawn ~= myChar and isPawnAlive(pawn) then
        if (pawn.TeamID or 0) ~= myTeamID then
          local ppos = pawn:K2_GetActorLocation()
          local distM = math.floor(math.sqrt((ppos.X-myPos.X)^2 + (ppos.Y-myPos.Y)^2 + (ppos.Z-myPos.Z)^2) / 100)
          if distM < 400 then
            HUD:AddDebugText(string.format("%dm", distM), pawn, 0.05, {X=0,Y=0,Z=110}, {X=0,Y=0,Z=110}, {R=0,G=255,B=255,A=255}, true, false, true, nil, 0.8, true)
            HUD:AddDebugText("✚", pawn, 0.05, {X=0,Y=0,Z=90}, {X=0,Y=0,Z=90}, {R=255,G=0,B=0,A=255}, true, false, true, nil, 1.0, true)
          end
        end
      end
    end
  end)
end

local function ApplyVisualMods(enemy, pc, isEnabled)
  if not Valid(enemy) then return end
  local meshes = {}
  pcall(function()
    if Valid(enemy.Mesh) then table.insert(meshes, enemy.Mesh) end
    local SkelClass = import("SkeletalMeshComponent")
    if SkelClass then
      local childs = enemy:GetComponentsByClass(SkelClass)
      if childs then
        local count = type(childs.Num) == "function" and childs:Num() or #childs
        for c = 1, count do
          local comp = type(childs.Get) == "function" and childs:Get(c - 1) or childs[c]
          if Valid(comp) and comp ~= enemy.Mesh then table.insert(meshes, comp) end
        end
      end
    end
  end)
  if isEnabled then
    pcall(function()
      for _, comp in ipairs(meshes) do
        if Valid(comp) then
          comp.UseScopeDistanceCulling = false
          comp.PrimitiveShadingStrategy = 1; comp.ShadingRate = 6
        end
      end
      local finalColor = { R=0.0, G=25.0, B=25.0, A=1.0, r=0.0, g=25.0, b=25.0, a=1.0 }
      for _, comp in ipairs(meshes) do
        if Valid(comp) then
          for i=0,10 do
            local s, mat = pcall(function() return comp:GetMaterial(i) end)
            if not s or not Valid(mat) then break end
            local s2, m = pcall(function() return comp:CreateAndSetMaterialInstanceDynamic(i) end)
            if s2 and Valid(m) then
                m:SetVectorParameterValue("BodyColor", finalColor)
                m:SetVectorParameterValue("Color", finalColor)
            end
          end
        end
      end
    end)
  end
end

local function ManageWallhack()
  pcall(function()
    local pc = slua_GameFrontendHUD:GetPlayerController()
    if not Valid(pc) then return end
    local myChar = pc:GetCurPawn()
    if not Valid(myChar) then return end
    local myTeamId = myChar.TeamID or 0
    local allPawns = Game:GetAllPlayerPawns() or {}
    for _, pawn in pairs(allPawns) do
      if Valid(pawn) and pawn ~= myChar and isPawnAlive(pawn) then
        if (pawn.TeamID or 0) ~= myTeamId then
          ApplyVisualMods(pawn, pc, _G.Mod_Wallhack_Enabled ~= false)
        end
      end
    end
  end)
end

-- Timer Hooks
_G.OnWeaponTimerTick = function(playerChar)
    if not Valid(playerChar) then return end
    local wm = playerChar.WeaponManagerComponent
    if not wm then return end
    local weapon = wm.CurrentWeaponReplicated
    if not weapon then return end
    local entity = weapon.ShootWeaponEntityComp
    if not Valid(entity) then return end
    
    if _G.Mod_NoRecoil_Enabled ~= false then
        local val = (_G.Mod_Recoil_Value or 30) / 100
        entity.RecoilKick = val; entity.RecoilKickADS = val; entity.AnimationKick = val
        entity.AccessoriesVRecoilFactor = val; entity.AccessoriesHRecoilFactor = val
        entity.GameDeviationFactor = val; entity.GameDeviationAccuracy = val
        entity.DeviationMultiplier = val; entity.CameraShakeScale = val
        if entity.RecoilInfo then
            entity.RecoilInfo.VerticalRecoilMin = val
            entity.RecoilInfo.VerticalRecoilMax = val
        end
    end
    if _G.Mod_NoSpread_Enabled ~= false then
        entity.ShotGunHorizontalSpread = 0.3; entity.ShotGunVerticalSpread = 0.3
        entity.DeviationMultiplier = 0.3; entity.GameDeviationFactor = 0.3
    end
    if _G.Mod_NoBreath_Enabled ~= false then
        entity.HoldBreathTimer = 999; entity.BreathHoldTime = 999
        entity.SwayScale = 0.3; entity.SwayYawScale = 0.3; entity.SwayPitchScale = 0.3
    end
    if _G.Mod_AimAssist_Enabled ~= false and entity.AutoAimingConfig then
        for _, r in ipairs({"OuterRange", "InnerRange"}) do
            local cfg = entity.AutoAimingConfig[r]
            if cfg then cfg.Speed = 7; cfg.RangeRate = 2; cfg.SpeedRate = 2 end
        end
    end
end

_G.OnMoveTimerTick = function(playerChar)
    if not Valid(playerChar) then return end
    if _G.Mod_NoFallDamage_Enabled ~= false then
        playerChar.TakeFallDamage = false
        if playerChar.CharacterMovement then playerChar.CharacterMovement.FallDamageScale = 0 end
    end
    if _G.Mod_FastParachute_Enabled ~= false then
        local pc = playerChar.ParachuteComponent
        if Valid(pc) then pc.CurrentFallSpeed = _G.Mod_FastParachute_Speed or 8000 end
    end
end

_G.OnEnvironmentTimerTick = function()
    if _G.Mod_RemoveFog_Enabled ~= false and not _G._fogRemoved then
        CMD("r.Fog", "0"); CMD("r.Atmosphere", "0"); _G._fogRemoved = true
    end
    if _G.Mod_RemoveGrass_Enabled and not _G._grassRemoved then
        CMD("grass.DensityScale", "0"); CMD("grass.Enable", "0"); _G._grassRemoved = true
    end
    if _G.Mod_RemoveWater_Enabled and not _G._waterRemoved then
        CMD("r.Water", "0"); CMD("r.Ocean", "0"); _G._waterRemoved = true
    end
end

_G.OnFOVTick = function(playerChar)
    if _G.Mod_FOV_Value and Valid(playerChar) then
        local tpCam = playerChar.ThirdPersonCameraComponent
        if Valid(tpCam) then tpCam:SetFieldOfView(_G.Mod_FOV_Value) end
    end
end

_G.OnWallhackTick = function()
    ManageWallhack()
end

_G.OnSkeletonTick = function()
    if _G.Mod_Skeleton_Enabled ~= false then drawEnemySkeleton() end
end