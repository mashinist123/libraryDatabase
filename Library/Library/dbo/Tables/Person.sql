CREATE TABLE [dbo].[Person] (
    [PersonID]        INT           IDENTITY (1, 1) NOT NULL,
    [Name]            NVARCHAR (30) NULL,
    [LastName]        NVARCHAR (30) NULL,
    [TelephoneNumber] NVARCHAR (30) NULL,
    [INDEX]           INT           NULL,
    CONSTRAINT [PK_PersonID] PRIMARY KEY CLUSTERED ([PersonID] ASC),
    CONSTRAINT [FK_INDEX] FOREIGN KEY ([INDEX]) REFERENCES [dbo].[Adress] ([Index])
);


GO
CREATE NONCLUSTERED INDEX [Person_name_idx]
    ON [dbo].[Person]([Name] ASC, [LastName] ASC);

