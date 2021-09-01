"""
    padbed(bedfile::String, pad::Int64)

Add padding to left and right coordinates of a bedfile.
"""
function padbed(bedfile::String, pad::Int64)
    
    m = readdlm(bedfile)

    w = pad / 2

    chrs = (m[:,1])
    p1 = BigInt.(m[:,2] .- w)
    p2 = BigInt.(m[:,3] .+ w)

    nb = hcat(string.(chrs), string.(p1), string.(p2))
    newpos = [join(nb[i,:], ":","-") for i in 1:size(nb,1)]

    return newpos

end
