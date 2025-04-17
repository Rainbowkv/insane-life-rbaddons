Config.Multifrec = {
    ["特殊单位"] = {
        "特殊频道1",
    },
    ["郡县警察"] = {
        "LSSD频道1",
    },
    ["市区警察"] = {
        "LSPD频道1",
    },
    ["医护单位"] = {
        "市区医护",
    },
}

Config.ButtonsMultiFreq = {
    ["BROADCAST SAFD"] = {
        "医护单位"
    },
    ["BROADCAST SAPD"] = {
        "特殊单位", "郡县警察", "市区警察"
    }
}

Config.BindFreqs = {
    ["talk-to-central"] = {"central"},
    ["talk-waiting-assignment"] = {"esperando-asignacion"},
    ["talk-police-station"] = {"comisaria"},
    ["talk-tacs"] = {"tac-01", "tac-02", "tac-03", "tac-04"},
    ["broadcast-special-units"] = {"SPECIAL UNITS"}
}

Config.MegaphoneVoiceDist = 75.0 -- The distance that the voice of the megaphone will be heared

exports("GetPoliceRadioBinds", function()
    return Config.BindFreqs
end)

exports("GetPoliceRadioChannels", function()
    return Config.Multifrec
end)

exports("GetPoliceRadioButtons", function()
    return Config.ButtonsMultiFreq
end)

Config.RequestsTime = 10 -- Minutos

-- DONT TOUCH THIS

function GetCategoryFreqs(category)
    local list = Config.Multifrec[category]
    if not list then
        print("Category not found: " .. category .. " in Config.Multifrec")
        return {}
    end
    local freqs = {}
    for _, v in pairs(list) do
        table.insert(freqs, v)
    end
    return freqs
end

local nextButtonMultiFreqUpdate = {}
for buttonName, categories in pairs(Config.ButtonsMultiFreq) do
    for _, category in pairs(categories) do
        for _, v in pairs(GetCategoryFreqs(category)) do
            if nextButtonMultiFreqUpdate[buttonName] == nil then
                nextButtonMultiFreqUpdate[buttonName] = {}
            end
            nextButtonMultiFreqUpdate[buttonName][#nextButtonMultiFreqUpdate[buttonName] + 1] = v
        end
    end
end

local newBindFreqs = {}
for button, freqs in pairs(Config.BindFreqs) do
    for _, freq in pairs(freqs) do
        if Config.Multifrec[freq] then
            for _, freq2 in pairs(Config.Multifrec[freq]) do
                newBindFreqs[button] = newBindFreqs[button] or {}
                table.insert(newBindFreqs[button], freq2:lower())
            end
        else
            newBindFreqs[button] = newBindFreqs[button] or {}
            table.insert(newBindFreqs[button], freq)
        end
    end
end

for button, freqs in pairs(newBindFreqs) do
    table.insert(Config.BindFreqs[button], freqs)
end

Config.ButtonsMultiFreq = nextButtonMultiFreqUpdate