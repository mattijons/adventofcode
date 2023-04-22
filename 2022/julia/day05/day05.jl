using StaticArrays

function main()
    open("input.txt") do file
        stacks1 = [Vector{Char}(undef, 0) for i=1:9]
        stacks2 = [Vector{Char}(undef, 0) for i=1:9]
        instruction = MVector{3, Int64}(0, 0, 0)
        for (i, line) in enumerate(eachline(file, keep=true))
            # Parse stacks.
            if i < 9
                for (j, char) in enumerate(line[begin+1:4:end-1])
                    if char != ' '
                        prepend!(stacks1[j], char)
                        prepend!(stacks2[j], char)
                    end
                end
            elseif line[1] == 'm'
                # Parse instructions.
                k = 1
                for word in eachsplit(line)
                    x = tryparse(Int64, word)
                    if !isnothing(x)
                        instruction[k] = x
                        k += 1
                    end
                end

                n = instruction[1]
                from = instruction[2]
                to = instruction[3]

                # Part 1
                for j = Base.OneTo(n)
                    append!(stacks1[to], pop!(stacks1[from]))
                end
                # Part 2
                index = lastindex(stacks2[from])
                append!(stacks2[to], splice!(stacks2[from], (index+1-n):index))

            end
        end
        foreach(stack -> print(stack[end]), stacks1)
        println()
        foreach(stack -> print(stack[end]), stacks2)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
