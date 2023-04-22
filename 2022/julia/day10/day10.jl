using StaticArrays

function main()
    open("input.txt") do file
        cycles = Iterators.Stateful([20, 60, 100, 140, 180, 220])
        cycle = 0

        CRT = fill('.', 6, 40)
        sprite = MVector(0, 1, 2)
        row = 1
        column = 0

        X = 1
        Xsum = 0

        @inbounds for line in readlines(file)
            cycle += 1
            column += 1 
            if column % 41 == 0
                column = 1
                row += 1
            end

            if cycle == peek(cycles)
                popfirst!(cycles)
                Xsum += X*cycle
            end

            if (column-1) in sprite
                CRT[row, column] = '#'
            end

            if line[1] == 'n'
                continue
            end

            cycle += 1
            column += 1 
            if column % 41 == 0
                column = 1
                row += 1
            end

            if cycle == peek(cycles)
                popfirst!(cycles)
                Xsum += X*cycle
            end

            if (column-1) in sprite
                CRT[row, column] = '#'
            end

            v = @view line[6:end]
            n = parse(Int64, v)
            X += n
            sprite[1] = X - 1
            sprite[2] = X
            sprite[3] = X + 1

        end
        display(CRT)
        println(Xsum)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
