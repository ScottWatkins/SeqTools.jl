"""
    gc_windows(positions::Array, refseq::NamedTuple; window=100, step=10, noslide=false)

Run the gc_simple function over genomic positions with user defined window size and step. Positions are an array of 1:123-345 style positions. Note that a genomic feature may be skipped by inputing a 2D matrix of postions (e.g. 1:100-200  1:230-300). 

The refseq input is generated using the readfasta function.
"""
function gc_windows(positions::Array, refseq::NamedTuple; window=100, step=10, noslide=false)

    ref = refseq
    m = []
    xvals = []

    for i in 1:size(positions,1)

        if size(positions,2) == 2
            s1 = getref(positions[i,1], ref)
            s2 = getref(positions[i,2], ref)
            s = s1 * s2
        else
            s = getref(positions[i], ref)
        end

        if noslide == true
            window = length(s)
            step = length(s)
        end
     
        gcdata = sliding_window(s, window, step, gc_simple)
        gcdata = round.(gcdata; digits=4)
        push!(m, gcdata)
        
    end

    return m

end
