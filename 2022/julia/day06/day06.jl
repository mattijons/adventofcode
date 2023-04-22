using StaticArrays

function main()
    open("input.txt") do file
        # Part 1: N = 4
        # Part 2: N = 14
        N = 14
        # Create a window
        window = Array{Char, 1}(undef, N)
        for i = 1:N
            window[i] = read(file, Char)
        end

        marker = 0

        # Update the window
        for (i, char) in enumerate(readeach(file, Char))
            popfirst!(window)
            append!(window, char)

            if allunique(window)
                marker = i + N
                break
            end
        end
        println(marker)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
