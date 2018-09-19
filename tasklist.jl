using JuliaDB

dbase = "taskDB/current_tasklist_database"
completed_dbase = "taskDB/completed_dbase"

function createemptytable(undone=true)
	t = table([], [], [], [], [], names=[:index, :taskname, :course, :date, :additioninfo], pkey = :index)
	path = if undone dbase else completed_dbase end
	save(t, path)
	return t
end

function loadtable()
	return load(dbase)
end

function loadcompletedlist()
	return load(completed_dbase)
end

function isfileexist(file)
	return isfile(file)
end

function isdatabaseexist()
	return isfileexist(dbase)
end

function addtask(table, taskname, course, date=nothing, additioninfo=nothing)
	index = if length(rows(table))==0 0 else rows(sort(table))[end][1] + 1 end
	push!(rows(table), @NT(index=index, taskname=taskname, course=course, date=date, additioninfo=additioninfo))
	table = sort(table)
	save(table, dbase)
	return table
end

function finishtask(t, ind, saveindb=true)
	if saveindb
		temp = if isfile(completed_dbase) loadcompletedlist() else table([], [], [], [], [], names=[:index, :taskname, :course, :date, :additioninfo], pkey = :index) end
		args = rows(filter(p->p.index==ind, t))[1]
		push!(rows(temp), @NT(index=args[1], taskname=args[2], course=args[3], date=args[4], additioninfo=args[5]))
		save(temp, completed_dbase)
	end
	t = filter(p->p.index!=ind, t)
	save(t, dbase)
	return t
end

function gettaskwithcourse(table, course_name)
	return filter(p->p.course==course_name, table)
end

function getreadingtask(table)
	return filter(p->p.taskname=="Reading", table)
end

function getlengthofrow(table)
	return length(rows(table))
end

function getlengthofcolumns(table)
	return length(columns(table))
end

function whaticando()
    println("Those are functions you can call: ")
    println("addtask(table, taskname, course, date=nothing, additioninfo=nothing)")
    println("finishtask(table, task_name)")
    println("gettaskwithcourse(table, course_name)")
end




