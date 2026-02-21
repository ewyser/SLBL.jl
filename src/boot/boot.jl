# include dependencies
using Revise,Pkg,Test
using Plots,LaTeXStrings,ProgressMeter,REPL.TerminalMenus
using LinearAlgebra
using JLD2,HDF5
using UnifiedBackend
import ArchGDAL as gdal


# include types
include(joinpath(SRC,"boot/include.jl"))
sucess = superInc(["boot/needs/types"]; root=SRC)

# create primitive structs
info = Self(
    sys = System(
        root = SRC,
	    out  = joinpath(dirname(SRC),"dump"),
	    test = joinpath(dirname(SRC),"test"),
    ), 
    ui = UI(), 
    bckd = UnifiedBackend.get_backend(), 
) 

# include .jl files
lists = ["io","core",]
@info join(superInc(lists; root=SRC, lib=info.sys.lib),"\n")