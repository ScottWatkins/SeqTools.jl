"""
    readbed(bedfile::String; pad=0, flanking=false, delim='\t')

Read and optionally pad coordinates of a 3+ column bedfile.
Return an array of positions in the chr:start-stop format.
Bedfile may be commented with #.

Examples:
Simply reformat sites to UCSC input: readbed(bedfile)
Expand the region by 1kb: readbed(bedfile, pad=1000);  
Omit target and get the flanking regions of size "pad"; 
(leftsites, rightsites) = readbed(bedfile; pad=100, flanking=true).
"""
function readbed(bedfile::String; pad=0, flanking=false, delim='\t')

    w = pad
    m = readdlm(bedfile, Char(delim))
    
    chrs = string.(m[:,1])
    chrs = replace.(chrs, r"\.0" => "")
    o1 = BigInt.(m[:,2])
    o2 = BigInt.(m[:,3])
    p1 = BigInt.(m[:,2] .- w)
    p1 = [if i < 0; 1 else i end for i in p1]
    p2 = BigInt.(m[:,3] .+ w)
    p2 = [if i < 0; 1 else i end for i in p2]

    if pad == 0 && flanking == true
        error("Pad sequence must be set and >0 if excluding region.")
    end
    
    if sum(collect(p1 .> p2)) > 0
        error("Second coordinate must be less than first.")
    end

    if flanking == true

        nb1 = hcat(string.(chrs), string.(p1 .- 1), string.(o1 .- 1))
        nb2 = hcat(string.(chrs), string.(o2 .+ 1), string.(p2 .+ 1))

        newpos1 = [join(nb1[i,:], ":","-") for i in 1:size(nb1,1)]
        newpos2 = [join(nb2[i,:], ":","-") for i in 1:size(nb2,1)]
        return newpos1, newpos2

    else

        nb = hcat(string.(chrs), string.(p1), string.(p2))
        newpos = [join(nb[i,:], ":","-") for i in 1:size(nb,1)]
        return newpos

    end

end
