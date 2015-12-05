function pmap!(func, array)
    buffer = pmap(func, array)
    copy!(array, buffer)
end
