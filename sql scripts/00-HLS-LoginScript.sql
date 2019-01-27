-- This script was included for completeness
--  It was run by sa for you
--  DO NOT TRY TO RUN THIS SCRIPT

-- script to build a portion of the HomeLendingSecurity database
-- This script has to be run as sa to create the logins


-- passwords are just suggestions - not the actual passowords
-- Creation of the logins - run with as admin

USE master;
IF EXISTS 		-- login for Smith
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'HLS_SmithJ')
BEGIN
  DROP LOGIN HLS_SmithJ;
  CREATE LOGIN HLS_SmithJ WITH PASSWORD = 'S123J';
END
ELSE
 BEGIN
  CREATE LOGIN HLS_SmithJ WITH PASSWORD = 'S123J';
 END

IF EXISTS 		-- login for Jones
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'HLS_JonesB')
BEGIN
  DROP LOGIN HLS_JonesB;
  CREATE LOGIN HLS_JonesB WITH PASSWORD = 'J456B';
END
ELSE
 BEGIN
  CREATE LOGIN HLS_JonesB WITH PASSWORD = 'J456B';
 END

IF EXISTS 		-- login for Johnson
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'HLS_JohnsonT')
BEGIN
  DROP LOGIN HLS_JohnsonT;
  CREATE LOGIN HLS_JohnsonT WITH PASSWORD = 'J987T';
END
ELSE
 BEGIN
  CREATE LOGIN HLS_JohnsonT WITH PASSWORD = 'J987T';
 END

IF EXISTS 		-- login for Dough
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'HLS_DoughW')
BEGIN
  DROP LOGIN HLS_DoughW;
  CREATE LOGIN HLS_DoughW WITH PASSWORD = 'D888W';
END
ELSE
 BEGIN
  CREATE LOGIN HLS_DoughW WITH PASSWORD = 'D888W';
 END

IF EXISTS 		-- login for Regan
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'HLS_ReganC')
BEGIN
  DROP LOGIN HLS_ReganC;
  CREATE LOGIN HLS_ReganC WITH PASSWORD = 'R222C';
END
ELSE
 BEGIN
  CREATE LOGIN HLS_ReganC WITH PASSWORD = 'R222C';
 END

IF EXISTS 		-- login for Wolf
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'HLS_WolfB')
BEGIN
  DROP LOGIN HLS_WolfB;
  CREATE LOGIN HLS_WolfB WITH PASSWORD = 'W000B';
END
ELSE
 BEGIN
  CREATE LOGIN HLS_WolfB WITH PASSWORD = 'W000B';
 END

-- list logins

select name, createdate
from master..syslogins


