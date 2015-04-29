--USE [master]; DROP DATABASE [Advent]; CREATE DATABASE [Advent]
USE [Advent]
GO

IF OBJECT_ID(N'apiErrorLog', N'P') IS NOT NULL DROP PROCEDURE [apiErrorLog]
IF OBJECT_ID(N'ErrorLog', N'U') IS NOT NULL DROP TABLE [ErrorLog]
IF OBJECT_ID(N'apiUserVerify', N'P') IS NOT NULL DROP PROCEDURE [apiUserVerify]
IF OBJECT_ID(N'apiUserLogin', N'P') IS NOT NULL DROP PROCEDURE [apiUserLogin]
IF OBJECT_ID(N'User', N'U') IS NOT NULL DROP TABLE [User]
GO

CREATE TABLE [User] (
  [Id] INT NOT NULL IDENTITY (1, 1),
		[Name] AS CONVERT(NVARCHAR(255), [Forename] + N' ' + [Surname]) PERSISTED,
		[Forename] NVARCHAR(127) NOT NULL,
		[Surname] NVARCHAR(127) NOT NULL,
  [Email] NVARCHAR(255) NOT NULL,
		[Password] NVARCHAR(255) NOT NULL,
		[MustResetPassword] BIT NOT NULL CONSTRAINT [DF_User_MustResetPassword] DEFAULT (1),
		[EnabledUTC] DATETIME NOT NULL CONSTRAINT [DF_User_EnabledUTC] DEFAULT (GETUTCDATE()),
		[ExpiredUTC] DATETIME NULL,
		[PingUTC] DATETIME NULL,
		CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([Id]),
		CONSTRAINT [CK_User_ExpiredUTC] CHECK ([ExpiredUTC] > [EnabledUTC]),
		CONSTRAINT [CK_User_PingUTC] CHECK ([PingUTC] BETWEEN [EnabledUTC] AND ISNULL([ExpiredUTC], GETUTCDATE()))
	)
GO

CREATE UNIQUE INDEX [IX_User_Email] ON [User] ([Email]) INCLUDE ([Id], [Password])
GO

INSERT INTO [User] ([Forename], [Surname], [Email], [Password], [MustResetPassword])
VALUES
 (N'Pierre', N'Henry', N'pierre@whitespace.co.uk', N'3YsVMhbpwLiFm7EEHE4pY5Svgyh0hVHaLKYa5dMSGVY=:khgtioJvgkNmAOstoDLRoXRxMEG8EI0Fqiq3xoVVyNA=', 0)
GO

CREATE PROCEDURE [apiUserLogin](@Email NVARCHAR(255))
AS
BEGIN
 SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT [UserId] = [Id], [Password]
	FROM [User]
	WHERE [Email] = @Email
	RETURN
END
GO

CREATE PROCEDURE [apiUserVerify](@UserId INT, @Timeout TINYINT = NULL)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @Error NVARCHAR(max)
	SELECT
	 @Error = CASE
		  WHEN [EnabledUTC] > GETUTCDATE() THEN N'asql:401:Your account is not yet enabled.'
				WHEN [ExpiredUTC] < GETUTCDATE() THEN N'asql:401:Your account has expired.'
				WHEN DATEADD(minute, @Timeout, [PingUTC]) < GETUTCDATE() THEN N'asql:401:Your session has expired.'
		 END
	FROM [User]
	WHERE [Id] = @UserId
 IF @@ROWCOUNT = 0 SET @Error = N'asql:401:Invalid user.'
	IF @Error IS NULL
	 UPDATE [User] SET [PingUTC] = GETUTCDATE() WHERE [Id] = @UserId
	ELSE
	 RAISERROR(@Error, 16, 1)
	RETURN
END
GO

CREATE TABLE [ErrorLog] (
  [LoggedUTC] DATETIME NOT NULL CONSTRAINT [DF_ErrorLog_LoggedUTC] DEFAULT (GETUTCDATE()),
		[IPAddress] NVARCHAR(255) NULL,
		[URL] NVARCHAR(255) NULL,
		[QueryString] NVARCHAR(max) NULL,
		[RequestBody] NVARCHAR(max) NULL,
		[Procedure] XML NULL,
		[Exception] NVARCHAR(max) NOT NULL,
		[Message] NVARCHAR(max) NOT NULL,
		[StackTrace] NVARCHAR(max) NULL,
		CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED ([LoggedUTC] DESC)
	)
GO

CREATE PROCEDURE [apiErrorLog](
		@IPAddress NVARCHAR(255) = NULL,
  @URL NVARCHAR(255),
		@QueryString NVARCHAR(max) = NULL,
		@RequestBody NVARCHAR(max) = NULL,
		@Procedure XML = NULL,
		@Exception NVARCHAR(max),
		@Message NVARCHAR(max),
		@StackTrace NVARCHAR(max) = NULL
 )
AS
BEGIN
 SET NOCOUNT ON
	INSERT INTO [ErrorLog] ([IPAddress], [URL], [QueryString], [RequestBody], [Procedure], [Exception], [Message], [StackTrace])
	VALUES (@IPAddress, @URL, @QueryString, @RequestBody, @Procedure, @Exception, @Message, @StackTrace)
	RETURN
END
GO

SELECT * FROM ErrorLog