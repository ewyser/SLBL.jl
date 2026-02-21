function import_data(data::Data{S,F}; warp::Any=nothing) where {S <: File, F <: Grid}
    proj = get_proj(data)
    if isnothing(warp)
        data = get_data(data)
    else
        for field ∈ ["LL","LR","UL","UR"]
            proj[field] = warp[field]
        end
        warped,proj = warp_data(data, proj)                
    end
    return Dict(
        "warp" => warp["temporal"],
        "data" => warped,
    )
end

function import_data(data::Data{S,F}; warp::Any=nothing) where {S <: File, F <: Polygon}
    return nothing
end
