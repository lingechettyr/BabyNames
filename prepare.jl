download("https://www.ssa.gov/oact/babynames/names.zip", ARGS[1])

using ZipFile
namesZip = ZipFile.Reader(ARGS[1]);

using SQLite
namesDB = SQLite.DB(ARGS[2]);

SQLite.execute(namesDB, "CREATE TABLE IF NOT EXISTS BabyNames (
        year INTEGER,
        name TEXT,
        sex TEXT,
        num INTEGER)");

using CSV
using DataFrames

df = DataFrame()
checkNum = r"^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$"

for f in namesZip.files
    yearNum = SubString(f.name, 4, 7)
    if (occursin(checkNum, yearNum))
        if nrow(df) == 0
            global df = DataFrame(CSV.File(f, header=false))
            insertcols!(df, 1, :year => [String(yearNum) for i in 1:nrow(df)])
        else
            df2 = DataFrame(CSV.File(f, header=false))
            insertcols!(df2, 2, :year => [String(yearNum) for i in 1:nrow(df2)])
            append!(df, df2)
        end
    end
end

rename!(df, [:year, :name, :sex, :num])
SQLite.load!(df, namesDB, "BabyNames")

close(namesZip)