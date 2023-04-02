CREATE   PROCEDURE dbo.usp_InsertAdress
@FirstName Nvarchar(30),
@LastName Nvarchar(30),
@Country Nvarchar(30),
@Region Nvarchar(30),
@City Nvarchar(30),
@Streat Nvarchar(30),
@Index INT

AS
BEGIN

DECLARE @p_id INT
DECLARE @Country_id INT
DECLARE @Region_id INT
DECLARE @City_id INT




SET @p_id = (SELECT PersonID FROM [dbo].[Person] WHERE [Name] = @FirstName AND LastName = @LastName)
WHILE (SELECT [INDEX] FROM dbo.Person WHERE PersonID = @p_id) IS NULL
BEGIN	
IF EXISTS (SELECT [Index] FROM dbo.Adress WHERE [Index] = @Index)
	BEGIN
	Update dbo.Person
	SET [INDEX] = @Index
	WHERE PersonID = @p_id
	END
IF EXISTS (SELECT CityID FROM dbo.City WHERE [City] = @City) AND
NOT EXISTS (SELECT [Index] FROM dbo.Adress WHERE [Index] = @Index)
	BEGIN
	INSERT INTO dbo.Adress([Index], [Street], [CityID]) VALUES (@Index, @Streat, @City_id)
	SET @City_id = (SELECT CityID FROM City WHERE @City = City)
	END
IF EXISTS (SELECT RegionID FROM dbo.Region WHERE [Region] = @Region) AND
NOT EXISTS (SELECT CityID FROM dbo.City WHERE [City] = @City)
	BEGIN
	INSERT INTO dbo.City([City], [RegionID]) VALUES (@City, @Region_id)
	SET @City_id = (SELECT CityID FROM City WHERE @City = City)
	END
IF EXISTS (SELECT CountryID FROM dbo.Country WHERE [Country] = @Country) AND
NOT EXISTS (SELECT RegionID FROM dbo.Region WHERE [Region] = @Region)
	BEGIN
	INSERT INTO [dbo].[Region]([Region], [CountryID]) VALUES (@Region, @Country_id)
	SET @Region_id = (SELECT RegionID FROM Region WHERE @Region = Region)
	END
IF NOT EXISTS (SELECT CountryID FROM dbo.Country WHERE [Country] = @Country)
	BEGIN
	INSERT INTO [dbo].[Country]([Country]) VALUES (@Country)
	SET @Country_id = (SELECT CountryID FROM Country WHERE @Country = Country)
	END
END

END