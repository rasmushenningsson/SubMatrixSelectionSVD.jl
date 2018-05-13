__precompile__()

module SMSSVD


export
    smssvd,
    projectionscore,
    projectionscorefiltered

include("projectionscore.jl")
include("smssvdimpl.jl")
include("precompile.jl")
VERSION>=v"0.6" && _precompile_()

end
