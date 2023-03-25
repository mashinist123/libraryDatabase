CREATE   PROCEDURE [dbo].[usp_DeletePerson]
--Задаем параметры
	@FirstName NVARCHAR(30)
	,@LastName NVARCHAR(30)

AS
BEGIN
--Задаем переменные
	DECLARE @p_id INT

		SET @p_id = (SELECT PersonID FROM [dbo].[Person] WHERE [Name] = @FirstName AND LastName = @LastName)
	--Если существующий есть в списке Person
IF EXISTS (SELECT 1 FROM [dbo].[Person] WHERE PersonID = @p_id) AND 
@p_id = (SELECT 1 FROM Employee WHERE EmployeeID = @p_id)
	BEGIN
	WHILE EXISTS (SELECT 1 FROM [dbo].[Person] WHERE PersonID = @p_id)
		BEGIN
			BEGIN TRY
			Delete FROM dbo.Person WHERE PersonID =  @p_id
			END TRY
			BEGIN CATCH
			DELETE FROM dbo.[Order] WHERE PersonID = @p_id
			DELETE FROM dbo.[BlackList] WHERE PersonID = @p_id
			END CATCH
		END
		PRINT 'Person succesfuly deleted'
	END
ELSE IF EXISTS (SELECT 1 FROM [dbo].[Person] WHERE PersonID = @p_id) AND 
@p_id = (SELECT Employee.EmployeeID FROM Employee WHERE EmployeeID = @p_id)
	BEGIN
	WHILE EXISTS (SELECT 1 FROM [dbo].[Person] WHERE PersonID = @p_id)
		BEGIN
			BEGIN TRY
			Delete FROM dbo.Person WHERE PersonID =  @p_id
			DELETE FROM dbo.Employee WHERE EmployeeID = @p_id
			END TRY
			BEGIN CATCH
			UPDATE dbo.[Order]
			SET [EmployeeID] = NULL
			WHERE EmployeeID = @p_id
			DELETE FROM dbo.[Employee] WHERE EmployeeID = @p_id
			END CATCH
		END
	Print 'Employee sucessfuly deleted'
	END
	ELSE
			BEGIN
			RAISERROR ('You inpute incorrect First Name or Last Name', 11, 1)
			END
END