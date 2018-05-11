using SMSSVD
@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end


@testset "Basic Tests" begin
	X = randn(10,7)
	U,Σ,V,ps,signalDimensions,selectedVariables = smssvd(X,4,logspace(-2,0,5),nbrIter=2)

	@test size(U)==(10,4)
	@test size(Σ)==(4,)
	@test size(V)==(7,4)
	@test size(ps)==(4,5)
	@test length(signalDimensions)<=4
	@test all(x->size(x)==(10,), selectedVariables)
end
