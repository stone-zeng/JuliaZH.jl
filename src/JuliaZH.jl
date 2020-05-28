module JuliaZH

import Base.Docs: DocStr

const keywords = Dict{Symbol, DocStr}()

const mirrors = Dict{String, String}()

mirrors["BFSU"] = "https://mirrors.bfsu.edu.cn/julia/static"
mirrors["default"] = "https://pkg.julialang.org"

function set_mirror(mirror_name="BFSU")
    ENV["JULIA_PKG_SERVER"] = mirrors[mirror_name]
    return
end

function __init__()
    # set to Chinese env by default
    ENV["REPL_LOCALE"] = "zh_CN"
    set_mirror("BFSU")
    if ccall(:jl_generating_output, Cint, ()) == 0
        include(joinpath(@__DIR__, "i18n_patch.jl"))
        include(joinpath(@__DIR__, "basedocs.jl"))
    end
end

end # module
