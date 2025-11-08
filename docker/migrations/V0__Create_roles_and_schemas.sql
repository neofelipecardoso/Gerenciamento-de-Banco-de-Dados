CREATE SCHEMA staging;
GO
CREATE SCHEMA dw;
GO
CREATE SCHEMA analytics;
GO

CREATE ROLE architect;
CREATE ROLE engineer;
CREATE ROLE analyst;
GO

GRANT ALTER, CONTROL ON SCHEMA::staging TO architect;
GRANT ALTER, CONTROL ON SCHEMA::dw TO architect;
GRANT ALTER, CONTROL ON SCHEMA::analytics TO architect;
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::staging TO engineer;
GRANT SELECT, INSERT, UPDATE ON SCHEMA::dw TO engineer;
GO

GRANT SELECT ON SCHEMA::dw TO analyst;
GRANT SELECT ON SCHEMA::analytics TO analyst;
GRANT CREATE VIEW TO analyst;
GRANT ALTER ON SCHEMA::analytics TO analyst;
GO

CREATE LOGIN architect_user WITH PASSWORD = 'Architect@Pass123!';
CREATE LOGIN engineer_user WITH PASSWORD = 'Engineer@Pass123!';
CREATE LOGIN analyst_user WITH PASSWORD = 'Analyst@Pass123!';
GO

CREATE USER architect_user FOR LOGIN architect_user;
CREATE USER engineer_user FOR LOGIN engineer_user;
CREATE USER analyst_user FOR LOGIN analyst_user;
GO

ALTER ROLE architect ADD MEMBER architect_user;
ALTER ROLE engineer ADD MEMBER engineer_user;
ALTER ROLE analyst ADD MEMBER analyst_user;
GO

