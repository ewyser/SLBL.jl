"""
    import_data(data::Data{S,F}; warp::Any=nothing) where {S <: File, F <: RasterGeometry}

Imports raster data and its georeferencing information from a `Data` object. Optionally applies a warp (spatial transformation) if provided.

# Arguments
- `data::Data{S,F}`: The raster data object to import (must be a `File` and `RasterGeometry`).
- `warp::Any`: (Optional) A dictionary specifying warp parameters. If not provided, no warping is applied.

# Returns
- `Dict`: A dictionary containing the raster data and projection information. If warping is applied, includes the warped data and temporal warp info.

# Example
```julia
data = new_data(File("/path/to/file.tif"))
result = import_data(data)
```
"""
function import_data(data::Data{S,F}; warp::Any=nothing) where {S <: File, F <: RasterGeometry}
    proj = get_proj(data)
    if isnothing(warp)
        data = get_data(data)
        return Dict(
            "proj" => proj,
            "data" => data,
        )
    else
        for field ∈ ["LL","LR","UL","UR"]
            proj[field] = warp[field]
        end
        warped,proj = warp_data(data, proj)                
        return Dict(
            "warp" => warp["temporal"],
            "data" => warped,
        )
    end

end

function import_data(data::Data{S,F}; warp::Any=nothing) where {S <: File, F <: VectorGeometry}
    return nothing
end
