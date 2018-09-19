print("Hello Wei! ")
if Dates.hour(now()) > 8
    println("You wake up later than 8 today, which is not good!")
else
    println("On time!")
end
println(now());
println("enter whaticando() to see functions")


timetable = Array{Any}(25,4)
score = 0

# Set Time

timetable[1,1] = "Time"
timetable[1,2] = "Task"
timetable[1,3] = "Done"
timetable[1,4] = "Current"


for i in 2:25
    timetable[i,1] = Dates.Time(i - 2)
    timetable[i,2] = "Not assigned"
    timetable[i,3] = false
end

# function package ---------------------------------------------
function setcur()
    timetable[2:25,4] = ""
    timetable[Dates.hour(now()) + 2, 4] = "Here!"
    return 
end

function showtable()
    setcur()
    return timetable
end

function addtask(name, index)
    timetable[index + 2, 2] = name
    return
end

function finish(index)
    timetable[index + 2, 3] = true
    global score = score + 1
    return
end 

function finish()
    timetable[Dates.hour(now()) + 2, 3] = true;
    global score = score + 1
    return
end

function finish(left, right)
    for i in left:right
        finish(i)
    end
end

function notfinish(index)
    timetable[index + 2, 3] = true
    global score = score - 1
    return
end 

function curtask()
    return timetable[Dates.hour(now()) + 2, 2]
end

function showscore()
    return score
end

function whaticando()
    println("Those are functions you can call: ")
    println("showtable()")
    println("addtask(name, index)")
    println("finish(index)")
    println("finish()")
    println("curtask()")
    println("showscore()")
    println("resettable()")
end

function resettable()
    for i in 2:25
        timetable[i,2] = "Not assigned"
        timetable[i,3] = false
    end
    return
end

function deletetask(i)
    timetable[i + 1, 2] = "Not assigned"
    timetable[i + 1, 3] = false
end

function doing()
    println("You current task is: ", curtask());
end 




