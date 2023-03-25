CREATE TABLE [dbo].[BlackList] (
    [PersonID] INT  NULL,
    [BookID]   INT  NULL,
    [DateGet]  DATE NULL,
    CONSTRAINT [FKbookID] FOREIGN KEY ([BookID]) REFERENCES [dbo].[Book] ([BookID]),
    CONSTRAINT [FKpersonID] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
);

