#' @title Export 'MST' vertices to shapefile objects 
#' 
#' @description Write a shapefile containing the 'MST' vertices
#'     
#' @param x a \code{MST} class object returned by the 
#'     \code{\link[emstreeR]{ComputeMST}} function.
#' @param V1 the numeric position or the name of the column to be used as the x 
#'     coordinates.
#' @param V2 the numeric position or the name of the column to be used as the y 
#'     coordinates.
#' @param file shapefile (\code{*.shp}) to be written.
#' @param crs coordinate reference system. It can be numeric, character, or 
#'     object of class sf or sfc.
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
#' export_vertices_to_shapefile(output, file="vertices.shp")
#' }
#' @export
#'
export_vertices_to_shapefile <- function(x, V1 = 1, V2 = 2, file, crs = 4326,
                                         driver = "ESRI Shapefile", ...) {
  # Convert the output to an sf data frame
  points_sf <- sf::st_as_sf(x, coords = c(V1, V2))
  
  # set the CRS
  if (!is.null(crs)) {
    sf::st_crs(points_sf) <- crs
  } 
  # Write the points to a shapefile
  sf::st_write(points_sf, file, driver = driver, ...)
  
  #pointsdf <-  sp::patialPointsDataFrame(as.data.frame(cbind(x[,V1], x[,V2])), data = data.frame(dummy = rep(1,nrow(x))), ...)
  #writeOGR(pointsdf, dsn = dsn, layer = layer, driver = driver, ...)
}

