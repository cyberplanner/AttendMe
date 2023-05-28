local ui = require('openmw.ui')
-- local I = require('openmw.interfaces')
return {
    engineHandlers = {
        onKeyPress = function(key)
            if key.symbol == 'x' then
                ui.showMessage('You have pressed "X"')
            end
        end
    }
}