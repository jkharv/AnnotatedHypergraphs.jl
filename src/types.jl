abstract type Partiteness{T} end
abstract type Interaction{T, U} end

struct Unipartite{T <: Any} <: Partiteness{T}

    vertices::Vector{T}

    function Unipartite(vertices::Vector{T}) where T <: Any

        if T <: Number
            throw(ArgumentError("Vertex identifiers can't be numbers."))
        end
        if !allunique(vertices)
            throw(ArgumentError("Vertex identifiers must be unique"))
        end

        new{T}(vertices)
    end
end

struct Bipartite{T <: Any} <: Partiteness{T}

    top::Vector{T}
    bottom::Vector{T}

    function Bipartite(top::Vector{T}, bottom::Vector{T}) where T <: Any

        if T <: Number
            throw(ArgumentError("Vertex identifiers can't be numbers."))
        end
        if !allunique(top)
            throw(ArgumentError("Vertex identifiers must be unique"))
        end
        if !allunique(bottom)
            throw(ArgumentError("Vertex identifiers must be unique"))
        end
        if !allunique(vcat(bottom, top))
            throw(ArgumentError("Vertex identifiers must be unique"))
        end

        new{T}(vertices)
    end
end

struct Directed{T, U} <: Interaction{T, U}

    src::T
    dst::T
    val::U
end

struct Undirected{T, U} <: Interaction{T, U}

    s1::T
    s2::T
    val::U
end

struct Hyperedge{T, U} <: Interaction{T, U}

    spp::Vector{T}
    val::U
end

struct AnnotatedHyperedge{T, U} <: Interaction{T, U}

    spp::Vector{T}
    roles::Vector{Symbol}
    val::U

    function AnnotatedHyperedge(
        spp::Vector{T}, 
        roles::Vector{Symbol}, 
        val::U) where {T <:Any, U <: Any}

        if length(spp) ≠ length(roles)

            throw(ArgumentError("The role and species vector must be the same length."))
        end

        new{T, U}(spp, roles, val)
    end
end

struct SpeciesInteractionNetwork{P <: Partiteness, I <: Interaction}

    species::P
    interactions::AbstractArray{I}
end