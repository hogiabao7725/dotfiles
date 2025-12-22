local M = {}

-- Recursively merge source table into target table (ignoring functions)
function M.merge_tables_recursive(target, source)
    for k, v in pairs(source) do
        if type(v) ~= 'function' then
            if type(v) == 'table' and type(target[k]) == 'table' then
                M.merge_tables_recursive(target[k], v)
            else
                target[k] = v
            end
        end
    end
    return target
end

return M 