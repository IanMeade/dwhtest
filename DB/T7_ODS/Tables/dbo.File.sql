CREATE TABLE [dbo].[File]
(
[DwhFileID] [int] NOT NULL,
[FileName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[EtlVersion] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Populated] [datetime2] NOT NULL CONSTRAINT [DF_File_Populated] DEFAULT (getdate()),
[DwhStatus] [varchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[File] ADD CONSTRAINT [PK_File] PRIMARY KEY CLUSTERED  ([DwhFileID]) ON [PRIMARY]
GO
