module SeqTools
println("Welcome to SeqTools ver 0.1.0")
using DelimitedFiles, Statistics, Plots

export readbed
export readfasta
export gc_windows

include("readfasta.jl")
include("gc_simple.jl")
include("readbed.jl")
include("sliding_window.jl")
include("getref.jl")
include("gc_windows.jl")

end
