"""
    get_data(data::Data{S,F}) where {S <: File, F <: RasterGeometry}

Reads and returns the raster data array from a `Data` object containing raster geometry.

# Arguments
- `data::Data{S,F}`: The raster data object (must be a `File` and `RasterGeometry`).

# Returns
- `Array`: The raster data as a Julia array (from the first band).

# Example
```julia
data = new_data(File("/path/to/file.tif"))
arr = get_data(data)
```
"""
function get_data(data::Data{S,F}) where {S <: File, F <: RasterGeometry}
    # import gridded data as dataset
    ds    = gdal.read(data.location.path)
    # data processing
    nband = gdal.nraster(ds)
    band  = gdal.getband(ds,1)
    return Array(band)
end