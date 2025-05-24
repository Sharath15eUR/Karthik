#include <stdio.h>
#include <stdlib.h>

int searchMatrix(int **matrix, int n, int key)
{
    //stair-case search

    int row = 0, col = n - 1; // initiate from top-right corner

    while (row < n && col >= 0)
    {
        if (matrix[row][col] == key)
            return 1;
        else if (matrix[row][col] > key)
            col--;
        else
            row++;
    }

    return 0;
}

int main() 
{
    int n, key;

    printf("Enter the size of the matrix (n x n): ");
    scanf("%d", &n);

    int **matrix = (int **)malloc(n * sizeof(int *));

    for (int i = 0; i < n; i++)
        matrix[i] = (int *)malloc(n * sizeof(int));

    printf("Enter %d elements in row-wise sorted and column-wise sorted order:\n", n * n);

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            scanf("%d", &matrix[i][j]);
        }
    }

    printf("Enter the key to search: ");
    scanf("%d", &key);

    if (searchMatrix(matrix, n, key))
        printf("Key %d found in matrix.\n", key);
    else
        printf("Key %d not found.\n", key);

    for (int i = 0; i < n; i++)
        free(matrix[i]);
    free(matrix);

    return 0;
}
