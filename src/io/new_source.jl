export new_source
"""
    new_source(path::String; type::Symbol=:file)

Creates an `AbstractSource` object from a given path. 
Currently supports `:file` type, but can be extended for other source types.

# Arguments
- `path::String`: The path to the data source (e.g., file path).
- `type::Symbol`: The type of source to create (`:file`, `:database`, etc.).

# Returns
- `AbstractSource`: An instance of the appropriate source type.
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