local ui = require('openmw.ui')
local util = require('openmw.util')
local time = require('openmw_aux.time')
local self = require('openmw.self')
local storage = require('openmw.storage')
-- local I = require('openmw.interfaces')

local bit8 = 255
local statColors = {
    fatigue = util.color.rgb(0 / bit8, 150 / bit8, 60 / bit8),
    health = util.color.rgb(200 / bit8, 60 / bit8, 30 / bit8),
    magicka = util.color.rgb(53 / bit8, 69 / bit8, 159 / bit8),
}

local element = ui.create {
    layer = 'HUD',
    type = ui.TYPE.Text,
    props = {
        relativePosition = util.vector2(0.9, 0.05),
        anchor = util.vector2(1, 0),
        -- text = "Initiating Level Indicator...",
        text = "Reaching for Meridia's grace...",
        textSize = 14,
        textColor = statColors.health,
        textShadow = true,
        textShadowColor =  statColors.magicka,
    },
}

local progressElement = ui.create {
    layer = 'HUD',
    type = ui.TYPE.Text,
    props = {
        relativePosition = util.vector2(0.9, 0.07),
        anchor = util.vector2(1, 0),
        text = "Initiating Level Indicator...",
        textSize = 12,
        textColor = util.color.rgb(1, 1, 1),
        textShadow = true,
        textShadowColor = util.color.rgb(0, 0, 0)
    },
}

-- local iconTex = ui.texture({
--     path = 'textures/menu_bar_red.dds'
-- })
local iconStandby = ui.texture({
    path = 'textures/level_up_00.dds'
})

local IconReady = ui.texture({
    path = 'textures/level_up_01.dds'
})

local iconElement = ui.create {
    type = ui.TYPE.Container,
    layer = 'HUD',
    props = {
        relativePosition = util.vector2(0.02, 0.05)
    },
    content = ui.content {{
        type = ui.TYPE.Image,
        props = {
            resource = iconStandby,
            size = util.vector2(40 , 40)
        }
    }}
}



local function flashText()
    local stats = (self.object.type).stats.level(self)
    local progress = stats.progress
    local currentLevel = stats.current
    local nextLevel = currentLevel + 1
    local isReadyToLevelUp = progress >= 10

    if isReadyToLevelUp then
        if progressElement.layout.props.text == "" then
            progressElement.layout.props.text = "Ascend to lvl: " .. tostring(nextLevel) .. "!!"
            element.layout.props.textColor = util.color.rgb(171, 0, 3) -- red
        else
            progressElement.layout.props.text = ""
            element.layout.props.textColor = util.color.rgb(242, 154, 2) -- lime green
        end
    end
    -- the layout changes won't affect the widget unless we request an update
    progressElement:update()
    element:update()
    -- iconElement:update()
end

local function updateTime()
    local stats = (self.object.type).stats.level(self)
    local progress = stats.progress
    local currentLevel = stats.current
    local nextLevel = currentLevel + 1
    local isReadyToLevelUp = progress >= 10

    progressElement.layout.props.text = ""
    if isReadyToLevelUp then
        ui.showMessage("Ready to level up...")
        element.layout.props.text = "LEVEL: " .. tostring(stats.current)
        progressElement.layout.props.text = "Ascend to lvl: " .. tostring(nextLevel) .. "!!"
        iconElement.layout.props.content[1].props.resource = IconReady
    else
        element.layout.props.text = "LEVEL: " .. tostring(stats.current)
        progressElement.layout.props.text = "Progress: " .. tostring(progress) .. "/10"
        iconElement.layout.props.content[1].props.resource = iconStandby
    end
    element:update()
    progressElement:update()
    iconElement:update()
end

-- we are showing game time in hours and minutes
-- so no need to update more often than once a game minute
-- I chnaged that to 5!
time.runRepeatedly(updateTime, 1 * time.minute, { type = time.GameTime })
time.runRepeatedly(flashText, 12 * time.second, { type = time.GameTime })