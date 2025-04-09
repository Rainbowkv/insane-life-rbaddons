Config = {}
Config.Locale = 'en'

 -- You don't have to sum to sum the chances of all of the prices to 100. The totel will be decided based on the
 -- <chance of one price>/<total of all prices>. e.g. Price: 'Common' has a chance of '50' and the total of all chances is 100, so 50/100 (50%)
 -- chance of packing common. You may add as many prices as you want. Follow the preset logic.
 Config.Prices = {
  Nothing = {
    chance = 50,
    message = '很遗憾，你什么都没赢到，有得必有失。',
    price = {
      price_money = 0,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Common = {
    chance = 20,
    message = '你赢得了一张新的刮刮卡！也许这次你会赢大奖？',
    price = {
      price_money = 0,
      item = {
        price_is_item = true,
        item_name = 'scratch_ticket',
        item_label = '刮刮卡',
        item_amount = 1
      }
    }
  },
  Rare = {
    chance = 17,
    message = '你赢了！去买点值$200的好东西奖励自己吧！',
    price = {
      price_money = 200,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Epic = {
    chance = 10,
    message = '你大获全胜！+$700！',
    price = {
      price_money = 700,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Legendary = {
    chance = 3,
    message = '传奇级大奖！你赢得了$1000！',
    price = {
      price_money = 1000,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  }
}

Config.Webhooks = {
  webhooksEnabled = false, -- enable/disable webhooks. Place your 'Discord WEBHOOK URL' in server/s_webhooks.lua:1
  logProperties = {
    possibleCheatingAttempt = true, -- will trigger on possible cheating attempt
    winMessages = true, -- will trigger on win (both money and item)
    loseMessages = false, -- will trigger on lose
    earlyMessage = false -- will trigger if person doesn't fully scratch ticket
  },
}

Config.ScratchCooldownInSeconds = 3 -- Cooldown in SECONDS, when will player be able to scratch another ticket? If below 30 will show notification until timer finished
Config.ShowCooldownNotifications = true -- Show a notification to player with the remaining cooldown timer
Config.ShowUsedTicketNotification = false  -- Show a notification to player whenever a ticket is used
Config.ShowResultTicketNotification = true  -- Show a notification with message of price ticket. See Config.Prices.message
Config.ScratchAmount = 50    -- Percentage of the ticket that needs to be scrapped away for the price to be 'seen'
