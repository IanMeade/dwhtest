/* 
Run this script on: 
 
        T7-DDT-06.MDM    -  This database will be modified 
 
to synchronize it with: 
 
        T7-DDT-01.MDM 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 30/08/2017 14:49:53 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
USE [MDM]
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[BrokerMappingCode]'
GO
CREATE TABLE [dbo].[BrokerMappingCode] 
( 
[OldBroker] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL, 
[NewBroker] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_BrokerMappingCode] on [dbo].[BrokerMappingCode]'
GO
ALTER TABLE [dbo].[BrokerMappingCode] ADD CONSTRAINT [PK_BrokerMappingCode] PRIMARY KEY CLUSTERED  ([OldBroker], [NewBroker])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT 
SET @Success = 1 
SET NOEXEC OFF 
IF (@Success = 1) PRINT 'The database update succeeded' 
ELSE BEGIN 
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	PRINT 'The database update failed' 
END
GO
