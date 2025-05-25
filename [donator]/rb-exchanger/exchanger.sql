CREATE TABLE IF NOT EXISTS coins_exchanger (
  id INT AUTO_INCREMENT PRIMARY KEY,
  citizenid VARCHAR(50) NOT NULL,
  amount INT NOT NULL, -- 赞助点数量
  price INT NOT NULL, -- 售价（美金）
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);