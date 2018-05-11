function _precompile_()
    ccall(:jl_generating_output, Cint, ()) == 1 || return nothing
    precompile(Tuple{typeof(SMSSVD.α), Base.UnitRange{Int64}, Base.LinAlg.Symmetric{Float64, Array{Float64, 2}}})
    precompile(Tuple{getfield(SMSSVD, Symbol("##projectionscorefiltered#10")), Int64, Array{Float64, 1}, typeof(identity), Array{Float64, 2}, Base.UnitRange{Int64}, Array{Float64, 1}})
    precompile(Tuple{getfield(SMSSVD, Symbol("##smssvd#19")), Int64, Int64, typeof(identity), Array{Float64, 2}, Int64, Array{Float64, 1}})
    precompile(Tuple{getfield(SMSSVD, Symbol("#kw##projectionscorefiltered")), Array{Any, 1}, typeof(SMSSVD.projectionscorefiltered), Array{Float64, 2}, Base.UnitRange{Int64}, Array{Float64, 1}})
    precompile(Tuple{typeof(SMSSVD._αfiltered), Array{Float64, 2}, Base.UnitRange{Int64}, Array{Float64, 1}, Array{Float64, 1}})
    precompile(Tuple{getfield(SMSSVD, Symbol("#kw##_svds")), Array{Any, 1}, typeof(SMSSVD._svds), Array{Float64, 2}, Array{Float64, 2}})
    precompile(Tuple{getfield(SMSSVD, Symbol("##_svds#18")), Array{Any, 1}, typeof(identity), Array{Float64, 2}, Array{Float64, 2}})
    precompile(Tuple{typeof(SMSSVD.smssvd), Array{Float64, 2}, Int64, Array{Float64, 1}})
    precompile(Tuple{typeof(SMSSVD.smssvd), Array{Float64, 2}, Int64})
    precompile(Tuple{typeof(SMSSVD.smssvd), Array{Float64, 2}, Array{Int64, 1}})
end
