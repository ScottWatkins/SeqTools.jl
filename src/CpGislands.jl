"""
    (oe, avg, cgi) = CpGislands(positions::Array, refseq::NamedTuple)

Perform a sliding window scans for regions of the genome to identify areas enriched in CpG dinucleotides. The default CpG content (0.6) and average GC content (0.5) can be changed by the user. 

Returns an array of the obs/exp ratios for CpG content, the average GC values, and CpG island flags by windowfor each input region in the bedfile.

kwargs: window=200, step=200, noslide=false, cpg=0.6, gcavg=0.5


"""
function CpGislands(positions::Array, refseq::NamedTuple; window=200, step=200, noslide=false, cpg=0.6, gcavg=0.5)

    cpglim = cpg    #min CpG dinucleotide cutoff
    gclim  = gcavg  #min avg GC content 
    
    obs = CpG_windows(positions, refseq, window=window, step=step, noslide=noslide)
    exp = CpG_windows_expected(positions, refseq, window=window, step=step, noslide=noslide)
    avg = gc_windows(positions, refseq, window=window, step=step, noslide=noslide)
    
    exp = map(x->round.(x, digits=4), exp)
    avg = map(x->round.(x, digits=4), avg)

    oe = Vector{Float64}[]

    for i in eachindex(obs)
        ratio = round.( (obs[i] ./ exp[i]), digits=4)
        push!(oe, ratio)
    end

    all_cgi = Vector{Any}[]
    
    for i in eachindex(oe)
        cgi = Int64[]
        for j in eachindex(oe[i])
            if oe[i][j] > cpglim && avg[i][j] > gclim 
                push!(cgi, 1)                    
            else
                push!(cgi,0)
            end
        end
        push!(all_cgi, cgi)
    end
    
    return (oe, avg, all_cgi)  

end
