"""
    gc_windows(positions::Array, refseq::NamedTuple; window=100, step=10, noslide=false)

Calculate the average GC content for genomic regions using a sliding window. Positions are input as an array of positions (1:200-300). Note that a genomic feature may be skipped by inputing a 2D matrix of postions (e.g. 1:100-200  1:230-300). 

The positions array is created using the readbed function and the refseq input is generated using the readfasta function.
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
