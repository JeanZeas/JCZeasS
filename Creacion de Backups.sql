


--Tarea de base de Datos II

--Backups
--1)Crea un dispositivo de backups múltiples para la base de datos Adventureworks.

EXEC sp_addumpdevice 'disk', 
'AdventureWorks2019', -- <--Este es el nombre del dispositivo
'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2019.bak';
go

--Con esta consulta puedo confirmar donde esta localizado el dispositivo y su nombre fisico

SELECT * FROM sys.backup_devices

--Estas sentencia elimina Dispositivos de Backups
EXEC sp_dropdevice 'AdventureWorks2019', 'delfile' ;  


--Crear un full backup en el dispositivo creado anteriormente: "AdventureWorks2019"

BACKUP DATABASE AdventureWorks2019
TO AdventureWorks2019
WITH FORMAT, INIT, NAME = N'AdventureWorks2019 Full Backup';
GO

--Lista los dispositivos .mdf y .ldf
RESTORE FILELISTONLY FROM AdventureWorks2019
GO

--Selecciona los backups creados
Restore headeronly from AdventureWorks2019
Go

--2
--Crea una rutina que asigne nombres de backups únicos 
--y haz que ejecute 4 backups sobre el dispositivo de backup creado en el punto anterior.
Declare @Respaldo Varchar(100)
Set @Respaldo = N'AdventureWorks2019' + FORMAT(GETDATE(),'yyyyMMdd_hhmmss');

Backup Database AdventureWorks2019
To AdventureWorks2019
With NoFormat, NoInit, Name = @Respaldo,
Skip, Norewind, Nounload, STATS = 10
Go
