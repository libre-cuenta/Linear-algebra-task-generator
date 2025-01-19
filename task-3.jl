using Random
using LinearAlgebra

# Функция для генерации матрицы и вектора
function generate_system(A_size, range)
    A = rand(range, A_size...)  # Генерация матрицы коэффициентов 4x4
    b = rand(range, A_size[1])  
    return A, b
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
        word_str *= join(matrix[i, :], " & ")
        if i < size(matrix, 1)
            word_str *= " @ "
        end
    end
    word_str *= " ))"
    return word_str
end

# open("task3_output.txt", "w") do file
#     write(file,"Задание 3\n\n")
# end

# for i in 1:5
    
#     A, b = nothing, nothing
    
#     # Генерация системы до получения невырожденной
#     while true
#         A, b = generate_system()
#         if det(A) != 0  # Проверка на невырожденность
#             break
#         end
#     end

#     # Нахождение определителей и значения x3
#     # det_A, det_A3, x3 = solve_for_x3(A, b)
#     rat_A = Matrix{Rational{Int}}(A)
#     rat_b = Vector{Rational{Int}}(b)
#     system = makesystem(A,b)
#     A_inv = replace(replace(matrix_to_word(inv(rat_A)),"//" => "/"),"/1 " => " ")
#     X = replace(replace(matrix_to_word(inv(rat_A)*rat_b),"//" => "/"),"/1 " => " ")
#     println("Вариант $i")
#     display(system)
#     println("Обратная")
#     display(A_inv)
#     println("X")
#     display(X)
#     open("task3_output.txt", "a") do file
#         write(file,"Вариант $i\n")
#         write(file,system,"\n")
#         write(file,"A_inv = $A_inv\nX = $X\n\n")
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

function gen_task_3(A_size, range)
    A, b = nothing, nothing
    while true
        A, b = generate_system(A_size, range)
        if det(A) != 0  # Проверка на невырожденность
            break
        end
    end
    
    rat_A = Matrix{Rational{Int}}(A)
    rat_b = Vector{Rational{Int}}(b)
    system = makesystem(A,b)
    A_inv = replace(replace(matrix_to_word(inv(rat_A)),"//" => "/"),"/1 " => " ")
    X = replace(replace(matrix_to_word(inv(rat_A)*rat_b),"//" => "/"),"/1 " => " ")
    return (system, A_inv, X)
end