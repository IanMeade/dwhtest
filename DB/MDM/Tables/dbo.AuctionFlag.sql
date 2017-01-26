CREATE TABLE [dbo].[AuctionFlag]
(
[AuctionFlagCode] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL,
[AuctionFlagName] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[DefaultValueYN] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuctionFlag] ADD CONSTRAINT [PK_AuctionFlag] PRIMARY KEY CLUSTERED  ([AuctionFlagCode]) ON [PRIMARY]
GO
