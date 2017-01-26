CREATE TABLE [dbo].[ProcessStatus]
(
[ProcessStatusID] [int] NOT NULL,
[BatchID] [int] NULL,
[ProcessName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[ProcessState] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[ProcessNotes] [varchar] (1000) COLLATE Latin1_General_CI_AS NULL,
[ProcessStarted] [datetime2] NOT NULL,
[ProcessEnded] [datetime2] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProcessStatus] ADD CONSTRAINT [PK_ProcessStatus] PRIMARY KEY CLUSTERED  ([ProcessStatusID]) ON [PRIMARY]
GO
