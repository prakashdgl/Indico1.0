USE [Indico]
GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

/****** Object:  StoredProcedure [dbo].[SPC_ValidateField]    Script Date: 3/9/2016 11:09:16 AM ******/
DROP PROCEDURE [dbo].[SPC_ValidateField]
GO

/****** Object:  StoredProcedure [dbo].[SPC_ValidateField]    Script Date: 3/9/2016 11:09:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SPC_ValidateField]
(
	@P_ID INT = 0,
	@P_TableName AS NVARCHAR(255) = '',
	@P_Field AS NVARCHAR(255) = '',
	@P_Value AS NVARCHAR(255) = ''
)
AS 

BEGIN

	DECLARE @RetVal int
	
	BEGIN TRY 
		DECLARE @sqlText nvarchar(4000);
		DECLARE @result table (ID int)
		
		SET @sqlText = N'SELECT TOP 1 ID FROM dbo.[' + @P_TableName + '] WHERE [' + @P_Field+ '] = ''' + @P_Value  + ''' AND ( ( '+ CONVERT(VARCHAR(10), @P_ID) +' = 0 ) OR (ID != '+ CONVERT(VARCHAR(10), @P_ID) +' ) )' 
		
		INSERT INTO @result EXEC (@sqlText)
		
		IF EXISTS (SELECT ID FROM @Result)
		BEGIN
			SET @RetVal = 0
		END
		ELSE
		BEGIN
		   SET @RetVal = 1
		END
	END TRY
	BEGIN CATCH	
		 --SELECT 
   --     ERROR_NUMBER() AS ErrorNumber
   --    ,ERROR_MESSAGE() AS ErrorMessage;
		SET @RetVal = 0				
	END CATCH

	SELECT @RetVal AS RetVal		
END

GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--

-- Sales Report page

DECLARE @PageId int
DECLARE @MenuItemMenuId int
DECLARE @MenuItemId int

DECLARE @IndimanAdministrator int
DECLARE @IndicoCoordinator int
DECLARE @IndicoAdministrator int

SET @IndimanAdministrator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indiman Administrator')
SET @IndicoCoordinator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indico Coordinator')
SET @IndicoAdministrator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indico Administrator')

-- Page
INSERT INTO [dbo].[Page]([Name],[Title],[Heading])
     VALUES ('/DetailReport.aspx','Detail Report','Detail Report')	 
SET @PageId = SCOPE_IDENTITY()

-- Parent Menu Item
SELECT @MenuItemMenuId = ID FROM [dbo].[MenuItem] WHERE Name = 'Reports'

--Menu Item					
INSERT INTO [dbo].[MenuItem]
			([Page],[Name],[Description],[IsActive],[Parent],[Position],[IsVisible])
	 VALUES (@PageId, 'Detail Report', 'Detail Report', 1, @MenuItemMenuId, 2, 1)
SET @MenuItemId = SCOPE_IDENTITY()

-- Menu Item Role
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndimanAdministrator)
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndicoCoordinator)
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndicoAdministrator)

GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--

/****** Object:  StoredProcedure [dbo].[SPC_GetDetailReportForDistributorForGivenDateRange]    Script Date: 09-Mar-16 4:05:28 PM ******/
DROP PROCEDURE [dbo].[SPC_GetDetailReportForDistributorForGivenDateRange]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetOrderQuantitiesAndAmountForDistributorsForGivenDateRange]    Script Date: 09-Mar-16 3:43:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SPC_GetDetailReportForDistributorForGivenDateRange](
	@P_StartDate AS datetime2(7) = '20160101',
	@P_EndDate AS datetime2(7) = '20160301',
	@P_Distributor AS int
)
AS
BEGIN

	IF OBJECT_ID('tempdb..#data') IS NOT NULL 
		DROP TABLE #data

	SELECT MONTH(o.[Date]) AS 'Month', YEAR(o.[Date]) AS 'Year', c.Name AS 'DistributorName', vl.NamePrefix AS 'VLName', i.Name AS 'SubItemName', j.Name AS 'JobName', SUM(odq.Qty) AS 'Quantity', SUM(odq.Qty * (1+ (od.SurCharge/100)) * od.EditedPrice) AS 'Value' INTO #data
	FROM [dbo].[Company] c
		JOIN [dbo].[Order] o
			ON c.ID = o.Distributor
		JOIN [dbo].[OrderDetail] od
			ON o.ID = od.[Order]
		JOIN [dbo].[VisualLayout] vl
			ON od.VisualLayout = vl.ID
		JOIN [dbo].[Pattern] p
			ON vl.Pattern = p.ID
		LEFT OUTER JOIN [dbo].[Item] i
			ON p.SubItem = i.ID
		JOIN [dbo].[JobName] j
			ON o.Client = j.ID
		JOIN [dbo].[OrderDetailQty] odq
			ON od.ID = odq.OrderDetail
	WHERE IsDistributor = 1 AND o.[Date] >= @P_StartDate AND o.[Date] <= @P_EndDate AND c.ID = @P_Distributor
	GROUP BY MONTH(o.[Date]), YEAR(o.[Date]), c.Name, vl.NamePrefix, i.Name, j.Name

	SELECT DATENAME( MONTH , DATEADD(MONTH , d.[Month] , -1)) + '-' + CAST(d.[Year] AS nvarchar(4)) AS 'MonthAndYear', 
			d.DistributorName,
			d.VLName,
			ISNULL(d.SubItemName,'') AS SubItemName,
			d.JobName,
			d.Quantity AS 'Quantity', 
			CAST((CAST(d.quantity AS float))/(SELECT SUM(Quantity) FROM #data d1 WHERE d1.[Month] = d.[Month] AND d1.[Year] = d.[Year]) AS decimal(7,5)) AS 'QuantityPercentage',
			d.Value AS 'Value',
			CASE WHEN (SELECT SUM(Value) FROM #data d1 WHERE d1.[Month] = d.[Month] AND d1.[Year] = d.[Year]) > 0 THEN
				CAST((CAST(d.Value AS float))/(SELECT SUM(Value) FROM #data d1 WHERE d1.[Month] = d.[Month] AND d1.[Year] = d.[Year]) AS decimal(9,5))
			ELSE
				CAST('0.00' AS decimal(5,2))
			END AS 'ValuePercentage',
			CASE WHEN d.Quantity > 0 THEN
				CAST(CAST(d.Value AS float)/(d.Quantity) AS decimal(9,5))
			ELSE
				CAST('0.00' AS decimal(5,2))
			END AS 'AvgPrice'
	FROM #data d
	ORDER BY d.[Year], d.[Month]

END

GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--

/****** Object:  View [dbo].[ReturnDetailReportContent]    Script Date: 3/7/2016 5:05:24 PM ******/
DROP VIEW [dbo].[ReturnDetailReportContent]
GO

/****** Object:  View [dbo].[ReturnDetailReportContent]    Script Date: 3/7/2016 5:05:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ReturnDetailReportContent]
AS

SELECT '' AS MonthAndYear,
      '' AS DistributorName, 
	  '' AS VLName,
	  '' AS SubItemName, 
	  '' AS JobName,
      0 AS Quantity,
	  0.0 AS QuantityPercentage,
	  0.0 AS Value,
	  0.0 AS ValuePercentage,
	  0.0 AS AvgPrice
GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--

/****** Object:  StoredProcedure [dbo].[SPC_GetOrderQuantitiesAndAmountForDistributorsForGivenDateRange]    Script Date: 3/10/2016 9:46:51 AM ******/
DROP PROCEDURE [dbo].[SPC_GetOrderQuantitiesAndAmountForDistributorsForGivenDateRange]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetOrderQuantitiesAndAmountForDistributorsForGivenDateRange]    Script Date: 3/10/2016 9:46:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SPC_GetOrderQuantitiesAndAmountForDistributorsForGivenDateRange](
	@P_StartDate AS datetime2(7) = '20160101',
	@P_EndDate AS datetime2(7) = '20160301',
	--@P_Distributor AS int,
	@P_DistributorName AS nvarchar(128),
	@P_DistributorType AS int
)
AS
BEGIN

	IF OBJECT_ID('tempdb..#data') IS NOT NULL 
		DROP TABLE #data

	SELECT MONTH(o.[Date]) AS 'Month', YEAR(o.[Date]) AS 'Year', c.Name, SUM(odq.Qty) AS 'Quantity', SUM(odq.Qty * ( (1+ (od.SurCharge/100)) * od.EditedPrice)) AS 'Value' INTO #data
	FROM [dbo].[Company] c
		JOIN [dbo].[Order] o
			ON c.ID = o.Distributor
		JOIN [dbo].[OrderDetail] od
			ON o.ID = od.[Order]
		JOIN [dbo].[OrderDetailQty] odq
			ON od.ID = odq.OrderDetail
	WHERE IsDistributor = 1 and DistributorType = @P_DistributorType AND o.[Date] >= @P_StartDate AND o.[Date] <= @P_EndDate AND (@P_DistributorName = '' OR c.Name LIKE '%' + @P_DistributorName + '%')--AND (@P_Distributor = 0 OR c.ID = @P_Distributor)
		AND o.[Status] != 28
	GROUP BY MONTH(o.[Date]), YEAR(o.[Date]), c.Name

	SELECT DATENAME( MONTH , DATEADD(MONTH , d.[Month] , -1)) + '-' + CAST(d.[Year] AS nvarchar(4)) AS 'MonthAndYear', 
			d.Name AS 'Name', 
			d.Quantity AS 'Quantity', 
			CAST((CAST(d.quantity AS float))/(SELECT SUM(Quantity) FROM #data d1 WHERE d1.[Month] = d.[Month] AND d1.[Year] = d.[Year]) AS decimal(7,5)) AS 'QuantityPercentage',
			d.Value AS 'Value',
			CASE WHEN (SELECT SUM(Value) FROM #data d1 WHERE d1.[Month] = d.[Month] AND d1.[Year] = d.[Year]) > 0 THEN
				CAST((CAST(d.Value AS float))/(SELECT SUM(Value) FROM #data d1 WHERE d1.[Month] = d.[Month] AND d1.[Year] = d.[Year]) AS decimal(9,5))
			ELSE
				CAST('0.00' AS decimal(5,2))
			END AS 'ValuePercentage',
			CASE WHEN d.Quantity > 0 THEN
				CAST(CAST(d.Value AS float)/(d.Quantity) AS decimal(9,5))
			ELSE
				CAST('0.00' AS decimal(5,2))
			END AS 'AvgPrice'
	FROM #data d
	ORDER BY d.[Year], d.[Month]

END


GO
