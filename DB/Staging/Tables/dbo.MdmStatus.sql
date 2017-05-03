CREATE TABLE [dbo].[MdmStatus]
(
[StatusName] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ConditionalTradingYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[ValidForEquity] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
