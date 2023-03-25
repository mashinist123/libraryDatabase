CREATE TABLE [dbo].[City] (
    [CityID]   INT           IDENTITY (1, 1) NOT NULL,
    [City]     NVARCHAR (30) NULL,
    [RegionID] INT           NULL,
    CONSTRAINT [PK_CityID] PRIMARY KEY CLUSTERED ([CityID] ASC),
    CONSTRAINT [FK_RegionID] FOREIGN KEY ([RegionID]) REFERENCES [dbo].[Region] ([RegionID])
);

