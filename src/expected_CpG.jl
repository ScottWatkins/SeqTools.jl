"""
    expected_CpG(seq::String)

Return the fraction of CpG dinucleotides expected in a random DNA sequence.
"""
function expected_CpG(seq::String)

    target = uppercase(seq)
    G = sum( [char for char in target] .== 'G' )
    C = sum( [char for char in target] .== 'C' )
    N = sum( [char for char in target] .== 'N' )
    Gexp = G / (length(seq) - N) #freq G
    Cexp = C / (length(seq) - N) #freq C
    exp_count = 2 * ((Cexp * Gexp) * (length(seq) - N))
    return exp_count

end
