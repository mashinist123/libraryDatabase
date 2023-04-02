CREATE    PROCEDURE [dbo].[usp_BlackList4]
AS
BEGIN
DECLARE @p_id INT
DECLARE @b_id INT
DECLARE @date date
DECLARE @a INT
	SET @a = 0
	DROP table IF EXISTs #TampB
	SELECT DISTINCT * INTO #TampB FROM [ORDER] WHERE DATEDIFF(YEAR, DateGive, GETDATE()) > = 2 AND DateGet IS NULL
	WHILE (SELECT COUNT(*) FROM [#TampB]) != 0
	BEGIN
		SET @p_id = (SELECT TOP 1 PersonID FROM #TampB)
		SET @b_id = (SELECT TOP 1 BookID FROM #TampB WHERE PersonID = @p_id)
		SET @date = (SELECT DateGive FROM dbo.[Order] WHERE @b_id = [BookID] AND @p_id = [PersonID])
		IF EXISTs (SELECT PersonID FROM dbo.BlackList WHERE @p_id = PersonID AND @b_id = BookID)
			BEGIN			
			DELETE FROM #TampB WHERE BookID = @b_id AND PersonID = @p_id
			PRINT 'STRING MISSED'
			END
	ELSE
			BEGIN
			INSERT INTO [dbo].[BlackList]([PersonID], [BookID], [DateGet]) VALUES (@p_id, @b_id, @date)
			PRINT 'Person added'
			DELETE FROM #TampB WHERE BookID = @b_id AND PersonID = @p_id
			END
		PRINT @a + 1
	END
DROP table IF EXISTs #TampB
SELECT * FROM BlackList
END