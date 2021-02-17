using SQLite
using DataFrames
using Gadfly
namesDB = SQLite.DB(ARGS[1])

result = DBInterface.execute(namesDB, "SELECT YEAR, num FROM BabyNames WHERE 
        name = ($(SQLite.esc_id(ARGS[2]))) COLLATE NOCASE and sex = ($(SQLite.esc_id(ARGS[3]))) GROUP BY year") |> DataFrame
Gadfly.push_theme(:dark)
p = plot(result, x=:year, y=:num, Geom.point, Geom.line, Guide.title(ARGS[2]))
img = SVG("plot.svg", 15cm, 10cm)
draw(img, p)