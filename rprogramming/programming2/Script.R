 #This function creates a special "matrix" object that can cache its inverse.
  makeCacheMatrix <- function(x = matrix()) {
     #clear inversematrix
    inverse <- NULL
     #set value
      set <- function(y) {
      x <<- y
     #clear inversematrix
     inverse <<- NULL   
        }
    #get statement
       get <- function() x
    #set statement
      setinverse <- function(inversed) inverse <<- inversed
      #get inverse
       getinverse <- function() inverse
     
       #list of functions
       list(set = set, get = get,
                   setinverse = setinverse,
                    getinverse = getinverse)    
  }


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should retrieve the inverse from the cache.
  

  cacheSolve <- function(x, ...) {
           ## Return a matrix that is the inverse of 'x'
       #lookup inversed matrix if exists
        inverse <- x$getinverse()
     if(!is.null(inverse)) {
         message("getting cached matrix from memory")
         #return the cached inverse
           return(inverse)
       }
    #get matrix supplied as argument
        data <- x$get()
     #calculate inverse by applying the solve function
    
    inversed <- data %*% solve(data, ...)
    #cache the result
       x$setinverse(inverse)
     #return the result
       inverse
  }
  
  
 
  
c = rbind(c(1, 3), c(5, 6))
cacheSolve(makeCacheMatrix(c))

  
