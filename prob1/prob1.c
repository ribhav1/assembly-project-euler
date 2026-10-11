#include <stdio.h>

int is_multiple(int i);

int main()
{
    int sum = 0;

    for (int i = 1; i < 1000; i++)
    {
        if (is_multiple(i))
        {
            sum += i;
        }
    }

    printf("sum: %d", sum);
    return 0;
}