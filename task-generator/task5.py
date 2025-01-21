import numpy as np
from fractions import Fraction

# Function to generate matrix and vector
def generate_system(A_size, range):
    A = np.random.randint(range[0], range[1], A_size)  # Generate coefficient matrix
    b = np.random.randint(range[0], range[1], A_size[0])
    return A, b

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

# Save matrix in Latex format
def matrix_to_word(matrix):
    word_str = "\left(\\begin{matrix}"
    word_str += " \\\\ ".join(map(str, matrix[:]))
    word_str += "\\\\\\end{matrix}\\right)"
    return word_str

# Save solution in Latex format
def vec_to_word(vec):
    word_str = "\left(\\begin{matrix}"
    word_str += " \\\\ ".join(map(str, vec))
    word_str += "\\\\\\end{matrix}\\right)"
    return word_str

# def gen_task_5(A_size, range, rank_A, rank_AB):
#     A, b = None, None
    
#     # Generate system until a non-degenerate one is obtained
#     while True:
#         A, b = generate_system(A_size, range)
#         if (np.linalg.matrix_rank(A) == rank_A and 
#             np.linalg.norm(A[0, :]) != 0 and 
#             np.linalg.norm(A[1, :]) != 0 and 
#             np.linalg.norm(A[2, :]) != 0 and 
#             np.linalg.norm(A[:, 0]) != 0 and 
#             np.linalg.norm(A[:, 1]) != 0 and 
#             np.linalg.norm(A[:, 2]) != 0 and 
#             np.linalg.matrix_rank(np.hstack((A, b.reshape(-1, 1)))) == rank_AB):
#             break

#     # Finding determinants and value of x3
#     rat_A = np.array(A, dtype=int)  # Convert to rational
#     rat_b = np.array(b, dtype=int)
#     system = makesystem(A, b)

#     Xchn = np.round(np.linalg.solve(rat_A, rat_b), decimals=5)
#     Xoo = np.round(np.linalg.null_space(rat_A), decimals=5)
#     Xon = "X="
#     for j in range(Xoo.shape[1]):
#         Xon += f"C{j + 1}{vec_to_word(Xoo[:, j]).replace('//', '/').replace('/1 ', ' ')}"
#     Xon += matrix_to_word(Xchn).replace('//', '/').replace('/1 ', ' ')
#     return system

def nullspace(A):
    U, S, Vh = np.linalg.svd(A)
    null_space_dim = np.sum(S < 1e-10)
    return Vh.T[:, -null_space_dim:]

# Generate task and solution
def gen_task_5(A_size, range_, rank_A, rank_AB):
    A, b = None, None
    
    # Generate system until a non-degenerate one is obtained
    while True:
        A, b = generate_system(A_size, range_)
        if (np.linalg.matrix_rank(A) == rank_A and 
            np.linalg.norm(A[0, :]) != 0 and 
            np.linalg.norm(A[1, :]) != 0 and 
            np.linalg.norm(A[2, :]) != 0 and 
            np.linalg.norm(A[:, 0]) != 0 and 
            np.linalg.norm(A[:, 1]) != 0 and 
            np.linalg.norm(A[:, 2]) != 0 and 
            np.linalg.matrix_rank(np.hstack((A, b.reshape(-1, 1)))) == rank_AB):
            break

    # Finding determinants and value of x3
    rat_A = np.array([[Fraction(a).limit_denominator() for a in row] for row in A], dtype=int)
    rat_b = np.array([Fraction(bi).limit_denominator() for bi in b], dtype=int)
    system = makesystem(A, b)

    Xchn = np.round(np.linalg.solve(rat_A, rat_b), decimals=5)
    Xoo = np.round(nullspace(rat_A), decimals=5)
    Xon = "X="
    for j in range(Xoo.shape[1]):
        Xon += "C{}{}".format(j + 1, vec_to_word(Xoo[:, j]).replace("//", "/").replace("/1 ", " "))
    Xon += matrix_to_word(Xchn).replace("//", "/").replace("/1 ", " ")
    return system, Xon
