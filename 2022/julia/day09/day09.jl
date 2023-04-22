using StaticArrays

function main()
    open("input.txt") do file
        N = 10

        rope = MVector{N, Complex{Float64}}(repeat([0 + 0im], N))

        directions = Dict(
            "R" => 1 + 0im,
            "L" => -1 + 0im,
            "U" => 0 + 1im,
            "D" => 0 - 1im
        )

        visits = Set([0 + 0im])
        for line in eachline(file)
            letter, n = split(line, " ")
            n = parse(Int64, n)
            direction = directions[letter]
            @inbounds for k = 1:n
                rope[1] += direction
                @inbounds for i = 2:N
                    dx = real(rope[i-1]) - real(rope[i])
                    dy = imag(rope[i-1]) - imag(rope[i])

                    if dx^2 + dy^2 >= 4
                        rope[i] += sign(dx) + sign(dy)im
                    end
                end
                push!(visits, rope[N])
            end
        end
        println(length(visits))
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
