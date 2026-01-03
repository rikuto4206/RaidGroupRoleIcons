--local f = CreateFrame("Frame")

-- local defaults = {
-- 	debugMode = false,
-- }

-- RaidGroupRoleIcons_SavedVars = {}

local roleIcons = {
    ["DAMAGER"] = "UI-LFG-RoleIcon-DPS",
    ["HEALER"] = "UI-LFG-RoleIcon-Healer",
    ["TANK"] = "UI-LFG-RoleIcon-Tank"
}

-- local function OnSettingChanged(setting, value)
-- 	-- local variable = setting:GetVariable()
-- 	-- RaidGroupRoleIcons_SavedVars[variable] = value
-- end


-- local category = Settings.RegisterVerticalLayoutCategory("RaidGroupRoleIcons")

-- do
--     local variable = "RaidGroupRoleIcons_DebugMode"
--     local name = "Debug Mode"
--     local tooltip = "Enable debug mode for RaidGroupRoleIcons"
--     local variableKey = "DebugMode"
--     local variableTbl = RaidGroupRoleIcons_SavedVars
--     local defaultValue = false

-- 	local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
--     Settings.CreateCheckbox(category, setting, tooltip)
-- 	Settings.SetOnValueChangedCallback(variable, OnSettingChanged)
-- end

-- Settings.RegisterAddOnCategory(category)

local function OnEvent(allstates, event, ...)
    local status = ...
    for state in pairs(allstates) do
        allstates[state] = {show = false, changed = true}
    end
    for i = 1, 40 do
        local unitFrame = _G["RaidGroupButton"..i]
        if unitFrame then
            local role = UnitGroupRolesAssigned(unitFrame.unit)
            if role ~= "NONE" then
                allstates[i] = {
                    show = true,
                    changed = true,
                    icon = roleIcons[role],
                    parent = unitFrame,
                }

                local f = CreateFrame("Frame", nil, unitFrame)
				local size = unitFrame:GetHeight()
                f:SetSize(size+4, size+4)
				f:SetPoint("CENTER", 14, 0)
				f.tex = f:CreateTexture()
				f.tex:SetPoint("CENTER")
				f.tex:SetSize(size+4, size+4)
				f.tex:SetAtlas(roleIcons[role], false)
            end
        end
    end
    return true
end

local f = CreateFrame("Frame")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:SetScript("OnEvent", OnEvent)