@testset "GHC" begin
  setify(lists) = Set(Set.(lists))

  Z = [ones(10,10) 2ones(10,10); 3ones(10,10) 4ones(10,10)]
  š® = georef((Z=Z,))
  p = partition(š®, GHC(4, 1.0))
  @test length(p) == 4
  @test all(nelements.(p) .== 100)
  p1, p2, p3, p4 = p
  @test mean(coordinates(centroid(p1, ind)) for ind in 1:nelements(p1)) == [5.0,5.0]
  @test mean(coordinates(centroid(p2, ind)) for ind in 1:nelements(p2)) == [15.0,5.0]
  @test mean(coordinates(centroid(p3, ind)) for ind in 1:nelements(p3)) == [5.0,15.0]
  @test mean(coordinates(centroid(p4, ind)) for ind in 1:nelements(p4)) == [15.0,15.0]

  C = cluster(š®, GHC(4, 1.0))
  @test C.cluster == vec(Z')

  š®ā² = georef(values(š®), centroid.(domain(š®)))
  Cā² = cluster(š®ā², GHC(4, 1.0))
  @test C.cluster == Cā².cluster

  š® = georef((z=[ā(i^2+j^2) for i in 1:50, j in 1:50],))
  p = partition(š®, GHC(50, 1.0))
  @test length(p) == 50

  if visualtests
    @test_reference "data/ghc.png" plot(p)
  end
end
