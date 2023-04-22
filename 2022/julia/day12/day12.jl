using DataStructures

function main()
    heights = Array{Char, 2}(undef, 41, 143)

    start = CartesianIndex(0, 0)
    final = CartesianIndex(0, 0)
    open("input.txt") do file
        @inbounds for (i, line) in enumerate(eachline(file))
            for (j, c) in enumerate(line)
                if c == 'E'
                    final = CartesianIndex(i, j)
                    heights[i, j] = 'z'
                    continue
                end
                if c == 'S'
                    start = CartesianIndex(i, j)
                    heights[i, j] = 'a'
                    continue
                end
                heights[i, j] = c
            end
        end
    end

    queue = Queue{Tuple{CartesianIndex{2}, Int64}}()
    enqueue!(queue, (final, 0))
    seen = Set{CartesianIndex{2}}()
    directions = CartesianIndex.(((1, 0), (-1, 0), (0, 1), (0, -1)))

    p1, p2 = 0, 0
    while true
        current, nsteps = dequeue!(queue)
        if current in seen
            continue
        end

        @inbounds if heights[current] == 'a'
            if p2 == 0
                p2 = nsteps
                break
            elseif current == start
                p1 = nsteps
                break
            end
        end
        push!(seen, current)
        @inbounds for direction in directions
            new = current + direction
            if checkbounds(Bool, heights, new)
                if !(heights[new] in seen) && heights[new] - heights[current] >= -1
                    enqueue!(queue, (new, nsteps+1))
                end
            end
        end
    end

    println(p1)
    println(p2)

end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
