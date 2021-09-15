"""
    count_CpG(seq::String)

Return the count of C and G bases in CpG dinucleotides for a given sequence.
"""
function count_CpG(seq::String)

    m = eachmatch(r"CG"i, seq)
    loc = [i.offset for i in m]
    n = sum( [char for char in seq] .== 'N' )
    obs = length(loc) * 2   #count of all dinuc in CpG
    return obs

end
