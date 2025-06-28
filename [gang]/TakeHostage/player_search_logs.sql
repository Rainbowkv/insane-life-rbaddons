CREATE TABLE IF NOT EXISTS player_search_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    searcher_id VARCHAR(10) NOT NULL,      -- 背包ID，例如 player:ABCDE12345
    be_searched_id VARCHAR(10) NOT NULL,   -- 被搜身玩家背包ID
    item_name VARCHAR(20) NOT NULL,        -- 拿走的物品名称
    amount INT NOT NULL,                    -- 拿走的数量
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP  -- 操作时间
);