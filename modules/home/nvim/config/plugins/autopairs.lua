require('nvim-autopairs').setup({
    check_ts = true, 
    fast_wrap = {
        map = '<M-e>', -- Alt+e
        chars = {'(', '[', '{', '"', "'", "`"},  
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),  
        end_key = '$',
    },
    ignored_next_char = '[%w%.]',  -- Ignora caratteri specifici
})