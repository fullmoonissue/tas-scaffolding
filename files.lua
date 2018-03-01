-- Listing of the files of your tas (can be multiple tas)
-- Requirements : table (key : tas name [a folder name in the tas folder], value : array of files without lua extension)
-- Why : io.popen is not available in BizHawk and can't juggle with LuaFileSystem on multi os
return {}