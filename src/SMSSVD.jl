__precompile__()

module SMSSVD


export
    smssvd,
    projectionscore,
    projectionscorefiltered

include("projectionscore.jl")
include("smssvdimpl.jl")
include("precompile.jl")
_precompile_()

end
