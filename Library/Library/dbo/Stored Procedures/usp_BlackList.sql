CREATE   PROCEDURE dbo.usp_BlackList
AS
BEGIN
DECLARE @p_id INT
DECLARE @b_id INT
DECLARE @date date
DECLARE @a INT

	SET @a = 0
	SET @p_id = (SELECT TOP 1 PersonID FROM dbo.[Order] WHERE DATEDIFF(YEAR, DateGive, GETDATE()) > = 2)
	SET @b_id = (SELECT TOP 1 BookID FROM dbo.[Order] WHERE PersonID = @p_id AND DATEDIFF(YEAR, DateGive, GETDATE()) > = 2)
	SET @date = (SELECT DateGive FROM dbo.[Order] WHERE @b_id = [BookID] AND @p_id = [PersonID] AND DateGet IS NULL)
	
	
WHILE (SELECT COUNT(*) FROM [ORDER] WHERE DATEDIFF(YEAR, DateGive, GETDATE()) > = 2 AND DateGet IS NULL) > =  (SELECT COUNT(*) FROM [dbo].[BlackList])
	BEGIN
		INSERT INTO [dbo].[BlackList]([PersonID], [BookID], [DateGet]) VALUES (@p_id, @b_id, @date)
		PRINT 'Person added'
		SET @p_id = (SELECT TOP 1 ord.PersonID FROM dbo.[Order] AS ord WHERE DATEDIFF(YEAR, DateGive, GETDATE()) > = 2 AND NOT EXISTs (SELECT PersonID FROM dbo.Blacklist))
		SET @b_id = (SELECT TOP 1 BookID FROM dbo.[Order] WHERE PersonID = @p_id AND DATEDIFF(YEAR, DateGive, GETDATE()) > = 2)
		SET @date = (SELECT DateGive FROM dbo.[Order] WHERE @b_id = [BookID] AND @p_id = [PersonID] AND DateGet IS NULL)
		SET @a = @a + 1
		Print @a
	END
END