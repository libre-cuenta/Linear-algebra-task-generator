import numpy as np

# Function to generate matrix and vector
def generate_system(A_size, range):
    A = np.random.randint(range[0], range[1], A_size)  # Generate coefficient matrix
    b = np.random.randint(range[0], range[1], A_size[0])  
    return A, b

# Function to apply Cramer's rule for x3
def solve_for_x(A, b, x_n):
    A3 = A.copy()            # Copy A for modification
    A3[:, x_n] = b           # Replace the third column with vector b
    det_A = round(np.linalg.det(A), 5)  # Main determinant
    det_An = round(np.linalg.det(A3), 5) # Determinant for x3
    x = f"{det_An}/{det_A}"   # Value of x3 by Cramer's rule
    return det_A, det_An, x

# def makesystem(A, b):
#     m, n = A.shape
#     eq = "{█("
#     for i in range(m):
#         str_ = "&"
#         first_elem = False
#         for j in range(n):
#             if first_elem and A[i, j] > 0:
#                 str_ += "+" 
#             elif A[i, j] == -1:
#                 str_ += "-"
#             if A[i, j] != 0:
#                 first_elem = True
#                 if abs(A[i, j]) != 1:
#                     str_ += f"{A[i, j]}"
#                 str_ += f"x_{j + 1}"
#         eq += str_ + f"={b[i]}"
#         if i < m - 1:
#             eq += "@"
#     return eq + ")┤"

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

# Make system and solution
def gen_task_2(A_size, range, x_n):
    A, b = None, None
    while True:
        A, b = generate_system(A_size, range)
        if np.linalg.det(A) != 0:  # Check for non-degeneracy
            break
    
    # Finding determinants and value of x3
    det_A, det_A3, x3 = solve_for_x(A, b, x_n)
    system = makesystem(A, b)
    answer = f"\nΔ = {det_A}\nΔ₃ = {det_A3}\nx₃ = {x3}"
    return system, answer

