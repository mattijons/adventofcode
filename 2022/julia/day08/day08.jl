function check_trees!(T::BitMatrix, M::AbstractMatrix, I::AbstractMatrix)
    @inbounds for j = 2:(size(M, 1) - 1)
        m = @view M[:, j]
        i = @view I[:, j]

        h = 0
        for (tree, index) in zip(m, i)
            if tree == 57
                T[index] = true
                break
            elseif tree > h
                h = tree
                T[index] = true
            end
        end

        h = 0
        for (tree, index) in Iterators.reverse(zip(m, i))
            if tree == 57
                T[index] = true
                break
            elseif tree > h
                h = tree
                T[index] = true
            end
        end

    end
end

function foo!(V, M)
    dimension = size(M, 1)
    for (j, col) in enumerate(eachcol(M))
        if j == 1 || j == dimension
            continue
        end

        for i = 2:(dimension - 1)
            t = col[i]
            v = 0
            for k in (i+1):dimension
                v += 1
                if col[k] >= t
                    break
                end
            end
            V[i, j] = V[i, j]*v
        end

        for i = (dimension-1):-1:2
            t = col[i]
            v = 0
            for k in (i-1):-1:1
                v += 1
                if col[k] >= t
                    break
                end
            end
            V[i, j] = V[i, j]*v
        end

    end

    for (j, col) in enumerate(eachcol(M'))
        if j == 1 || j == dimension
            continue
        end

        for i = 2:(dimension - 1)
            t = col[i]
            v = 0
            for k in (i+1):dimension
                v += 1
                if col[k] >= t
                    break
                end
            end
            V[j, i] = V[j, i]*v
        end

        for i = (dimension-1):-1:2
            t = col[i]
            v = 0
            for k in (i-1):-1:1
                v += 1
                if col[k] >= t
                    break
                end
            end
            V[j, i] = V[j, i]*v
        end

    end
end

function main()
    dimension = 99
    M = Array{Int8, 2}(undef, dimension, dimension) # min = 48, max = 57
    I = LinearIndices(M)

    open("input.txt") do file
        i = 1
        for tree in readeach(file, Int8)
            if tree == 10
                continue
            end
            M[i] = tree
            i += 1
        end
    end

    # # Part 1
    T = falses(dimension, dimension) # BitArray
    T[begin, begin] = true
    T[begin, end] = true
    T[end, begin] = true
    T[end, end] = true
    check_trees!(T, M, I)
    check_trees!(T, M', I')
    println(sum(T))

    # Part 2
    V = ones(Int64, dimension, dimension)
    foo!(V, M)
    println(maximum(V))

end

main()
