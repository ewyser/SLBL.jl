export new_data
"""
    new_data(source::AbstractSource; label::String="")

Constructs a `Data` object from a given `AbstractSource` (such as a `File`).
This function extracts the file extension, determines the appropriate format (e.g., raster or vector), and initializes a `Data` struct with the provided label and default attributes.

This function is extensible: add more formats to the internal Dict as needed. If the file extension is not recognized, a KeyError will be thrown.

# Arguments
- `source::AbstractSource`: The data source to wrap in a `Data` object (e.g., a `File`).
- `label::String`: (Optional) A descriptive label for the data (e.g., "Altimetric data").

# Returns
- `Data`: A fully constructed `Data` object with the correct types and metadata.

# Example
```julia
source = File("/path/to/file.tif")
data = new_data(source; label="DEM")
```
"""
function new_data(source::S; label::String="") where {S <: AbstractSource} 
    function find_extension(path::String)
        return path[findlast(==('.'), path)+1:end]
    end
    function find_format(ext::String)
        formats = Dict(
            "tif" => RasterGeometry("tif"),
            "shp" => VectorGeometry("shp"),
        )
        return formats[ext]
    end
    format    = find_format(find_extension(source.path))
    attribute = String[]
    warp      = Dict{String,Any}()

    return Data{typeof(source), typeof(format)}(location=source, format=format, attribute=attribute, warp=warp, label=label)
end

