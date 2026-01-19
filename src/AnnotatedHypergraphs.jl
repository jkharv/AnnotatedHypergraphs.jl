module AnnotatedHypergraphs

using SpeciesInteractionNetworks

include("types.jl")
export AnnotatedHyperedge, AnnotatedHypergraph

include("interface.jl")
export species, richness, interactions
export isloop
export role, roles, has_role, with_role, subject, object

include("degree.jl")
export degree
export generality, vulnerability

include("paths.jl")
export shortestpath

include("distance_to_base.jl")
export distancetobase

end