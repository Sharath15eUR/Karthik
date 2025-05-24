#include <stdio.h>
#include <string.h>

#define MAX_DAYS 7
#define MAX_TASKS 3
#define MAX_TASK_LENGTH 100

struct Day
{
    char dayName[10];
    char tasks[MAX_TASKS][MAX_TASK_LENGTH];
    int taskCount;
};

void inputTasks(struct Day week[])
{
    char dayInput[10];
    int i, j;

    printf("!! Yo ppl enter your task for the day #$ for each day --\n");
    printf("Give 'exit' to terminate.\n");

    while (1)
    {
        printf("\nEnter day name (like 'Monday'): ");
        scanf("%s", dayInput);

        if (strcmp(dayInput, "exit") == 0)
            break;

        int found = 0;

        for (i = 0; i < MAX_DAYS; i++)
        {
            if (strcmp(week[i].dayName, dayInput) == 0)
            {
                found = 1;
                printf("Enter up to 3 tasks for %s:\n", week[i].dayName);

                for (j = 0; j < MAX_TASKS; j++)
                {
                    printf("Task %d (type 'end' to stop): ", j + 1);
                    scanf(" %[^\n]", week[i].tasks[j]);

                    if (strcmp(week[i].tasks[j], "end") == 0)
                        break;

                    week[i].taskCount++;
                }
                break;
            }
        }

        if (!found)
        {
            printf("Invalid day. Try again.\n");
        }
    }
}

void displayTasks(struct Day week[])
{
    printf("\nWeekly Task Schedule:\n");

    for (int i = 0; i < MAX_DAYS; i++)
    {
        printf("\n%s:\n", week[i].dayName);

        for (int j = 0; j < week[i].taskCount; j++)
        {
            printf("  - %s\n", week[i].tasks[j]);
        }
    }
}

int main()
{
    struct Day week[MAX_DAYS] = {
        {"Monday", {}, 0}, {"Tuesday", {}, 0}, {"Wednesday", {}, 0},
        {"Thursday", {}, 0}, {"Friday", {}, 0}, {"Saturday", {}, 0},
        {"Sunday", {}, 0}
    };

    printf("-----!!!!-YO-!!!!-----\n");
    printf("------DAY_PLANNER-----\n");
    printf("-----!!!!-YO-!!!!-----\n");

    inputTasks(week);
    displayTasks(week);

    return 0;
}
