CREATE   PROCEDURE [dbo].[usp_AddOrder]
--Задаем параметры
	@FirstName NVARCHAR(30)
	,@LastName NVARCHAR(30)
	,@TelephoneNumber NVARCHAR (30)
	,@BookName NVARCHAR(30)
AS
BEGIN
--Задаем переменные
	DECLARE @p_id INT
	DECLARE @b_id INT
	DECLARE @e_id INT

	SET @e_id = (SELECT TOP 1 [EmployeeID] FROM [dbo].[Employee] ORDER BY RAND())
	SET @p_id = (SELECT [PersonID] FROM [dbo].[Person] WHERE TelephoneNumber = @TelephoneNumber)
	--Если существующий есть в списке Person но имя и Фамилия не совпаают
	IF EXISTS (SELECT 1 FROM [dbo].[Person] WHERE TelephoneNumber = @TelephoneNumber)
		BEGIN
		IF ((SELECT [Name] FROM [dbo].[Person] WHERE TelephoneNumber = @TelephoneNumber) != @FirstName)
		AND ((SELECT [LastName] FROM [dbo].[Person] WHERE TelephoneNumber = @TelephoneNumber) != @LastName)
			BEGIN
				RAISERROR ('This number is already exist. Input another telephone number!', 16, 1)
			END
		--Изменение фамилии если она поменялась
		IF ((SELECT [Name] FROM [dbo].[Person] WHERE TelephoneNumber = @TelephoneNumber) = @FirstName)
		AND ((SELECT [LastName] FROM [dbo].[Person] WHERE TelephoneNumber = @TelephoneNumber) != @LastName)
			BEGIN
				UPDATE dbo.Person
				SET LastName = @LastName
				WHERE PersonID = (SELECT PersonID FROM [dbo].[Person] WHERE PersonID = @p_id)
			END
		END
	ELSE
	BEGIN		
		INSERT INTO [dbo].[Person]([Name], [LastName], [TelephoneNumber])
		VALUES (@FirstName, @LastName, @TelephoneNumber)
			SET @p_id = (SELECT PersonID FROM [dbo].[Person] WHERE [Name] = @FirstName AND LastName = @LastName)
	END
	--Выдача книги
	SET @b_id = (SELECT [BookID] FROM dbo.Book WHERE BookName = @BookName)
	IF EXISTs (SELECT BookID FROM Book WHERE BookName = @BookName)
		BEGIN
			--Если книга выдана более одного раза  и ещё не сдана
			IF ((SELECT COUNT(*) FROM [dbo].[Order] WHERE @p_id = PersonID AND @b_id = BookID AND DateGet IS NULL) >= 1)
				BEGIN
				RAISERROR ('You got this book already', 12, 1)
				END
			--Если книги в библиотеке законились
			ELSE IF ((SELECT COUNT(*) FROM [dbo].[Order] GROUP BY BookID HAVING BookID = @b_id) >= (SELECT [Count] FROM dbo.Book WHERE BookId = @b_id))
			--Оставляем одну книгу Библии в библиотеке
				OR ((SELECT COUNT(*) FROM [dbo].[Order] GROUP BY BookID HAVING BookID = @b_id) >= (SELECT [Count] - 1  FROM dbo.Book WHERE BookName = 'Bible' AND BookId = @b_id))
				BEGIN
				RAISERROR ('Is not available book', 12, 1)
				END
			ELSE
				BEGIN
			--Если книга не выдавадась
				INSERT INTO [dbo].[Order]([BookID],[PersonID],[DateGive], [EmployeeID])  Values (@b_id, @p_id, GETDATE(), @e_id) 
				END
		END
	ELSE
		BEGIN
		RAISERROR ('Add this book in library list', 12, 1)
		END

END