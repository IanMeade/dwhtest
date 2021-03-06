CREATE TABLE [dbo].[IndexValue]
(
[IndexValueID] [int] NOT NULL IDENTITY(1, 1),
[ValueInserted] [datetime2] NOT NULL CONSTRAINT [DF_IndexValue_ValueInserted] DEFAULT (getdate()),
[OLAST] [numeric] (8, 3) NULL,
[OOPEN] [numeric] (8, 3) NULL,
[OHIGH] [numeric] (15, 3) NULL,
[OLOW] [numeric] (8, 3) NULL,
[ORETURN] [numeric] (8, 3) NULL,
[FLAST] [numeric] (8, 3) NULL,
[FOPEN] [numeric] (8, 3) NULL,
[FHIGH] [numeric] (15, 3) NULL,
[FLOW] [numeric] (8, 3) NULL,
[FRETURN] [numeric] (8, 3) NULL,
[GLAST] [numeric] (8, 3) NULL,
[GOPEN] [numeric] (8, 3) NULL,
[GHIGH] [numeric] (15, 3) NULL,
[GLOW] [numeric] (8, 3) NULL,
[GRETURN] [numeric] (8, 3) NULL,
[SLAST] [numeric] (8, 3) NULL,
[SOPEN] [numeric] (8, 3) NULL,
[SHIGH] [numeric] (15, 3) NULL,
[SLOW] [numeric] (8, 3) NULL,
[SRETURN] [numeric] (8, 3) NULL,
[ILAST] [numeric] (8, 3) NULL,
[IOPEN] [numeric] (8, 3) NULL,
[IHIGH] [numeric] (15, 3) NULL,
[ILOW] [numeric] (8, 3) NULL,
[IRETURN] [numeric] (8, 3) NULL,
[ELAST] [numeric] (8, 3) NULL,
[EOPEN] [numeric] (8, 3) NULL,
[EHIGH] [numeric] (15, 3) NULL,
[ELOW] [numeric] (8, 3) NULL,
[ERETURN] [numeric] (8, 3) NULL,
[NLAST] [numeric] (8, 3) NULL,
[NOPEN] [numeric] (8, 3) NULL,
[NHIGH] [numeric] (15, 3) NULL,
[NLOW] [numeric] (8, 3) NULL,
[XLAST] [numeric] (8, 3) NULL,
[XOPEN] [numeric] (8, 3) NULL,
[XHIGH] [numeric] (15, 3) NULL,
[XLOW] [numeric] (8, 3) NULL,
[XRETURN] [numeric] (8, 3) NULL,
[VLAST] [numeric] (8, 3) NULL,
[VOPEN] [numeric] (8, 3) NULL,
[VHIGH] [numeric] (15, 3) NULL,
[VLOW] [numeric] (8, 3) NULL,
[VRETURN] [numeric] (8, 3) NULL,
[LLAST] [numeric] (8, 3) NULL,
[LOPEN] [numeric] (8, 3) NULL,
[LHIGH] [numeric] (15, 3) NULL,
[LLOW] [numeric] (8, 3) NULL,
[LRETURN] [numeric] (8, 3) NULL,
[CLAST] [numeric] (8, 3) NULL,
[COPEN] [numeric] (8, 3) NULL,
[CHIGH] [numeric] (15, 3) NULL,
[CLOW] [numeric] (8, 3) NULL,
[CRETURN] [numeric] (8, 3) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IndexValue] ADD CONSTRAINT [PK_IndexValue] PRIMARY KEY CLUSTERED  ([IndexValueID]) ON [PRIMARY]
GO
