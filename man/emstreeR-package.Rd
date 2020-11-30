\docType{package}
\name{emstreeR-package}
\alias{emstreeR-package}
\alias{emstreeR}
\title{Euclidean Minimum Spanning Tree}

\description{
  The \pkg{emstreeR} package enables \R users to fast and easily 
  compute an Euclidean Minimum Spanning Tree from data.
}

\section{Introduction}{
  This package relies on \pkg{RcppMLPACK} to provide an \R interface for the Dual-Tree 
  Boruvka algorithm (March, Ram, Gray, 2010) implemented in 'mlpack' - the C++ 
  Machine Learning Library (Curtin et. al., 2013). The Dual-Tree Boruvka is 
  theoretically and emiprically the fastest algorithm for computing an Euclidean
  Minimum Spanning Tree (EMST). 
}

\section{Computing the Minimum Spanning Tree}{
  \code{\link[emstreeR]{ComputeMST}} is the main function of this package. It is
  a fast wrapper to its \code{C++} homonym from 'mlpack' for computing an 
  Euclidean Minimum Spanning Tree. Compared to functions in other MST related \R 
  packages, \code{\link[emstreeR]{ComputeMST}} is easier to use because you can 
  pass your data as a \code{numeric matrix} or a \code{data.frame}, which are 
  the most common data input formats in the wild. You do not have to put it into 
  a graph format as you otherwise would in other packages.
}

\section{Plotting}{

  'emstreeR' also provides wrapper functions and an S3 method for plotting the 
  resulting MST from \code{\link[emstreeR]{ComputeMST}}.

\itemize{
  \item{\code{\link[emstreeR]{plot.MST}} is an S3 method to the generic function 
  \code{\link{plot}} and produces 2D scatter plots with segments between the 
  points in a 'base' R style, following the linkage order in the MST.}
  
  \item{\code{\link[emstreeR]{plotMST3D}} produces a 3D point cloud with segments 
  between the points, following the linkage order in the MST and using the 
  'scatterplot3d' package style for plotting.}
  
  \item{\code{\link[emstreeR]{stat_MST}} is a 'ggplot2' Stat extension which 
  produces 2D scatter plots with segments based on the linkage order in the MST 
  using the 'ggplot2' style.}
  }

}

\author{

  Author & Mantainer: Allan Quadros \email{allanvcq@gmail.com}

}

\references{

March, W. B., and Ram, P., and Gray, A. G. (2010). \emph{Fast euclidian minimum 
spanning tree: algorithm analysis, and applications}. 16th ACM SIGKDD 
International Conference on Knowledge Discovery and Data mining, July 
25-28 2010. Washington, DC, USA. doi:10.1145/1835804.1835882.

Curtin, R. R. et al. (2013). Mlpack: A scalable C++ machine learning 
library. \emph{Journal of Machine Learning Research}, v. 14, 2013.

}

\seealso{

  Useful links:
  
  \itemize{
    \item{ \code{mlpack}: \url{https://www.mlpack.org/}}
  }

}
