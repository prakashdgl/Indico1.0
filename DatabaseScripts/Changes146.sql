USE [Indico]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetShippingAddressWeekendDate]    Script Date: 07/30/2015 10:46:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_GetShippingAddressWeekendDate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_GetShippingAddressWeekendDate]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetShippingAddressWeekendDate]    Script Date: 07/30/2015 10:46:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SPC_GetShippingAddressWeekendDate](
@P_WeekEndDate datetime2(7)
)
AS
BEGIN
	SELECT DISTINCT dca.[ID] AS ID, 
					dca.[CompanyName] AS CompanyName
	FROM [dbo].[Order] o
		LEFT OUTER JOIN [dbo].[OrderDetail] od
			ON o.[ID] = od.[Order]
		LEFT OUTER JOIN [dbo].[DistributorClientAddress] dca
			ON o.[DespatchToAddress] = dca.[ID]
	WHERE  o.[DespatchToAddress] IS NOT NULL 
	AND (od.[SheduledDate] BETWEEN cast(DATEADD(wk, DATEDIFF(wk, 0, @P_WeekEndDate), 0) as DATE) AND DATEADD(day, 2, CONVERT (date, @P_WeekEndDate)))		 	
END



GO

/****** Object:  StoredProcedure [dbo].[SPC_GetPackingListDetails]    Script Date: 07/30/2015 10:51:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_GetPackingListDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_GetPackingListDetails]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetPackingListDetails]    Script Date: 07/30/2015 10:51:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SPC_GetPackingListDetails] (	
@P_WeekEndDate datetime2(7),
@P_ShipmentMode AS int = 0 ,
@P_ShipmentAddress AS int = 0
)	
AS 
BEGIN	
	SELECT pl.ID AS PackingList,
		   wpc.ID AS WeeklyProductionCapacity,
		   pl.CartonNo,
		   o.ID AS OrderNumber,		
		   od.[ID] AS OrderDetail,
		   vl.[NamePrefix] + ISNULL(CAST(vl.[NameSuffix] AS nvarchar(255)),'') AS VLName,
		   p.[Number] + ' ' + p.[NickName] AS Pattern,
		   d.Name AS Distributor,
		   c.Name AS Client,
		   wpc.WeekendDate AS WeekendDate,
		   ISNULL((SELECT SUM(QTY) FROM [dbo].[PackingListSizeQty] WHERE PackingList = pl.ID),0) AS PackingTotal,
		   ISNULL((SELECT COUNT([Count]) FROM [dbo].[PackingListCartonItem] WHERE PackingList = pl.ID),0) AS ScannedTotal,
		   ISNULL(o.[ShipmentMode], 0) AS ShimentModeID,
			ISNULL(shm.[Name], 'AIR') AS ShipmentMode,
			ISNULL(dca.[CompanyName], '') AS 'CompanyName',
			dca.[Address] AS 'Address',
			dca.[Suburb]  AS 'Suberb' ,
			ISNULL(dca.[State],'') AS 'State',
			dca.[PostCode]  AS 'PostCode',			 
			coun.[ShortName] AS 'Country',
			dca.[ContactName] + ' ' + dca.[ContactPhone] AS 'ContactDetails',
			o.[IsWeeklyShipment] AS 'IsWeeklyShipment',
			[IsAdelaideWareHouse] AS 'IsAdelaideWareHouse',
			ISNULL(o.[DespatchToAddress], 0) AS 'ShipTo'		
	FROM  dbo.[PackingList] pl
		INNER JOIN dbo.[OrderDetail] od
			ON pl.OrderDetail = od.ID
		INNER JOIN dbo.[Order] o
			ON od.[Order] = o.ID
		INNER JOIN dbo.[VisualLayout] vl
			ON od.[VisualLayout] = vl.ID	
		INNER JOIN dbo.Pattern p
			ON od.Pattern = p.ID
		INNER JOIN dbo.Client c
			ON o.Client = c.ID
		INNER JOIN dbo.Company d
			ON o.Distributor = d.ID	
		INNER JOIN dbo.WeeklyProductionCapacity wpc
			ON pl.WeeklyProductionCapacity = wpc.ID
		JOIN [dbo].[ShipmentMode] shm
			ON o.[ShipmentMode] = shm.[ID] 	
		JOIN [dbo].[DistributorClientAddress] dca
			ON o.[DespatchToAddress] = dca.[ID]
		JOIN [dbo].[Country] coun
			ON dca.[Country] = coun.[ID]		
	WHERE (wpc.[WeekendDate] = @P_WeekEndDate) AND
		  (od.[SheduledDate] BETWEEN cast(DATEADD(wk, DATEDIFF(wk, 0, @P_WeekEndDate), 0) as DATE) AND DATEADD(day, 2, CONVERT (date, @P_WeekEndDate))) AND
		  (@P_ShipmentMode = 0 OR o.[ShipmentMode] = @P_ShipmentMode) AND 
		  (@P_ShipmentAddress = 0 OR o.[DespatchToAddress] = @P_ShipmentAddress)
	ORDER BY pl.[CartonNo] ASC
END

GO


