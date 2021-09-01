"""
    seq = getref(region, refseq)

Get a subsequence from the genome reference.
Input region in the format, chr1:1234-5678.
The reference tuple is created by readfasta.jl
"""
function getref(region::String, refseq::NamedTuple)
    chr,range = split(region, ":")
    start,stop = split(range, "-")
    start = parse(Int64, start)
    stop = parse(Int64, stop)

    target = uppercase(refseq[Symbol(chr)][start:stop])
    return target
end
