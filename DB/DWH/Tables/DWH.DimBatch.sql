CREATE TABLE [DWH].[DimBatch]
(
[BatchID] [int] NOT NULL IDENTITY(1, 1),
[StartTime] [datetime] NOT NULL CONSTRAINT [DF_DimBatch_StartTime] DEFAULT (getdate()),
[EndTime] [datetime] NULL,
[ErrorFreeYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_DimBatch_ErrorFreeYN] DEFAULT ('Y'),
[BatchType] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[ETLVersion] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [DWH].[DimBatch] ADD CONSTRAINT [PK_DimBatch] PRIMARY KEY CLUSTERED  ([BatchID]) ON [PRIMARY]
GO
