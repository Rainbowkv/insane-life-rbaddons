CREATE TABLE IF NOT EXISTS donator (
    `license` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
    `coins` INT(11) NOT NULL DEFAULT 0,
    UNIQUE INDEX `license` (`license`) USING BTREE
);

CREATE TABLE IF NOT EXISTS donator_transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    license VARCHAR(50) NOT NULL,
    player_name VARCHAR(100) NOT NULL,      -- 记录 QBCore 中玩家的姓名
    description TEXT NOT NULL,
    amount INT NOT NULL,
    operator VARCHAR(50) NOT NULL,         -- 系统 / 管理员的 identifier
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);