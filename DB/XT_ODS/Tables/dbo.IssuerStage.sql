CREATE TABLE [dbo].[IssuerStage]
(
[Name] [varchar] (600) COLLATE Latin1_General_CI_AS NULL,
[DateOfIncorporation] [datetime] NULL,
[DebtorCode] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[DebtorCodeEquity] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[Domicile] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[DomicileDomesticFlag] [varchar] (1) COLLATE Latin1_General_CI_AS NULL,
[FeeCode] [int] NULL,
[SmfName] [varchar] (600) COLLATE Latin1_General_CI_AS NULL,
[Td_Home_Member_Country] [varchar] (400) COLLATE Latin1_General_CI_AS NULL,
[VatNumber] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[LegalStructure] [varchar] (40) COLLATE Latin1_General_CI_AS NULL,
[YearEnd] [datetime] NULL,
[Pd_Home_Member_Country] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[Lei_Code] [varchar] (40) COLLATE Latin1_General_CI_AS NULL,
[EUFlag] [varchar] (20) COLLATE Latin1_General_CI_AS NULL,
[IsoCode] [varchar] (20) COLLATE Latin1_General_CI_AS NULL,
[Gid] [varchar] (40) COLLATE Latin1_General_CI_AS NULL,
[ExtractSequenceId] [bigint] NOT NULL IDENTITY(1, 1),
[ExtractDate] [datetime] NULL CONSTRAINT [DF__IssuerSta__Extra__15502E78] DEFAULT (getdate()),
[MessageId] [bigint] NULL
) ON [PRIMARY]
GO
