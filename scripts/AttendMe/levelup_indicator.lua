local ui = require('openmw.ui')
local util = require('openmw.util')
local time = require('openmw_aux.time')
local self = require('openmw.self')

local element = ui.create {
    -- important not to forget the layer
    -- by default widgets are not attached to any layer and are not visible
    layer = 'HUD',
    type = ui.TYPE.Text,
    props = {
        -- position in the top right corner
        relativePosition = util.vector2(1, 0),
        -- position is for the top left corner of the widget by default
        -- change it to align exactly to the top right corner of the screen
        anchor = util.vector2(1, 0),
        -- text = calendar.formatGameTime('%H:%M'),
        text = "TEST!",
        textSize = 18,
        -- default black text color isn't always visible, lime green is better
        textColor = util.color.rgb(158, 0, 237),
    },
}


local function updateTime()
    ui.showMessage("Checking level up...")
    print("This is a console message.")
    -- local health = (self.object.type).stats.dynamic.health(self)
    -- ui.showMessage(tostring(health.current) .. " / " .. tostring(health.base) .. " health")

    local isPlayer = (self.object.type).objectIsInstance(self, "player")
    -- ui.showMessage(tostring(isPlayer) .. "isPlayer: ")
    
    -- ui.showMessage(tostring(level) .. " level")
    -- ui.showMessage(tostring(progress) .. " progress")
    local stats = (self.object.type).stats.level(self)

    ui.showMessage(tostring(stats.progress) .. "  /  " .. tostring(stats.current) .. " LVL Progress")
    -- formatGameTime uses current time by default

    -- otherwise we could get it by calling `core.getGameTime()`
    -- element.layout.props.text = calendar.formatGameTime('%H:%M')
    -- ui.showMessage("LEVEL UP!" .. self.object.name)
    element.layout.props.text = "LEVEL UP!"
    -- the layout changes won't affect the widget unless we request an update
    element:update()
end

-- we are showing game time in hours and minutes
-- so no need to update more often than once a game minute
time.runRepeatedly(updateTime, 1 * time.minute, { type = time.GameTime })
