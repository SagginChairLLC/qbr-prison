Config = {}

Config.RemoveJob = true -- If true then player loses job once jailed.

Config.JailMenukey = 0xF3830D8E -- J

Config.JailMenu = {
{name = 'Jail Menu',   injail = "x",	coords = vector3(3371.02, -658.29, 46.27),    blip = false},
}

Config.PackagingTime = math.random(30000,45000)
Config.PrisonJobs = {
    {name = 'Apples', jobType = "apple",	coords = vector3(3352.91, -688.71, 44.09),	showblip = true},
    {name = 'Hay',	  jobType = "hay",	coords = vector3(3343.91, -706.63, 44.22),	showblip = true},
}

Config.Locations = {
    ["outside"] = {
        coords = vector4(2930.21, -1204.08, 43.22, 110.87)
    },
    ["middle"] = {
        coords = vector4(3357.41, -679.26, 46.26, 165.59)
    },
    ["shop"] = {
        coords = vector4(3371.02, -658.29, 46.27, 299.74)
    },
    spawns = {
        [1] = {
            coords = vector4(3330.66, -692.75, 43.95, 292.86)
        },
        [2] = {
            coords = vector4(3349.62, -650.41, 45.38, 207.53)
        },
        [3] = {
            coords = vector4(3380.62, -672.35, 46.27, 110.95)
        },
        [4] = {
            coords = vector4(3366.75, -666.08, 46.34, 297.69)
        }
    }
}

Config.CanteenItems = {
    [1] = {
        name = "sandwich",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 1
    },
    [2] = {
        name = "water_bottle",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 2
    }
}
