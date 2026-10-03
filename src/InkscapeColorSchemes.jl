module InkscapeColorSchemes
    using FileIO
    using ColorSchemes: ColorScheme, colorschemes
    using Colors

    export InkscapeColorScheme

    const StringOrMissing = Union{String, Missing}

    struct InkscapeColorScheme{V <: AbstractVector{ColorScheme}}
        name::StringOrMissing
        colorschemes::V 
    end

    InkscapeColorScheme(arg, varargs...) = !(arg isa StringOrMissing) ? InkscapeColorScheme(missing, arg, varargs...) : error("Not reachable!")
    InkscapeColorScheme(name::StringOrMissing, v::ColorScheme...) = InkscapeColorScheme{Vector{ColorScheme}}(name, collect(v))
    InkscapeColorScheme(name::StringOrMissing, s::Symbol...) = InkscapeColorScheme{Vector{ColorScheme}}(name, collect(colorschemes[c] for c in s))
    # InkscapeColorScheme(name::Missing, s::T...) where {T<: AbstractString} = InkscapeColorScheme{Vector{ColorScheme}}(name, Symbol.(s)...)

    hasname(c::InkscapeColorScheme) = c.name isa AbstractString
    basename(f::File{format"gpl"}) = join(split(f.filename, ".")[1:end-1], ".")

    function save(f::File{format"gpl"}, data::InkscapeColorScheme)
        open(f, "w") do f
            println(f, "GIMP Palette")
            name = hasname(data) ? data.name : basename(f)
            println(f, "Name: " * name)
            println(f, "#")
            for (cidx, c) in enumerate(data.colorschemes)
                for (coloridx, color) in enumerate(c)
                    color = RGB(color)
                    println(f, join([255 * color.r, 255 * color.g, 255 * color.b, cidx, coloridx], " "))
                end
            end
        end
    end
    save(f::File{format"gpl"}, data::ColorScheme) = save(f, InkscapeColorSchemes(basename(f), data))

end
