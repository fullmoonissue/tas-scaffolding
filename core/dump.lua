return setmetatable(
    {},
    {
        __call = function()
            return {
                -- Dump the listing of files asked for each tas
                lfsForBizhawk = function(tasFolder)
                    local lfs = require('lfs')
                    local contents = { 'return {' }
                    for folder in lfs.dir(tasFolder) do
                        if folder ~= '.' and folder ~= '..' then
                            local rTasFolder = tasFolder .. '/' .. folder
                            if lfs.attributes(rTasFolder).mode == 'directory' then
                                contents[#contents + 1] = '    [\'' .. folder .. '\'] = {'
                                for file in lfs.dir(rTasFolder) do
                                    if file ~= '.' and file ~= '..' then
                                        contents[#contents + 1] = '        \'' .. string.gsub(file, '.lua', '') .. '\','
                                    end
                                end
                                contents[#contents + 1] = '    },'
                            end
                        end
                    end
                    contents[#contents + 1] = '}'

                    return table.concat(contents, "\n")
                end,
            }
        end
    }
)