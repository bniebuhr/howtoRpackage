How to create R packages
================
Bernardo Niebuhr, Elie Gurarie

This is a tutorial on a few steps to create R packages.

## 0\) Check if the name you chose to your package is available

``` r
library(available)

available("howtoRpackage", browse = F)
```

## 1\) Create the R package within R

We can create the structure of a package using the function
`create_package` from the `usethis` package. This create the very
minimal structure before building the package.

``` r
library(usethis)

# create the package structure
usethis::create_package("howtoRpackage")
```

## 2\) Create README and define a license

One can define a license by hand or using a few pre-determined functions
from the `usethis` package. If we use the function, this will modify
both the `DESCRIPTION` file and also add a `LICENSE.md` file.

``` r
# Begin readme
usethis::use_readme_md()

# Define GPL3 as our license
usethis::use_gpl3_license(name = "Bernardo Niebuhr, Elie Gurarie et al")
```

## 3\) Add some functions

Now we add some functions. We can create them by hand (just copy and
paste now) within the `R` folder. Now we can build

## 4\) Add packages upon which the functions depend

``` r
# Necessary packages
usethis::use_package("sp", type = "Imports")

# Suggested packages
usethis::use_package("plyr", type = "Suggests")
```

## 5\) Add data - now we add both raw and ready to use

First we create the `raw-data` folder using the `use_data_raw` function.
It will also create a script for preparation of the raw data into the R
data format, `.rda`.

``` r
# add raw data
usethis::use_data_raw()
```

Now, we put the our dataset in the `data-raw` folder. Then we can edit
the script for preparing the dataset. There we read and prepare the
data, then we save it as `.rda` using, e.g. the function
`usethis::use_data` or `save()`:

``` r
# read data
juveniles <- read.csv("data-raw/subsetGPSlocs.csv")

# create data for use in the Rpackage
usethis::use_data(juveniles, overwrite = TRUE)

# or
dir.create("data/")
save(juveniles, file = "data/juveniles.rda")
```

## 6\) Use the package

Now we can use the package, and then save this as an example script on
how to use our functions.

## 7\) Add some `roxyxen2` documentation to the script

We can add some info to the functions, using the `roxygen2` notation,
and it will be transformed into documentation in the `man` folder.

``` r
usethis::use_git(message = "initial commit")

usethis::use_github()
```
