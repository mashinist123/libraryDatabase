CREATE TABLE [dbo].[Region] (
    [RegionID]  INT           IDENTITY (1, 1) NOT NULL,
    [Region]    NVARCHAR (30) NULL,
    [CountryID] INT           NULL,
    CONSTRAINT [PK_ReginID] PRIMARY KEY CLUSTERED ([RegionID] ASC),
    CONSTRAINT [FK_CountryID] FOREIGN KEY ([CountryID]) REFERENCES [dbo].[Country] ([CountryID])
);

