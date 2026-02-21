export test
function test()

    new_source = raw"C:\Users\lili8\Documents\GitHub\SLBL.jl\data\raster\dem.tif"
    rast     = File(new_source)

    dem   = new_data(rast, label="Altimetric data")    

    vec  = File(raw"C:\Users\lili8\Documents\GitHub\SLBL.jl\data\vector\landslide.shp")
    landslide = new_data(vec, label="Landslide data")   

    proj = import_data(dem; )["proj"]



    indices = new_mask(landslide, proj; )
    
    return indices
end

#=
    rast      = File(raw"C:\Users\lili8\Documents\GitHub\SLBL.jl\data\raster\dem.tif")
    dem       = new_data(rast, label="Altimetric data")    
    vec       = File(raw"C:\Users\lili8\Documents\GitHub\SLBL.jl\data\vector\landslide.shp")
    landslide = new_data(vec, label="Landslide data")   

    indices = slbl(dem, landslide)
=#