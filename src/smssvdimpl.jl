
# Julia version compatibility
if VERSION<v"0.5"
    _svds(args...; kwargs...) = svds(args...; kwargs...)
else
    _svds(args...; kwargs...) = (A=svds(args...; kwargs...); (A[1][:U],A[1][:S],A[1][:V]))
end


function smssvd(X, n, stdThresholds=logspace(-2,0,100); nbrIter=10, maxSignalDim=typemax(Int))
    σMax = maximum(std(X,2)) # Always base the variable filtering on the original σ's 

    U = zeros(size(X,1),n)
    Σ = zeros(n)
    V = zeros(size(X,2),n)

    ps = zeros(n, length(stdThresholds))

    signalDimensions = Int[]
    selectedVariables = Vector{BitArray}()

    k = 1
    while k<=n
        # Filter variables and choose dimension by optimizing over Projection Score
        σ = squeeze(std(X,2),2) / σMax # always keep the same scale

        dmax = min(n-k+1, maxSignalDim)
        PS = projectionscorefiltered(X, 1:dmax, stdThresholds, nbrIter=nbrIter, σ=σ)
        dims,σInd = ind2sub(size(PS), indmax(PS)) # Use projection score both to choose dimension and threshold for this signal
        σThresh = stdThresholds[σInd]

        r = k:k+dims-1
        ps[r,:] = PS[1:dims,:]
        push!(signalDimensions, dims)

        push!(selectedVariables,σ.>=σThresh)
        Y = X[selectedVariables[end],:]

        # Find the subspace Π that we are interested in.
        K = Symmetric(Y'Y)
        M = size(K,1)
        _,Π = eig(K, M-dims+1:M) # only get the largest eigenvalues and vectors

        # Project X onto the subspace v and compute SVD. For dims=1, this is identical to uσ:=Xv.
        UΠ,ΣΠ,VΠ = _svds(X*Π,nsv=dims) # solve for smaller matrix expressed in the basis of the subspace Π
        U[:,r] = UΠ
        Σ[r]   = ΣΠ
        V[:,r] = Π*VΠ # expand to original basis

        # make matrix orthogonal to previous component
        X = X - UΠ*(UΠ'X) # multiplication order avoiding big matrices

        k += dims
    end

    U,Σ,V,ps,signalDimensions,selectedVariables
end