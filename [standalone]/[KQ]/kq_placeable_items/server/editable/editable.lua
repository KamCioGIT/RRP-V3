local sqlDriver = Config.sql.driver


function SqlFetch(query, data)
    if sqlDriver == 'mysql' then
        return MySQL.Sync.fetchAll(query, data or {})
    end

    if sqlDriver == 'oxmysql' then
        if Config.sql.newOxMysql then
            return exports[sqlDriver]:fetchSync(query, data)
        end
        return exports[sqlDriver]:query_async(query, data)
    else
        return exports[sqlDriver]:executeSync(query, data)
    end
end

function SqlInsert(query, data)
    if sqlDriver == 'mysql' then
        MySQL.Sync.insert(query, data)
        return
    end

    if sqlDriver == 'oxmysql' then
        exports[sqlDriver]:insertSync(query, data)
    else
        exports[sqlDriver]:executeSync(query, data)
    end
end
