-- table-adjust.lua
function Table(el)
    -- Check if the table has headers and calculate the column count appropriately
    local column_count = 0
    if el.headers and #el.headers > 0 then
      for _, header in ipairs(el.headers) do
        if header and #header > 0 then
          column_count = column_count + 1
        end
      end
    else
      -- Fallback to using the first row to determine the number of columns if headers are not available
      if el.rows and #el.rows > 0 then
        for _, cell in ipairs(el.rows[1]) do
          if cell and #cell > 0 then
            column_count = column_count + 1
          end
        end
      end
    end

    if column_count == 0 then
      return nil -- Return nil to avoid processing tables without detectable columns
    end

    -- Prepare the LaTeX code for adjusting the table size and wrapping text
    local latex_start = '\\begin{adjustbox}{width=\\textwidth}\\begin{tabularx}{\\textwidth}{'
    local latex_end = '\\end{tabularx}\\end{adjustbox}'

    local header_spec = {}

    for i = 1, column_count do
      table.insert(header_spec, 'X')
    end

    local align_spec = table.concat(header_spec, " | ")
    latex_start = latex_start .. align_spec .. '}'

    -- Insert the LaTeX start code before the table and the end code after it
    return {
      pandoc.RawBlock('latex', latex_start),
      el,
      pandoc.RawBlock('latex', latex_end)
    }
  end
