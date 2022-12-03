using InkscapeColorSchemes
using Documenter

DocMeta.setdocmeta!(InkscapeColorSchemes, :DocTestSetup, :(using InkscapeColorSchemes); recursive=true)

makedocs(;
    modules=[InkscapeColorSchemes],
    authors="Martin Kunz <martinkunz@email.cz> and contributors",
    repo="https://github.com/kunzaatko/InkscapeColorSchemes.jl/blob/{commit}{path}#{line}",
    sitename="InkscapeColorSchemes.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://kunzaatko.github.io/InkscapeColorSchemes.jl",
        edit_link="trunk",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/kunzaatko/InkscapeColorSchemes.jl",
    devbranch="trunk",
)
