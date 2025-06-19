CREATE TABLE player_sessions (
    id INT NOT NULL AUTO_INCREMENT,
    citizenid VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    src INT NOT NULL,
    login_time DATETIME NOT NULL,
    drop_time DATETIME NOT NULL,
    PRIMARY KEY (id)
);