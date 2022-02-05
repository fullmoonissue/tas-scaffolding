-- Create and retrieve the file content needed to get the listing of files for each tas
local function lfsForBizhawk(tasFolder)
    local contents = { 'return {' }
    local lsTasCategories = io.popen('/bin/ls ' .. tasFolder)
    for tasCategory in lsTasCategories:lines() do
        contents[#contents + 1] = '    [\'' .. tasCategory .. '\'] = {'
        local lsTasCategoryFiles = io.popen('/bin/ls ' .. tasFolder .. '/' .. tasCategory)
        for file in lsTasCategoryFiles:lines() do
            contents[#contents + 1] = '        \'' .. string.gsub(file, '.lua', '') .. '\','
        end
        lsTasCategoryFiles:close()
        contents[#contents + 1] = '    },'
    end
    lsTasCategories:close()
    contents[#contents + 1] = '}'

    return table.concat(contents, "\n")
end

local function process(cFilesPath, tasPath)
    local f = io.open(cFilesPath, 'w')
    f:write(lfsForBizhawk(tasPath))
    f:close()
end

-- Call
if 'tests/' ~= string.sub(arg[0], 1, 6) then
    process(arg[1], arg[2])
else
    return { lfsForBizhawk = lfsForBizhawk }
end