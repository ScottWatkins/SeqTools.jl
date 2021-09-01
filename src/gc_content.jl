"""
    (gc, x) = gc_content(region::String, refseq)

Calculate the base composition for a DNA region.
Return values: (GC, [G, C, A, T, missing])
"""
function gc_content(region::String, refseq::NamedTuple)
    chr,range = split(region, ":")
    start,stop = split(range, "-")
    start = parse(Int64, start)
    stop = parse(Int64, stop)

    target = uppercase(refseq[Symbol(chr)][start:stop])
    
    g = sum( [char for char in target] .== 'G' )
    c = sum( [char for char in target] .== 'C' )
    a = sum( [char for char in target] .== 'A' )
    t = sum( [char for char in target] .== 'T' )
    n = sum( [char for char in target] .== 'N' )

    d = (stop - start + 1) - n
    bases = [g, c, a, t] ./ d
    gc_content = (g + c) / d
    miss = n / (stop - start + 1)
    push!(bases, miss)

    return (gc_content, bases)

end
