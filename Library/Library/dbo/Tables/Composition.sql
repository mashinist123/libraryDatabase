CREATE TABLE [dbo].[Composition] (
    [CompositionID]    INT           IDENTITY (1, 1) NOT NULL,
    [TitleComposition] NVARCHAR (30) NULL,
    [Genre]            NVARCHAR (30) NULL,
    [AuthorID]         INT           NULL,
    [Famous (0-10)]    INT           NULL,
    CONSTRAINT [PK_CompositionID] PRIMARY KEY CLUSTERED ([CompositionID] ASC),
    CONSTRAINT [FK_AuthorID] FOREIGN KEY ([AuthorID]) REFERENCES [dbo].[Person] ([PersonID])
);

