export File, URL, DB
export Grid, Polygon    
export Data, DataSet

struct File <: AbstractSource
    path::String
end
struct DB <: AbstractSource 

end

struct URL <: AbstractSource 

end

struct RasterGeometry <: AbstractGeometry
    ext::String
end

struct VectorGeometry <: AbstractGeometry
    ext::String
end


Base.@kwdef mutable struct Data{S<:AbstractSource, F<:AbstractFormat}
    location  ::Union{S, Nothing} = nothing
    format    ::Union{F, Nothing} = nothing
    attribute ::Vector{String}    = String[]
    warp      ::Dict{String,Any}  = Dict{String,Any}()
    label     ::String            = ""
end

Base.@kwdef mutable struct DataSet{S<:AbstractSource}
    altimeteric  ::Union{Data{S, <:AbstractFormat}, Nothing} = nothing
    landslide    ::Union{Data{S, <:AbstractFormat}, Nothing} = nothing
end
function DataSet{S}(from::Dict, extent::Dict) where {S<:File}
    return nothing
end