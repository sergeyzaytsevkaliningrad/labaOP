import random
import sys
import time

def generate_random_matrix(rows, cols):
    """Генерирует случайную матрицу размера rows x cols."""
    return [[random.randint(1, 10) for _ in range(cols)] for _ in range(rows)]


def matrix_multiply(A, B):
    if len(A[0]) != len(B):
        raise ValueError("Количество столбцов в первой матрице должно совпадать с количеством строк второй матрицы.")
    
    result = [[0 for _ in range(len(B[0]))] for _ in range(len(A))]
    
    # Работаем со строкам первой матрицы
    for i in range(len(A)):
        # Работаем со столбцам второй матрицы
        for j in range(len(B[0])):
            # Записываем все в result[i][j]
            for k in range(len(B)):
                result[i][j] += A[i][k] * B[k][j]
    
    return result


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Использование: python script.py <строки A> <столбцы A> <столбцы B>")
        sys.exit(1)

    rows_A = int(sys.argv[1])
    cols_A = int(sys.argv[2])
    cols_B = int(sys.argv[3])

    # Генерация случайных матриц A и B
    A = generate_random_matrix(rows_A, cols_A)
    B = generate_random_matrix(cols_A, cols_B)  # cols_A == rows_B

    # Перемножаем матрицы A и B
    start = time.perf_counter()
    result = matrix_multiply(A, B)
    end = time.perf_counter()
    print("time:", end - start)
    time.sleep(5)
