CREATE TABLE [dbo].[RawTcC810]
(
[RawTc810Id] [int] NOT NULL IDENTITY(1, 1),
[FileID] [int] NOT NULL,
[REPORT_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[REPORT_EFF_DATE] [datetime] NULL,
[REPORT_PROCESS_DATE] [datetime] NULL,
[ENV_ONE] [tinyint] NULL,
[ENV_TWO] [tinyint] NULL,
[CLRMEM_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[CLRMEM_SETTLE_LOC] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[CLRMEM_SETTLE_ACC] [int] NULL,
[EXCHMEMB_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[OWNER_EXMEMB_INST_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[OWNER_EXMEMB_BR_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[INSTRU_ISIN] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[UNITS] [tinyint] NULL,
[TRANS_TIME] [bigint] NULL,
[PARTA_SUBGRP_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[PARTA_USR_NO] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[UNIQ_TRADE_NO] [int] NULL,
[TRADE_NO_SUFX] [tinyint] NULL,
[TRANS_TYPE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[ORIGIN_TYPE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[CROSS_IND] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[SETTLE_IND] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[OTC_TRADE_TIME] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[ORDER_INSTR_ISIN] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[ORD_NO] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[EXECUTOR_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[INTERMEM_ORD_NO] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[FREE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[ACC_TYPE_CODE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[ACC_TYPE_NO] [tinyint] NULL,
[BUY_SELL_IND] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[NETTING_TYPE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[MATCHED_QTY] [decimal] (28, 10) NULL,
[MATCHED_PRICE] [decimal] (28, 10) NULL,
[SETTLE_AMOUNT] [decimal] (28, 10) NULL,
[SETTLE_DATE] [datetime] NULL,
[SETTLE_CODE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[ACCRUED_INTEREST] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[ACCRUED_INTEREST_DAY] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[EXCHMEM_INST_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[EXCHMEM_BR_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[PART_USR_GRP_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[PART_USR_NO] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[COUNTER_EXCHMEM_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[COUNTER_EXCHMEM_BR_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[COUNTER_CRL_SET_MEM_ID] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[COUNTER_SETL_LOC] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[COUNTER_SETL_ACC] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[COUNTER_KASSEN_NO] [int] NULL,
[DEPOSITORY_TYPE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[TRANS_FEE] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[TRANS_FEE_CURRENCY] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
ALTER TABLE [dbo].[RawTcC810] ADD CONSTRAINT [PK_RawTcC810] PRIMARY KEY CLUSTERED  ([RawTc810Id]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RawTcC810] ON [dbo].[RawTcC810] ([FileID]) ON [PRIMARY]
GO
