--
-- EXECUTE THIS SCRIPT FROM THE COMMAND LINE
-- USING AN ADMINISTRATIVE MYSQL USER.
--
--   $ mysql -u root -p < create.sql
--
-- Creates a database and a user with all privileges
-- on that database for the project.
--
-- Included in the application here for completeness.
--

DROP SCHEMA IF EXISTS `AkshayBookstoreDB`;
CREATE SCHEMA IF NOT EXISTS `AkshayBookstoreDB`
    DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE USER IF NOT EXISTS 'akshayreddy'@'%' IDENTIFIED BY '4304';
GRANT ALL PRIVILEGES ON AkshayBookstoreDB.* to 'akshayreddy'@'%';
FLUSH PRIVILEGES;