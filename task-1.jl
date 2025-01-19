# Функция для форматирования матриц для Word
function matrix_to_word(matrix)
    word_str = "(■("
    for i in 1:size(matrix, 1)
        word_str *= join(matrix[i, :], "&")
        if i < size(matrix, 1)
            word_str *= "@"
        end
    end
    word_str *= "))"
    return word_str
end

# open("task1_output.txt", "w") do file
#     write(file,"Задание 1\n\n")
# end

# for i in 1:5
#     A = rand(-2:3, 3, 2)  # Матрица A размером 3x2
#     B = rand(-2:3, 3, 3)  # Матрица B размером 3x3
    
#     # Вычисление произведения матриц B и A
#     C = B * A

#     # Экспорт матриц
#     word_A = "A="*matrix_to_word(A)
#     word_B = "B="*matrix_to_word(B)
#     word_C = "BA="*matrix_to_word(C)

#     open("task1_output.txt", "a") do file
#         write(file,"Вариант $i\n")
#         write(file,word_A,"\n")
#         write(file,word_B,"\n")
#         write(file,word_C,"\n\n")
#     end

#     # Вывод формул
#     println("Вариант $i")
#     println("Матрица A: $word_A")
#     println("Матрица B: $word_B")
#     println("Матрица C: $word_C\n")
# end

function gen_task_1(A_size, B_size, range)
    A = rand(range, A_size...)  # Матрица A размером 3x2
    B = rand(range, B_size...)  # Матрица B размером 3x3
    
    # Вычисление произведения матриц B и A
    C = B * A

    # Экспорт матриц
    word_A = "A="*matrix_to_word(A)
    word_B = "B="*matrix_to_word(B)
    word_C = "BA="*matrix_to_word(C)

    # open("task1_output.txt", "a") do file
    #     write(file,"Вариант $i\n")
    #     write(file,word_A,"\n")
    #     write(file,word_B,"\n")
    #     write(file,word_C,"\n\n")
    # end
    return (word_A, word_B, word_C)
end