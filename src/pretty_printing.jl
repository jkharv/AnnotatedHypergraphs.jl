function Base.show(io::IO, net::SpeciesInteractionNetwork)
 
    str = """
    $(typeof(net))
        → $(length(net.species.vertices)) species
        → $(length(net.interactions)) interactions"""
   
    print(io, str)
end

function Base.show(io::IO, spp::Partiteness)
 
    str = 
    "\
    $(type_outer_name(typeof(spp))) species pool represented by \
    $(typeof(spp).parameters[1])s with \
    $(length(spp.vertices)) species.\
    "
   
    print(io, str)
end

function Base.show(io::IO, int::Directed)
 
    str = "Directed interaction $(int.src) → $(int.dst)"
   
    print(io, str)
end

function Base.show(io::IO, int::Undirected)
 
    str = "Undirected itneraction $(int.src) ↔ $(int.dst)"
   
    print(io, str)
end

function Base.show(io::IO, int::Hyperedge)

    str = "Hyperedge between: "

    for s ∈ int.spp[begin:end-1]

        str = str * string(s) * ", "
    end 

    str = str * "and " * string(int.spp[end])

    print(io, str)
end

function Base.show(io::IO, int::AnnotatedHyperedge)

    z = collect(zip(int.spp, int.roles))
    str = "Annotated Hyperedge between:"

    for s ∈ z[begin:end-1]
        
        str = str * " $(first(s)) as $(last(s)),"
    end

    s = z[end]
    str = str * " and $(first(s)) as $(last(s)),"

    print(io, str)
end

"""
    For a type like Vector{Int64} this will return the Symbol :Vector.
"""
function type_outer_name(dt::DataType)::Symbol

    return dt.name.name
end