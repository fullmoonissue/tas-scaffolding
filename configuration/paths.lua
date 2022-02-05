-- Take note that if you change the paths here, the paths quoted into :
-- * README.md
-- * assets/templates/Makefile
-- will be no more valid. Do it with caution.

return {
    ['configuration'] = {
        ['play'] = 'configuration/play',
        ['savestate'] = 'configuration/savestates',
        ['screenshot'] = 'configuration/screenshots',
    },
    ['subscriber'] = {
        ['bizhawk'] = 'src/subscriber/bizhawk',
        ['overlay'] = 'src/subscriber/overlay',
        ['screenshot'] = 'src/subscriber/screenshot',
    },
    ['folder'] = {
        ['bk2'] = 'assets/bk2',
        ['publication'] = 'assets/publication',
        ['savestate'] = 'assets/savestates',
        ['tas'] = 'tas',
    },
    ['tas'] = {
        ['files'] = 'configuration/files',
    },
    ['template'] = {
        ['newFile'] = 'assets/templates/new-inputs-file.lua',
    },
}