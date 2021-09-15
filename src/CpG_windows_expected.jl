"""
    CpG_windows_expected(positions::Array, refseq::NamedTuple; window=5, step=5, noslide=false)

Ouput the expected number of CpG sites for the specified genomic positions using a user-defined window size and step. Positions are an array of 1:123-345 style positions. A genomic feature may be skipped by inputing a 2d array of postions. For example, 1:100-200  1:230-300, skips the feature from 1:201-229. 

The refseq input is generated using the readfasta function.
"""
function CpG_windows_expected(positions::Array, refseq::NamedTuple; window=5, step=5, noslide=false)

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
        
        gcdata = sliding_window(s, window, step, expected_CpG)

        push!(m, gcdata)
        
    end

    return m

end
