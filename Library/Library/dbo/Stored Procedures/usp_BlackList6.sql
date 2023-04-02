
CREATE PROCEDURE [dbo].[usp_BlackList6]
AS

	IF OBJECT_ID ('tempdb..#temp_list') IS NOT NULL
	BEGIN
		DROP TABLE #temp_list
	END

	SELECT DISTINCT PersonID, BookID, DateGive
	INTO #temp_list
	FROM [ORDER] 
	WHERE DATEDIFF(YEAR, DateGive, GETDATE()) > = 2 AND DateGet IS NULL

	INSERT INTO dbo.BlackList
	SELECT tmp.PersonID, tmp.BookID, tmp.DateGive
	FROM #temp_list tmp
	LEFT JOIN dbo.BlackList bl
	ON bl.PersonID = tmp.PersonID
	AND bl.BookID = tmp.BookID
	AND bl.DateGet = tmp.DateGive
	WHERE bl.PersonID IS NULL

	DELETE bl 
	FROM dbo.BlackList bl
	LEFT JOIN #temp_list tmp
	ON bl.PersonID = tmp.PersonID
	AND bl.BookID = tmp.BookID
	AND bl.DateGet = tmp.DateGive
	WHERE tmp.PersonID IS NULL