function main()
    monkeyItems = Vector{Int64}[]
    monkeyTrue = Int64[]
    monkeyFalse = Int64[]
    modulos = Int64[]
    operators = Char[]
    rhs = String[]

    open("input.txt") do file
        for line in eachline(file)
            if isempty(line)
                continue
            end

            if line[3] == 'S'
                push!(monkeyItems, parse.(Int64, split(line[19:end], ", ")))
                continue
            end

            if line[3] == 'O'
                push!(operators, line[24])
                push!(rhs, line[26:end])
            end

            if line[3] == 'T'
                push!(modulos, parse(Int64, line[22:end]))
                continue
            end

            if line[5] == 'I'
                if line[8] == 't'
                    push!(monkeyTrue, parse(Int64, line[30]))
                else
                    push!(monkeyFalse, parse(Int64, line[31]))
                end
                continue
            end

        end
    end

    tests = Array{Function, 1}(undef, 0)
    for (modulo, mTrue, mFalse) in zip(modulos, monkeyTrue, monkeyFalse)
        push!(tests, x -> (x % modulo == 0) ? mTrue : mFalse)
    end

    operations = Array{Function, 1}(undef, 0)
    for (operator, r) in zip(operators, rhs)
        if r == "old"
            if operator == '+'
                push!(operations, x -> x + x)
            else
                push!(operations, x -> x * x)
            end
        else
            if operator == '+'
                push!(operations, x -> x + parse(Int64, r))
            else
                push!(operations, x -> x * parse(Int64, r))
            end
        end
    end

    # Part 1: N = 20
    # Part 2: N = 10000
    N = 10000

    # modular arithmetic trick from:
    # https://old.reddit.com/r/adventofcode/comments/zifqmh/2022_day_11_solutions/izrd7iz/
    trick = lcm(modulos)
    if N == 10000
        f = x -> x % trick
    else
        f = x -> div(x, 3)
    end

    inspections = zeros(Int64, length(monkeyItems))
    for i = 1:N
        k = 1
        for (items, operation, test) in zip(monkeyItems, operations, tests, inspections)

            inspections[k] += length(items)
            while !isempty(items)
                item = popfirst!(items)
                item = f(operation(item))
                push!(monkeyItems[test(item) + 1], item)
            end
            k += 1
        end
    end

    println(prod(sort!(inspections, rev=true)[1:2]))

end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
