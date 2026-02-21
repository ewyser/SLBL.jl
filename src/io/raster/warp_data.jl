"""
    warp_data(data::Data{S,F}, extent::Dict) where {S <: File, F <: RasterGeometry}

Warps (reprojects and resamples) raster data to a new extent and resolution using GDAL.

# Arguments
- `data::Data{S,F}`: The raster data object to warp (must be a `File` and `RasterGeometry`).
- `extent::Dict`: Dictionary specifying the new extent and resolution (keys: "LL", "UR", "res").

# Returns
- `Array`: The warped raster data as a Julia array.
- `Dict`: The updated projection and georeferencing information.

# Example
```julia
data = new_data(File("/path/to/file.tif"))
extent = Dict("LL" => [xmin, ymin], "UR" => [xmax, ymax], "res" => [dx, dy])
warped, proj = warp_data(data, extent)
```
"""
function warp_data(data::Data{S,F},extent::Dict) where {S <: File, F <: RasterGeometry}
    instr = ["-te","$(extent["LL"][1])","$(extent["LL"][2])","$(extent["UR"][1])", "$(extent["UR"][2])","-tr","$(extent["res"][1])","$(extent["res"][2])","-r","max"]
    # warping
    warped_data = nothing
    warped_proj = Dict()
    
    gdal.read(data.location.path) do source
        gdal.gdalwarp([source],instr) do warped
            # Get projection info from warped raster
            nx, ny = gdal.width(warped), gdal.height(warped)
            gt = gdal.getgeotransform(warped)
            crs = gdal.getproj(warped)
            proj4 = gdal.toPROJ4(gdal.importWKT(crs))
            dx, dy = gt[2], gt[6]
            xO, yO = gt[1], gt[4]
            
            xv = collect(range(xO, xO + dx * nx, step=dx))
            yv = collect(range(yO, yO + dy * ny, step=dy))
            xc = collect(range(xO + dx/2.0, xO + dx * nx, step=dx))
            yc = collect(range(yO + dy/2.0, yO + dy * ny, step=dy))
            
            warped_proj = Dict(
                "proj4" => proj4,
                "size"  => [nx, ny],
                "res"   => [dx, dy],
                "xv"    => xv,
                "yv"    => yv,
                "xc"    => xc,
                "yc"    => yc,
                "LL"    => [minimum(xv), minimum(yv)],
                "LR"    => [maximum(xv), minimum(yv)],
                "UL"    => [minimum(xv), maximum(yv)],
                "UR"    => [maximum(xv), maximum(yv)],
            )
            
            # Store warped data
            warped_data = Array(gdal.getband(warped, 1))
        end
    end
    return warped_data,warped_proj
end