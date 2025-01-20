using Random
using LinearAlgebra

# Функция для генерации матрицы и вектора
function generate_system(A_size, range)
    A = rand(range, A_size...)  # Генерация матрицы коэффициентов 4x4
    b = rand(range, A_size[1])  
    return A, b
end

# Функция для применения формулы Крамера для x3
function solve_for_x(A, b, x_n)
    A3 = copy(A)            # Копируем A для изменения
    A3[:, x_n] = b           # Заменяем третий столбец на вектор b
    det_A = round(det(A),digits = 5)  # Главный определитель
    det_An = round(det(A3),digits = 5) # Определитель для x3
    x = "$det_An/$det_A "   # Значение x3 по формуле Крамера
    return det_A, det_An, x
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

# open("task2_output.txt", "w") do file
#     write(file,"Задание 2\n\n")
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
#     det_A, det_A3, x3 = solve_for_x3(A, b)
#     system = makesystem(A,b)

#     open("task2_output.txt", "a") do file
#         write(file,"Вариант $i\n")
#         write(file,system,"\n")
#         write(file,"Δ = $det_A\nΔ₃ = $det_A3\nx₃ = $x3","\n\n")
#     end

#     # display(A)
#     # display(b)
#     println(system)
    
#     println("Δ = $det_A\nΔ₃ = $det_A3\nx₃ = $x3")
# end

function gen_task_2(A_size, range, x_n)
    A, b = nothing, nothing
    while true
        A, b = generate_system(A_size, range)
        if det(A) != 0  # Проверка на невырожденность
            break
        end
    end
    
    # Нахождение определителей и значения x3
    det_A, det_A3, x3 = solve_for_x(A, b, x_n)
    system = makesystem(A,b)
#     println(system)    
#     println("Δ = $det_A\nΔ₃ = $det_A3\nx₃ = $x3")
    answer = "Δ = $det_A\nΔ₃ = $det_A3\nx₃ = $x3"
    return (system, answer)
end
