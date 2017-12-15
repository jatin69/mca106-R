Q2. [Lending Club](https://www.lendingclub.com/) is a platform for non-traditional loans. Applicants submit an application for a
loan, and individual investors can choose to fund part of the loan. To help investors make
intelligent decisions, Lending Club has released data on past loan performance. For these
questions, I will be looking at the lending club loans issued in 2014 and 2015. [Download](https://www.lendingclub.com/info/download-data.action) the
relevant CSV files, as well as a spreadsheet describing the columns (i.e. Data Dictionary).

a) What is the median loan amount?

b) Each loan is categorized into a single purpose. What fraction of all loans are for the most
common purpose?

c) Calculate the average interest rate across loans for each purpose. What is the ratio of
minimum average rate to the maximum average rate? (The ratio should be less than 1.)

d) What is the difference in the fraction of the loans with a 36-month term between 2014 and
2015?

e) I will consider all loans that are not in the 'Fully Paid', 'Current', 'In Grace Period' statuses
to be in default. Calculate the ratio of the time spent paying the loan, defined as thedifference between the last payment date and the issue date, divided by the term of loan.
What is the standard deviation of this ratio for all the loans in default?

f) What is the Mean, Median, Mean Absolute Deviation, Variance, IQR, Skewness and
Kurtosis for the total rate of return, as figured from the total payments and the loan amount,
and the interest rate? Consider only loans that have reached the end of their term. [Summary
function NOT to be used here]

g) Let's find a loan purpose that shows up abnormally often in one state. Call A the probability
of a loan going to a specific purpose nationwide. Call B the probability of a loan going to
a specific purpose for each state. Out of all (state, purpose) pairs with at least 10 loans,
what is the highest ratio of B / A (i.e. the most surprising)?

h) Group all loans by their sub-grade and calculate their average interest rate, average default
rate, and percentage of loan status categories.