CREATE TABLE [dbo].[RAWTC_810_NEW_InstrumentGrp]
(
[product] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[instrumentType] [tinyint] NULL,
[instrumentId] [bigint] NULL,
[instrumentMnemonic] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[isinCod] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[wknNo] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[instNam] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[tc810KeyGrp4_Id] [numeric] (20, 0) NULL
) ON [PRIMARY]
GO
