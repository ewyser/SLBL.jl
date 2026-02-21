export slbl
function slbl(
    altimetry::Data{S,F <: RasterGeometry},
    landslide::Data{S,F <: VectorGeometry};     
    zmax     ::Real, 
    L        ::Real; 
    C        ::Real=-1,
    ϵ        ::Real=-1
    ) where {S <: File}
    


    indices = new_mask(landslide, import_data(altimetry; )["proj"]; )
    
    return indices
end