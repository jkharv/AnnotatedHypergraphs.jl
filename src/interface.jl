species(spp::Bipartite) = vcat(spp.top, spp.bottom)
species(spp::Unipartite) = vcat(spp.vertices)

species(int::Directed) = vcat(int.src, int.dst)
species(int::Undirected) = vcat(int.s1, int.s2)
species(int::Hyperedge) = int.spp
species(int::AnnotatedHyperedge) = int.spp

species(net::SpeciesInteractionNetwork) = species(net.species)

richness(net::SpeciesInteractionNetwork) = length(species(net))

interactions(net::SpeciesInteractionNetwork) = 
    [net.interactions[i] for i ∈ eachindex(net.interactions)]

function role(sp::T, int::AnnotatedHyperedge{T, U})::Symbol where {T<:Any, U<:Any}

    return roles(sp, int)[1] 
end

function roles(sp::T, int::AnnotatedHyperedge{T, U})::Vector{Symbol} where {T<:Any, U<:Any}

    indices = findall(x -> x == sp, int.spp)

    if isnothing(indices)

        throw(ArgumentError("Can't find $sp in this interaction: $int"))
    end

    return int.roles[indices]
end

function has_role(sp::T, 
    int::AnnotatedHyperedge{T, U}, 
    role::Symbol)::Bool where {T<:Any, U<:Any}

    return role ∈ roles(sp, int)
end