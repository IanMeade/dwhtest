CREATE TABLE [dbo].[RAWTC_810_NEW_rptHdr]
(
[exchNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[envText] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[rptCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[rptNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[rptFlexKey] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[membId] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[membLglNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[rptPrntEffDat] [datetime] NULL,
[rptPrntEffTim] [datetime] NULL,
[rptPrntRunDat] [datetime] NULL,
[tc810_Id] [numeric] (20, 0) NULL
) ON [PRIMARY]
GO
