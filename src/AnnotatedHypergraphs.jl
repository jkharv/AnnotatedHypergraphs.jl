module AnnotatedHypergraphs

    include("./types.jl")
    include("./pretty_printing.jl")
    include("./interface.jl")
   
    export Partiteness, Bipartite, Unipartite
    export Interaction, Directed, Undirected, Hyperedge, AnnotatedHyperedge

    export species, richness, interactions, role, roles, has_role

end
