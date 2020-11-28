#' @title Data checking
#' 
#' @description Checks the integrity of the inputed data before computing the 
#' Euclidian Minimum Spanning Tree (EMST)
#'
#' @param x a \code{matrix} or \code{data.frame}.
#' 
#' @details \code{data_check} is called from inside 
#'     \code{\link[emstreeR]{ComputeMST}} before the computation begins. First, 
#'     it evaluates the object format. Afterwards, it checks whether the 
#'     inputed data has at least two columns and tries to coerce all columns 
#'     into numeric, beyond removing all rows containing \code{NA} entries.
#' 
#' @return a \code{matrix} containing the cleaned data after running the 
#'     necessary checks.
#'     
#' @keywords internal
#' @noRd
data_check <- function(x) {

  # 1) matrix/data.frame verification
  x <- tryCatch({
    as.matrix(x)
  },
  error=function(e) {
    message("Error: Not a matrix or data.frame.")
    message(e)
    # Choose a return value in case of error
    return(NULL)
  })
  
  # 2) multivariate data verification
  if(ncol(x) < 2){
    message("Error: Your data should have more than 1 column.")
    return(NULL)
  }
  
  # 3) numeric cols verification
  x <- tryCatch({
    vapply(1:ncol(x), FUN = function(j) as.numeric(as.character(x[ ,j])), 
           numeric(nrow(x)))
  },
  error=function(e) {
    message("Error: Could not transform your data columns into numeric.")
    message(e)
    # Choose a return value in case of error
    return(NULL)
  })
  
  # 4) only NA'S in a column verification (e.g. when all entries of a column 
  #.. have characters)
  na_count <- vapply(1:ncol(x), function(j) length(which(is.na(x[ ,j]))), 
                     numeric(1))
  
  if(any(na_count == nrow(x))){
    message("Error after transforming your columns into numeric: one or more 
            columns end up having only NA's as entries.")
    return(NULL)
  } 
  
  
  # 5) removing NA's verification
  if(any(is.na(x))){
    x <- tryCatch({
      na.omit(x)
    },
    error=function(e) {
      message("Error: Could not remove your NA's entries.")
      message(e)
      # Choose a return value in case of error
      return(NULL)
    })  
  }
  
  return(x) # returns the transformed data after all checks
  
}
