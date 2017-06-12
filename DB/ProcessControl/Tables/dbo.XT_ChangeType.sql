CREATE TABLE [dbo].[XT_ChangeType]
(
[BatchID] [int] NULL,
[DateInserted] [datetime2] NULL CONSTRAINT [DF_XT_ChangeType_DateInserted] DEFAULT (getdate()),
[InstrumentGlobalID] [varchar] (30) COLLATE Latin1_General_CI_AS NULL,
[UpdateType] [varchar] (10) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
