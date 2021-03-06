% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/multiscaleSVDxpts.R
\name{symilr}
\alias{symilr}
\title{Symmetric multivariate, penalized image-based linear regression model (symilr)}
\usage{
symilr(voxmats, basisK, smoothingMatrixX, smoothingMatrixY, iterations = 10,
  gamma = 1e-06, sparsenessQuantileX = 0.5, sparsenessQuantileY = 0.5,
  positivityX = c("positive", "negative", "either"),
  positivityY = c("positive", "negative", "either"), initialUMatrix,
  repeatedMeasures = NA, verbose = FALSE)
}
\arguments{
\item{voxmats}{A list that contains the named x and y matrices.}

\item{basisK}{an integer determining the size of the basis.}

\item{smoothingMatrixX}{allows parameter smoothing, should be square and same
size as input matrix on left side of equation}

\item{smoothingMatrixY}{allows parameter smoothing, should be square and same
size as input matrix on right side of equation}

\item{iterations}{number of gradient descent iterations}

\item{gamma}{step size for gradient descent}

\item{sparsenessQuantileX}{quantile to control sparseness - higher is sparser}

\item{sparsenessQuantileY}{quantile to control sparseness - higher is sparser}

\item{positivityX}{restrict to positive or negative solution (beta) weights.
choices are positive, negative or either as expressed as a string.}

\item{positivityY}{restrict to positive or negative solution (beta) weights.
choices are positive, negative or either as expressed as a string.}

\item{initialUMatrix}{initialization matrix size \code{n} by \code{k}.
If this is missing, a random matrix will be used.}

\item{repeatedMeasures}{list of repeated measurement identifiers. this will
allow estimates of per identifier intercept.}

\item{verbose}{boolean to control verbosity of output}
}
\value{
A list of u, x and y-related matrices.
}
\description{
This function simplifies calculating image-wide multivariate beta maps from
that is similar to CCA.
}
\examples{

set.seed(1500)
nsub = 12
npix = 100
outcome = rnorm( nsub )
covar = rnorm( nsub )
mat = replicate( npix, rnorm( nsub ) )
mat2 = replicate( npix + 10, rnorm( nsub ) )
mat3 = replicate( npix + 10, rnorm( nsub ) )
nk = 3
result = symilr( list( vox = mat, vox2 = mat2, vox3 = mat3 ), basisK = 3 )

}
\seealso{
\code{\link{milr}} \code{\link{mild}}
}
\author{
BB Avants.
}
