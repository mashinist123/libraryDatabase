CREATE TABLE [dbo].[Employee] (
    [EmployeeID] INT             NOT NULL,
    [Salary]     DECIMAL (10, 3) NULL,
    [Experience] DECIMAL (3, 1)  NULL,
    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([EmployeeID] ASC),
    CONSTRAINT [FK_Eployee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Person] ([PersonID])
);

