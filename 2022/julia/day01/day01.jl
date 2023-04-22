using StaticArrays

function main()
    open("input.txt") do file
        elves = MVector{3, Int64}(0, 0, 0)

        calories = 0
        @inbounds for line in eachline(file)
            if length(line) == 0
                if calories > elves[end]
                    elves[end-2] = elves[end-1]
                    elves[end-1] = elves[end]
                    elves[end] = calories
                elseif calories > elves[end-1]
                    elves[end-1] = elves[end]
                    elves[end] = calories
                elseif calories > elves[end-1]
                    elves[end-2] = calories
                end
                calories = 0
                continue
            end
            calories += parse(Int64, line)
        end

        # Part 1
        println(elves[end])
        # Part 2
        println(sum(elves))
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
