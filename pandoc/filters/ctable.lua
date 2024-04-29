function Div(el)
    if el.classes[1] == "ctable" then
      -- Prepare the LaTeX tabularx environment header.
      local latexHeader = "\\begin{table}[htbp]\\centering\\begin{tabularx}{\\textwidth}{|X|X|X|X|X|X|X|X|}\\hline"
      local latexFooter = "\\hline\\end{tabularx}\\end{table}"

      -- Convert the div's content (assumed to be a Markdown table) to LaTeX.
      local content = pandoc.utils.stringify(el)
      local latexTable = pandoc.pipe("pandoc", {"-f", "markdown", "-t", "latex"}, content)

      -- Replace the Pandoc-generated table environment with tabularx environment.
      latexTable = latexTable:gsub("\\begin{longtable}", latexHeader)
      latexTable = latexTable:gsub("\\end{longtable}", latexFooter)

      -- Use raw LaTeX block to ensure proper rendering.
      return pandoc.RawBlock("latex", latexTable)
    end
  end

function Div(el)
    if el.classes[1] == "ctable" then
        local content = pandoc.Pandoc(el.content)
        local latexContent = pandoc.write(content, "latex")
        local latexString = "\\begin{ctable}\n" .. latexContent .. "\\end{ctable}\n"
        return pandoc.RawBlock("latex", latexString)
    end
end
