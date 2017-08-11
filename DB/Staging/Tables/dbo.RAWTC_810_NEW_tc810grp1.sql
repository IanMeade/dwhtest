CREATE TABLE [dbo].[RAWTC_810_NEW_tc810grp1]
(
[tc810Grp1_Id] [numeric] (20, 0) NULL,
[membClgIdCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[membCcpClgIdCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[settlAcct] [int] NULL,
[settlLocat] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[settlCurr] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[sumMembTotBuyOrdr] [bigint] NULL,
[sumMembTotSellOrdr] [bigint] NULL,
[tc810Grp_Id] [numeric] (20, 0) NULL
) ON [PRIMARY]
GO
