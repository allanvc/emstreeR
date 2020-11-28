// [[Rcpp::depends(RcppMLPACK)]]

#include <RcppMLPACK.h>				// MLPACK, Rcpp and RcppArmadillo


using namespace mlpack::emst;
using namespace std;


//' @title \code{mlpack}'s Euclidean Minimum Spanning Tree
//'
//' @description Fast computes an EMST using the \code{mlpack C++} library.
//'
//' @param data a \code{matrix}.
//' @return a \code{matrix} containing each pair of start and end points
//' on its columns, and the distance between these points in order to 
//' produce the Minimum Spanning Tree.
//' @noRd
//'
// [[Rcpp::export]]
Rcpp::NumericMatrix mlpack_mst(arma::mat& data)
{
	// transposing the matrix so mlpack accepts the format v4
	data = data.t();
	
	DualTreeBoruvka<> dtb(data); //initialization -- create the tree
	
	// find the MST
	
	arma::mat mstResults;
	dtb.ComputeMST(mstResults);
	// different from R logic -- it saves the results in mstResults
	
	// adding 1 to rows "from" & "to" - v3
	mstResults.row(0) = mstResults.row(0) + 1; //start index = 0 in C++
	mstResults.row(1) = mstResults.row(1) + 1;
	
	// transpose the matrix back to how it was, for returning to R
	data = data.t();
	// pull request nr 1, based on the modify-in-place behaviour of Rcpp:
	// sol: https://stackoverflow.com/questions/24112893/within-c-functions-how-are-rcpp-objects-passed-to-other-functions-by-referen).
	
	// returning a matrix instead of a list - v2
	return Rcpp::wrap(mstResults); 
}
