-- Take note that if you change the paths here, the paths quoted into the tas-scaffolding's README.md will be no
-- more valid. Do it with caution.

return {
    ['collection'] = {
        ['overlay'] = 'plugins/overlay/collection',
        ['preload'] = 'plugins/preload/collection',
        ['screenshot'] = 'plugins/screenshot/collection',
    },
    ['folder'] = {
        ['bk2'] = 'plugins/bizhawk/bk2',
        ['publication'] = 'assets/publication',
        ['savestate'] = 'plugins/preload/savestate',
        ['tas'] = 'tas',
    },
    ['tas'] = {
        ['files'] = 'configuration/files',
        ['infos'] = 'configuration/tas',
    },
    ['template'] = {
        ['newFile'] = 'assets/templates/new-tas-file.lua',
    },
}