## This function creates a special matrix object
## that can cache its inverse.
## We need this because the inverse of a matrix 
## is generally computationally expensive 
##
makeCacheMatrix <- function(x = matrix()) {
  # sets x equal to an empty matrix
  inv <- NULL
  
  ## set function assigns the argument to x
  ## and reset the inverse of x
  set <- function(y){
    x <<- y
    inv <<- NULL
  }
  
  ## returns the x-matrix
  ## no effect on the inverse
  get <- function() {
    return(x)
  }
  
  ## setInverse overrides the previous value 
  ## of the inverse of matrix
  ## this function destroys the previous value
  setInverse <- function(solve) {
    inv <<- solve
  }
  
  ## returns the inverse
  ## no effect on the inverse
  getInverse <- function() {
    return(inv)
  }
  
  ## creates a list of the function
  list(set = set, 
       get = get, 
       setInverse = setInverse, 
       getInverse = getInverse)
}

## This function computes the inverse of the special matrix object
## returned by the function makeCacheMatrix 
## If the inverse has already been calculated, 
## then the cachesolve should retrieve the inverse from the cache
## 
cacheSolve <- function(x, ...) {
  inv <- x$getInverse()
  
  ## Retrieves the most recent value for the inverse
  ## If the value of inverse is not null, 
  ## cacheSolve returns that value
  if(!is.null(inv)){
    message("getting cached data")
    return(inv)
  }
  
  ## If the value of Inverse is null, 
  ## then we get the x matrix
  ## and solve x to get the inverse 
  matrixToBeSolved <- 
  inv <- solve(x$get(), ...)
  x$setInverse(inv)

  return(inv) 
}



