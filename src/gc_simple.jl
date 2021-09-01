"""
    gc = gc_simple(region::String)

Calculate the gc_content for a DNA string.
"""
function gc_simple(seq::String)

    target = uppercase(seq)
    
    g = sum( [char for char in target] .== 'G' )
    c = sum( [char for char in target] .== 'C' )
    a = sum( [char for char in target] .== 'A' )
    t = sum( [char for char in target] .== 'T' )
    n = sum( [char for char in target] .== 'N' )

    d = length(target) - n
    gc = (g + c) / d

    return (gc)

end
