function main()
    open("input.txt") do file
        current = 1
        path = Int64[current]
        previous = 0

        sizes = Dict(1 => 0)

        seek(file, 7)  # Skip first line
        for (k, line) in enumerate(eachline(file))
            if line == "\$ ls" || line[1] == 'd'
                continue
            end
            if line[1] == '\$'
                for (i, s) in enumerate(eachsplit(line, " "))
                    if i == 3
                        if s == ".."
                            previous = current
                            pop!(path)
                            current = path[end]
                            sizes[current] += sizes[previous]
                        else
                            previous = current
                            push!(path, k)
                            current = k
                            sizes[current] = 0
                        end
                    end
                end
            else
                number = 0
                for s in eachsplit(line, " ")
                    number = parse(Int64, s)
                    sizes[current] += number
                    break
                end
            end
        end

        # Walk back to the top
        for p in reverse(path[begin:end-1])
            previous = current
            current = p
            sizes[current] += sizes[previous]
        end

        available = 70_000_000
        required = 30_000_000
        needed = required - available + sizes[1]

        s = 0
        d = typemax(Int64)
        for value in values(sizes)
            # Part 1
            if value < 100000
                s += value
            end
            # Part 2
            if value >= needed
                d = min(d, value)
            end
        end
        println(d)
        println(s)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
