using Random
using LinearAlgebra

# Функция для генерации матрицы и вектора
function generate_system(A_size, range)
    A = rand(range, A_size...)  # Генерация матрицы коэффициентов 4x4
    b = rand(range, A_size[1])  
    return A, b
end


function makesystem(A,b)
    m, n = size(A)
    eq = "{█("
    for i in 1:m
        str = "&"
        first_elem = false
        for j in 1:n
            if first_elem * (A[i,j] > 0)
                str *= "+" 
            elseif A[i,j] == -1
                str *= "-"
            end
            if A[i,j] != 0
                first_elem = true
                if abs(A[i,j]) != 1
                    str *= "$(A[i,j])"
                end
                str *= "x_$j"
            end
        end
        eq *= str * "=$(b[i])"
        if i < m 
            eq *= "@"
        end
    end
    return eq * ")┤"
end

function matrix_to_word(matrix)
    word_str = "(■("
    for i in 1:size(matrix, 1)
        word_str *= join(matrix[i, :], " & ")
        if i < size(matrix, 1)
            word_str *= " @ "
        end
    end
    word_str *= " ))"
    return word_str
end

function vec_to_word(vec)
    word_str = "(■("

    word_str *= join(vec, " @ ")

    word_str *= " ))"
    return word_str
end

# open("task5_output.txt", "w") do file
#     write(file,"Задание 5\n\n")
# end

# for i in 1:5
    
#     A, b = nothing, nothing
    
#     # Генерация системы до получения невырожденной
#     while true
#         A, b = generate_system()
#         if (rank(A) == 2) * (norm(A[1,:]) != 0) * (norm(A[2,:]) != 0) * (norm(A[3,:]) != 0) * (norm(A[:,1]) != 0) * (norm(A[:,2]) != 0) * (norm(A[:,3]) != 0) * (rank(hcat(A,b)) == 2)
#             break
#         end
#     end

#     # Нахождение определителей и значения x3
#     # det_A, det_A3, x3 = solve_for_x3(A, b)
#     rat_A = Matrix{Rational{Int}}(A)
#     rat_b = Vector{Rational{Int}}(b)
#     system = makesystem(A,b)

#     Xchn = round.(rat_A \ rat_b,digits=5)
#     Xoo = round.(nullspace(rat_A),digits=5)
#     Xon = "X="
#     for j in 1:size(Xoo)[2]
#         Xon *= "C$j$(replace(replace(vec_to_word(Xoo[:,j]),"//" => "/"),"/1 " => " "))+"
#     end
#     Xon *= replace(replace(matrix_to_word(Xchn),"//" => "/"),"/1 " => " ")
#     println("Вариант $i")
#     display(system)
#     # println("Общее решение")
#     # println(Xon)
#     open("task5_output.txt", "a") do file
#         write(file,"Вариант $i\n")
#         write(file,system,"\n")
#         write(file,"$Xon\n\n")
#     end

#     # display(A)
#     # display(b)
#     # println(system)
#     # println("A_inv =")
#     # display(inv(rat_A))
#     # println("X =")
#     # display(inv(rat_A)*rat_b)
#     # println("A_inv = $(inv(rat_A))\nX = $(round.((inv(rat_A)*rat_b),digits=5))\n\n")
# end

function gen_task_5(A_size, range, rank_A, rank_AB)
    A, b = nothing, nothing
    
    # Генерация системы до получения невырожденной
    while true
        A, b = generate_system(A_size, range)
        if (rank(A) == rank_A) * (norm(A[1,:]) != 0) * (norm(A[2,:]) != 0) * (norm(A[3,:]) != 0) * (norm(A[:,1]) != 0) * (norm(A[:,2]) != 0) * (norm(A[:,3]) != 0) * (rank(hcat(A,b)) == rank_AB)
            break
        end
    end

    # Нахождение определителей и значения x3
    # det_A, det_A3, x3 = solve_for_x3(A, b)
    rat_A = Matrix{Rational{Int}}(A)
    rat_b = Vector{Rational{Int}}(b)
    system = makesystem(A,b)

    Xchn = round.(rat_A \ rat_b,digits=5)
    Xoo = round.(nullspace(rat_A),digits=5)
    Xon = "X="
    for j in 1:size(Xoo)[2]
        Xon *= "C$j$(replace(replace(vec_to_word(Xoo[:,j]),"//" => "/"),"/1 " => " "))+"
    end
    Xon *= replace(replace(matrix_to_word(Xchn),"//" => "/"),"/1 " => " ")
    return system
end
