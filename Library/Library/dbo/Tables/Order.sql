CREATE TABLE [dbo].[Order] (
    [BookID]     INT  NULL,
    [PersonID]   INT  NULL,
    [DateGive]   DATE NULL,
    [EmployeeID] INT  NULL,
    [DateGet]    DATE NULL,
    CONSTRAINT [FK_BookID_Order] FOREIGN KEY ([BookID]) REFERENCES [dbo].[Book] ([BookID]),
    CONSTRAINT [FK_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]),
    CONSTRAINT [FK_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
);

