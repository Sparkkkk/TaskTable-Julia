using Base.Test
include("tasklist.jl")

# test createemptytable()
t = createemptytable()
@test 5 == length(columns(t))
@test 0 == length(rows(t))
t = nothing

# test isfileexist()
filename = "taskDB/test"
touch(filename)
@test true == isfileexist(filename)
rm(filename)
@test false == isfileexist(filename)

# test loadtable()
t = createemptytable()
save(t, filename)
l = load(filename)
rm(filename)
@test l == t

# test addtask(table, taskname, course, date=nothing, additioninfo=nothing)
addtask(t, 0, "task1", "CPSC322", "date1", "nope")
@test 1 == getlengthofrow(t)

# test finishtask(table, taskname)
t = finishtask(t, 0)
@test 0 == getlengthofrow(t)
