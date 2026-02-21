export new_source
"""
    new_source(input::Any)

Creates an `AbstractSource` object from a given input, which can be a file path, URL, or other supported source type.
Currently, supports local files and URLs (http/https). Can be extended for other source types.

# Arguments
- `input::Any`: The input to create the source from (typically a String path or URL).

# Returns
- `AbstractSource`: An instance of the appropriate source type (e.g., `File`).
"""
function new_source(input::Any)
    function isurl(input::String)
        return occursin(r"^https?://", input)
    end

    if isfile(input)
        return File(input)
    elseif isurl(input)
        # path = joinpath(info.sys.out, basename(input))
        download(input)
        return URL(input)
    else
        error("Input $(input) is not a recognized file path or URL.")
    end
end