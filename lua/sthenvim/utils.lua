local M = {}

-- set many keys on a table in one shot
function M.tbl_set_keys(t, d)
    for k, v in pairs(d) do
        t[k] = v
    end
end

-- set key mapping
function M.fn_repeat(f, v)
    for _, a in ipairs(v) do
        f(unpack(a))
    end
end


return M
