include("tasklist.jl")

t = if isdatabaseexist() loadtable() else createemptytable() end

println(t)

# whaticando()

function showtable()
	print(t)
end


