"""
    readfasta(file::String);

Read a disk file of fasta sequence and return a named tuple of sequences.
Sequence names will be the first field of the id line, which is space, tab, comma, and pipe delimited. For instance: >2 sample2|Jun4,2021 will be named "2".
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

            if !occursin(r"^>", a[i])
                error("Fasta file is not properly formatted: Line $i")
            end
            
            c = split(a[i], r">|\s+|\||,|\t")

            if length(c) < 2
                continue
            end

            c = Symbol(c[2])
            push!(chr, c)
            push!(seq, a[i+1])

        end

        chr = Tuple(chr)
        fs = NamedTuple{chr}(seq)

        return fs

    end
end
