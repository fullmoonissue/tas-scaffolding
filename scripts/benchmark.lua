-- # ### ### ### ### ### ### ### ### ### #
-- #  This is an example of a benchmark  #
-- # ### ### ### ### ### ### ### ### ### #

local Benchmark = {}

-- Create the database if not exists and connect to it
Benchmark.setup = function (dbFilePath)
    dbFilePath = dbFilePath or 'db/benchmark.db'
    local function prepareDatabase()
        SQL.createdatabase(dbFilePath)
    end

    local function connectDatabase()
        SQL.opendatabase(dbFilePath)
    end

    local function writeEntries()
        SQL.writecommand('CREATE TABLE benchmark (id int PRIMARY KEY, level int, stage int, result int)')
        SQL.writecommand('INSERT INTO benchmark VALUES (1, 1, 1, 0)')
        SQL.writecommand('INSERT INTO benchmark VALUES (2, 1, 2, 0)')
        SQL.writecommand('INSERT INTO benchmark VALUES (3, 1, 3, 0)')
        SQL.writecommand('INSERT INTO benchmark VALUES (4, 2, 1, 0)')
        SQL.writecommand('INSERT INTO benchmark VALUES (5, 2, 2, 0)')
        SQL.writecommand('INSERT INTO benchmark VALUES (6, 2, 3, 0)')
        SQL.writecommand('INSERT INTO benchmark VALUES (7, 3, 1, 0)')
        SQL.writecommand('INSERT INTO benchmark VALUES (8, 3, 2, 0)')
        SQL.writecommand('INSERT INTO benchmark VALUES (9, 3, 3, 0)')
    end

    local f = io.open(dbFilePath, 'r')
    if f ~= nil then
        io.close(f)
        connectDatabase()
    else
        prepareDatabase()
        connectDatabase()
        writeEntries()
    end
end

-- Get the next one to treat
Benchmark.retrieveNext = function()
    local nextBenchmark = SQL.readcommand(
        'SELECT id, level, stage FROM benchmark WHERE result = 0 ORDER BY level asc, stage asc LIMIT 1'
    )

    if not nextBenchmark['id 0'] then
        return nil
    end

    return {
        ['id'] = nextBenchmark['id 0'],
        ['level'] = nextBenchmark['level 0'],
        ['stage'] = nextBenchmark['stage 0'],
    }
end

return Benchmark