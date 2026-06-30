function Base.show(io::IO, net::AnnotatedHypergraph)

    str = """
    $(typeof(net))
        → $(richness(net)) species
        → $((length ∘ interactions)(net)) interactions"""
   
    print(io, str)
end

function Base.show(io::IO, int::AnnotatedHyperedge)

    z = collect(zip(int.spp, int.roles))
    str = "Annotated Hyperedge: $(subject(int)) ← $(object(int)); "

    for (i, m) in (enumerate ∘ modifiers)(int)

        if i == length(modifiers(int))
            str *= "$m :: $(role(m, int))"
        else
            str *= "$m :: $(role(m, int)), "
        end
    end

    print(io, str)
end

"""
    For a type like Vector{Int64} this will return the Symbol :Vector.
"""
function type_outer_name(dt::DataType)::Symbol

    return dt.name.name
end