CREATE     PROCEDURE [dbo].[usp_PassBook]
--Задаем параметры
	@TelephoneNumber NVARCHAR (30)
	,@BookName NVARCHAR(30)
AS
BEGIN
--Задаем переменные
	DECLARE @p_id INT
	DECLARE @b_id INT


	
	SET @p_id = (SELECT [PersonID] FROM [dbo].[Person] WHERE TelephoneNumber = @TelephoneNumber)
	SET @b_id = (SELECT [BookID] FROM [dbo].[Book] WHERE BookName = @BookName)
	IF @p_id IS NOT NULL
	BEGIN
		IF ((SELECT [BookName] FROM [dbo].[Book] WHERE BookName = @BookName) = @BookName)
			BEGIN
			UPDATE [dbo].[Order]
			SET [DateGet] = getdate()
			WHERE PersonID = @p_id AND BookID = @b_id
			END
		ELSE			
			BEGIN
				RAISERROR ('You inputed incorrect book name or this book is not exist', 16, 1)
			END
		END
	ELSE
		BEGIN
				RAISERROR ('You inputed incorrect telephone nubber or this telephone number is not exist', 16, 1)
		END
		--Очистка базы данных от книг, которые зданы год назад

END