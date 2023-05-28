local ui = require('openmw.ui')
local util = require('openmw.util')
-- local calendar = require('openmw_aux.calendar')
local time = require('openmw_aux.time')

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
        text = "LEVEL UP!",
        textSize = 24,
        -- default black text color isn't always visible, lime green is better
        textColor = util.color.rgb(0, 1, 0),
    },
}

local function updateTime()
    -- ui.log('Updating time')
    ui.showMessage("LEVEL UP!")
    -- formatGameTime uses current time by default
    -- otherwise we could get it by calling `core.getGameTime()`
    -- element.layout.props.text = calendar.formatGameTime('%H:%M')
    element.layout.props.text = "LEVEL UP!"
    -- the layout changes won't affect the widget unless we request an update
    element:update()
end

-- we are showing game time in hours and minutes
-- so no need to update more often than once a game minute
time.runRepeatedly(updateTime, 1 * time.minute, { type = time.GameTime })
