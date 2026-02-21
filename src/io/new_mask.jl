"""
    new_mask(data::Data{S,F}, baseline::Dict; save=false) where {S <: File, F <: VectorGeometry}

Rasterizes a vector layer to create a binary mask (1 for features, 0 elsewhere) using the provided baseline georeferencing.
If `save=true`, the mask is saved as a GeoTIFF file; otherwise, it is created in memory.

# Arguments
- `data::Data{S,F}`: The vector data to rasterize (must be a File and VectorGeometry).
- `baseline::Dict`: Dictionary containing georeferencing info (keys: "res", "LL", "UR").
- `save::Bool`: If true, saves the mask to disk as a GeoTIFF; if false, keeps it in memory (default: false).

# Returns
- `Vector{Tuple{Int32,Int32}}`: Indices of raster cells where the mask is 1 (feature present).
"""
function new_mask(data::Data{S,F},baseline::Dict; save=false) where {S <: File, F <: VectorGeometry}
    res,LL,UR = baseline["res"],baseline["LL"],baseline["UR"]
    options   = ["-burn", "1",
        "-tr", "$(abs(res[1]))", "$(abs(res[2]))",
        "-a_nodata", "0",
        "-te", "$(LL[1])", "$(LL[2])", "$(UR[1])", "$(UR[2])",
        "-ot", "Int32",
        "-of", "GTiff"
    ]
    mask = gdal.read(data.location.path) do ds
        if save
            name   = "$(first(split(basename(data.location.path),"."))).tif"
            raster = gdal.unsafe_gdalrasterize(ds,options; dest=name)
        else
            raster = gdal.unsafe_gdalrasterize(ds,options)
        end
        return Array(gdal.getband(raster,1))
    end
    k,indices = 0,Vector{Tuple{Int32,Int32}}(undef,count(==(1), mask))
    for col ∈ axes(mask,2)
        for row ∈ axes(mask,1)
            if mask[row,col] == 1
                k += 1
                indices[k] = (Int32(row),Int32(col))
            end
        end
    end
    return indices
end
