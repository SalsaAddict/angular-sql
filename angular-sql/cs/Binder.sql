USE [Advent]
GO

SET NOCOUNT ON
GO

IF OBJECT_ID(N'apiBinderSectionAdjuster', N'P') IS NOT NULL DROP PROCEDURE [apiBinderSectionAdjuster]
IF OBJECT_ID(N'apiBinderSection', N'P') IS NOT NULL DROP PROCEDURE [apiBinderSection]
IF OBJECT_ID(N'apiBinderSections', N'P') IS NOT NULL DROP PROCEDURE [apiBinderSections]
IF OBJECT_ID(N'BinderSection', N'U') IS NOT NULL DROP TABLE [BinderSection]
IF OBJECT_ID(N'apiClassOfBusiness', N'P') IS NOT NULL DROP PROCEDURE [apiClassOfBusiness]
IF OBJECT_ID(N'ClassOfBusiness', N'U') IS NOT NULL DROP TABLE [ClassOfBusiness]
IF OBJECT_ID(N'apiBinderDomiciled', N'P') IS NOT NULL DROP PROCEDURE [apiBinderDomiciled]
IF OBJECT_ID(N'apiBinderBroker', N'P') IS NOT NULL DROP PROCEDURE [apiBinderBroker]
IF OBJECT_ID(N'apiBinderCoverholder', N'P') IS NOT NULL DROP PROCEDURE [apiBinderCoverholder]
IF OBJECT_ID(N'apiBinderSave', N'P') IS NOT NULL DROP PROCEDURE [apiBinderSave]
IF OBJECT_ID(N'apiBinder', N'P') IS NOT NULL DROP PROCEDURE [apiBinder]
IF OBJECT_ID(N'apiBinders', N'P') IS NOT NULL DROP PROCEDURE [apiBinders]
IF OBJECT_ID(N'Binder', N'U') IS NOT NULL DROP TABLE [Binder]
IF OBJECT_ID(N'apiCompanySave', N'P') IS NOT NULL DROP PROCEDURE [apiCompanySave]
IF OBJECT_ID(N'apiCompanyRoles', N'P') IS NOT NULL DROP PROCEDURE [apiCompanyRoles]
IF OBJECT_ID(N'apiCompany', N'P') IS NOT NULL DROP PROCEDURE [apiCompany]
IF OBJECT_ID(N'apiCompanies', N'P') IS NOT NULL DROP PROCEDURE [apiCompanies]
IF OBJECT_ID(N'CompanyRole', N'U') IS NOT NULL DROP TABLE [CompanyRole]
IF OBJECT_ID(N'Company', N'U') IS NOT NULL DROP TABLE [Company]
IF OBJECT_ID(N'apiTerritories', N'P') IS NOT NULL DROP PROCEDURE [apiTerritories]
IF OBJECT_ID(N'vwTerritoryCountries', N'V') IS NOT NULL DROP VIEW [vwTerritoryCountries]
IF OBJECT_ID(N'TerritoryCountry', N'U') IS NOT NULL DROP TABLE [TerritoryCountry]
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

INSERT INTO [Country] ([Name], [Id])
VALUES
 (N'Afghanistan', N'AF'),
 (N'�land Islands', N'AX'),
 (N'Albania', N'AL'),
 (N'Algeria', N'DZ'),
 (N'American Samoa', N'AS'),
 (N'Andorra', N'AD'),
 (N'Angola', N'AO'),
 (N'Anguilla', N'AI'),
 (N'Antarctica', N'AQ'),
 (N'Antigua and Barbuda', N'AG'),
 (N'Argentina', N'AR'),
 (N'Armenia', N'AM'),
 (N'Aruba', N'AW'),
 (N'Australia', N'AU'),
 (N'Austria', N'AT'),
 (N'Azerbaijan', N'AZ'),
 (N'Bahamas', N'BS'),
 (N'Bahrain', N'BH'),
 (N'Bangladesh', N'BD'),
 (N'Barbados', N'BB'),
 (N'Belarus', N'BY'),
 (N'Belgium', N'BE'),
 (N'Belize', N'BZ'),
 (N'Benin', N'BJ'),
 (N'Bermuda', N'BM'),
 (N'Bhutan', N'BT'),
 (N'Bolivia, Plurinational State of', N'BO'),
 (N'Bonaire, Sint Eustatius and Saba', N'BQ'),
 (N'Bosnia and Herzegovina', N'BA'),
 (N'Botswana', N'BW'),
 (N'Bouvet Island', N'BV'),
 (N'Brazil', N'BR'),
 (N'British Indian Ocean Territory', N'IO'),
 (N'Brunei Darussalam', N'BN'),
 (N'Bulgaria', N'BG'),
 (N'Burkina Faso', N'BF'),
 (N'Burundi', N'BI'),
 (N'Cambodia', N'KH'),
 (N'Cameroon', N'CM'),
 (N'Canada', N'CA'),
 (N'Cape Verde', N'CV'),
 (N'Cayman Islands', N'KY'),
 (N'Central African Republic', N'CF'),
 (N'Chad', N'TD'),
 (N'Chile', N'CL'),
 (N'China', N'CN'),
 (N'Christmas Island', N'CX'),
 (N'Cocos (Keeling) Islands', N'CC'),
 (N'Colombia', N'CO'),
 (N'Comoros', N'KM'),
 (N'Congo', N'CG'),
 (N'Congo, the Democratic Republic of the', N'CD'),
 (N'Cook Islands', N'CK'),
 (N'Costa Rica', N'CR'),
 (N'Côte d''Ivoire', N'CI'),
 (N'Croatia', N'HR'),
 (N'Cuba', N'CU'),
 (N'Curaçao', N'CW'),
 (N'Cyprus', N'CY'),
 (N'Czech Republic', N'CZ'),
 (N'Denmark', N'DK'),
 (N'Djibouti', N'DJ'),
 (N'Dominica', N'DM'),
 (N'Dominican Republic', N'DO'),
 (N'Ecuador', N'EC'),
 (N'Egypt', N'EG'),
 (N'El Salvador', N'SV'),
 (N'Equatorial Guinea', N'GQ'),
 (N'Eritrea', N'ER'),
 (N'Estonia', N'EE'),
 (N'Ethiopia', N'ET'),
 (N'Falkland Islands (Malvinas)', N'FK'),
 (N'Faroe Islands', N'FO'),
 (N'Fiji', N'FJ'),
 (N'Finland', N'FI'),
 (N'France', N'FR'),
 (N'French Guiana', N'GF'),
 (N'French Polynesia', N'PF'),
 (N'French Southern Territories', N'TF'),
 (N'Gabon', N'GA'),
 (N'Gambia', N'GM'),
 (N'Georgia', N'GE'),
 (N'Germany', N'DE'),
 (N'Ghana', N'GH'),
 (N'Gibraltar', N'GI'),
 (N'Greece', N'GR'),
 (N'Greenland', N'GL'),
 (N'Grenada', N'GD'),
 (N'Guadeloupe', N'GP'),
 (N'Guam', N'GU'),
 (N'Guatemala', N'GT'),
 (N'Guernsey', N'GG'),
 (N'Guinea', N'GN'),
 (N'Guinea-Bissau', N'GW'),
 (N'Guyana', N'GY'),
 (N'Haiti', N'HT'),
 (N'Heard Island and McDonald Mcdonald Islands', N'HM'),
 (N'Holy See (Vatican City State)', N'VA'),
 (N'Honduras', N'HN'),
 (N'Hong Kong', N'HK'),
 (N'Hungary', N'HU'),
 (N'Iceland', N'IS'),
 (N'India', N'IN'),
 (N'Indonesia', N'ID'),
 (N'Iran, Islamic Republic of', N'IR'),
 (N'Iraq', N'IQ'),
 (N'Ireland', N'IE'),
 (N'Isle of Man', N'IM'),
 (N'Israel', N'IL'),
 (N'Italy', N'IT'),
 (N'Jamaica', N'JM'),
 (N'Japan', N'JP'),
 (N'Jersey', N'JE'),
 (N'Jordan', N'JO'),
 (N'Kazakhstan', N'KZ'),
 (N'Kenya', N'KE'),
 (N'Kiribati', N'KI'),
 (N'Korea, Democratic People''s Republic of', N'KP'),
 (N'Korea, Republic of', N'KR'),
 (N'Kuwait', N'KW'),
 (N'Kyrgyzstan', N'KG'),
 (N'Lao People''s Democratic Republic', N'LA'),
 (N'Latvia', N'LV'),
 (N'Lebanon', N'LB'),
 (N'Lesotho', N'LS'),
 (N'Liberia', N'LR'),
 (N'Libya', N'LY'),
 (N'Liechtenstein', N'LI'),
 (N'Lithuania', N'LT'),
 (N'Luxembourg', N'LU'),
 (N'Macao', N'MO'),
 (N'Macedonia, the Former Yugoslav Republic of', N'MK'),
 (N'Madagascar', N'MG'),
 (N'Malawi', N'MW'),
 (N'Malaysia', N'MY'),
 (N'Maldives', N'MV'),
 (N'Mali', N'ML'),
 (N'Malta', N'MT'),
 (N'Marshall Islands', N'MH'),
 (N'Martinique', N'MQ'),
 (N'Mauritania', N'MR'),
 (N'Mauritius', N'MU'),
 (N'Mayotte', N'YT'),
 (N'Mexico', N'MX'),
 (N'Micronesia, Federated States of', N'FM'),
 (N'Moldova, Republic of', N'MD'),
 (N'Monaco', N'MC'),
 (N'Mongolia', N'MN'),
 (N'Montenegro', N'ME'),
 (N'Montserrat', N'MS'),
 (N'Morocco', N'MA'),
 (N'Mozambique', N'MZ'),
 (N'Myanmar', N'MM'),
 (N'Namibia', N'NA'),
 (N'Nauru', N'NR'),
 (N'Nepal', N'NP'),
 (N'Netherlands', N'NL'),
 (N'New Caledonia', N'NC'),
 (N'New Zealand', N'NZ'),
 (N'Nicaragua', N'NI'),
 (N'Niger', N'NE'),
 (N'Nigeria', N'NG'),
 (N'Niue', N'NU'),
 (N'Norfolk Island', N'NF'),
 (N'Northern Mariana Islands', N'MP'),
 (N'Norway', N'NO'),
 (N'Oman', N'OM'),
 (N'Pakistan', N'PK'),
 (N'Palau', N'PW'),
 (N'Palestine, State of', N'PS'),
 (N'Panama', N'PA'),
 (N'Papua New Guinea', N'PG'),
 (N'Paraguay', N'PY'),
 (N'Peru', N'PE'),
 (N'Philippines', N'PH'),
 (N'Pitcairn', N'PN'),
 (N'Poland', N'PL'),
 (N'Portugal', N'PT'),
 (N'Puerto Rico', N'PR'),
 (N'Qatar', N'QA'),
 (N'Réunion', N'RE'),
 (N'Romania', N'RO'),
 (N'Russian Federation', N'RU'),
 (N'Rwanda', N'RW'),
 (N'Saint Barthélemy', N'BL'),
 (N'Saint Helena, Ascension and Tristan da Cunha', N'SH'),
 (N'Saint Kitts and Nevis', N'KN'),
 (N'Saint Lucia', N'LC'),
 (N'Saint Martin (French part)', N'MF'),
 (N'Saint Pierre and Miquelon', N'PM'),
 (N'Saint Vincent and the Grenadines', N'VC'),
 (N'Samoa', N'WS'),
 (N'San Marino', N'SM'),
 (N'Sao Tome and Principe', N'ST'),
 (N'Saudi Arabia', N'SA'),
 (N'Senegal', N'SN'),
 (N'Serbia', N'RS'),
 (N'Seychelles', N'SC'),
 (N'Sierra Leone', N'SL'),
 (N'Singapore', N'SG'),
 (N'Sint Maarten (Dutch part)', N'SX'),
 (N'Slovakia', N'SK'),
 (N'Slovenia', N'SI'),
 (N'Solomon Islands', N'SB'),
 (N'Somalia', N'SO'),
 (N'South Africa', N'ZA'),
 (N'South Georgia and the South Sandwich Islands', N'GS'),
 (N'South Sudan', N'SS'),
 (N'Spain', N'ES'),
 (N'Sri Lanka', N'LK'),
 (N'Sudan', N'SD'),
 (N'Suriname', N'SR'),
 (N'Svalbard and Jan Mayen', N'SJ'),
 (N'Swaziland', N'SZ'),
 (N'Sweden', N'SE'),
 (N'Switzerland', N'CH'),
 (N'Syrian Arab Republic', N'SY'),
 (N'Taiwan, Province of China', N'TW'),
 (N'Tajikistan', N'TJ'),
 (N'Tanzania, United Republic of', N'TZ'),
 (N'Thailand', N'TH'),
 (N'Timor-Leste', N'TL'),
 (N'Togo', N'TG'),
 (N'Tokelau', N'TK'),
 (N'Tonga', N'TO'),
 (N'Trinidad and Tobago', N'TT'),
 (N'Tunisia', N'TN'),
 (N'Turkey', N'TR'),
 (N'Turkmenistan', N'TM'),
 (N'Turks and Caicos Islands', N'TC'),
 (N'Tuvalu', N'TV'),
 (N'Uganda', N'UG'),
 (N'Ukraine', N'UA'),
 (N'United Arab Emirates', N'AE'),
 (N'United Kingdom', N'GB'),
 (N'United States', N'US'),
 (N'United States Minor Outlying Islands', N'UM'),
 (N'Uruguay', N'UY'),
 (N'Uzbekistan', N'UZ'),
 (N'Vanuatu', N'VU'),
 (N'Venezuela, Bolivarian Republic of', N'VE'),
 (N'Viet Nam', N'VN'),
 (N'Virgin Islands, British', N'VG'),
 (N'Virgin Islands, U.S.', N'VI'),
 (N'Wallis and Futuna', N'WF'),
 (N'Western Sahara', N'EH'),
 (N'Yemen', N'YE'),
 (N'Zambia', N'ZM'),
 (N'Zimbabwe', N'ZW')
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
 (1, 1, N'GB'),
	(2, 1, N'US'),
	(3, 0, N'GB'),
	(4, 0, N'US')
GO

CREATE VIEW [vwTerritoryCountries]
AS
SELECT
 [TerritoryId] = t.[Id],
	[Territory] = t.[Name],
	[CountryId] = c.[Id],
	[Country] = c.[Name]
FROM [Territory] t CROSS JOIN [Country] c
 LEFT JOIN [TerritoryCountry] tc ON t.[Id] = tc.[TerritoryId] AND c.[Id] = tc.[CountryId]
WHERE (
   t.[Type] IS NULL
			OR (t.[Type] = 1 AND tc.[CountryId] IS NOT NULL)
			OR (t.[Type] = 0 AND tc.[CountryId] IS NULL)
  )
GO

CREATE PROCEDURE [apiTerritories](@CountryId NCHAR(2) = NULL)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	IF @CountryId IS NULL
	 SELECT [TerritoryId] = [Id], [Territory] = [Name]
		FROM [Territory]
		ORDER BY [Name]
	ELSE
	 SELECT [TerritoryId], [Territory]
		FROM [vwTerritoryCountries]
		WHERE [CountryId] = @CountryId
		ORDER BY [Territory]
	RETURN
END
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
		CONSTRAINT [FK_Company_User_UpdatedById] FOREIGN KEY ([UpdatedById]) REFERENCES [User] ([Id]),
		CONSTRAINT [CK_Company_UpdatedDTO] CHECK ([UpdatedDTO] >= [CreatedDTO])
	)
GO

INSERT INTO [Company] ([Name], [CountryId], [LBR], [COV], [CreatedById], [UpdatedById])
VALUES
 (N'Whitespace Software Limited', N'GB', 1, 0, 1, 1),
	(N'Datarise Limited', N'US', 0, 1, 2, 2)
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

CREATE PROCEDURE [apiCompany](@UserId INT, @CompanyId INT)
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
		[TPA] = cmp.[TPA],
		[UpdatedDTO] = cmp.[UpdatedDTO]
	FROM [Company] cmp
	WHERE cmp.[Id] = @CompanyId
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
		@Name NVARCHAR(255) = NULL,
		@Address NVARCHAR(255) = NULL,
		@Postcode NVARCHAR(25) = NULL,
		@CountryId NCHAR(2) = NULL,
		@LBR BIT = NULL,
		@COV BIT = NULL,
		@CAR BIT = NULL,
		@TPA BIT = NULL,
		@Active BIT = NULL,
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
				[CreatedDTO],
				[CreatedById],
				[UpdatedDTO],
				[UpdatedById],
				[Active]
			)
		VALUES (
		  @Name,
				@Address,
				@Postcode,
				ISNULL(@CountryId, N'GB'),
				ISNULL(@LBR, 0),
				ISNULL(@COV, 0),
				ISNULL(@CAR, 0),
				ISNULL(@TPA, 0),
				GETUTCDATE(),
				@UserId,
				GETUTCDATE(),
				@UserId,
				ISNULL(@Active, 1)
			)
		SET @CompanyId = SCOPE_IDENTITY()

	END ELSE BEGIN

	 UPDATE [Company]
		SET
		 [Name] = ISNULL(@Name, [Name]),
			[Address] = ISNULL(@Address, [Address]),
			[Postcode] = ISNULL(@Postcode, [Postcode]),
			[CountryId] = ISNULL(@CountryId, [CountryId]),
			[LBR] = ISNULL(@LBR, [LBR]),
			[COV] = ISNULL(@COV, [LBR]),
			[CAR] = ISNULL(@CAR, [CAR]),
			[TPA] = ISNULL(@TPA, [TPA]),
			[UpdatedDTO] = GETUTCDATE(),
			[UpdatedById] = @UserId,
			[Active] = ISNULL(@Active, [Active])
		WHERE [Id] = @CompanyId

	END

	EXEC [apiCompany] @UserId, @CompanyId

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
		CONSTRAINT [CK_Binder_ExpiryDate] CHECK ([ExpiryDate] >= [InceptionDate]),
		CONSTRAINT [CK_Binder_UpdatedDTO] CHECK ([UpdatedDTO] >= [CreatedDTO])
	)
GO

INSERT INTO [Binder] ([UMR], [Reference], [BrokerId], [CoverholderId], [InceptionDate], [ExpiryDate], [RisksTerritoryId], [DomiciledTerritoryId], [LimitsTerritoryId], [CreatedById], [UpdatedById])
VALUES
 (N'UMR0001', N'REF00001', 1, 2, N'2012-01-01', N'2012-12-31', 0, 2, 4, 1, 1),
	(N'UMR0002', N'REF00002', 2, 1, N'2013-07-01', N'2014-06-30', 0, 1, 3, 1, 1)
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
	 [BinderId] = b.[Id],
		[UMR] = b.[UMR], 
		[Reference] = b.[Reference],
		[BrokerId] = b.[BrokerId],
		[CoverholderId] = b.[CoverholderId],
		[InceptionDate] = b.[InceptionDate],
		[ExpiryDate] = b.[ExpiryDate],
		[RisksTerritoryId] = b.[RisksTerritoryId],
		[DomiciledTerritoryId] = b.[DomiciledTerritoryId],
		[LimitsTerritoryId] = b.[LimitsTerritoryId]
	FROM [Binder] b
	WHERE b.[Id] = @BinderId
	RETURN
END
GO

CREATE PROCEDURE [apiBinderSave](
  @BinderId INT = NULL,
  @UMR NVARCHAR(50) = NULL,
		@Reference NVARCHAR(50) = NULL,
		@BrokerId INT = NULL,
		@CoverholderId INT = NULL,
		@InceptionDate DATE = NULL,
		@ExpiryDate DATE = NULL,
		@RisksTerritoryId INT = NULL,
		@DomiciledTerritoryId INT = NULL,
		@LimitsTerritoryId INT = NULL,
  @UserId INT
	)
AS
BEGIN
 IF @BinderId IS NULL BEGIN

		INSERT INTO [Binder] (
				[UMR],
				[Reference],
				[BrokerId],
				[CoverholderId],
				[InceptionDate],
				[ExpiryDate],
				[RisksTerritoryId],
				[DomiciledTerritoryId],
				[LimitsTerritoryId],
				[CreatedDTO],
				[CreatedById],
				[UpdatedDTO],
				[UpdatedById]
			)
		SELECT
			[UMR] = @UMR,
			[Reference] = @Reference,
			[BrokerId] = @BrokerId,
			[CoverholderId] = @CoverholderId,
			[InceptionDate] = @InceptionDate,
			[ExpiryDate] = @ExpiryDate,
			[RisksTerritoryId] = @RisksTerritoryId,
			[DomiciledTerritoryId] = @DomiciledTerritoryId,
			[LimitsTerritoryId] = @LimitsTerritoryId,
			[CreatedDTO] = GETUTCDATE(),
			[CreatedById] = @UserId,
			[UpdatedDTO] = GETUTCDATE(),
			[UpdatedById] = @UserId
		SET @BinderId = SCOPE_IDENTITY()

	END ELSE BEGIN

		UPDATE [Binder]
		SET
			[UMR] = ISNULL(@UMR, [UMR]),
			[Reference] = ISNULL(@Reference, [Reference]),
			[BrokerId] = ISNULL(@BrokerId, [BrokerId]),
			[CoverholderId] = ISNULL(@CoverholderId, [CoverholderId]),
			[InceptionDate] = ISNULL(@InceptionDate, [InceptionDate]),
			[ExpiryDate] = ISNULL(@ExpiryDate, [ExpiryDate]),
			[RisksTerritoryId] = ISNULL(@RisksTerritoryId, [RisksTerritoryId]),
			[DomiciledTerritoryId] = ISNULL(@DomiciledTerritoryId, [DomiciledTerritoryId]),
			[LimitsTerritoryId] = ISNULL(@LimitsTerritoryId, [LimitsTerritoryId]),
			[UpdatedDTO] = GETUTCDATE(),
			[UpdatedById] = @UserId
		WHERE [Id] = @BinderId

	END

	EXEC [apiBinder] @UserId, @BinderId

END
GO

CREATE PROCEDURE [apiBinderCoverholder](@UserId INT, @BinderId INT = NULL)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 SELECT
	 [CoverholderId] = c.[Id],
		[Coverholder] = c.[Name] + N' (' + c.[CountryId] + N')'
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
	 [BrokerId] = c.[Id],
		[Broker] = c.[Name] + N' (' + c.[CountryId] + N')'
	FROM [Company] c
	 LEFT JOIN [Binder] b ON @BinderId = b.[Id] AND c.[Id] = b.[BrokerId]
	WHERE c.[LBR] & c.[Active] = 1
	 OR b.[Id] IS NOT NULL
	ORDER BY c.[Name], c.[CountryId]
	RETURN
END
GO

CREATE PROCEDURE [apiBinderDomiciled](@UserId INT, @CoverholderId INT, @DomiciledTerritoryId INT)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT [Valid] = CONVERT(BIT, CASE WHEN EXISTS (
	  SELECT 1
			FROM [Company] cmp
			 JOIN [vwTerritoryCountries] tc ON cmp.[CountryId] = tc.[CountryId]
			WHERE cmp.[Id] = @CoverholderId
			 AND tc.[TerritoryId] = @DomiciledTerritoryId
		) THEN 1 END)
	RETURN
END
GO

CREATE TABLE [ClassOfBusiness] (
  [Id] NVARCHAR(5) NOT NULL,
		[Description] NVARCHAR(255) NOT NULL,
		CONSTRAINT [PK_ClassOfBusiness] PRIMARY KEY NONCLUSTERED ([Id]),
		CONSTRAINT [UQ_ClassOfBusiness_Description] UNIQUE CLUSTERED ([Description])
	)
GO

INSERT INTO [ClassOfBusiness] ([Id], [Description])
VALUES
 (N'MOTOR', N'Motor'),
	(N'PROP', N'Property'),
	(N'BI', N'Business Interruption'),
	(N'PROD', N'Product Liability'),
	(N'PUB', N'Public Liability'),
	(N'EMP', N'Employers Liability')
GO

CREATE PROCEDURE [apiClassOfBusiness](@UserId INT)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT [Id], [Description] FROM [ClassOfBusiness] ORDER BY [Description]
	RETURN
END
GO

CREATE TABLE [BinderSection] (
  [Id] INT NOT NULL IDENTITY (1, 1),
  [BinderId] INT NOT NULL,
		[ClassId] NVARCHAR(5) NOT NULL,
		[Title] NVARCHAR(255) NOT NULL,
		[AdjusterId] INT NOT NULL,
		[CreatedDTO] DATETIMEOFFSET NOT NULL CONSTRAINT [DF_BinderSection_CreatedDTO] DEFAULT (GETUTCDATE()),
		[CreatedById] INT NOT NULL,
		[UpdatedDTO] DATETIMEOFFSET NOT NULL CONSTRAINT [DF_BinderSection_UpdatedDTO] DEFAULT (GETUTCDATE()),
		[UpdatedById] INT NOT NULL,
		CONSTRAINT [PK_BinderSection] PRIMARY KEY NONCLUSTERED ([Id]),
		CONSTRAINT [UQ_BinderSection_Title] UNIQUE CLUSTERED ([BinderId], [Title]),
		CONSTRAINT [FK_BinderSection_Binder] FOREIGN KEY ([BinderId]) REFERENCES [Binder] ([Id]) ON DELETE CASCADE,
		CONSTRAINT [FK_BinderSection_ClassOfBusiness] FOREIGN KEY ([ClassId]) REFERENCES [ClassOfBusiness] ([Id]) ON UPDATE CASCADE,
		CONSTRAINT [FK_BinderSection_User_CreatedById] FOREIGN KEY ([CreatedById]) REFERENCES [User] ([Id]),
		CONSTRAINT [FK_BinderSection_User_UpdatedById] FOREIGN KEY ([UpdatedById]) REFERENCES [User] ([Id]),
		CONSTRAINT [CK_BinderSection_UpdatedDTO] CHECK ([UpdatedDTO] >= [CreatedDTO])
	)
GO

INSERT INTO [BinderSection] ([BinderId], [ClassId], [Title], [AdjusterId], [CreatedById], [UpdatedById])
VALUES
 (1, N'PROP', N'Property', 1, 1, 1),
	(1, N'BI', N'Business Interruption', 1, 1, 1)
GO

CREATE PROCEDURE [apiBinderSections] (@UserId INT, @BinderId INT)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT
	 [SectionId] = bs.[Id],
		[Title] = bs.[Title],
		[Class] = cob.[Description]
	FROM [Binder] b
	 JOIN [BinderSection] bs ON b.[Id] = bs.[BinderId]
		JOIN [ClassOfBusiness] cob ON bs.[ClassId] = cob.[Id]
	WHERE b.[Id] = @BinderId
	ORDER BY bs.[Title]
	RETURN
END
GO

CREATE PROCEDURE [apiBinderSection](@UserId INT, @SectionId INT)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT
	 [SectionId] = bs.[Id],
		[BinderId] = bs.[BinderId],
		[ClassId] = bs.[ClassId],
		[Title] = bs.[Title],
		[AdjusterId] = bs.[AdjusterId]
	FROM [BinderSection] bs
	WHERE bs.[Id] = @SectionId
	RETURN
END
GO

CREATE PROCEDURE [apiBinderSectionAdjuster](@UserId INT, @SectionId INT)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 SELECT
	 [AdjusterId] = c.[Id],
		[Adjuster] = c.[Name] + N' (' + c.[CountryId] + N')'
	FROM [Company] c
	 LEFT JOIN [BinderSection] bs ON @SectionId = bs.[Id] AND c.[Id] = bs.[AdjusterId]
	WHERE c.[TPA] & c.[Active] = 1
	 OR bs.[Id] IS NOT NULL
	ORDER BY c.[Name], c.[CountryId]
	RETURN
END
GO

EXEC [apiBinderSection] 1, 1
EXEC [apiBinderSectionAdjuster] 1, 1