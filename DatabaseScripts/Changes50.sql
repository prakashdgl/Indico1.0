USE [Indico] 
GO

DELETE FROM [dbo].[PriceChangeEmailList]
WHERE [ID] != 1 AND [ID] != 3
GO
