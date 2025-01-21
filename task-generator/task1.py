import numpy as np

# def matrix_to_word(matrix):
#     word_str = "(■("
#     for i in range(matrix.shape[0]):
#         word_str += "&".join(map(str, matrix[i, :]))
#         if i < matrix.shape[0] - 1:
#             word_str += "@"
#     word_str += "))"
#     return word_str

# Save in Latex format
def matrix_to_word(matrix):
    word_str = "\left(\\begin{matrix}"

    for i in range(matrix.shape[0]):
        word_str += "&".join(map(str, matrix[i, :]))
        if i < matrix.shape[0] - 1:
            word_str += "\\\\"
    word_str += "\\end{matrix}\\right)"
    return word_str

# Generate A, B и C matrix
def gen_task_1(A_size, B_size, range):
    A = np.random.randint(range[0], range[1], size=A_size)  # Matrix A of size 3x2
    B = np.random.randint(range[0], range[1], size=B_size)  # Matrix B of size 3x3
    
    # Matrix multiplication of B and A
    C = np.dot(B, A)

    # Export matrices
    word_A = "A="+matrix_to_word(A)+","
    word_B = "B="+matrix_to_word(B)+","
    word_C = "BA="+matrix_to_word(C)

    return (word_A, word_B, word_C)

