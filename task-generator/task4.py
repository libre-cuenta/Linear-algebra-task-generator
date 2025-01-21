import numpy as np

# Function to generate matrix and vector
def generate_matrix_system(A_size, B_size, C_size, range):
    A = np.random.randint(range[0], range[1], A_size)  # Generate coefficient matrix
    B = np.random.randint(range[0], range[1], B_size)
    C = np.random.randint(range[0], range[1], C_size)
    return A, B, C

# Function to apply Cramer's rule for x3
def solve_for_x3(A, b):
    A3 = A.copy()            # Copy A for modification
    A3[:, 2] = b            # Replace the third column with vector b
    det_A = round(np.linalg.det(A), 5)  # Main determinant
    det_A3 = round(np.linalg.det(A3), 5) # Determinant for x3
    x3 = f"{det_A3}/{det_A}"   # Value of x3 by Cramer's formula
    return det_A, det_A3, x3

# Make system of equations
def makesystem(A, b):
    m, n = A.shape
    eq = " "
    for i in range(m):
        str_ = " "
        first_elem = False
        for j in range(n):
            if first_elem and A[i, j] > 0:
                str_ += " + " 
            elif A[i, j] == -1:
                str_ += " - "
            if A[i, j] != 0:
                first_elem = True
                if abs(A[i, j]) != 1:
                    str_ += f"{A[i, j]}"
                str_ += f"x_{j + 1}"
        eq += str_ + f" = {b[i]}\n"
    return eq

# Save task in Latex format
def matrix_to_word(matrix):
    word_str = "\left(\\begin{matrix}"

    for i in range(matrix.shape[0]):
        word_str += "&".join(map(str, matrix[i, :]))
        if i < matrix.shape[0] - 1:
            word_str += "\\\\"
    word_str += "\\end{matrix}\\right)"
    return word_str

# def matrix_to_word1(matrix):
#     word_str = "(■("
#     for i in range(matrix.shape[0]):
#         word_str += " & ".join(map(str, matrix[i, :]))
#         if i < matrix.shape[0] - 1:
#             word_str += " @ "
#     word_str += " ))"
#     return word_str

# Generate A, B and C matrix. Find X
def gen_task_4(A_size, B_size, C_size, range):
    A, B, C = None, None, None
    while True:
        A, B, C = generate_matrix_system(A_size, B_size, C_size, range)
        if np.linalg.det(A) != 0 and np.linalg.det(B) != 0:  # Check for non-degeneracy
            break
    
    rat_A = np.array(A, dtype=int)  # Convert to rational
    rat_B = np.array(B, dtype=int)
    rat_C = np.array(C, dtype=int)

    A_inv = "A^{-1}="+matrix_to_word(np.linalg.inv(rat_A)).replace("//", "/").replace("/1 ", " ")
    B_inv = "B^{-1}="+matrix_to_word(np.linalg.inv(rat_B)).replace("//", "/").replace("/1 ", " ")

    X = "X="+matrix_to_word(np.linalg.inv(rat_A) @ rat_C @ np.linalg.inv(rat_B)).replace("//", "/").replace("/1 ", " ")
    system = f"{matrix_to_word(A)}∙X∙{matrix_to_word(B)}={matrix_to_word(C)} \n"

    return (system, A_inv, B_inv, X)

