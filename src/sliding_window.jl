"""
    sliding_window(seq, window_size, step_size, operation)

Perform an operation on sequential windows of a DNA sequence. Return the results of the operation in an array.
"""
function sliding_window(seq::String, window::Int64, step::Int64, op::Function)

    s::Int64 = 1
    w::Int64 = window
    e::Int64 = w
    a::Int64 = step
    
    results = []

    while e <= length(seq)
        subseq = seq[s:e]
        s = s + (w - (w - a))
        e = e + (w - (w - a))
        r = op(subseq)
        push!(results, r)
    end

    return results

end
