USE [Indico]
GO


/****** Object:  StoredProcedure [dbo].[SPC_ViewVisualLayoutDetails]    Script Date: 11/13/2015 11:16:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_ViewVisualLayoutDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_ViewVisualLayoutDetails]
GO

/****** Object:  StoredProcedure [dbo].[SPC_ViewVisualLayoutDetails]    Script Date: 11/13/2015 11:16:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SPC_ViewVisualLayoutDetails]
(
	@P_SearchText AS NVARCHAR(255) = '',
	@P_MaxRows AS int = 20,
	@P_Set AS int = 0,
	@P_Sort AS int = 0, --0 CreatedDate,--1 Name, --2 Pattern, --3 Fabric, --4 Client, --5 Distributor, --6 Coordinator
	@P_OrderBy AS bit = 1,  -- 0 ASC , -- 1 DESC
	@P_RecCount int OUTPUT,
	@P_Coordinator AS NVARCHAR(255) = '',
	@P_Distributor AS NVARCHAR(255) = '',
	@P_Client AS NVARCHAR(255) = '',
	@P_IsCommon AS int = 2
)
AS
BEGIN
	-- Get the patterns	
	SET NOCOUNT ON
	DECLARE @StartOffset int;
	--SET @StartOffset = (@P_Set - 1) * @P_MaxRows;
	
	--WITH VisualLayout AS
	--(
		SELECT 
			--DISTINCT TOP (@P_Set * @P_MaxRows)
			CONVERT(int, ROW_NUMBER() OVER (
			ORDER BY 
				CASE 
					WHEN (@p_Sort = 0 AND @p_OrderBy = 0) THEN v.[CreatedDate]
				END ASC,
				CASE						
					WHEN (@p_Sort = 0 AND @p_OrderBy = 1) THEN v.[CreatedDate]
				END DESC,
				CASE 
					WHEN (@p_Sort = 1 AND @p_OrderBy = 0) THEN v.[NamePrefix]
				END ASC,
				CASE						
					WHEN (@p_Sort = 1 AND @p_OrderBy = 1) THEN v.[NamePrefix]
				END DESC,
				CASE 
					WHEN (@p_Sort = 2 AND @p_OrderBy = 0) THEN p.[Number]
				END ASC,
				CASE						
					WHEN (@p_Sort = 2 AND @p_OrderBy = 1) THEN p.[Number]
				END DESC,	
				CASE 
					WHEN (@p_Sort = 3 AND @p_OrderBy = 0) THEN f.[Name]
				END ASC,
				CASE						
					WHEN (@p_Sort = 3 AND @p_OrderBy = 1) THEN f.[Name]
				END DESC,
				CASE 
					WHEN (@p_Sort = 4 AND @p_OrderBy = 0) THEN c.[Name]
				END ASC,
				CASE						
					WHEN (@p_Sort = 4 AND @p_OrderBy = 1) THEN c.[Name]
				END DESC,	
				CASE 
					WHEN (@p_Sort = 5 AND @p_OrderBy = 0) THEN d.[Name]
				END ASC,
				CASE						
					WHEN (@p_Sort = 5 AND @p_OrderBy = 1) THEN d.[Name]
				END DESC,
				CASE 
					WHEN (@p_Sort = 6 AND @p_OrderBy = 0) THEN u.[GivenName]
				END ASC,
				CASE						
					WHEN (@p_Sort = 6 AND @p_OrderBy = 1) THEN u.[GivenName]
				END DESC					
				)) AS ID,
			   v.[ID] AS VisualLayout,
			   ISNULL(v.[NamePrefix] + '' + ISNULL(CAST(v.[NameSuffix] AS NVARCHAR(64)), ''), '') AS Name,
			   ISNULL(v.[Description], '') AS 'Description',
			   ISNULL(p.[Number] + ' - '+ p.[NickName], '') AS Pattern,
			   ISNULL(f.[Name], '') AS Fabric,
			   ISNULL(c.[Name], '') AS Client,
			   ISNULL(d.[Name], '') AS Distributor,
			   ISNULL(u.[GivenName] + ' '+ u.[FamilyName], '') AS Coordinator,
			   ISNULL(v.[NNPFilePath], '') AS NNPFilePath,
			   ISNULL(v.[CreatedDate], GETDATE()) AS CreatedDate,
			   ISNULL(v.[IsCommonProduct], 0) AS IsCommonProduct,
			   ISNULL(v.[ResolutionProfile], 0) AS ResolutionProfile,
			   ISNULL(v.[Printer], 0) AS Printer,
			   ss.[Name] AS SizeSet,
			  CONVERT(bit, (SELECT CASE WHEN (EXISTS(SELECT TOP 1 (od.[VisualLayout]) FROM [dbo].[OrderDetail] od WHERE od.[VisualLayout] = v.[ID])) THEN 1 ELSE 0 END)) AS OrderDetails
		FROM [dbo].[VisualLayout] v
			LEFT OUTER JOIN [dbo].[Pattern] p
				ON v.[Pattern] = p.[ID]
			LEFT OUTER JOIN [dbo].[FabricCode] f
				ON v.[FabricCode] = f.[ID]
			LEFT OUTER JOIN [dbo].[JobName] j
				ON v.[Client] = j.[ID]
			LEFT OUTER JOIN [dbo].[Client] c
				ON j.[Client] = c.[ID]	
			LEFT OUTER JOIN [dbo].[Company] d
				ON c.[Distributor] = d.[ID]
			LEFT OUTER JOIN [dbo].[User] u
				ON d.[Coordinator] = u.[ID]
			LEFT OUTER JOIN [dbo].[SizeSet] ss
				ON p.[SizeSet] = ss.[ID]
		WHERE (@P_SearchText = '' OR
			   v.[NamePrefix]  LIKE '%' + @P_SearchText + '%' OR
			   v.[NameSuffix]  LIKE '%' + @P_SearchText + '%' OR
			   v.[Description] LIKE '%' + @P_SearchText + '%' OR
			   p.[Number] LIKE '%' + @P_SearchText + '%' OR
			   c.[Name] LIKE '%' + @P_SearchText + '%' OR
			   d.[Name] LIKE '%' + @P_SearchText + '%' OR
			   u.[GivenName] LIKE '%' + @P_SearchText + '%' OR
			   u.[FamilyName] LIKE '%' + @P_SearchText + '%') 
			   AND (@P_Coordinator = '' OR u.[ID] = @P_Coordinator)
			   AND(@P_Distributor = '' OR  d.ID = @P_Distributor )
			   --AND(@P_Client = '' OR c.[Name] LIKE '%' + @P_SearchText + '%')
			   AND(@P_IsCommon = 2 OR v.[IsCommonProduct] = CONVERT(bit,@P_IsCommon))			   
		--)
	--SELECT * FROM VisualLayout WHERE ID > @StartOffset
	
	/*IF @P_Set = 1
	BEGIN	
		SELECT @P_RecCount = COUNT (vl.ID)
		FROM (
			SELECT DISTINCT	v.ID
		FROM [dbo].[VisualLayout] v
			JOIN [dbo].[Pattern] p
				ON v.[Pattern] = p.[ID]
			JOIN [dbo].[FabricCode] f
				ON v.[FabricCode] = f.[ID]
			LEFT OUTER JOIN [dbo].[Client] c
				ON v.[Client] = c.[ID]
			LEFT OUTER JOIN [dbo].[Company] d
				ON c.[Distributor] = d.[ID]
			LEFT OUTER JOIN [dbo].[User] u
				ON d.[Coordinator] = u.[ID]
		WHERE (@P_SearchText = '' OR
			   v.[NamePrefix]  LIKE '%' + @P_SearchText + '%' OR
			   v.[NameSuffix]  LIKE '%' + @P_SearchText + '%' OR
			   v.[Description] LIKE '%' + @P_SearchText + '%' OR
			   p.[Number] LIKE '%' + @P_SearchText + '%' OR
			   c.[Name] LIKE '%' + @P_SearchText + '%' OR
			   d.[Name] LIKE '%' + @P_SearchText + '%' OR
			   u.[GivenName] LIKE '%' + @P_SearchText + '%' OR
			   u.[FamilyName] LIKE '%' + @P_SearchText + '%')
			   AND (@P_Coordinator = '' OR (u.[GivenName] + ' ' + u.[FamilyName]) LIKE + '%' + @P_Coordinator + '%')
			   AND(@P_Distributor = '' OR  d.[Name] LIKE +'%' + @P_Distributor + '%')
			   AND(@P_Client = '' OR c.[Name] LIKE +'%' + @P_SearchText + '%')
			   AND(@P_IsCommon = 2 OR v.[IsCommonProduct] = CONVERT(bit,@P_IsCommon))	
		)vl
	END
	ELSE*/
	--BEGIN
		SET @P_RecCount = 0
	--END
END

GO

--------------------------- new client page --------------------------------------

DECLARE @PageId int
DECLARE @MenuItemMenuId int
DECLARE @MenuItemId int

DECLARE @IndimanAdministrator int
DECLARE @IndimanCoordinator int
DECLARE @IndicoAdministrator int
DECLARE @IndicoCoordinator int

SET @MenuItemMenuId =  (SELECT ID FROM [dbo].[MenuItem] WHERE 
						(Name ='Manage')
						AND Parent IS NULL )

SET @IndimanAdministrator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indiman Administrator')
SET @IndimanCoordinator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indiman Coordinator')
SET @IndicoAdministrator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indico Administrator')
SET @IndicoCoordinator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indico Coordinator')

INSERT INTO [dbo].[Page]([Name],[Title],[Heading])
     VALUES ('/ViewDistributorClients.aspx','Clients','Clients')
	 
SET @PageId = SCOPE_IDENTITY()

INSERT INTO [dbo].[MenuItem]
			([Page],[Name],[Description],[IsActive],[Parent],[Position],[IsVisible])
	 VALUES (@PageId, 'Clients', 'Clients', 1, @MenuItemMenuId, 6, 1)
SET @MenuItemId = SCOPE_IDENTITY()	

INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndimanAdministrator)
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndimanCoordinator)
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndicoAdministrator)
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndicoCoordinator)	 
	 	 
GO


