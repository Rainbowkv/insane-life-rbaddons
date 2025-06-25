CREATE TABLE IF NOT EXISTS rb_ranking_optin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    citizenid VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    leaderboard VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY (citizenid, leaderboard)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;