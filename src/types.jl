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

function AnnotatedHypergraph(
    web::SpeciesInteractionNetwork{Unipartite{T}, Binary{Bool}}
    )::AnnotatedHypergraph{T} where T

    hyperedges = Vector{AnnotatedHyperedge{T}}(undef, (length ∘ interactions)(web))

    for (i, intx) in (enumerate ∘ interactions)(web)

        sbj, obj, _ = intx
        hyperedges[i] = AnnotatedHyperedge([sbj, obj], [:subject, :object])
    end

    return AnnotatedHypergraph(copy(web.nodes), hyperedges)
end