function get_proj(data::Data{S,F}) where {S <: File, F <: RasterGeometry}
    # import gridded data
    ds    = gdal.read(data.location.path)
    # data processing
    nx,ny = gdal.width(ds),gdal.height(ds)
    gt    = gdal.getgeotransform(ds)
    crs   = gdal.getproj(ds)
    proj4 = gdal.toPROJ4(gdal.importWKT(crs))
    dx,dy = gt[2],gt[6]
    xO,yO = gt[1],gt[4]
    xv    = collect(range(xO       ,xO+dx*nx,step=dx))
    yv    = collect(range(yO       ,yO+dy*ny,step=dy))
    xc    = collect(range(xO+dx/2.0,xO+dx*nx,step=dx))
    yc    = collect(range(yO+dy/2.0,yO+dy*ny,step=dy))
    return Dict(
        "proj4" => proj4,
        #"srid"  => srid,
        "size"  => [nx,ny],
        "res"   => [dx,dy],
        "xv"    => xv,
        "yv"    => yv,
        "xc"    => xc,
        "yc"    => yc,
        "LL"    => [minimum(xv),minimum(yv)],
        "LR"    => [maximum(xv),minimum(yv)],
        "UL"    => [minimum(xv),maximum(yv)],
        "UR"    => [maximum(xv),maximum(yv)],
    )
end
