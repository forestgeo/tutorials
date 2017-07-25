#' Abundance or basal area dividing data with 1 or 2 categorical variables
#' 
#' @description
#' Calculates total abundance or basal area, dividing data with 1 or 2 
#' categorical variables.
#' 
#' @details
#' The categorical variables must be submitted as vectors whose length matches
#' exactly as the number of rows in the plot data submitted (so one per tree or
#' stem). The first vector should be the one with the most categories (for
#' instances, `split1 = species`, `split2 = dbhcategory`).
#' 
#' For basal area, pass a stem table to `censdata`; For abundance, use either
#' the stem or full table to count stems or trees, respectively.
#' 
#' @template mindbh
#' @template censdata
#' @template type
#' @template alivecode
#' @template dbhunit
#' @param split1 a vector of categories, one per individual
#' @param split2 another vector of categories, one per individual
#'
#' @return a named list of two elements, either `abund` or `ba`, and meandate 
#'   (mean measurement date for all individuals in each category). Each element 
#'   of the list is an array of one or two dimensions, depending on how many 
#'   split variables were submitted: each of the dimensions of the array handles
#'   one of the categorical variables.
#'
#' @examples
#' \dontrun{
#'
#' CTFSplot('bci',5:6,'full')
#'
#' CTFSplot('bci',5:6,'stem')
#' total=abundance(bci::bci12full5,mindbh=10)
#' total$abund
#' total$meandate
#' totalstem=abundance(bci::bci12stem5,mindbh=10)
#'
#' BAperSpecies=abundance(bci::bci12stem5,type='ba',mindbh=10,split1=bci::bci12stem5$sp)
#' head(BAperSpecies$ba)
#' head(BAperSpecies$meandate)}
#'
#'
'abundance'

#' Abundance, basal area, or agb of every species by quadrat.
#'
#' @description
#' Finds abundance, basal area, or agb of every species per square quadrat of
#' any size; plotdim is the x dimension then y dimension of the plot and must be
#' set correctly; gridsize is the quadrat dimension. The plot is divided into a
#' checkerboard of non-overlapping, space-filling squares.
#'
#' @details
#' If the plot dimensions is not an exact multiple of the quadrat size, then a 
#' strip at the upper edge of the plot (north and east if plot is on cardinal 
#' directions) is omitted. For example, if `gridsize = 40` and `plotdim = 500`,
#' then there are an extra 20 meters at the upper boundary omitted from the 
#' calculations.
#'
#' The array of abundances per quadrat is useful for similarity, counting
#' species and stems per quadrat, etc.
#' 
#' @inheritParams abundance
#' @inheritParams findborderquads
#' 
#' @seealso [abundance()]
#' 
#' @return See [abundance()].
#'
#' @examples
#' \dontrun{
#' Nperquad = abundanceperquad(
#'   bci::bci12full6,
#'   plotdim = c(1000, 500),
#'   gridsize = 100,
#'   type = 'abund'
#' )
#' colSums(Nperquad$abund)
#' apply(Nperquad$abund, 2, countspp)
#' plot(colSums(Nperquad$abund), apply / (Nperquad$abund, 2, countspp))
#' }
#'
'abundanceperquad'

#' Abundance of trees by species and DBH classes.
#'
#' @description
#'
#' A wrapper to calculate total abundance (or ba or agb) for each species in
#' given dbh categories. The dbh categories are set with `dbhbreaks`.
#' 
#' @return See [abundance()].
#' @seealso [abundance()]
#' @inheritParams abundance
#' @param dbhbreaks a vector of dbhs to define divisions of categories; the last
#'   category will be >= the final division
#'
'abundance.spp'

#' Change in abundance, basal area, or agb in two censuses.
#'
#' @description
#' Finds abundance, basal area, or agb in two censuses and the rate of change 
#' between them. Accepts two dataframes, each an R Analytical Table for one
#' census, the earlier census first.
#'
#' @details
#' Do not use this function with diameter categories as a split variable! The 
#' results won't make sense. The categories need to be permanent attributes, 
#' such as species, genus, quadrat. To find population change of dbh categories
#' use instead [pop.change.dbh()]
#'
#' Mean census date for a species is not the mean census date for all living
#' individuals in that census, but the mean census date for all individuals
#' alive in either census. Plants recruited between the two censuses get a first
#' census date equal to the date on which the quadrat they later appear in was
#' censused in the first census. Plants dead in the second census get a census
#' date equal to the date on which their quadrat was censused
#'
#' @return
#' The return value is a list of 6 components:
#' - N.1 (or BA.1 or AGB.1) an array of abundance (or basal area or agb) in the
#' first census; one dimension of the array for split1, the second for split2
#' - N.2 (or BA.2 or AGB.2) abundance (or basal area  or agb) in the second
#' census in a matching array
#' - date1 mean date of first census in a matching array
#' - date2 mean date of second census in a matching array
#' - interval the time interval in years in a matching array
#' - little.r the rate of population change in a matching array,
#' `(log(N2) - log(N1))/time`
#'
#' This list can be submitted to [assemble.demography()] (topic utilitiesCTFS) 
#' to convert into a convenient table.
#'
#' @inheritParams abundance
#' @inheritParams biomass.change
#'
#' @seealso [abundance()], [assemble.demography()]
#'
#' @examples
#' \dontrun{
#' bcichange = pop.change(
#'   bci::bci12full5,
#'   bci::bci12full6,
#'   type = 'abund',
#'   split1 = bci::bci12full5$sp,
#'   mindbh = 10
#' )
#' str(bcichange)
#' head(bcichange$N.1)
#' change.table = assemble.demography(bcichange, type = 'a')
#' head(change.table)
#' }
#'
'pop.change'

#' Change between two censuses in abundance or basal area.
#'
#' @description
#' Finds abundance or basal area in two censuses and the rate of change between
#' them, in several dbh categories.
#'
#' @details
#' Accepts two dataframes, each an R Analytical Table for one census, the
#' earlier census first. Only one additional splitting variable (other than dbh
#' category) is allowed. Typically, this is species, but genus or quadrat are
#' other examples.
#'
#' @inheritParams abundance
#' @inheritParams mortality.dbh
#' @param split A vector of categorical values of the same length as census
#'   which groups trees into classes of interest for which abundance values are
#'   computed. This vector can be composed of characters or numbers.
#'
#' @seealso [abundance()]
#' 
#' @return
#' The return value is a list of two elements, one name abund (or ba) and the 
#' other meandate, just as other abundance results. Each is a table having one
#' pair of columns for every dbh category: the first for census 1, the second
#' for census 2. So if there are 3 dbh categories, the table has 6 columns. The
#' rows of the table are the splitting variable (eg, species).
#'
#' @examples
#' \dontrun{
#' Nchange = pop.change.dbh(bci::bci12full5, bci::bci12full6, classbreak = c(10, 100, 300))
#' Nchange$abund
#'
#' BAchangePerSpp <- pop.change.dbh(
#'   bci::bci12full5,
#'   bci::bci12full6,
#'   classbreak = c(10, 100),
#'   split = bci::bci12full5$sp
#' )
#' head(BAchangePerSpp$ba)}
#'
'pop.change.dbh'

#' Basal area of trees.
#'
#' @description 
#' Calculates the individual basal areas (in square meters) for all submitted
#' dbhs. The dbh units must be submitted, either cm'or 'millimeters'.
#' @inheritParams abundance
#' @template dbh
#' @return A vector of basal area values of same length as the submitted vector 
#'   of dbhs.
'ba'

#' Returns the basal area summed over all submitted dbhs.
#'
#' @description
#' Returns the basal area summed over all submitted dbhs. NAs can be included,
#' as sum will be completed with `na.rm = TRUE`.
#'
#' @template dbh
#' @template mindbh
#' @template dbhunit
#'
'basum'

#' Collect abundances of all species across several censuses.
#'
#' @description
#' Collect abundances of all species across several censuses. 
#' 
#' @template allcns
#' @template mindbh
#' @template dbhunit
#' @template type
#' @param excludestatus By default, any tree ever given code M is not counted in
#'   any census, but set `excludestatus = NULL` to include them.
#' @param excludespp A character vector of species codes can be submitted as
#'   `excludespp`, for instance those for unidentified trees.
#'
#' @examples
#' \dontrun{
#' N = abund.manycensus(
#'   allcns = list(
#'     bci::bci12full1, bci::bci12full2, bci::bci12full3, bci::bci12full4
#'   ),
#'   mindbh = 10,
#'   type = 'abund',
#'   excludespp = 'uniden',
#'   excludestatus = 'M'
#' )
#' head(N)
#' colSums(N)
#' apply(N,2,countspp)
#'
#' N = abund.manycensus(
#'   allcns = list(bci::bci12full5, bci::bci12full6),
#'   mindbh = 10,
#'   type = 'abund',
#'   excludespp = c('uniden', 'tremxx'),
#'   excludestatus = NULL
#' )
#' }
#'
'abund.manycensus'
