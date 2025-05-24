#include <stdio.h>
#include <stdlib.h>

void rearrangeEvenOdd(int *arr, int size)
{
    int *temp = (int *)malloc(size * sizeof(int));
    int *ptr = arr;
    int *t = temp;

    //  even num first

    for (int i = 0; i < size; i++)
        if (*(ptr + i) % 2 == 0)
            *(t++) = *(ptr + i);

    // odd num next

    for (int i = 0; i < size; i++)
        if (*(ptr + i) % 2 != 0)
            *(t++) = *(ptr + i);

    // swap to actual preserved order

    for (int i = 0; i < size; i++)
        *(arr + i) = *(temp + i);

    free(temp);
}

void printArray(int *arr, int size)
{
    for (int i = 0; i < size; i++)
        printf("%d ", *(arr + i));
    printf("\n");
}

int main()
{
    int size;
    printf("Enter the number of elements: ");
    scanf("%d", &size);

    int *arr = (int *)malloc(size * sizeof(int));

    if (arr == NULL)
    {
        printf("Memory allocation failed.\n");
        return 1;
    }

    printf("Enter %d numbers:\n", size);

    for (int i = 0; i < size; i++)
        scanf("%d", (arr + i));

    rearrangeEvenOdd(arr, size);

    printf("Rearranged array (even before odd):\n");
    printArray(arr, size);

    free(arr);
    return 0;
}
