# Analytics Home Assignment

## Assignment Instructions

This assignment uses Data Analysis to familiarize with the dataset provided in tasks_used_da, which contains the tasks performed by a given user at any given date. The data will be analyzed in a series of questions with reproducible queries and visualizations.

## Tools

For this assignment, we had the opportunity to choose the tools that would be necessary to complete the analysis. The following list will have the main reason of why the tools chosen were the most appropriate for the work requested:

- **TablePlus**: There's many options to function as a versatile UI to connect to any database type. But with TablePlus connections can be easily sorted and label but most importantly when working with big queries this tool is able to make it easier by toggling lines and comments. Plus it includes a query history so that you can easily replay past queries or saved them for future reference.

- **Tableau Public**: We considered using Google Data Studio but encountered a technical limitation when the csv file is over the limit of 100 MB. With this limitation we considered the second optio which is Tableau, a very effective visualization tool that allows the creation of quick complex graphs handling more data and calculations on datasets.
    - Download Link for [Tableau Public](https://public.tableau.com/en-us/s/download) 

## Data Analysis

- Which are the top 10 accounts ids by number of users?
- Create a summary table at the account level that signals when an account is new (boolean). An account is new for the first day we see it run a task(s). The table should look similar to the one below in structure.
- Create a summary table at the account level. Add a column with the percentage difference in the number of tasks to the previous day.
- Add another column with the moving average of the tasks run in the last 7 days for each account.
- A lost account is an account with no tasks run on a given month. How many accounts did we lose (had no executed tasks) in February 2017?
   
## BONUS

Create a visualization that represents the growth of new accounts in a way you would communicate to a peer or business stakeholder.

The visualization was made exporting the data source and using Tableau. 

The following bar chart created we can see how many of the accounts for each month are brand new.


