function main()
    open("input.txt") do file

        v = Vector{Int64}(undef, 4)

        score1 = 0
        score2 = 0
        for line in eachline(file)
            k = 1
            for q in eachsplit(line, ",")
                for p in eachsplit(q, "-")
                    v[k] = parse(Int64, p)
                    k += 1
                end
            end
            a = v[1]:v[2]
            b = v[3]:v[4]

            i = intersect(a, b)
            # Part 1
            if i == a || i == b
                score1 += 1
            end
            # Part 2
            if !isempty(i)
                score2 += 1
            end

        end
        println(score1)
        println(score2)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
