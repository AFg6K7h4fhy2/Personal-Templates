function Link(el)
  -- Check if the link is to GitHub
  if el.target:find("wikipedia.org") then
    -- Define the path to the converted GitHub icon in PDF format
    local icon_path = "../../templates/pandoc/styles/logos/wiki.pdf"
    -- LaTeX command to insert, resize, and raise the icon
    -- Note: Adjusting the horizontal shift (e.g., \hspace{-1em}) may be needed
    local latexString = "\\raisebox{0.2em}{\\hspace{-0.5em}\\includegraphics[height=0.75em,width=0.75em]{" .. icon_path .. "}}"
    -- Append the icon to the link text with a preceding space for separation
    table.insert(el.content, pandoc.Space())
    table.insert(el.content, pandoc.RawInline('latex', latexString))
  end
  return el
end

-- function Link(el)
--     -- Check if the link is a Wikipedia link
--     if el.target:find("wikipedia.org") then
--       -- Define the path to Wikipedia SVG icon
--       local icon_path = "../../templates/pandoc/styles/logos/wiki.svg"
--       -- Create an image element for the icon
--       local icon = pandoc.Image("", icon_path)
--       icon.attributes = {width = "0.75em", height = "0.75em"}
--       -- Set the image size if desired (optional)
--       -- icon.attributes = {width = "1em", height = "1em"}
--       -- Append the icon to the link text
--       -- POSSIBLE table.insert(el.content, pandoc.Space())
--       table.insert(el.content, icon)
--     end
--     return el
--   end
