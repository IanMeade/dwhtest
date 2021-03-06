USE MDM

/* 
Run this script on: 
 
T7-DDT-06.MDM    -  This database will be modified 
 
to synchronize it with: 
 
T7-DDT-01.MDM 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Data Compare version 12.0.33.3389 from Red Gate Software Ltd at 30/08/2017 17:29:58 
 
*/ 
		
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)
 
PRINT(N'Add 4 rows to [dbo].[BrokerMappingCode]')
INSERT INTO [dbo].[BrokerMappingCode] ([OldBroker], [NewBroker]) VALUES ('BLODB', 'BLXDB')
INSERT INTO [dbo].[BrokerMappingCode] ([OldBroker], [NewBroker]) VALUES ('BNPDB', 'BNADB')
INSERT INTO [dbo].[BrokerMappingCode] ([OldBroker], [NewBroker]) VALUES ('DAVDB', 'JEDDB')
INSERT INTO [dbo].[BrokerMappingCode] ([OldBroker], [NewBroker]) VALUES ('DSTDB', 'DBUDB')
COMMIT TRANSACTION
GO
