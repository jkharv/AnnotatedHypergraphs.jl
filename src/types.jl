# For now it's a symbol, but I wanna seperate use of Symbol for roles cause in the
# future, something fancier for roles may be to come.
const RoleType = Symbol

struct AnnotatedHyperedge{T}

    spp::Vector{T}
    roles::Vector{RoleType}
end

struct AnnotatedHypergraph{T}

    nodes::Unipartite{T}
    edges::Vector{AnnotatedHyperedge{T}}

    function AnnotatedHypergraph(
        nodes::Unipartite{T}, 
        edges::Vector{AnnotatedHyperedge{T}}
    ) where T

        new{T}(nodes, edges)
    end
end