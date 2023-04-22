function main()
    open("input.txt") do file
        d = Dict(zip(vcat('a':'z', 'A':'Z'), 1:52))

        elves = ["", "", ""]

        s1 = 0
        s2 = 0

        n = 1
        @inbounds for line in eachline(file)
            half = div(length(line), 2)
            s1 += d[intersect(line[begin:half], line[half+1:end])[1]]

            elves[n] = line
            n += 1
            if n > 3
                s2 += d[intersect(elves...)[1]]
                n = 1
            end

        end
        println(s1)
        println(s2)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
