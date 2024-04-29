function Div(el)
    if el.classes[1] == "bquote" then
      local content = pandoc.Pandoc(el.content)
      local latexContent = pandoc.write(content, "latex")
      local latexString = "\\begin{bquote}\n" .. latexContent .. "\\end{bquote}\n"
      return pandoc.RawBlock("latex", latexString)
    end
    if el.classes[1] == "bquote_alt" then
      local content = pandoc.Pandoc(el.content)
      local latexContent = pandoc.write(content, "latex")
      local latexString = "\\begin{bquote_alt}\n" .. latexContent .. "\\end{bquote_alt}\n"
      return pandoc.RawBlock("latex", latexString)
    end
  end
