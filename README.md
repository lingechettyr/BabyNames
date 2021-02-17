# BabyNames

These two seperate programs use Julia to first download data on baby names and their frequency over time (years), and then load that data into a database that one of the programs also creates. Once the data is loaded into an SQLite database, the plotting program can be used to query for the name and gender (command line inputs) and plot the frequency of that name and gender combination over the timeframe of the data.

## Dependencies

The following packages must be added to Julia in order to successfully run the programs: 

```bash
ZipFile (scans zip file)
SQLite (connection to database engine)
CSV 
DataFrames
Gadfly (plotting library)
```

## Design

### Prepare.jl

This program is the one that downloads the baby names zip file containing the text files that contain data corresponding to year and load that data into an SQLite database.

An example is given below to demostrate the execution of this program:

```bash
$ julia prepare.jl names.zip names.db
```

It takes two arguements (what to name the zip file downloaded by the program and the name of the generated database). This program is meant to only be executed once (but can run multiple times) and it takes ~40s to fully run.

### Plot.jl

This is the plotting program that takes three arguments (name of database, name of baby name, and sex) that will be used to query the database.

An example is given below:

```bash 
$ julia plot.jl names.db lia F
```

It will plot the frequency of the input name (case insensitive) and gender combination over the years in the database. This program will generate an SVG file in the same directory as it, so one will have to open that SVG to view the plot. Furthermore, it takes ~1m to run to completion and can and should be run mulitple times.

## Jupyter Notebooks

Also included are interactable Jupyter Notebooks
