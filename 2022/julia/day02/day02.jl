using StaticArrays

function main()
    open("input.txt") do file
        p1 = SMatrix{3, 3, Int64}(
           # P1 Score matrix
           # X Y Z
            [4 8 3  # A (rock)
             1 5 9  # B (paper)
             7 2 6] # C (scissor)
        )

        p2 = SMatrix{3, 3, Int64}(
           # P2 Score matrix
           # l d w
           # X Y Z
            [3 4 8  # A (rock)
             1 5 9  # B (paper)
             2 6 7] # C (scissor)
        )

        p1_score = 0
        p2_score = 0

        buffer = Array{UInt8, 1}(undef, 3)
        while !eof(file)
            readbytes!(file, buffer)
            skip(file, 1)

            @inbounds p1_score += p1[buffer[1] % 64, buffer[3] % 87]
            @inbounds p2_score += p2[buffer[1] % 64, buffer[3] % 87]
        end
        println(p1_score)
        println(p2_score)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
