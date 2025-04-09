function getTimestamp()
    local meridiem = '上午'
    year , month , day , hour , minute , second = ''
    if GetGameName() == 'fivem' then
        year , month , day , hour , minute , second = GetLocalTime()
    elseif GetGameName() == 'redm' then
        year , month , day , hour , minute , second = GetPosixTime()
    end
    if hour < 5 then
        meridiem = '凌晨'
    end
    if hour >= 13 then
        if hour >=19 then
            meridiem = '晚上'
        else
            meridiem = '下午'
        end
        hour = hour - 12
    end
    if hour == 12 then
        meridiem = '中午'
    end
    if minute <= 9 then
        minute = '0' .. minute
    end
    timestamp = hour .. ':' .. minute .. ' ' .. meridiem
    return timestamp
end

exports('getTimestamp', getTimestamp)