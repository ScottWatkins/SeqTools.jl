"""
    readfasta(file::String)

Read a disk file of fasta sequence and return a named tuple of sequences.
(Remember to end with ; when reading large files \U1F601)
"""
function readfasta(file::String)
    open(file) do f
        a = [i for i in eachline(f)]
        chr = Array{Symbol,1}()
        seq = Array{String,1}()
        for i in 1:length(a) - 1
            if i % 2 == 0
                continue
            end
            c = split(a[i], r">|\s+|\||,|\t")
            c = Symbol(c[2])
            push!(chr, c)
            push!(seq, a[i+1])
        end
        chr = Tuple(chr)
        fs = NamedTuple{chr}(seq)
        return fs
    end
end


    
