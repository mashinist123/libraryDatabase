CREATE TABLE [dbo].[Country] (
    [CountryID] INT           IDENTITY (1, 1) NOT NULL,
    [Country]   NVARCHAR (30) NULL,
    CONSTRAINT [PK_CountryID] PRIMARY KEY CLUSTERED ([CountryID] ASC)
);

