export Self

Base.@kwdef mutable struct System
	root::String = " "
	out ::String = " "
	test::String = " "
	lib ::Dict   = Dict()
    ncell::Int   = 0
end
Base.@kwdef mutable struct UI
	ui    ::Bool       = true
    plot  ::Bool       = true
    bckd  ::Bool       = true 
    logs  ::NamedTuple = (; log_info = true, log_warn = true, log_error = true) 
end
Base.@kwdef mutable struct Self
	sys ::System
	ui  ::UI
	bckd::UnifiedBackend.Backend
end