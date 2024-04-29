-- Define a global table to hold all links
local links = {}

-- Function to capture links and store them in a table
function Link(el)

    -- Add link URL to the global links table
    table.insert(links, el.target)
    -- Return the link unchanged
    return el

end


-- Function to convert the collected links into a bullet list
function links_to_list(links)
    local items = {}
    for _, url in ipairs(links) do
        local escaped_url = url:gsub("#", "\\#")
        escaped_url = escaped_url:gsub("%$", "\\$")
        escaped_url = escaped_url:gsub("_", "\\_")
        escaped_url = escaped_url:gsub("&", "\\&")
        -- escaped_url = escaped_url:gsub("%%", "\\%")
        local latex_link = "\\href{" .. url .. "}{" .. escaped_url .. "}"
        -- Create a Pandoc element for the LaTeX link
        local link_element = pandoc.RawInline('latex', latex_link)
        -- Add the link element to the list of items
        table.insert(items, pandoc.Plain({link_element}))
    end
    -- Create a bullet list containing the links
    return pandoc.BulletList(items)
end


-- Function to replace the placeholder with the list of links
function RawBlock(el)
    if el.text:match'\\listoflinks' then
        if #links > 0 then
            -- Convert the collected links to a bullet list
            local list_of_links = links_to_list(links)
            -- Create a block element to hold the list
            local div = pandoc.Div(list_of_links, {id = "list-of-links"})
            return div
        else
            -- If no links were collected, replace the command with a notice
            return pandoc.Para("No links collected.")
        end
    end
end

-- Ensure that the RawBlock function is applied to both Block and Inline contexts
return {
    {Link = Link, RawBlock = RawBlock}
}


-- -- Define a global table to hold all links
-- local links = {}

-- function Link(el)
--   -- Add link URL to the global links table
--   table.insert(links, el.target)
--   return el
-- end

-- function links_to_list(links)
--   local items = {}
--   for _, url in ipairs(links) do
--     table.insert(items, pandoc.Plain(pandoc.Link(url, url)))
--   end
--   return pandoc.BulletList(items)
-- end

-- -- Replace the placeholder with the list of links
-- function RawBlock(el)
--   if el.text:match'\\listoflinks' then
--     if #links > 0 then
--       -- Convert the collected links to a BulletList
--       local list_of_links = links_to_list(links)
--       -- Create a block to hold the list
--       local div = pandoc.Div(list_of_links, {id = "list-of-links"})
--       return div
--     else
--       -- If no links were collected, replace the command with an empty string or a notice
--       return pandoc.Para("No links collected.")
--     end
--   end
-- end

-- -- Ensure that the RawBlock function is applied to both Block and Inline contexts
-- return {
--   {Link = Link, RawBlock = RawBlock, RawInline = RawBlock}
-- }
