import numpy as np
from fractions import Fraction

# Function to generate matrix and vector
def generate_system(A_size, range):
    A = np.random.randint(range[0], range[1], A_size)  # Generate coefficient matrix
    b = np.random.randint(range[0], range[1], A_size[0])  
    return A, b

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

# Save inversion matrix in Latex format
def matrix_to_word(matrix):
    word_str = "A^{-1}= \left(\\begin{matrix}"

    for i in range(matrix.shape[0]):
        word_str += "&".join(map(str, matrix[i, :]))
        if i < matrix.shape[0] - 1:
            word_str += "\\\\"
    word_str += "\\end{matrix}\\right) \n"
    return word_str

# Save matrix X in Latex format
def matrix_to_word2(matrix):
    word_str = "X= \left(\\begin{matrix}"
    word_str += " \\\\ ".join(map(str, matrix[:]))
    word_str += "\\\\\\end{matrix}\\right)"
    return word_str

# Generate task and solution
def gen_task_3(A_size, range):
    A, b = None, None
    while True:
        A, b = generate_system(A_size, range)
        if np.linalg.det(A) != 0:  # Check for non-degeneracy
            break
        
    # rat_A = np.array([[Fraction(a).limit_denominator() for a in row] for row in A], dtype=int)
    rat_A = np.array(A, dtype=int)
    inverse_A = np.linalg.inv(rat_A)
    inverse_A = np.round(inverse_A, decimals=5)
    # rat_b = np.array([Fraction(bi).limit_denominator() for bi in b], dtype=int)
    rat_b = np.array(b, dtype=int)
    system = makesystem(A, b)
    A_inv = matrix_to_word(inverse_A)
    X = matrix_to_word2(np.round(np.dot(inverse_A, rat_b), 5))
    return (system, A_inv, X)

