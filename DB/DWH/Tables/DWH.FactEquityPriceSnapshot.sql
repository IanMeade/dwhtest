CREATE TABLE [DWH].[FactEquityPriceSnapshot]
(
[SampleDateID] [int] NOT NULL,
[SampleTime] [time] NOT NULL,
[InstrumentID] [int] NOT NULL,
[LtpDateID] [int] NULL,
[LtpTimeID] [smallint] NULL,
[LTP] [numeric] (19, 6) NULL,
[BatchID] [int] NOT NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
ALTER TABLE [DWH].[FactEquityPriceSnapshot] ADD CONSTRAINT [PK_FactEquityPriceSnapshot] PRIMARY KEY CLUSTERED  ([SampleDateID], [SampleTime], [InstrumentID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
