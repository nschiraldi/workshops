import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

#  Load in all of the states
dfs = []
for state in ["AL", "OR", "AK"]:
    dfs.append(
        pd.read_csv(
            "https://gitlab.rit.albany.edu/ns742711/python-workshop/raw/master/python/data/espyAK-AL-OR/espy{0}.csv".format(
                state
            )
        )
    )
df = pd.concat(dfs)


# Let's just grab Alabama. Also, let's make sure we don't include any dates that are "null"
# We will "chain" boolean statements in order to do this. Note that this is a special property
# of pandas, base python does not support chaining (e.g. (a == b) & (c != b) )

# take a look at all of the state_abbreviations using the "unique" command, so we know how
# to filter on AL
df.state_abbreviation.unique()

# there is a lot of extra data in the dataframe, let's pull out just a few columns that might be
# interesting
AL = df.loc[
    (~df.date_execution.isnull()) & (df.state_abbreviation == "AL"),
    [
        "state_abbreviation",
        "date_execution",
        "age",
        "gender_assigned",
        "race",
        "enslaved",
        "jurisdiction",
        "county_name",
        "county_code",
        "execution_method",
        "first_name",
    ],
]


# Let's make date_execution a true "datetime" and set it as the "index". Note that a special
# property of dataframes, is that any column can be made an index! Datetimes allow flexiblity
# to index more naturally on dates/months/years
AL["date_execution"] = pd.to_datetime(AL["date_execution"])
AL.set_index("date_execution", inplace=True) # inplace means we do not have to reassgin the variable


# Let's plot the number of executions per year
# To do this, we will use the groupby function. We will take all of the entries in the dataframe
# and group them by "year", then take the len() of the list and plot it


AL.groupby(AL.index.year).apply(lambda x: len(x)).plot(
    title="Total Number of Executions per Year"
)


# Let's plot the number of executions per year that are keyed as "enslaved"
# First, we need to take a look at the entries for "enslaved" so we know the kind of
#  data that we are working with, what are the datatypes?
AL.enslaved.head()


# Booleans are datatypes that can be summed! True = 1, False = 0. Group the column "enslaved"
#  by the df.index.year, then "sum" them. This can all be done on one line, with chained commands
AL.loc[:, "enslaved"].groupby(AL.index.year).sum().plot(
    title="Number of Enslaved Executions per Year"
)


# The Emancipation Proclamimation was signed in 1963, the 14th amendment was 
# not ratified until 1865.
#  - let's plot a vertical line for those dates, so we can see those dates
#  - let's exclude anything after 1875, since the sums are zero
fig, ax = plt.subplots()
enslaved_exec = AL.loc[:, "enslaved"].groupby(AL.index.year).sum()
enslaved_exec.loc[enslaved_exec.index <= 1875].plot(
    ax=ax, title="Number of Enslaved Executions per Year"
)
ax.axvline(1863, color="k", label="1863")
ax.axvline(1865, color="r", label="1865")
plt.show()

# How many "enslaved" executions where there, between 1863 and 1865?
enslaved_exec[1863:1865].sum()


# Let's transform the "race" column to white vs non white
# There are many ways to do this. For this application, we will add a new
# boolean column "white". True = white, False = nonwhite.

# first, take a look at all of the races in the dataset
AL.race.unique()

# Now, we will create a column called "white" and set it to True where 
# AL.race == 'white', FALSE other wise'
AL.loc[:, "white"] = AL.race == "White" # creates list of true/false


# Now, let's see the percentage of white vs nonwhite executions per year
fig, ax = plt.subplots()
ax.axvline(1863, color="k", label="1863")
ax.axvline(1865, color="r", label="1865")
AL.loc[:, "white"].groupby(AL.index.year).apply(lambda x: sum(x) / len(x)).plot(
    ax=ax, title="Percent of Executions Where Race=white"
)  # note, sum() cannot interpret nan!
plt.show()


# Finally, let's plot by year:
# - total number of executions
# - total number of enslaved executions
# - total number of non white executions
fig, ax = plt.subplots(figsize=(8, 4))
AL.groupby(AL.index.year).apply(lambda x: len(x)).plot(ax=ax, label="Total")
AL.loc[:, "enslaved"].groupby(AL.index.year).sum().plot(
    ax=ax, label="Enslaved", color="r"
)
AL.loc[:, "white"].groupby(AL.index.year).apply(lambda x: sum(~x)).plot(
    ax=ax, label="Non-white"
)
ax.set_title("Execution Statics for Alabama")
plt.legend()
plt.show()

# # A quick thought on seaborn
# Most of the graphics above look fine, but of course you want them to look better. Seaborn is a package that replicated ggplot() styling. Let's implement it!
import seaborn as sns
sns.set_context("talk")
fig, ax = plt.subplots(figsize=(8, 4))
AL.groupby(AL.index.year).apply(lambda x: len(x)).plot(ax=ax, label="Total")
AL.loc[:, "enslaved"].groupby(AL.index.year).sum().plot(
    ax=ax, label="Enslaved", color="r"
)
AL.loc[:, "white"].groupby(AL.index.year).apply(lambda x: sum(~x)).plot(
    ax=ax, label="Non-white"
)
ax.set_title("Execution Statics for Alabama")

plt.legend()
plt.show()