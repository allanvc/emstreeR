#' @title 3D Minimum Spanning Tree Plot
#' 
#' @description Plots a 3D MST by producing a point cloud with segments as a 
#'     'scatterplot3d' graphic.
#' 
#' @param tree a \code{MST} class object returned by the \code{ComputeMST()} 
#'     function.
#' @param x the numeric position or the name of the column to be used as the x 
#'     coordinates of points in the plot.
#' @param y the numeric position or the name of the column to be used as the y 
#' coordinates of points in the plot.
#' @param z the numeric position or the name of the column to be used as the z 
#' coordinates of points in the plot.
#' @param col.pts color of points (vertices/nodes) in the plot.
#' @param col.segts color of segments (edges) in the plot.
#' @param angle angle between x and y axis (Attention: result depends on 
#'     scaling).
#' @param ... further graphical parameters.
#' @return NULL
#' 
#' @examples
#' 
#' ## 3D artificial data:
#' n1 = 12
#' n2 = 22
#' n3 = 7
#' n = n1 + n2 + n3
#' set.seed(1984)
#' 
#' mean_vector <- sample(seq(1, 10, by = 2), 3)
#' sd_vector <- sample(seq(0.01, 0.8, by = 0.01), 3)
#' c1 <- matrix(rnorm(n1*3, mean = mean_vector[1], sd = .3), n1, 3)
#' c2 <- matrix(rnorm(n2*3, mean = mean_vector[2], sd = .5), n2, 3)
#' c3 <- matrix(rnorm(n3*3, mean = mean_vector[3], sd = 1), n3, 3)
#' d<-rbind(c1, c2, c3)
#' 
#' ## MST:
#' out <- ComputeMST(d)
#' 
#' ## 3D PLOT:
#' plotMST3D(out)
#' 
#' @export
#' 
plotMST3D <- function(tree, x=1, y=2, z=3, 
                      col.pts = "black", col.segts = "black", angle=40, ...) {
  
  x = x
  y = y
  z = z
  
  g <- scatterplot3d::scatterplot3d(tree[, x], tree[, y], tree[, z], 
                                    color=col.pts, angle=angle, ...)
  
  from <- g$xyz.convert(tree[tree$from, x] , tree[tree$from, y], 
                        tree[tree$from, z])
  to <- g$xyz.convert(tree[tree$to, x] , tree[tree$to, y], 
                      tree[tree$to, z])
  
  segments(from$x, from$y, to$x, to$y, col=col.segts, ...)
}