
CREATE   PROCEDURE [dbo].[usp_AddBook]
	@BookName NVARCHAR(30),
	@Publishing INT NULL
AS
BEGIN
 DECLARE @id_book INT
	IF EXISTS (SELECT BookID FROM [dbo].[Book] WHERE [BookName] = @BookName)
		BEGIN
		RAISERROR ('This book already exist', 11, 1)
		END
	ELSE
		BEGIN
		INSERT INTO [dbo].[Book] ([BookName], [Release])
		VALUES (@BookName, @Publishing)
		END
END