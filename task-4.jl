using Random
using LinearAlgebra

# Функция для генерации матрицы и вектора
function generate_matrix_system(A_size, B_size, C_size, range)
    A = rand(range, A_size...)  # Генерация матрицы коэффициентов 4x4
    B = rand(range, B_size...)
    C = rand(range, C_size...)
    return A, B, C
end

# Функция для применения формулы Крамера для x3
function solve_for_x3(A, b)
    A3 = copy(A)            # Копируем A для изменения
    A3[:, 3] = b           # Заменяем третий столбец на вектор b
    det_A = round(det(A),digits = 5)  # Главный определитель
    det_A3 = round(det(A3),digits = 5) # Определитель для x3
    x3 = "$det_A3/$det_A "   # Значение x3 по формуле Крамера
    return det_A, det_A3, x3
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
        word_str *= join(matrix[i, :], "&")
        if i < size(matrix, 1)
            word_str *= "@"
        end
    end
    word_str *= " ))"
    return word_str
end
function matrix_to_word1(matrix)
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
# open("task4_output.txt", "w") do file
#     write(file,"Задание 4\n\n")
# end

# # println(matrix)

# for i in 1:5
#     A, B, C = nothing, nothing, nothing
#     while true
#         A, B, C = generate_system()
#         if (det(A) != 0) * (det(B) != 0)# Проверка на невырожденность
#             break
#         end
#     end

#     rat_A = Matrix{Rational{Int}}(A)
#     rat_B = Matrix{Rational{Int}}(B)
#     rat_C = Matrix{Rational{Int}}(C)

#     A_inv = replace(replace(matrix_to_word1(inv(rat_A)),"//" => "/"),"/1 " => " ")
#     B_inv = replace(replace(matrix_to_word1(inv(rat_B)),"//" => "/"),"/1 " => " ")

#     X = replace(replace(matrix_to_word1(inv(rat_A)*rat_C*inv(rat_B)),"//" => "/"),"/1 " => " ")
#     println("Вариант $i")
#     println("$(matrix_to_word(A))∙X∙$(matrix_to_word(B))=$(matrix_to_word(C))")
#     println("Обратная A")
#     display(A_inv)
#     println("Обратная B")
#     display(B_inv)
#     println("X")
#     display(X)
#     open("task4_output.txt", "a") do file
#         write(file,"Вариант $i\n")
#         write(file,"$(matrix_to_word(A))∙X∙$(matrix_to_word(B))=$(matrix_to_word(C))","\n")
#         write(file,"A_inv = $A_inv\nB_inv = $B_inv\nX = $X\n\n")
#     end

# end

function gen_task_4(A_size, B_size, C_size, range)
    A, B, C = nothing, nothing, nothing
    while true
        A, B, C = generate_matrix_system(A_size, B_size, C_size, range)
        if (det(A) != 0) * (det(B) != 0)# Проверка на невырожденность
            break
        end
    end
    
    rat_A = Matrix{Rational{Int}}(A)
    rat_B = Matrix{Rational{Int}}(B)
    rat_C = Matrix{Rational{Int}}(C)

    A_inv = replace(replace(matrix_to_word1(inv(rat_A)),"//" => "/"),"/1 " => " ")
    B_inv = replace(replace(matrix_to_word1(inv(rat_B)),"//" => "/"),"/1 " => " ")

    X = replace(replace(matrix_to_word1(inv(rat_A)*rat_C*inv(rat_B)),"//" => "/"),"/1 " => " ")
    system = "$(matrix_to_word(A))∙X∙$(matrix_to_word(B))=$(matrix_to_word(C))"

    return (system, A_inv, B_inv, X)
end
