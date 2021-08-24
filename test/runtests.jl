using GeoClustering
using Meshes
using GeoStatsBase
using Test, Random, Plots
using ReferenceTests, ImageIO

# workaround GR warnings
ENV["GKSwstype"] = "100"

# environment settings
isCI = "CI" ∈ keys(ENV)
islinux = Sys.islinux()
visualtests = !isCI || (isCI && islinux)
datadir = joinpath(@__DIR__,"data")

# list of tests
testfiles = [
  "slic.jl",
  "ghc.jl"
]

@testset "GeoClustering.jl" begin
  for testfile in testfiles
    include(testfile)
  end
end
