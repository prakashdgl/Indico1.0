USE [Indico]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetOrderClients]    Script Date: 10/15/2015 14:26:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_GetOrderClients]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_GetOrderClients]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetOrderClients]    Script Date: 10/15/2015 14:26:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SPC_GetOrderClients](
@P_Distributor AS int 
)

AS
BEGIN

	SELECT  DISTINCT c.[ID]
					,c.[Name] AS Name 
			FROM [dbo].[Order] o
			 JOIN [dbo].[Client] c
				ON o.[Client] = c.[ID]
			WHERE (@P_Distributor = 0 OR o.[Distributor] = @P_Distributor)
			ORDER BY c.Name
END

GO

