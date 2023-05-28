local ui = require('openmw.ui')
local I = require('openmw.interfaces')
local storage = require('openmw.storage')

I.Settings.registerGroup({
    key = 'SettingsAttendMeUI',
    page = 'AttendMe',
    l10n = 'AttendMe_UISettings',
    name = "group_name",
    permanentStorage = false,
    settings = {
        {
            key = 'showLevelUpIndicator',
            name = "showLevelUpIndicator_name",
            default = true,
            renderer = 'checkbox',
        },
    },
})

local uiSettings = storage.globalSection('SettingsAttendMeUI')

return {
    engineHandlers = {
        -- onLevelUp = function()
        --     if uiSettings:get('showLevelUpIndicator') then
        --         ui.showMessageBox({
        --             message = "You have leveled up!",
        --             buttons = { "OK" },
        --         })
        --     end
        -- end,
        -- onKeyPress = function(key)
        --     if key.symbol == 'x' then
        --         ui.showMessage('You have pressed "X"')
        --     end
        -- end
        onLoad = function()
            ui.showMessage('Hello, Morrowind!')
            -- ui.showMessageBox({
            --     message = "Welcome to AttendMe!",
            --     buttons = { "OK" },
            -- })
        end,
    },
}