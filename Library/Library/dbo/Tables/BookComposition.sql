CREATE TABLE [dbo].[BookComposition] (
    [ComposiyionID] INT NOT NULL,
    [BookID]        INT NOT NULL,
    CONSTRAINT [PK_BookComposition] PRIMARY KEY CLUSTERED ([ComposiyionID] ASC, [BookID] ASC),
    CONSTRAINT [FK_BookID] FOREIGN KEY ([BookID]) REFERENCES [dbo].[Book] ([BookID]),
    CONSTRAINT [FK_ComposiyionID] FOREIGN KEY ([ComposiyionID]) REFERENCES [dbo].[Composition] ([CompositionID])
);

