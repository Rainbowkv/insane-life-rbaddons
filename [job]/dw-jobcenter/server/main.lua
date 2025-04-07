local QBCore = exports['qb-core']:GetCoreObject()

-- Get a list of jobs for the UI
QBCore.Functions.CreateCallback('dw-jobcenter:server:getJobs', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return cb({}) end
    
    local citizenid = Player.PlayerData.citizenid
    local playerName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    
    cb(Config.Jobs, citizenid, playerName)
end)

-- Get applications for a specific job
QBCore.Functions.CreateCallback('dw-jobcenter:server:getApplications', function(source, cb, jobName)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then 
        return cb({}) 
    end
    
    -- Ensure jobName is a string
    if type(jobName) == "table" then
        jobName = Player.PlayerData.job.name
    elseif type(jobName) ~= "string" then
        jobName = Player.PlayerData.job.name
    end
    
    -- Instead of using the ORM, use direct SQL query for debugging
    local query = "SELECT * FROM job_applications WHERE job = '" .. jobName .. "' AND status = 'pending'"  -- 修改为只要status为pending的记录
    
    MySQL.query(query, {}, function(results)
        
        if not results then
            cb({})
            return
        end
        
        
        if #results == 0 then
            cb({})
            return
        end
        
        -- Print all applications
        for i=1, #results do
            -- Also check if the answers column has valid data
            if results[i].answers then
                local answers = results[i].answers
                if string.len(answers) > 0 then
                    -- Try to parse just to check validity
                    local success = pcall(function() json.decode(answers) end)
                end
            end
        end
        -- Process all applications
        for i=1, #results do
            -- Parse answers
            if results[i].answers then
                local success, parsed = pcall(function() return json.decode(results[i].answers) end)
                if success then
                    results[i].answers = parsed
                else
                    -- Fallback to showing raw answers for debugging
                    results[i].answers = {
                        { question = "Raw data (JSON parse failed)", answer = tostring(results[i].answers) }
                    }
                end
            else
                results[i].answers = {}
            end

            if results[i].date_submitted then
                local raw = tonumber(results[i].date_submitted) -- 保证是数字
                if raw and raw > 1000000000000 then -- 判断是毫秒级（大于10位数）
                    raw = math.floor(raw / 1000) -- 转换成秒
                end
                results[i].date_submitted = os.date('%Y-%m-%d %H:%M', raw)
            end
        end
        
        -- Return all applications
        cb(results)
    end)
end)

-- Handle whitelisted job applications
RegisterNetEvent('dw-jobcenter:server:applyForJob', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    local citizenid = Player.PlayerData.citizenid
    local jobName = data.job
    local playerName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local answers = data.answers
    
    -- Check if job exists and is whitelisted
    if not Config.Jobs[jobName] then
        TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "这份工作不存在", Config.NotificationTypes.error)
        return
    end
    
    if Config.Jobs[jobName].type ~= "申请制" then
        TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "这不是申请制的工作", Config.NotificationTypes.error)
        return
    end
    
    -- Format the answers for the database
    local formattedAnswers = {}
    for i, question in ipairs(Config.Jobs[jobName].questions) do
        table.insert(formattedAnswers, {
            question = question,
            answer = answers[i] or ""
        })
    end
    
    -- Insert application into database
    MySQL.insert('INSERT INTO job_applications (citizenid, job, name, answers, status, date_submitted) VALUES (?, ?, ?, ?, ?, ?)', {
        citizenid,
        jobName,
        playerName,
        json.encode(formattedAnswers),
        'pending',
        os.date('%Y-%m-%d %H:%M:%S')
    }, function(id)
        if id > 0 then
            TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "您的申请已经被提交，请耐心等待~", Config.NotificationTypes.success)
        else
            TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "提交申请失败，请重试~", Config.NotificationTypes.error)
        end
    end)
end)

-- Handle application reviews
RegisterNetEvent('dw-jobcenter:server:reviewApplication', function(applicationId, action, notes)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    -- Get application details
    MySQL.query('SELECT * FROM job_applications WHERE id = ?', {applicationId}, function(results)
        if not results or #results == 0 then
            TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "申请未找到", Config.NotificationTypes.error)
            return
        end
        
        local application = results[1]
        
        -- Check if reviewer has permission
        if Player.PlayerData.job.name ~= application.job then
            TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "您没有权限查看应聘申请", Config.NotificationTypes.error)
            return
        end
        
        -- Check reviewer grade (relaxed for debugging)
        local minGrade = Config.Jobs[application.job] and Config.Jobs[application.job].minReviewGrade or 0
        if Player.PlayerData.job.grade.level < minGrade then
            TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "您没有权限查看应聘申请", Config.NotificationTypes.error)
            return
        end
        
        -- Update application status
        local newStatus = action == 'accept' and 'accepted' or 'rejected'
        local reviewerName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        
        -- Update the application in the database
        MySQL.update('UPDATE job_applications SET status = ?, reviewer_id = ?, date_reviewed = ?, notes = ? WHERE id = ?', {
            newStatus,
            Player.PlayerData.citizenid,
            os.date('%Y-%m-%d %H:%M:%S'),
            notes or '',
            applicationId
        }, function(rowsChanged)
            if rowsChanged > 0 then
                -- If accepted, set the player's job
                if action == 'accept' then
                    local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(application.citizenid)
                    if targetPlayer then
                        -- Player is online, set job immediately
                        targetPlayer.Functions.SetJob(application.job, Config.Jobs[application.job].grade)
                        TriggerClientEvent('dw-jobcenter:client:sendNotification', targetPlayer.PlayerData.source, "您对" .. Config.Jobs[application.job].label .. "的申请已被接受，请前往报道！", Config.NotificationTypes.success)
                    else
                        -- Player is offline, update in database
                        MySQL.update('UPDATE players SET job = ?, job_grade = ? WHERE citizenid = ?', {
                            application.job,
                            Config.Jobs[application.job].grade,
                            application.citizenid
                        })
                    end
                else
                    -- If rejected, notify the player if they're online
                    local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(application.citizenid)
                    if targetPlayer then
                        TriggerClientEvent('dw-jobcenter:client:sendNotification', targetPlayer.PlayerData.source, "遗憾~您对" .. Config.Jobs[application.job].label .. "的申请已经被拒绝", Config.NotificationTypes.error)
                    end
                end
            else
                TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "更新申请表失败~", Config.NotificationTypes.error)
            end
        end)
    end)
end)

-- Handle non-whitelisted job selection
RegisterNetEvent('dw-jobcenter:server:takeJob', function(jobName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    -- Check if job exists and is not whitelisted
    if not Config.Jobs[jobName] then
        TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "该工作不存在！", Config.NotificationTypes.error)
        return
    end
    
    if Config.Jobs[jobName].type == "申请制" then
        TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "您需要先申请这份工作。", Config.NotificationTypes.error)
        return
    end
    
    -- Set player's job
    Player.Functions.SetJob(jobName, Config.Jobs[jobName].grade)
    TriggerClientEvent('dw-jobcenter:client:sendNotification', src, "您成为" .. Config.Jobs[jobName].label.."的雇员", Config.NotificationTypes.success)
end)