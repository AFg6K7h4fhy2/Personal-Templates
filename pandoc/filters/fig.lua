







-- function Div(el)
--   if el.classes[1] == "iimage" then
--     local content = pandoc.Pandoc(el.content)
--     local latexContent = pandoc.write(content, "latex")
--     local latexString = "\\begin{iimage}\n" .. latexContent .. "\\end{iimage}\n"
--     return pandoc.RawBlock("latex", latexString)
--   end
-- end






-- -- Works for just images
function Image(elem)
    -- Set default width and height
    local width = '1.0\\textwidth'
    local height = '0.85\\textheight'

    -- Generate LaTeX string for image inclusion
    local latexString = string.format(
      "\\includegraphics[width=%s,height=%s,keepaspectratio]{%s}",
      width, height, elem.src)

    -- For LaTeX output, return a RawInline element with the LaTeX code
    if FORMAT:match 'latex' then
        return pandoc.RawInline('latex', latexString)
    end

    -- Otherwise, return the unmodified element
    return elem
end
