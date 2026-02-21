function get_data(data::Data{S,F}) where {S <: File, F <: RasterGeometry}
    # import gridded data as dataset
    ds    = gdal.read(data.location.path)
    # data processing
    nband = gdal.nraster(ds)
    band  = gdal.getband(ds,1)
    return Array(band)
end