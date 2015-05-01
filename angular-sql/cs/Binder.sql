USE [Advent]
GO

IF OBJECT_ID(N'apiBinderBroker', N'P') IS NOT NULL DROP PROCEDURE [apiBinderBroker]
IF OBJECT_ID(N'apiBinderCoverholder', N'P') IS NOT NULL DROP PROCEDURE [apiBinderCoverholder]
IF OBJECT_ID(N'apiBinder', N'P') IS NOT NULL DROP PROCEDURE [apiBinder]
IF OBJECT_ID(N'apiBinders', N'P') IS NOT NULL DROP PROCEDURE [apiBinders]
IF OBJECT_ID(N'Binder', N'U') IS NOT NULL DROP TABLE [Binder]
IF OBJECT_ID(N'apiCompanySave', N'P') IS NOT NULL DROP PROCEDURE [apiCompanySave]
IF OBJECT_ID(N'apiCompanyRoles', N'P') IS NOT NULL DROP PROCEDURE [apiCompanyRoles]
IF OBJECT_ID(N'apiCompany', N'P') IS NOT NULL DROP PROCEDURE [apiCompany]
IF OBJECT_ID(N'apiCompanies', N'P') IS NOT NULL DROP PROCEDURE [apiCompanies]
IF OBJECT_ID(N'CompanyRole', N'U') IS NOT NULL DROP TABLE [CompanyRole]
IF OBJECT_ID(N'Company', N'U') IS NOT NULL DROP TABLE [Company]
IF OBJECT_ID(N'TerritoryCountry', N'U') IS NOT NULL DROP TABLE [TerritoryCountry]
IF OBJECT_ID(N'apiTerritories', N'P') IS NOT NULL DROP PROCEDURE [apiTerritories]
IF OBJECT_ID(N'Territory', N'U') IS NOT NULL DROP TABLE [Territory]
IF OBJECT_ID(N'apiCountries', N'P') IS NOT NULL DROP PROCEDURE [apiCountries]
IF OBJECT_ID(N'Country', N'U') IS NOT NULL DROP TABLE [Country]
GO

CREATE TABLE [Country] (
  [Id] NCHAR(2) NOT NULL,
		[Name] NVARCHAR(255) NOT NULL,
		CONSTRAINT [PK_Country] PRIMARY KEY NONCLUSTERED ([Id]),
		CONSTRAINT [UQ_Country_Name] UNIQUE CLUSTERED ([Name])
	)
GO

INSERT INTO [Country] ([Id], [Name])
VALUES
 (N'UK', N'United Kingdom'),
	(N'US', N'United States')
GO

CREATE PROCEDURE [apiCountries]
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT [Id], [Name] FROM [Country] ORDER BY [Name]
	RETURN
END
GO

CREATE TABLE [Territory] (
  [Id] INT NOT NULL IDENTITY (1, 1),
		[Name] NVARCHAR(255) NOT NULL,
		[Type] BIT NULL,
		CONSTRAINT [PK_Territory] PRIMARY KEY NONCLUSTERED ([Id]),
		CONSTRAINT [UQ_Territory_Name] UNIQUE ([Name]),
		CONSTRAINT [UQ_Territory_Type] UNIQUE ([Id], [Type]),
	)
GO

CREATE PROCEDURE [apiTerritories]
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT [Id], [Name] FROM [Territory] ORDER BY [Name]
	RETURN
END
GO

CREATE TABLE [TerritoryCountry] (
  [TerritoryId] INT NOT NULL,
		[Type] BIT NOT NULL,
		[CountryId] NCHAR(2) NOT NULL,
		CONSTRAINT [PK_TerritoryCountry] PRIMARY KEY CLUSTERED ([TerritoryId], [CountryId]),
		CONSTRAINT [FK_TerritoryCountry_Territory] FOREIGN KEY ([TerritoryId], [Type]) REFERENCES [Territory] ([Id], [Type]) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT [FK_TerritoryCountry_Country] FOREIGN KEY ([CountryId]) REFERENCES [Country] ([Id]) ON DELETE CASCADE
	)
GO

SET IDENTITY_INSERT [Territory] ON
INSERT INTO [Territory] ([Id], [Name], [Type])
VALUES
 (0, N'All Countries', NULL),
	(1, N'UK Only', 1),
	(2, N'US Only', 1),
	(3, N'Outside UK', 0),
	(4, N'Outside US', 0)
SET IDENTITY_INSERT [Territory] OFF
GO

INSERT INTO [TerritoryCountry] ([TerritoryId], [Type], [CountryId])
VALUES
 (1, 1, N'UK'),
	(2, 1, N'US'),
	(3, 0, N'UK'),
	(3, 0, N'US')
GO

CREATE TABLE [Company] (
  [Id] INT NOT NULL IDENTITY (1, 1),
		[Name] NVARCHAR(255) NOT NULL,
		[Address] NVARCHAR(255) NULL,
		[Postcode] NVARCHAR(25) NULL,
		[CountryId] NCHAR(2) NOT NULL,
		[LBR] BIT NOT NULL CONSTRAINT [DF_Company_LBR] DEFAULT (0), -- Lloyd's Broker
		[COV] BIT NOT NULL CONSTRAINT [DF_Company_COV] DEFAULT (0), -- Coverholder
		[CAR] BIT NOT NULL CONSTRAINT [DF_Company_CAR] DEFAULT (0), -- Carrier
		[TPA] BIT NOT NULL CONSTRAINT [DF_Company_TPA] DEFAULT (0), -- Third-Party Adjuster
		[CreatedDTO] DATETIMEOFFSET NOT NULL CONSTRAINT [DF_Company_CreatedDTO] DEFAULT (GETUTCDATE()),
		[CreatedById] INT NOT NULL,
		[UpdatedDTO] DATETIMEOFFSET NOT NULL CONSTRAINT [DF_Company_UpdatedDTO] DEFAULT (GETUTCDATE()),
		[UpdatedById] INT NOT NULL,
		[Active] BIT NOT NULL CONSTRAINT [DF_Company_Active] DEFAULT (1),
		CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED ([Id]),
		CONSTRAINT [UQ_Company_Name] UNIQUE ([CountryId], [Name]),
		CONSTRAINT [FK_Company_Country] FOREIGN KEY ([CountryId]) REFERENCES [Country] ([Id]),
		CONSTRAINT [FK_Company_User_CreatedById] FOREIGN KEY ([CreatedById]) REFERENCES [User] ([Id]),
		CONSTRAINT [FK_Company_User_UpdatedById] FOREIGN KEY ([UpdatedById]) REFERENCES [User] ([Id])
	)
GO

INSERT INTO [Company] ([Name], [CountryId], [CreatedById], [UpdatedById])
VALUES
 (N'Whitespace Software Limited', N'UK', 1, 1),
	(N'Datarise Limited', N'US', 2, 2)
GO

CREATE TABLE [CompanyRole] (
  [Id] NCHAR(3) NOT NULL,
		[Description] NVARCHAR(25) NOT NULL,
		[Sort] TINYINT NOT NULL,
		CONSTRAINT [PK_CompanyRole] PRIMARY KEY NONCLUSTERED ([Id]),
		CONSTRAINT [UQ_CompanyRole_Description] UNIQUE ([Description]),
		CONSTRAINT [UQ_CompanyRole_Sort] UNIQUE CLUSTERED ([Sort])
	)
GO

INSERT INTO [CompanyRole] ([Id], [Description], [Sort])
VALUES
 (N'LBR', N'Lloyd''s Broker', 1),
	(N'COV', N'Coverholder', 2),
	(N'CAR', N'Carrier', 3),
	(N'TPA', N'Third-Party Adjuster', 4)
GO

CREATE PROCEDURE [apiCompanies](@UserId INT, @RoleId NCHAR(3) = NULL)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT
	 [CompanyId] = cmp.[Id],
		[Name] = cmp.[Name],
		[CountryId] = cmp.[CountryId],
		[Country] = co.[Name]
	FROM [Company] cmp
	 JOIN [Country] co ON cmp.[CountryId] = co.[Id]
	ORDER BY cmp.[Name], co.[Name]
	RETURN
END
GO

CREATE PROCEDURE [apiCompany](@UserId INT, @CountryId NCHAR(2), @Name NVARCHAR(255))
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 SELECT
	 [CompanyId] = cmp.[Id],
		[Name] = cmp.[Name],
		[Address] = cmp.[Address],
		[Postcode] = cmp.[Postcode],
		[CountryId] = cmp.[CountryId],
		[LBR] = cmp.[LBR],
		[COV] = cmp.[COV],
		[CAR] = cmp.[CAR],
		[TPA] = cmp.[TPA]
	FROM [Company] cmp
	WHERE cmp.[CountryId] = @CountryId
	 AND cmp.[Name] = @Name
	RETURN
END
GO

CREATE PROCEDURE [apiCompanyRoles]
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT [Id], [Description] FROM [CompanyRole] ORDER BY [Sort]
	RETURN
END
GO

CREATE PROCEDURE [apiCompanySave](
  @CompanyId INT = NULL,
		@Name NVARCHAR(255),
		@Address NVARCHAR(255) = NULL,
		@Postcode NVARCHAR(25) = NULL,
		@CountryId NCHAR(2) = N'UK',
		@LBR BIT = 0,
		@COV BIT = 0,
		@CAR BIT = 0,
		@TPA BIT = 0,
		@Active BIT = 1,
		@UserId INT
 )
AS
BEGIN

 IF @CompanyId IS NULL BEGIN

	 INSERT INTO [Company] (
		  [Name],
				[Address],
				[PostCode],
				[CountryId],
				[LBR],
				[COV],
				[CAR],
				[TPA],
				[CreatedById],
				[UpdatedById],
				[Active]
			)
		VALUES (
		  @Name,
				@Address,
				@Postcode,
				@CountryId,
				@LBR,
				@COV,
				@CAR,
				@TPA,
				@UserId,
				@UserId,
				@Active
			)
		SET @CompanyId = SCOPE_IDENTITY()

	END ELSE BEGIN

	 UPDATE [Company]
		SET
		 [Name] = @Name,
			[Address] = @Address,
			[Postcode] = @Postcode,
			[CountryId] = @CountryId,
			[Active] = @Active,
			[LBR] = @LBR,
			[COV] = @COV,
			[CAR] = @CAR,
			[TPA] = @TPA,
			[UpdatedDTO] = GETUTCDATE(),
			[UpdatedById] = @UserId
		WHERE [Id] = @CompanyId

	END

	EXEC [apiCompany] @UserId, @CountryId, @Name

	RETURN
END
GO

CREATE TABLE [Binder] (
  [Id] INT NOT NULL IDENTITY (1, 1),
		[UMR] NVARCHAR(50) NOT NULL,
		[Reference] NVARCHAR(50) NULL,
		[BrokerId] INT NOT NULL,
		[CoverholderId] INT NOT NULL,
		[InceptionDate] DATE NOT NULL,
		[ExpiryDate] DATE NOT NULL,
		[RisksTerritoryId] INT NOT NULL,
		[DomiciledTerritoryId] INT NOT NULL,
		[LimitsTerritoryId] INT NOT NULL,
		[CreatedDTO] DATETIMEOFFSET NOT NULL CONSTRAINT [DF_Binder_CreatedDTO] DEFAULT (GETUTCDATE()),
		[CreatedById] INT NOT NULL,
		[UpdatedDTO] DATETIMEOFFSET NOT NULL CONSTRAINT [DF_Binder_UpdatedDTO] DEFAULT (GETUTCDATE()),
		[UpdatedById] INT NOT NULL,
		CONSTRAINT [PK_Binder] PRIMARY KEY CLUSTERED ([Id]),
		CONSTRAINT [UQ_Binder_UMR] UNIQUE ([UMR]),
		CONSTRAINT [FK_Binder_Company_BrokerId] FOREIGN KEY ([BrokerId]) REFERENCES [Company] ([Id]),
		CONSTRAINT [FK_Binder_Company_CoverholderId] FOREIGN KEY ([CoverholderId]) REFERENCES [Company] ([Id]),
		CONSTRAINT [FK_Binder_Territory_RisksTerritoryId] FOREIGN KEY ([RisksTerritoryId]) REFERENCES [Territory] ([Id]),
		CONSTRAINT [FK_Binder_Territory_DomiciledTerritoryId] FOREIGN KEY ([DomiciledTerritoryId]) REFERENCES [Territory] ([Id]),
		CONSTRAINT [FK_Binder_Territory_LimitsTerritoryId] FOREIGN KEY ([LimitsTerritoryId]) REFERENCES [Territory] ([Id]),
		CONSTRAINT [FK_Binder_User_CreatedById] FOREIGN KEY ([CreatedById]) REFERENCES [User] ([Id]),
		CONSTRAINT [FK_Binder_User_UpdatedById] FOREIGN KEY ([UpdatedById]) REFERENCES [User] ([Id]),
		CONSTRAINT [CK_Binder_ExpiryDate] CHECK ([ExpiryDate] >= [InceptionDate])
	)
GO

INSERT INTO [Binder] ([UMR], [Reference], [BrokerId], [CoverholderId], [InceptionDate], [ExpiryDate], [RisksTerritoryId], [DomiciledTerritoryId], [LimitsTerritoryId], [CreatedById], [UpdatedById])
VALUES
 (N'UMR0001', N'REF00001', 1, 2, N'2012-01-01', N'2012-12-31', 0, 1, 3, 1, 1),
	(N'UMR0002', N'REF00002', 2, 1, N'2013-07-01', N'2014-06-30', 0, 2, 4, 1, 1)
GO

CREATE PROCEDURE [apiBinders](@UserId INT)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT
	 [BinderId] = b.[Id],
		[UMR] = b.[UMR],
		[Reference] = b.[Reference],
		[Broker] = lbr.[Name],
		[Coverholder] = cov.[Name],
		[InceptionDate] = b.[InceptionDate],
		[ExpiryDate] = b.[ExpiryDate]
	FROM [Binder] b
	 JOIN [Company] lbr ON b.[BrokerId] = lbr.[Id]
		JOIN [Company] cov ON b.[BrokerId] = cov.[Id]
	ORDER BY cov.[Name], b.[ExpiryDate] DESC, b.[UMR]
	RETURN
END
GO

CREATE PROCEDURE [apiBinder](@UserId INT, @BinderId INT)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT
	 [Id],
		[UMR], 
		[Reference],
		[BrokerId],
		[CoverholderId],
		[InceptionDate],
		[ExpiryDate],
		[RisksTerritoryId],
		[DomiciledTerritoryId],
		[LimitsTerritoryId]
	FROM [Binder]
	WHERE [Id] = @BinderId
	RETURN
END
GO

CREATE PROCEDURE [apiBinderCoverholder](@UserId INT, @BinderId INT = NULL)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 SELECT
	 [Id] = c.[Id],
		[Name] = c.[Name] + N' (' + c.[CountryId] + N')'
	FROM [Company] c
	 LEFT JOIN [Binder] b ON @BinderId = b.[Id] AND c.[Id] = b.[CoverholderId]
	WHERE c.[COV] & c.[Active] = 1
	 OR b.[Id] IS NOT NULL
	ORDER BY c.[Name], c.[CountryId]
	RETURN
END
GO

CREATE PROCEDURE [apiBinderBroker](@UserId INT, @BinderId INT = NULL)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 SELECT
	 [Id] = c.[Id],
		[Name] = c.[Name] + N' (' + c.[CountryId] + N')'
	FROM [Company] c
	 LEFT JOIN [Binder] b ON @BinderId = b.[Id] AND c.[Id] = b.[BrokerId]
	WHERE c.[LBR] & c.[Active] = 1
	 OR b.[Id] IS NOT NULL
	ORDER BY c.[Name], c.[CountryId]
	RETURN
END
GO