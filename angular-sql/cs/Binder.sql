USE [Advent]
GO

SET NOCOUNT ON
GO

IF OBJECT_ID(N'apiBinderSectionCarrier', N'P') IS NOT NULL DROP PROCEDURE [apiBinderSectionCarrier]
IF OBJECT_ID(N'apiBinderSectionAdministrator', N'P') IS NOT NULL DROP PROCEDURE [apiBinderSectionAdministrator]
IF OBJECT_ID(N'apiBinderSection', N'P') IS NOT NULL DROP PROCEDURE [apiBinderSection]
IF OBJECT_ID(N'apiBinderSections', N'P') IS NOT NULL DROP PROCEDURE [apiBinderSections]
IF OBJECT_ID(N'BinderSectionCarrier', N'U') IS NOT NULL DROP TABLE [BinderSectionCarrier]
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
 (N'Cote d''Ivoire', N'CI'),
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
 (N'Reunion', N'RE'),
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
		[DisplayName] AS [Name] + N' (' + [CountryId] + N')' PERSISTED,
		[Address] NVARCHAR(255) NULL,
		[Postcode] NVARCHAR(25) NULL,
		[CountryId] NCHAR(2) NOT NULL,
		[LBR] BIT NOT NULL CONSTRAINT [DF_Company_LBR] DEFAULT (0), -- Lloyd's Broker
		[COV] BIT NOT NULL CONSTRAINT [DF_Company_COV] DEFAULT (0), -- Coverholder
		[CAR] BIT NOT NULL CONSTRAINT [DF_Company_CAR] DEFAULT (0), -- Carrier
		[TPA] BIT NOT NULL CONSTRAINT [DF_Company_TPA] DEFAULT (0), -- Third-Party Administrator
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

INSERT INTO [Company] ([Name], [CountryId], [LBR], [COV], [CAR], [TPA], [CreatedById], [UpdatedById])
SELECT [Name], [CountryId], [LBR], [COV], [CAR], [TPA], 1, 1
FROM (VALUES
   ('A Plus Lawn Care'),
   ('A+ Investments'),
   ('Aaronson Furniture'),
   ('Accord Investments'),
   ('Acuserv'),
   ('Adapt'),
   ('Alexander''s'),
   ('Allied Radio'),
   ('Anderson-Little'),
   ('Angel''s'),
   ('Asian Answers'),
   ('Asian Junction'),
   ('Asian Plan'),
   ('Atlas Architectural Designs'),
   ('Atlas Realty'),
   ('Audio Visions'),
   ('Avant Garde Appraisal Group'),
   ('Avant Garde Interior Designs'),
   ('Balanced Fortune'),
   ('Baltimore Markets'),
   ('Bay Furniture'),
   ('Best Products'),
   ('Big A Auto Parts'),
   ('Big D Supermarkets'),
   ('Big Star Markets'),
   ('Blockbuster Music'),
   ('Body Toning'),
   ('Bold Ideas'),
   ('Bonanza Produce Stores'),
   ('Briazz'),
   ('Brilliant Home Designs'),
   ('Britling Cafeterias'),
   ('Brooks Fashions'),
   ('Buehler Foods'),
   ('Buena Vista Garden Maintenance'),
   ('Builders Emporium'),
   ('Burger Chef'),
   ('Carl Durfees'),
   ('Carter''s Foods'),
   ('Castro Convertibles'),
   ('Central Hardware'),
   ('Channel Home Centers'),
   ('Chargepal'),
   ('Cherry & Webb'),
   ('Chess King'),
   ('Chi-Chi''s'),
   ('Children''s Palace'),
   ('Circuit Design'),
   ('Club Wholesale'),
   ('Coast to Coast Hardware'),
   ('Coconut''s'),
   ('Colonial Stores'),
   ('Compact Disc Center'),
   ('CompuAdd'),
   ('Consumers and Consumers Express'),
   ('Cougar Investment'),
   ('Country Club Markets'),
   ('Crafts Canada'),
   ('Crazy Eddie'),
   ('Crown Books'),
   ('Cut Above'),
   ('Dave Cooks'),
   ('De Pinna'),
   ('Delchamps'),
   ('Destiny Planners'),
   ('Destiny Realty'),
   ('Dick Fischers'),
   ('Disc Jockey'),
   ('Dream Home Improvements'),
   ('Druther''s'),
   ('Earl Abel''s'),
   ('Earthworks Garden Kare'),
   ('Earthworks Yard Maintenance'),
   ('Eden Lawn Service'),
   ('Edge Yard Service'),
   ('Eisner Food Stores'),
   ('Electric Avenue'),
   ('Electronic Geek'),
   ('Electronics Source'),
   ('Ellman''s Catalog Showrooms'),
   ('Elm Farm'),
   ('Endicott Johnson'),
   ('Endicott Shoes'),
   ('Envirotecture Design Service'),
   ('Erb Lumber'),
   ('Erol''s'),
   ('Exact Solutions'),
   ('EXPO Design Center'),
   ('Express Merchant Service'),
   ('E-zhe Source'),
   ('Farmer Jack'),
   ('Fayva'),
   ('Fedco'),
   ('First Choice Yard Help'),
   ('First Rate Choice'),
   ('Flipside Records'),
   ('FlowerTime'),
   ('Food Fair'),
   ('Food Mart'),
   ('Foreman & Clark'),
   ('Forest City'),
   ('Formula Gray'),
   ('Foxmoor'),
   ('Franklin Simon'),
   ('Frank''s Nursery & Crafts'),
   ('Fresh Start'),
   ('Future Bright'),
   ('Future Plan'),
   ('G.I. Joe''s'),
   ('Galaxy Man'),
   ('Gallenkamp'),
   ('Galyan''s'),
   ('Gamma Grays'),
   ('Gantos'),
   ('Garden Guru'),
   ('Garden Master'),
   ('Gas Depot'),
   ('Geri''s Hamburgers'),
   ('Giant'),
   ('Gino''s Hamburgers'),
   ('Gold Leaf Garden Management'),
   ('Gold Touch'),
   ('Golden''s Distributors'),
   ('Golf Augusta Pro Shops'),
   ('Good Guys'),
   ('Grade A Investment'),
   ('Grand Union'),
   ('Great American Music'),
   ('Great Clothes'),
   ('Grossman''s'),
   ('Handy Andy'),
   ('Hanover Shoe'),
   ('Hastings'),
   ('Heilig-Meyers'),
   ('Helios Air'),
   ('Helping Hand'),
   ('Henry''s'),
   ('Herman''s World of Sporting Goods'),
   ('Highland Appliance'),
   ('Hills Supermarkets'),
   ('Holly Tree Inn'),
   ('Home Centers'),
   ('Home Quarters Warehouse'),
   ('HomeBase'),
   ('Honest Air Group'),
   ('House Of Denmark'),
   ('House Works'),
   ('Hoyden'),
   ('Hudson''s MensWear'),
   ('Hugh M. Woods'),
   ('Hughes & Hatcher'),
   ('Hughes Markets'),
   ('Ideal Garden Management'),
   ('Incredible Universe'),
   ('Integra Design'),
   ('Integra Wealth'),
   ('Intelacard'),
   ('Intelli Wealth Group'),
   ('Irving''s Sporting Goods'),
   ('J. K. Gill Company'),
   ('Jack Lang'),
   ('Janeville'),
   ('Jitney Jungle'),
   ('Judy''s'),
   ('Just For Feet'),
   ('K&G Distributors'),
   ('Karl''s Shoes'),
   ('Keeney''s'),
   ('Kelly and Cohen'),
   ('Kelsey''s Neighbourhood Bar & Grill'),
   ('Kids Mart'),
   ('Kinney Shoes'),
   ('Knockout Kickboxing'),
   ('Kohl''s Food Stores'),
   ('Kragen Auto Parts'),
   ('Krauses Sofa Factory'),
   ('L'' Fish'),
   ('Landskip Yard Care'),
   ('Larry''s Markets'),
   ('Laughner''s Cafeteria'),
   ('Laura Ashley Mother & Child'),
   ('Laura Ashley'),
   ('Lechters Housewares'),
   ('Leonard Krower & Sons'),
   ('Liberal'),
   ('Liberty Wealth Planner'),
   ('Licorice Pizza'),
   ('Life Map Planners'),
   ('Life Map'),
   ('Listenin'' Booth'),
   ('Little Folk Shops'),
   ('Littler''s'),
   ('Lone Wolf Wealth Planning'),
   ('Luria''s'),
   ('MacMarr Stores'),
   ('Macroserve'),
   ('Madcats Music & Books'),
   ('Mages'),
   ('Magik Gray'),
   ('Magik Grey'),
   ('Magna Architectural Design'),
   ('Magna Solution'),
   ('Magna Wealth'),
   ('Manu Connection'),
   ('Marianne'),
   ('Market Basket'),
   ('Matrix Design'),
   ('Matrix Interior Design'),
   ('Maurice The Pants Man'),
   ('Maxiserve '),
   ('Maxi-Tech'),
   ('Megatronic'),
   ('Merry-Go-Round'),
   ('Metro'),
   ('Mighty Casey''s'),
   ('Mikro Designs'),
   ('Mikrotechnic'),
   ('Mission Realty'),
   ('Mission You'),
   ('Modern Architecture Design'),
   ('Modern Realty'),
   ('Monit'),
   ('Monk Home Funding Services'),
   ('Monk Home Improvements'),
   ('Monk Home Loans'),
   ('Monk Real Estate Service'),
   ('Monsource'),
   ('Morrie Mages'),
   ('Movie Gallery'),
   ('Multicerv'),
   ('Muscle Factory'),
   ('Music Den'),
   ('Musicland'),
   ('MVP Sports'),
   ('Nan Duskin'),
   ('National Tea'),
   ('Nedick''s'),
   ('Netcore'),
   ('Netobill'),
   ('Newhair'),
   ('Newmark & Lewis'),
   ('Northern Reflections'),
   ('Northern Star'),
   ('Nutri G'),
   ('O.K. Fairbanks'),
   ('Office Warehouse'),
   ('Official All Star Caf�'),
   ('Olympic Sports'),
   ('Omni Architectural Designs'),
   ('Omni Superstore'),
   ('Omni Tech Solutions'),
   ('On Cue'),
   ('One-Up Realtors'),
   ('One-Up Realty'),
   ('Opticomp'),
   ('Oranges Records & Tapes'),
   ('Orion'),
   ('Pace Membership Warehouse'),
   ('Pak and Save'),
   ('Pantry Pride'),
   ('Parts America'),
   ('Patterson-Fletcher'),
   ('Paul''s Food Mart'),
   ('Paul''s Record Hut'),
   ('Pay ''N Pak'),
   ('Payless Cashways'),
   ('Pay''N Takeit'),
   ('Pender''s Food Stores'),
   ('Piccolo Mondo'),
   ('Piece Goods Fabric'),
   ('Plan Future'),
   ('Plan Smart Partner'),
   ('Plan Smart'),
   ('Planet Pizza'),
   ('Planetbiz'),
   ('Platinum Interior Design'),
   ('Play Town'),
   ('Pleasures and Pasttimes'),
   ('Pointers'),
   ('Poore Simon''s'),
   ('Practi-Plan Mapping'),
   ('Practi-Plan'),
   ('Prahject Planner'),
   ('Price Club'),
   ('PriceRite Warehouse Club'),
   ('Pro Property Maintenance'),
   ('Pro Star Garden Management'),
   ('Pro-Care Garden Maintenance'),
   ('Protean'),
   ('Quality Event Planner'),
   ('Quality Merchant Services'),
   ('Quest Technology Service'),
   ('Rack N Sack'),
   ('Rainbow Life'),
   ('Red Baron Electronics'),
   ('Red Food'),
   ('Rhodes Furniture'),
   ('Rickel'),
   ('Roadhouse Grill'),
   ('Roberd''s'),
   ('Robinson Furniture'),
   ('Romp'),
   ('Rossi Auto Parts'),
   ('Rustler Steak House'),
   ('S&W Cafeteria'),
   ('Sam Goody'),
   ('Sammy''s Record Shack'),
   ('Sandy''s'),
   ('Sanitary Grocery Stores'),
   ('Schaak Electronics'),
   ('Scott Ties'),
   ('Scotty''s Builders Supply'),
   ('Seamans Furniture'),
   ('Sears Homelife'),
   ('Second Time Around'),
   ('Sew-Fro Fabrics'),
   ('Shoe Kicks'),
   ('Shoe Pavilion'),
   ('Shoe Town'),
   ('Signa Air'),
   ('Smitty''s Marketplace'),
   ('Soft Warehouse'),
   ('Solution Bridge'),
   ('Soul Sounds Unlimited'),
   ('Sound Advice'),
   ('Sound Warehouse'),
   ('Sounds of Soul Records & Tapes'),
   ('Source Club'),
   ('Sportmart'),
   ('Star Merchant Services'),
   ('Starship Tapes & Records'),
   ('Steinberg''s'),
   ('Steve''s Ice Cream'),
   ('Stop and Shop'),
   ('Stop N Shop'),
   ('Stratabiz'),
   ('Strategic Profit'),
   ('Strategy Consulting'),
   ('Strategy Planner'),
   ('Strength Gurus'),
   ('Success Is Yours'),
   ('Sun Television and Appliances'),
   ('Sunflower Market'),
   ('Sunny Real Estate Investments'),
   ('Super Shops'),
   ('Susie''s Casuals'),
   ('System Star'),
   ('Tape World'),
   ('Team Electronics'),
   ('Tee Town'),
   ('Terra Nova Garden Services'),
   ('Thalhimers'),
   ('The Goose and Duck'),
   ('The Great Train Stores'),
   ('The Independent Planners'),
   ('The Lawn Guru'),
   ('The Network Chef'),
   ('The Pink Pig Tavern'),
   ('The Polka Dot Bear Tavern'),
   ('The Wall'),
   ('The White Swan'),
   ('Thom McAn Store'),
   ('Thriftway Food Mart'),
   ('Total Sources'),
   ('Total Yard Maintenance'),
   ('Tower Records'),
   ('Twin Food Stores'),
   ('Ukrop''s Super Market'),
   ('Unity Stationers'),
   ('Universo Realtors'),
   ('Value Giant'),
   ('Vibrant Man'),
   ('Virgin Megastores'),
   ('VitaGrey'),
   ('Vitamax Health Food Center'),
   ('Waccamaw''s Homeplace'),
   ('Wag''s'),
   ('Walt''s IGA'),
   ('Warner Brothers Studio Store'),
   ('Warshal''s'),
   ('Waves Music'),
   ('Wealth Zone Group'),
   ('Western Auto'),
   ('Wetson''s'),
   ('Whitlocks Auto Supply'),
   ('Widdmann'),
   ('William Wanamaker & Sons'),
   ('Wise Solutions'),
   ('Woolf Brothers'),
   ('World of Fun'),
   ('Yardbirds Home Center'),
   ('York Steak House'),
   ('You Are Successful'),
   ('Zephyr Investments')
  ) cmp ([Name])
	CROSS APPLY (SELECT TOP 1 [Id] FROM [Country] WHERE cmp.[Name] IS NOT NULL ORDER BY NEWID()) co ([CountryId])
	CROSS APPLY (SELECT TOP 1 [Bit] FROM (VALUES (0), (1)) b ([Bit]) WHERE cmp.[Name] IS NOT NULL ORDER BY NEWID()) lbr ([LBR])
	CROSS APPLY (SELECT TOP 1 [Bit] FROM (VALUES (0), (1)) b ([Bit]) WHERE cmp.[Name] IS NOT NULL ORDER BY NEWID()) cov ([COV])
	CROSS APPLY (SELECT TOP 1 [Bit] FROM (VALUES (0), (1)) b ([Bit]) WHERE cmp.[Name] IS NOT NULL ORDER BY NEWID()) car ([CAR])
	CROSS APPLY (SELECT TOP 1 [Bit] FROM (VALUES (0), (1)) b ([Bit]) WHERE cmp.[Name] IS NOT NULL ORDER BY NEWID()) tpa ([TPA])
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
	(N'TPA', N'Third-Party Administrator', 4)
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
SELECT
 [UMR] = N'UMR' + RIGHT(N'000000' + CONVERT(NVARCHAR(10), v.[number]), 6),
	[Reference] = N'REF' + RIGHT(N'000000' + CONVERT(NVARCHAR(10), v.[number] * (2 + v.[number])), 6),
	[BrokerId] = lbr.[Id],
	[CoverholderId] = cov.[Id],
	[InceptionDate] = dte.[InceptionDate],
	[ExpiryDate] = DATEADD(day, -1, DATEADD(year, 1, dte.[InceptionDate])),
	[RisksTerritoryId] = (SELECT TOP 1 [Id] FROM [Territory] WHERE v.[number] IS NOT NULL ORDER BY NEWID()),
	[DomiciledTerritoryId] = (SELECT TOP 1 [TerritoryId] FROM [vwTerritoryCountries] tc WHERE cov.[CountryId] = tc.[CountryId] ORDER BY NEWID()),
	[LmitsTerritoryId] = (SELECT TOP 1 [Id] FROM [Territory] WHERE v.[number] IS NOT NULL ORDER BY NEWID()),
	[CreatedById] = 1,
	[UpdatedById] = 1
FROM [master]..[spt_values] v
 CROSS APPLY (SELECT TOP 1 * FROM [Company] WHERE [LBR] = 1 AND v.[number] IS NOT NULL ORDER BY NEWID()) lbr
	CROSS APPLY (SELECT TOP 1 * FROM [Company] WHERE [COV] = 1 AND v.[number] IS NOT NULL ORDER BY NEWID()) cov
	CROSS APPLY (SELECT DATEADD(month, v.[number] / 2, N'1995-01-01')) dte ([InceptionDate])
WHERE v.[type] = N'P'
 AND v.[number] BETWEEN 1 AND 500
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
		[Coverholder] = c.[DisplayName]
	FROM [Company] c
	 LEFT JOIN [Binder] b ON @BinderId = b.[Id] AND c.[Id] = b.[CoverholderId]
	WHERE c.[COV] & c.[Active] = 1
	 OR b.[Id] IS NOT NULL
	ORDER BY c.[DisplayName]
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
		[Broker] = c.[DisplayName]
	FROM [Company] c
	 LEFT JOIN [Binder] b ON @BinderId = b.[Id] AND c.[Id] = b.[BrokerId]
	WHERE c.[LBR] & c.[Active] = 1
	 OR b.[Id] IS NOT NULL
	ORDER BY c.[DisplayName]
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
		[AdministratorId] INT NOT NULL,
		[CreatedDTO] DATETIMEOFFSET NOT NULL CONSTRAINT [DF_BinderSection_CreatedDTO] DEFAULT (GETUTCDATE()),
		[CreatedById] INT NOT NULL,
		[UpdatedDTO] DATETIMEOFFSET NOT NULL CONSTRAINT [DF_BinderSection_UpdatedDTO] DEFAULT (GETUTCDATE()),
		[UpdatedById] INT NOT NULL,
		CONSTRAINT [PK_BinderSection] PRIMARY KEY NONCLUSTERED ([Id]),
		CONSTRAINT [UQ_BinderSection_Title] UNIQUE CLUSTERED ([BinderId], [Title]),
		CONSTRAINT [FK_BinderSection_Binder] FOREIGN KEY ([BinderId]) REFERENCES [Binder] ([Id]) ON DELETE CASCADE,
		CONSTRAINT [FK_BinderSection_ClassOfBusiness] FOREIGN KEY ([ClassId]) REFERENCES [ClassOfBusiness] ([Id]) ON UPDATE CASCADE,
		CONSTRAINT [FK_BinderSection_Company_AdministratorId] FOREIGN KEY ([AdministratorId]) REFERENCES [Company] ([Id]),
		CONSTRAINT [FK_BinderSection_User_CreatedById] FOREIGN KEY ([CreatedById]) REFERENCES [User] ([Id]),
		CONSTRAINT [FK_BinderSection_User_UpdatedById] FOREIGN KEY ([UpdatedById]) REFERENCES [User] ([Id]),
		CONSTRAINT [CK_BinderSection_UpdatedDTO] CHECK ([UpdatedDTO] >= [CreatedDTO])
	)
GO

INSERT INTO [BinderSection] ([BinderId], [ClassId], [Title], [AdministratorId], [CreatedById], [UpdatedById])
VALUES
 (1, N'PROP', N'Buildings', 1, 1, 1),
	(1, N'BI', N'Business Cover', 1, 1, 1)
GO

CREATE TABLE [BinderSectionCarrier] (
  [SectionId] INT NOT NULL,
		[CarrierId] INT NOT NULL,
		[Percentage] DECIMAL(5, 4) NOT NULL,
		CONSTRAINT [PK_BinderSectionCarrier] PRIMARY KEY CLUSTERED ([SectionId], [CarrierId]),
		CONSTRAINT [FK_BinderSectionCarrier_BinderSection] FOREIGN KEY ([SectionId]) REFERENCES [BinderSection] ([Id]) ON DELETE CASCADE,
		CONSTRAINT [FK_BinderSectionCarrier_Company_CarrierId] FOREIGN KEY ([CarrierId]) REFERENCES [Company] ([Id]),
		CONSTRAINT [CK_BinderSectionCarrier_Percentage] CHECK ([Percentage] BETWEEN 0 AND 1)
	)
GO

INSERT INTO [BinderSectionCarrier] ([SectionId], [CarrierId], [Percentage])
VALUES
 (1, 1, 0.6),
	(1, 2, 0.4),
 (2, 2, 0.75),
	(2, 1, 0.25)
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
	;WITH XMLNAMESPACES (N'http://james.newtonking.com/projects/json' AS [json])
	SELECT
	 [SectionId] = bs.[Id],
		[BinderId] = bs.[BinderId],
		[ClassId] = bs.[ClassId],
		[Title] = bs.[Title],
		[AdministratorId] = bs.[AdministratorId],
		(
		  SELECT
				 [@json:Array] = N'true',
					[CarrierId] = bsc.[CarrierId],
					[Percentage] = bsc.[Percentage]
				FROM [BinderSectionCarrier] bsc
				WHERE bs.[Id] = bsc.[SectionId]
				FOR XML PATH (N'Carriers'), TYPE
		 )
	FROM [BinderSection] bs
	WHERE bs.[Id] = @SectionId
	FOR XML PATH (N'Section')
	RETURN
END
GO

CREATE PROCEDURE [apiBinderSectionAdministrator](@UserId INT, @SectionId INT = NULL)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 SELECT
	 [AdministratorId] = CONVERT(NVARCHAR(10), c.[Id]),
		[Administrator] = c.[DisplayName]
	FROM [Company] c
	 LEFT JOIN [BinderSection] bs ON @SectionId = bs.[Id] AND c.[Id] = bs.[AdministratorId]
	WHERE c.[TPA] & c.[Active] = 1
	 OR bs.[Id] IS NOT NULL
	ORDER BY c.[DisplayName]
	RETURN
END
GO

CREATE PROCEDURE [apiBinderSectionCarrier](@UserId INT, @BinderId INT = NULL)
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT
		[CarrierId] = CONVERT(NVARCHAR(10), [Id]),
		[Carrier] = [DisplayName] 
	FROM [Company]
	WHERE [CAR] = 1
		OR [Id] IN (
				SELECT DISTINCT bsc.[CarrierId]
				FROM [BinderSection] bs
					JOIN [BinderSectionCarrier] bsc ON bs.[Id] = bsc.[SectionId]
				WHERE bs.[BinderId] = @BinderId
			)
	ORDER BY [DisplayName]
 RETURN
END
GO
