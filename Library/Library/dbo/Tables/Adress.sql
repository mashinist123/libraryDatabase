CREATE TABLE [dbo].[Adress] (
    [Index]  INT           NOT NULL,
    [Street] NVARCHAR (30) NULL,
    [CityID] INT           NULL,
    CONSTRAINT [PK_INDEX] PRIMARY KEY CLUSTERED ([Index] ASC),
    CONSTRAINT [FK_CityID] FOREIGN KEY ([CityID]) REFERENCES [dbo].[City] ([CityID])
);

