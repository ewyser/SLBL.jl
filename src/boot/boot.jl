# include dependencies
using Revise,Pkg,Test
using Plots,LaTeXStrings,ProgressMeter,REPL.TerminalMenus
using LinearAlgebra
using JLD2,HDF5
using UnifiedBackend
import ArchGDAL as gdal


# include types &
include(joinpath(SRC,"boot/include.jl"))
sucess = superInc(["boot/needs/types"]; root=SRC)