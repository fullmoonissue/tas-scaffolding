local Inputs = {
    DISK_SELECT = {
        Label = 'Disc Select',
        DefaultValue = '1'
    },
    OPEN = {
        Label = 'Open',
        DefaultValue = '.'
    },
    CLOSE = {
        Label = 'Close',
        DefaultValue = '.'
    },
    RESET = {
        Label = 'Reset',
        DefaultValue = '.'
    },
    LEFT_STICK_X = {
        Label = '%s LStick X',
        DefaultValue = '128',
    },
    LEFT_STICK_Y = {
        Label = '%s LStick Y',
        DefaultValue = '128',
    },
    RIGHT_STICK_X = {
        Label = '%s RStick X',
        DefaultValue = '128',
    },
    RIGHT_STICK_Y = {
        Label = '%s RStick Y',
        DefaultValue = '128',
    },
    UP = {
        Label = '%s Up',
        DefaultValue = '.',
        ActiveValue = 'U'
    },
    DOWN = {
        Label = '%s Down',
        DefaultValue = '.',
        ActiveValue = 'D'
    },
    LEFT = {
        Label = '%s Left',
        DefaultValue = '.',
        ActiveValue = 'L'
    },
    RIGHT = {
        Label = '%s Right',
        DefaultValue = '.',
        ActiveValue = 'R'
    },
    SELECT = {
        Label = '%s Select',
        DefaultValue = '.',
        ActiveValue = 's'
    },
    START = {
        Label = '%s Start',
        DefaultValue = '.',
        ActiveValue = 'S'
    },
    SQUARE = {
        Label = '%s Square',
        DefaultValue = '.',
        ActiveValue = 'Q'
    },
    TRIANGLE = {
        Label = '%s Triangle',
        DefaultValue = '.',
        ActiveValue = 'T'
    },
    CIRCLE = {
        Label = '%s Circle',
        DefaultValue = '.',
        ActiveValue = 'O'
    },
    CROSS = {
        Label = '%s Cross',
        DefaultValue = '.',
        ActiveValue = 'X'
    },
    L1 = {
        Label = '%s L1',
        DefaultValue = '.',
        ActiveValue = 'l'
    },
    R1 = {
        Label = '%s R1',
        DefaultValue = '.',
        ActiveValue = 'r'
    },
    L2 = {
        Label = '%s L2',
        DefaultValue = '.',
        ActiveValue = 'L'
    },
    R2 = {
        Label = '%s R2',
        DefaultValue = '.',
        ActiveValue = 'R'
    },
    L3 = {
        Label = '%s L3',
        DefaultValue = '.',
    },
    R3 = {
        Label = '%s R3',
        DefaultValue = '.',
    },
    MODE = {
        Label = '%s MODE',
        DefaultValue = '.',
    }
}

return {
    getConsoleNamesOrdered = function()
        return {
            'DISK_SELECT',
            'OPEN',
            'CLOSE',
            'RESET'
        }
    end,
    getConsoleLabel = function(name)
        return Inputs[name].Label
    end,
    getConsoleDefaultValue = function(name)
        return Inputs[name].DefaultValue
    end,

    getButtonNamesOrdered = function()
        return {
            'LEFT_STICK_X',
            'LEFT_STICK_Y',
            'RIGHT_STICK_X',
            'RIGHT_STICK_Y',
            'UP',
            'DOWN',
            'LEFT',
            'RIGHT',
            'SELECT',
            'START',
            'SQUARE',
            'TRIANGLE',
            'CIRCLE',
            'CROSS',
            'L1',
            'R1',
            'L2',
            'R2',
            'L3',
            'R3',
            'MODE'
        }
    end,
    getButtonLabel = function(player, name)
        return string.format(Inputs[name].Label, string.format('P%d', player))
    end,
    getButtonDefaultValue = function(name)
        return Inputs[name].DefaultValue
    end,
    getButtonActiveValue = function(name)
        return Inputs[name].ActiveValue
    end
}