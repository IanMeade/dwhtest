CREATE TABLE [dbo].[IssuerStage]
(
[Name] [varchar] (300) COLLATE Latin1_General_CI_AS NOT NULL,
[DateOfIncorporation] [datetime] NULL,
[DebtorCode] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[DebtorCodeEquity] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[Domicile] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[DomicileDomesticFlag] [bit] NULL,
[FeeCode] [int] NULL,
[SmfName] [varchar] (300) COLLATE Latin1_General_CI_AS NULL,
[Td_Home_Member_Country] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[VatNumber] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[AccountingStandard] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[LegalStructure] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[YearEnd] [datetime] NULL,
[Pd_Home_Member_Country] [varchar] (200) COLLATE Latin1_General_CI_AS NULL,
[Lei_Code] [varchar] (20) COLLATE Latin1_General_CI_AS NULL,
[EUFlag] [bit] NULL,
[IsoCode] [varchar] (2) COLLATE Latin1_General_CI_AS NULL,
[Gid] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL,
[ExtractSequenceId] [bigint] NOT NULL IDENTITY(1, 1),
[ExtractDate] [datetime] NULL CONSTRAINT [DF__IssuerSta__Extra__239E4DCF] DEFAULT (getdate()),
[MessageId] [varchar] (256) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IssuerStage] ADD CONSTRAINT [PK__IssuerSt__A1071C3DD5A6A91E] PRIMARY KEY CLUSTERED  ([ExtractSequenceId]) ON [PRIMARY]
GO
