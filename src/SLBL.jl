module SLBL

# define module location as const
const SRC = @__DIR__

# include boot file
include(joinpath(SRC,"boot/boot.jl"))

function __init__()
    println("Hello there, welcome to SLBL.jl! This is a work in progress, so expect some bugs and missing features. If you want to contribute, please check out the GitHub repository and feel free to submit issues or pull requests.")
end

end
