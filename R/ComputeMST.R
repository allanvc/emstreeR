#' @title Euclidean Minimum Spanning Tree
#'
#' @description Computes an Euclidean Minimum Spanning Tree (EMST) from the 
#'     data. \code{ComputeMST} is a wrapper around the homonym function in
#'     the 'mlpack' library.
#'
#' @param x a \code{numeric matrix} or \code{data.frame}.
#' @param verbose If \code{TRUE}, mutes the output from the C++
#'     code.
#' @param scale If \code{TRUE}, it will scale your data with 
#'     \code{\link[base]{scale}} before computing the the minimum spanning tree 
#'     and the distances to be presented will refer to the scaled data.
#'
#' @details Before the computation, ComputeMST runs some checks and 
#'     transformations (if needed) on the provided data using the 
#'     \code{data_check} function. After the computation, it returns the 
#'     'cleaned' data plus 3 columns: \code{from}, \code{to}, and 
#'     \code{distance}. Those columns show each pair of start and end points, 
#'     and the distance between them, forming the Minimum Spanning Tree (MST).
#'
#' @return an object of class \code{MST} and \code{data.frame}.
#'
#' @note It is worth noting that the afore mentioned  columns (\code{from}, 
#'     \code{to}, and \code{distance}) have no relationship with their 
#'     respective row in the output \code{MST/data.frame} object. The authors 
#'     chose the \code{data.frame} format for the output rather than a 
#'     \code{list} because it is more suitable for plotting the MST with the 
#'     new 'ggplot2' Stat (\code{\link[emstreeR]{stat_MST}}) provided with this 
#'     package. The last row of the output at these three columns will always 
#'     be the same: \code{1 1 0.0000000}. This is because we always have n-1 
#'     edges for n points. Hence, this is done to 'complete' the data.frame 
#'     that is returned.
#'
#' @examples
#' 
#' ## artifical data
#' set.seed(1984)
#' n <- 15
#' c1 <- data.frame(x = rnorm(n, -0.2, sd = 0.2), y = rnorm(n, -2, sd = 0.2))
#' c2 <- data.frame(x = rnorm(n, -1.1, sd = 0.15), y = rnorm(n, -2, sd = 0.3)) 
#' d <- rbind(c1, c2)
#' d <- as.data.frame(d)
#' 
#' ## MST:
#' out <- ComputeMST(d)
#' out
#' 
#' @export
#' 
ComputeMST <- function(x, verbose=TRUE, scale=FALSE) {
  # returns a mst/df object
  data_aux <- data_check(x)
  
  if(isFALSE(scale)){
    if(isFALSE(verbose)) {
      BBmisc::suppressAll(
        from_to_matrix <- mlpack_mst(data_aux) # always scaled  
      )} else {
        from_to_matrix <- mlpack_mst(data_aux) # always scaled  
      } # as suggested at: https://github.com/rcppmlpack/RcppMLPACK1/issues/7
    
    from <- c(as.integer(from_to_matrix[1,]), 
              1 ) # repeating the last link 
    #.. for plots with ggplot2
    to <- c(as.integer(from_to_matrix[2,]), 
            1 ) # it should not be 
    #.. "from" 1 "to" 1 in order to get stat_MST working
    distance <- c(from_to_matrix[3,], 0) # adding a zero to the last row's 
    #.. distance to not intefere in the total cost of the MST
    
    colnames(data_aux) <- colnames(as.data.frame(x))
    # forcing as a data.frame because sometimes it's a matrix with no colnames
    # we can't recover the rownames because sometimes data_check() may remove 
    #.. lines with NA in the data
    
    
    
  } else {
    
    data_aux <- scale(data_aux)
    
    if(isFALSE(verbose)) {
      BBmisc::suppressAll(
        from_to_matrix <- mlpack_mst(data_aux) # always scaled  
      )} else {
        from_to_matrix <- mlpack_mst(data_aux) # always scaled  
      } # as suggested at: https://github.com/rcppmlpack/RcppMLPACK1/issues/7  
    
    from <- c(as.integer(from_to_matrix[1,]), 
              1 ) # repeating the last link 
    #.. for plots with ggplot2
    to <- c(as.integer(from_to_matrix[2,]), 
            1 ) # it should not be 
    #.. "from" 1 "to" 1 in order to get stat_MST working
    distance <- c(from_to_matrix[3,], 0) # adding a zero to the last row's 
    #.. distance to not intefere in the total cost of the MST
    
    colnames(data_aux) <- paste0("scaled_", colnames(as.data.frame(x)))
    # forcing as a data.frame because sometimes it's a matrix with no colnames
    # we can't recover the rownames because sometimes data_check() may remove 
    #.. lines with NA in the data
    
    
  }
  
  x <- data.frame(data_aux, from, to, distance) # from and to are not linked 
  #..to the rows
  # we just cbind from and to in order to have a data.frame and not a list
  
  rm(data_aux) # cleaning
  class(x) <- c("MST", "data.frame") # because we wanted a new plot.method for 
  #..objects of class "MST".
  
  
  
  return(x)
}