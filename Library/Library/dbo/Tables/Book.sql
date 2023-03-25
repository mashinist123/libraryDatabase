CREATE TABLE [dbo].[Book] (
    [BookID]   INT           IDENTITY (1, 1) NOT NULL,
    [BookName] NVARCHAR (30) NULL,
    [Release]  INT           NULL,
    [Count]    INT           DEFAULT ((30)) NULL,
    CONSTRAINT [PK_BookID] PRIMARY KEY CLUSTERED ([BookID] ASC)
);

