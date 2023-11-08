#' @title Export 'MST' edges to shapefile objects 
#' 
#' @description Write a shapefile containing the 'MST' edges
#'     
#' @param x a \code{MST} class object returned by the 
#'     \code{\link[emstreeR]{ComputeMST}} function.
#' @param V1 the numeric position or the name of the column to be used as the x 
#'     coordinates of the points in the plot.
#' @param V2 the numeric position or the name of the column to be used as the y 
#' coordinates of the points in the plot.
#' @param file shapefile (\code{*.shp}) to be written.
#' @param crs coordinate reference system. It can be numeric, character, or 
#'     object of class sf or sfc.
#' @param multiple_files logical. Should I write each edge to one different file.
#' @param driver vector driver to be used in the process. Refer to 
#'     \url{https://gdal.org/drivers/vector/index.html}
#' @param ... further \code{\link[sf]{sf}} parameters.
#' 
#' @examples
#' 
#' #mock data
#' country_coords_txt <- "
#' 1     3.00000  28.00000       Algeria
#' 2    54.00000  24.00000           UAE
#' 3   139.75309  35.68536         Japan
#' 4    45.00000  25.00000 'Saudi Arabia'
#' 5     9.00000  34.00000       Tunisia
#' 6     5.75000  52.50000   Netherlands
#' 7   103.80000   1.36667     Singapore
#' 8   124.10000  -8.36667         Korea
#' 9    -2.69531  54.75844            UK
#' 10    34.91155  39.05901        Turkey
#' 11  -113.64258  60.10867        Canada
#' 12    77.00000  20.00000         India
#' 13    25.00000  46.00000       Romania
#' 14   135.00000 -25.00000     Australia
#' 15    10.00000  62.00000        Norway"
#' 
#' d <- read.delim(text = country_coords_txt, header = FALSE,
#'                 quote = "'", sep = "",
#'                 col.names = c('id', 'lon', 'lat', 'name'))
#'                 
#' #MST
#' library(emstreeR)
#' output <- ComputeMST(d[,2:3])
#' #plot(output)
#' \dontrun{
#' export_edges_to_shapefile(output, file="edges.shp")
#' }
#' @export
#'
export_edges_to_shapefile <- function(x, V1 = 1, V2 = 2, file,
                                      crs = 4326,
                                      multiple_files = FALSE, 
                                      driver = "ESRI Shapefile", ...) {
  
  if (isFALSE(multiple_files)) {
    
    # --------------- saving EDGES to a shapefile --------------- #
    
    # Preparing data
    mst <- data.frame("x" = x[x$from, V1],
                      "y" = x[x$from, V2],
                      "xend" = x[x$to, V1],
                      "yend" = x[x$to, V2])
    
    mst <- as.matrix(mst) 
    
    # Create sf lines for all edges
    l <- vector("list", nrow(mst))
    
    for (i in 1:nrow(mst)) {
      mat <- matrix(rep(0, 4), ncol = 2)
      mat[1, ] <- mst[i, 1:2]
      mat[2, ] <- mst[i, 3:4]
      
      l[[i]] <- sf::st_linestring(mat)
    }
    
    # Create an sf object for the edges
    edges_sf <- sf::st_sf(geometry = l, ID = 1:nrow(mst))
    
    # set the CRS
    if (!is.null(crs)) {
      sf::st_crs(edges_sf) <- crs
    }
    
    # Write the edges to a shapefile
    sf::st_write(edges_sf, file, driver = driver)
  
  } else {
  
    # Create separate shapefiles for each edge
    for (i in 1:nrow(mst)) {
      mat <- matrix(rep(0, 4), ncol = 2)
      mat[1, ] <- mst[i, 1:2]
      mat[2, ] <- mst[i, 3:4]
      
      line <- sf::st_linestring(mat)
      edge_sf <- sf::st_sf(geometry = list(line), ID = 1)
      # set the CRS
      if (!is.null(crs)) {
        sf::st_crs(edges_sf) <- crs
      }
      sf::st_write(edge_sf, paste(sub("\\.shp$","", file), i, ".shp", sep = ""), driver = "ESRI Shapefile")
    }  
    
  }
  
}