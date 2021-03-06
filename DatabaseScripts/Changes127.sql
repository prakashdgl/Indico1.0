USE [Indico]
GO


/****** Object:  StoredProcedure [dbo].[SPC_ViewOrderDetails]    Script Date: 03/09/2015 13:27:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_ViewOrderDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_ViewOrderDetails]
GO


/****** Object:  StoredProcedure [dbo].[SPC_ViewOrderDetails]    Script Date: 03/09/2015 13:27:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SPC_ViewOrderDetails]
(
	@P_SearchText AS NVARCHAR(255) = '',
	@P_LogCompanyID AS int = 0,
	@P_Status AS nvarchar(255),
	@P_Coordinator AS int = 0,
	@P_Distributor AS int = 0,
	@P_Client AS int = 0,
	@P_SelectedDate1 AS datetime2(7) = NULL,
	@P_SelectedDate2 AS datetime2(7) = NULL,
	@P_DistributorClientAddress AS int = 0
	 
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @orderid AS int;
	DECLARE @status AS TABLE ( ID int )
	
	IF (ISNUMERIC(@P_SearchText) = 1) 
		BEGIN
			SET @orderid = CONVERT(INT, @P_SearchText)		
		END
	ELSE
		BEGIN	
			SET @orderid = 0
		END;
	
	INSERT INTO @status (ID) SELECT DATA FROM [dbo].Split(@P_Status,',');
	
	SELECT 			
		   od.[ID] AS OrderDetail
		  ,ot.[Name] AS OrderType
		  ,vl.[NamePrefix] + ISNULL(CAST(vl.[NameSuffix] AS nvarchar(255)),'') AS VisualLayout
		  ,od.[VisualLayout] AS VisualLayoutID
		  ,od.[Pattern] AS PatternID
		  ,p.[Number] + ' - ' + p.[NickName] AS Pattern
		  ,od.[FabricCode] AS FabricID
		  ,fc.[Code] + ' - ' + fc.[Name] AS Fabric
		  ,od.[VisualLayoutNotes] AS VisualLayoutNotes      
		  ,od.[Order] AS 'Order'
		  ,ISNULL(o.[Label], 0) AS Label
		  ,ISNULL(ods.[Name], 'New') AS OrderDetailStatus
		  ,ISNULL(od.[Status], 0) AS OrderDetailStatusID
		  ,od.[ShipmentDate] AS ShipmentDate
		  ,od.[SheduledDate] AS SheduledDate      
		  ,od.[RequestedDate] AS RequestedDate
		  ,ISNULL((SELECT SUM(odq.[Qty]) FROM [dbo].[OrderDetailQty] odq WHERE odq.[OrderDetail] = od.[ID]),0) AS Quantity      
		  ,(SELECT DATEDIFF(day, od.[RequestedDate], od.[SheduledDate])) AS 'DateDiffrence'
		  ,ISNULL(o.[OldPONo], '') AS 'PurONo'
		  ,c.[Name] AS Distributor
		  ,u.[GivenName] + ' ' + u.[FamilyName] AS Coordinator
		  ,cl.[Name] AS Client
		  ,os.[Name] AS OrderStatus
		  ,o.[Status] AS OrderStatusID
		  ,urc.[GivenName] + ' ' + urc.[FamilyName] AS Creator
		  ,o.[Creator] AS CreatorID
		  ,o.[CreatedDate] AS CreatedDate
		  ,urm.[GivenName] + ' ' + urm.[FamilyName] AS Modifier
		  ,o.[ModifiedDate] AS ModifiedDate
		  ,ISNULL(pm.[Name], '') AS PaymentMethod
		  ,ISNULL(sm.[Name], '') AS ShipmentMethod
		  ,o.[IsWeeklyShipment]  AS WeeklyShiment
		  ,o.[IsCourierDelivery]  AS CourierDelivery
		  ,o.[IsAdelaideWareHouse] AS AdelaideWareHouse
		  ,o.[IsFollowingAddress] AS FollowingAddress
		  ,ISNULL(dca.[CompanyName] + ' ' + dca.[Address] + ' ' + dca.[Suburb] + ' ' + ISNULL(dca.[State], '') + ' ' + co.[ShortName] + ' ' + dca.[PostCode], '') AS ShippingAddress
		  ,ISNULL(dp.[Name], '') AS DestinationPort
		  ,ISNULL(vl.[ResolutionProfile], 0 ) AS ResolutionProfile
	  FROM [dbo].[Order] o				
		LEFT OUTER JOIN [dbo].[OrderStatus] os
			ON o.[Status] = os.[ID]
		LEFT OUTER JOIN [dbo].[Company] c
			ON o.[Distributor] = c.[ID]
		LEFT OUTER JOIN [dbo].[User] u
			ON c.[Coordinator] = u.[ID]		
		LEFT OUTER JOIN [dbo].[PaymentMethod] pm
			ON o.[PaymentMethod] = pm.[ID]
		LEFT OUTER JOIN [dbo].[ShipmentMode] sm
			ON o.[ShipmentMode] = sm.[ID]					
		LEFT OUTER JOIN [dbo].[Client] cl
			ON o.[Client] = cl.[ID]				
		LEFT OUTER JOIN [dbo].[User] urc
			ON o.[Creator] = urc.[ID]
		LEFT OUTER JOIN [dbo].[User] urm
			ON o.[Modifier] = urm.[ID]
		LEFT OUTER JOIN [dbo].[DistributorClientAddress] dca
			ON o.[DespatchToExistingClient] = dca.[ID]	
		LEFT OUTER JOIN [dbo].[Country] co
			ON dca.[Country] = co.[ID]
		LEFT OUTER JOIN [dbo].[DestinationPort] dp
			ON dca.[Port] = dp.[ID] 		
		INNER JOIN [dbo].[OrderDetail] od				
			ON o.[ID] = od.[Order]				
		LEFT OUTER JOIN [dbo].[VisualLayout] vl
			ON od.[VisualLayout] = vl.[ID]
		LEFT OUTER JOIN [dbo].[Pattern] p 
			ON od.[Pattern] = p.[ID]
		LEFT OUTER JOIN [dbo].[FabricCode] fc
			ON od.[FabricCode] = fc.[ID]
		LEFT OUTER JOIN [dbo].[OrderDetailStatus] ods
			ON od.[Status] = ods.[ID]
		LEFT OUTER JOIN [dbo].[OrderType] ot
			ON od.[OrderType] = ot.[ID]
	WHERE (@P_SearchText = '' OR
			o.[ID] = @orderid OR
		   o.[OldPONo] LIKE '%' + @P_SearchText + '%' OR
		   u.[GivenName]  LIKE '%' + @P_SearchText + '%' OR
		   u.[FamilyName] LIKE '%' + @P_SearchText + '%' OR
		   p.[Number] LIKE '%' + @P_SearchText + '%' OR 
		   p.[NickName] LIKE '%' + @P_SearchText + '%' OR
		   vl.[NamePrefix] LIKE '%' + @P_SearchText + '%' OR 
		   vl.[NameSuffix] LIKE '%' + @P_SearchText + '%' OR 
		   ods.[Name] LIKE '%' + @P_SearchText + '%' OR 
		   ot.[Name] LIKE '%' + @P_SearchText + '%' OR
		   c.[Name] LIKE '%' + @P_SearchText + '%' OR 
		   cl.[Name] LIKE '%' + @P_SearchText + '%' OR					
		   fc.[Code] LIKE '%' + @P_SearchText + '%' OR 
		   fc.[Name] LIKE '%' + @P_SearchText + '%'  
			)AND
		   (@P_Status = '' OR  (os.[ID] IN (SELECT ID FROM @status)) )  AND											   
		  (@P_LogCompanyID = 0 OR c.[ID] = @P_LogCompanyID)	AND
		  (@P_Coordinator = 0 OR c.[Coordinator] = @P_Coordinator ) AND				  
		  (@P_Distributor = 0 OR o.Distributor = @P_Distributor)	AND
		  (@P_Client = 0 OR o.[Client] = @P_Client) AND				  
		  (@P_DistributorClientAddress = 0 OR o.[DespatchToExistingClient] = @P_DistributorClientAddress) AND
		  ((@P_SelectedDate1 IS NULL AND @P_SelectedDate2 IS NULL) OR (od.[SheduledDate] BETWEEN @P_SelectedDate1 AND @P_SelectedDate2))
	--ORDER BY o.[ID] DESC
				
END




GO

													