CREATE TABLE IF NOT EXISTS black_money_transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trader VARCHAR(100),
    seller_name VARCHAR(100),
    citizen_id VARCHAR(100),
    item VARCHAR(100),
    price INT,
    amount INT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;;