USE [Indico]
GO


/****** Object:  StoredProcedure [dbo].[SPC_GetWeeklySummary]    Script Date: 07/16/2015 17:43:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_GetWeeklySummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_GetWeeklySummary]
GO


/****** Object:  StoredProcedure [dbo].[SPC_GetWeeklySummary]    Script Date: 07/16/2015 17:43:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SPC_GetWeeklySummary] (	
@P_WeekEndDate datetime2(7), --Shipment Date in OrderDetail Table
@P_IsShipmentDate AS bit = 1
)	
AS 
BEGIN

	IF(@P_IsShipmentDate = 1)
		BEGIN
				SELECT 
						ISNULL(dca.CompanyName, '') AS 'CompanyName', 
							ISNULL(SUM(odq.Qty), 0) AS  'Qty' , 
							ISNULL(sm.[Name], 'AIR') AS 'ShipmentMode',
							ISNULL(sm.[ID], 0) AS 'ShipmentModeID',
							ISNULL(dca.[ID], 0) AS 'DistributorClientAddress',
							ISNULL(pm.[Name], '') AS PaymentMethod,
							ISNULL(ins.[Name], 'Pending') AS InvoiceStatus,
							od.[ShipmentDate],
							ISNULL(i.[ID], 0) AS Invoice,
							c.[ShortName] AS Country
							  FROM [Indico].[dbo].[DistributorClientAddress] dca
							 JOIN [dbo].[ORDER] o
								ON o.[BillingAddress] = dca.ID
							 JOIN [dbo].[OrderDetail] od
								ON od.[Order] = o.ID
							 JOIN [dbo].[OrderDetailQty] odq
								ON odq.[OrderDetail] = od.ID
							 JOIN [dbo].[ShipmentMode] sm
								ON o.[ShipmentMode] = sm.[ID]
							 JOIN [dbo].[PaymentMethod] pm
								ON o.[PaymentMethod] = pm.[ID]
							 LEFT OUTER JOIN [dbo].[InvoiceOrder] ino
								ON ino.[OrderDetail] = od.[ID]
							 LEFT OUTER JOIN [dbo].[Invoice] i
								ON ino.[Invoice] = i.[ID]
							 LEFT OUTER JOIN [dbo].[InvoiceStatus] ins
								ON i.[Status] = ins.[ID]
							 JOIN [dbo].[Country] c
								ON dca.[Country] = c.[ID]
						WHERE (od.[ShipmentDate] = @P_WeekEndDate) AND
						      (od.[Status] IS NULL  OR od.[Status] IN ((SELECT [ID] FROM [dbo].[OrderDetailStatus]  WHERE [Name] = 'ODS Printed' OR [Name] = 'On Hold' OR [Name] = 'Pre Shipped' OR [Name] = 'Waiting Info'))) 
						GROUP BY dca.CompanyName, sm.[Name], sm.[ID],dca.[ID], pm.[Name], ins.[Name], od.[ShipmentDate], i.[ID], c.[ShortName]
		END
	ELSE
		BEGIN
			SELECT 
							ISNULL(dca.CompanyName, '') AS 'CompanyName', 
							ISNULL(SUM(odq.Qty), 0) AS  'Qty' , 
							ISNULL(sm.[Name], 'AIR') AS 'ShipmentMode',
							ISNULL(sm.[ID], 0) AS 'ShipmentModeID',
							ISNULL(dca.[ID], 0) AS 'DistributorClientAddress',
							ISNULL(pm.[Name], '') AS PaymentMethod,
							ISNULL(ins.[Name], 'Pending') AS InvoiceStatus,
							od.[ShipmentDate],
							ISNULL(i.[ID], 0) AS Invoice,
							c.[ShortName] AS Country
							  FROM [Indico].[dbo].[DistributorClientAddress] dca
							 JOIN [dbo].[ORDER] o
								ON o.[BillingAddress] = dca.ID
							 JOIN [dbo].[OrderDetail] od
								ON od.[Order] = o.ID
							 JOIN [dbo].[OrderDetailQty] odq
								ON odq.[OrderDetail] = od.ID
							 JOIN [dbo].[ShipmentMode] sm
								ON o.[ShipmentMode] = sm.[ID]
							 JOIN [dbo].[PaymentMethod] pm
								ON o.[PaymentMethod] = pm.[ID]
							 LEFT OUTER JOIN [dbo].[InvoiceOrder] ino
								ON ino.[OrderDetail] = od.[ID]
							 LEFT OUTER JOIN [dbo].[Invoice] i
								ON ino.[Invoice] = i.[ID]
							 LEFT OUTER JOIN [dbo].[InvoiceStatus] ins
								ON i.[Status] = ins.[ID]
							 JOIN [dbo].[Country] c
								ON dca.[Country] = c.[ID]
							WHERE (od.[SheduledDate] BETWEEN cast(DATEADD(wk, DATEDIFF(wk, 0, @P_WeekEndDate), 0) as DATE) AND DATEADD(day, 2, CONVERT (date, @P_WeekEndDate))) AND
								  (od.[Status] IS NULL  OR od.[Status] IN ((SELECT [ID] FROM [dbo].[OrderDetailStatus]  WHERE [Name] = 'ODS Printed' OR [Name] = 'On Hold' OR [Name] = 'Pre Shipped' OR [Name] = 'Waiting Info')))
							GROUP BY dca.CompanyName, sm.[Name], sm.[ID],dca.[ID], pm.[Name], ins.[Name], od.[ShipmentDate], i.[ID], c.[ShortName]
		END
END

GO


/****** Object:  StoredProcedure [dbo].[SPC_GetInvoiceOrderDetails]    Script Date: 07/16/2015 17:45:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_GetInvoiceOrderDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_GetInvoiceOrderDetails]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetInvoiceOrderDetails]    Script Date: 07/16/2015 17:45:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/****** Script for SelectTopNRows command from SSMS  ******/

CREATE PROC [dbo].[SPC_GetInvoiceOrderDetails]
(
	@P_Invoice int,
	@P_ShipTo int,
	@P_IsNew AS bit = 1,
	@P_WeekEndDate datetime2(7), --- OrderDetail Table Shipment Date
	@P_ShipmentMode int
)
AS BEGIN

	IF(@P_IsNew = 1)

			BEGIN
						SELECT od.[ID] AS OrderDetail
							  ,ot.[Name] AS OrderType
							  ,vl.[NamePrefix] + ISNULL(CAST(vl.[NameSuffix] AS nvarchar(255)),'') AS VisualLayout
							  ,od.[VisualLayout] AS VisualLayoutID
							  ,od.[Pattern] AS PatternID
							  ,p.[Number] + ' - ' + p.[NickName] AS Pattern
							  ,od.[FabricCode] AS FabricID
							  ,fc.[Code] + ' - ' + fc.[Name] AS Fabric							   
							  ,od.[Order] AS 'Order'	
							  ,ISNULL((SELECT SUM(odq.[Qty]) FROM [dbo].[OrderDetailQty] odq WHERE odq.[OrderDetail] = od.[ID]),0) AS Quantity       
							  ,ISNULL(o.[OldPONo], '') AS 'PurONo'
							  ,c.[Name] AS Distributor
							  ,u.[GivenName] + ' ' + u.[FamilyName] AS Coordinator
							  ,cl.[Name] AS Client							 
							  ,(SELECT CASE
										WHEN (ISNULL((SELECT TOP 1 co.[QuotedFOBCost] FROM [dbo].[CostSheet] co WHERE co.[Pattern] = od.[Pattern]AND co.[Fabric] = od.[FabricCode]), 0.00) = 0.00)
											THEN  	(ISNULL((SELECT TOP 1 co.[JKFOBCost] FROM [dbo].[CostSheet] co WHERE co.[Pattern] = od.[Pattern]AND co.[Fabric] = od.[FabricCode]), 0.00))
										ELSE (ISNULL((SELECT TOP 1 co.[QuotedFOBCost] FROM [dbo].[CostSheet] co WHERE co.[Pattern] = od.[Pattern]AND co.[Fabric] = od.[FabricCode]), 0.00))
								END) AS 'FactoryRate'														  
							  ,ISNULL((SELECT SUM(odq.[Qty]) FROM [dbo].[OrderDetailQty] odq WHERE odq.[OrderDetail] = od.[ID]), 0) AS 'Qty'
							  ,g.[Name] AS 'Gender'
							  ,ISNULL(ag.[Name], '') AS 'AgeGroup'
							  ,(SELECT CASE
										WHEN (ISNULL((SELECT TOP 1 co.[QuotedCIF] FROM [dbo].[CostSheet] co WHERE co.[Pattern] = od.[Pattern]AND co.[Fabric] = od.[FabricCode]), 0.00) = 0.00)
											THEN  	(ISNULL((SELECT TOP 1 co.[IndimanCIF] FROM [dbo].[CostSheet] co WHERE co.[Pattern] = od.[Pattern]AND co.[Fabric] = od.[FabricCode]), 0.00))
										ELSE (ISNULL((SELECT TOP 1 co.[QuotedCIF] FROM [dbo].[CostSheet] co WHERE co.[Pattern] = od.[Pattern]AND co.[Fabric] = od.[FabricCode]), 0.00))
								END) AS 'IndimanRate'	
							  ,0 AS 'InvoiceOrder'
							  ,dca.[CompanyName] + '  ' + dca.[Address] + '  ' + dca.[Suburb] + '  ' + dca.[PostCode] + '  ' + co.[ShortName] AS ShipmentAddress
							  ,sm.[Name] AS ShipmentMode
							  ,ISNULL(dp.[Name], '') AS DestinationPort
							  ,ISNULL(pm.[Name], '') AS ShipmentTerm
							  ,ISNULL((SELECT [ID] FROM [dbo].[CostSheet] cs WHERE cs.[Pattern] = od.[Pattern] AND cs.[Fabric] = od.[FabricCode]), 0) AS CostSheet
						  FROM [Indico].[dbo].[OrderDetail] od
							JOIN [dbo].[Order] o
								ON od.[Order] = o.[ID]
							JOIN [dbo].[VisualLayout] vl
								ON od.[VisualLayout] = vl.[ID]
							JOIN [dbo].[Pattern] p 
								ON od.[Pattern] = p.[ID]
							JOIN [dbo].[FabricCode] fc
								ON od.[FabricCode] = fc.[ID]						
							JOIN [dbo].[OrderType] ot
								ON od.[OrderType] = ot.[ID]
							JOIN [dbo].[Company] c
								ON c.[ID] = o.[Distributor]
							JOIN [dbo].[User] u
								ON c.[Coordinator] = u.[ID]
							JOIN [dbo].[Client] cl
								ON o.[Client] = cl.[ID]	
							JOIN [dbo].[Gender] g
								ON p.[Gender] = g.[ID]
							LEFT OUTER JOIN [dbo].[AgeGroup] ag
								ON p.[AgeGroup] = ag.[ID]							
							JOIN [dbo].[DistributorClientAddress] dca
								ON o.[BillingAddress] = dca.[ID]
							JOIN [dbo].[Country] co
								ON dca.[Country] = co.[ID]
							JOIN [dbo].[ShipmentMode] sm
								ON o.[ShipmentMode] = sm.[ID]
							LEFT OUTER JOIN [dbo].[DestinationPort] dp
								ON dca.[Port] = dp.[ID] 	
							LEFT OUTER JOIN [dbo].[PaymentMethod] pm
								ON o.[PaymentMethod] = pm.[ID] 							
						WHERE (@P_ShipTo = 0 OR o.[BillingAddress] = @P_ShipTo) AND
							  (@P_ShipmentMode = 0 OR o.[ShipmentMode] = @P_ShipmentMode) AND
							  (od.[ShipmentDate] = @P_WeekEndDate) AND
							  (o.[Status] IN (SELECT [ID] FROM [dbo].[OrderStatus] WHERE [Name] = 'Indiman Submitted' OR [Name] = 'In Progress' OR [Name] = 'Partialy Completed' OR [Name] = 'Completed'))
			END
	ELSE
			BEGIN
			
						SELECT od.[ID] AS OrderDetail
							  ,ot.[Name] AS OrderType
							  ,vl.[NamePrefix] + ISNULL(CAST(vl.[NameSuffix] AS nvarchar(255)),'') AS VisualLayout
							  ,od.[VisualLayout] AS VisualLayoutID
							  ,od.[Pattern] AS PatternID
							  ,p.[Number] + ' - ' + p.[NickName] AS Pattern
							  ,od.[FabricCode] AS FabricID
							  ,fc.[Code] + ' - ' + fc.[Name] AS Fabric							      
							  ,od.[Order] AS 'Order'	
							  ,ISNULL((SELECT SUM(odq.[Qty]) FROM [dbo].[OrderDetailQty] odq WHERE odq.[OrderDetail] = od.[ID]),0) AS Quantity       
							  ,ISNULL(o.[OldPONo], '') AS 'PurONo'
							  ,c.[Name] AS Distributor
							  ,u.[GivenName] + ' ' + u.[FamilyName] AS Coordinator
							  ,cl.[Name] AS Client							 
							  ,ISNULL(iod.[FactoryPrice], 0.00) AS 'FactoryRate'
							  ,ISNULL((SELECT SUM(odq.[Qty]) FROM [dbo].[OrderDetailQty] odq WHERE odq.[OrderDetail] = od.[ID]), 0) AS 'Qty'
							  ,g.[Name] AS 'Gender'
							  ,ISNULL(ag.[Name], '') AS 'AgeGroup'							  
							  ,(SELECT CASE 
									WHEN (ISNULL(iod.[IndimanPrice], 0.00) = 0.00 )
									THEN 
										(SELECT CASE
											WHEN (ISNULL((SELECT TOP 1 co.[QuotedCIF] FROM [dbo].[CostSheet] co WHERE co.[Pattern] = od.[Pattern]AND co.[Fabric] = od.[FabricCode]), 0.00) = 0.00)
												THEN  	(ISNULL((SELECT TOP 1 co.[IndimanCIF] FROM [dbo].[CostSheet] co WHERE co.[Pattern] = od.[Pattern]AND co.[Fabric] = od.[FabricCode]), 0.00))
											ELSE (ISNULL((SELECT TOP 1 co.[QuotedCIF] FROM [dbo].[CostSheet] co WHERE co.[Pattern] = od.[Pattern]AND co.[Fabric] = od.[FabricCode]), 0.00))											
									     END) 
									ELSE (ISNULL(iod.[IndimanPrice],0.00))
									END) AS 'IndimanRate'
							  ,iod.[ID] AS 'InvoiceOrder'
							  ,dca.[CompanyName] + '  ' + dca.[Address] + '  ' + dca.[Suburb] + '  ' + dca.[PostCode] + '  ' + co.[ShortName] AS ShipmentAddress
							  ,sm.[Name] AS ShipmentMode
							  ,ISNULL(dp.[Name], '') AS DestinationPort
							  ,ISNULL(pm.[Name], '') AS ShipmentTerm
							  ,ISNULL((SELECT [ID] FROM [dbo].[CostSheet] cs WHERE cs.[Pattern] = od.[Pattern] AND cs.[Fabric] = od.[FabricCode]), 0) AS CostSheet
						 FROM [Indico].[dbo].[OrderDetail] od
							JOIN [dbo].[Order] o
								ON od.[Order] = o.[ID]
							JOIN [dbo].[VisualLayout] vl
								ON od.[VisualLayout] = vl.[ID]
							JOIN [dbo].[Pattern] p 
								ON od.[Pattern] = p.[ID]
							JOIN [dbo].[FabricCode] fc
								ON od.[FabricCode] = fc.[ID]						
							JOIN [dbo].[OrderType] ot
								ON od.[OrderType] = ot.[ID]
							JOIN [dbo].[Company] c
								ON c.[ID] = o.[Distributor]
							JOIN [dbo].[User] u
								ON c.[Coordinator] = u.[ID]
							JOIN [dbo].[Client] cl
								ON o.[Client] = cl.[ID]	
							JOIN [dbo].[Gender] g
								ON p.[Gender] = g.[ID]
							LEFT OUTER JOIN [dbo].[AgeGroup] ag
								ON p.[AgeGroup] = ag.[ID]
							JOIN [dbo].[InvoiceOrder] iod
								ON od.[ID] = iod.[OrderDetail]	
							JOIN [dbo].[DistributorClientAddress] dca
								ON o.[BillingAddress] = dca.[ID]
							JOIN [dbo].[Country] co
								ON dca.[Country] = co.[ID]
							JOIN [dbo].[ShipmentMode] sm
								ON o.[ShipmentMode] = sm.[ID]
							LEFT OUTER JOIN [dbo].[DestinationPort] dp
								ON dca.[Port] = dp.[ID] 	
							LEFT OUTER JOIN [dbo].[PaymentMethod] pm
								ON o.[PaymentMethod] = pm.[ID] 			
						WHERE /*(@P_ShipTo = 0 OR o.[ShipTo] = @P_ShipTo) AND*/
							  (@P_Invoice = 0 OR iod.[Invoice] = @P_Invoice) /*AND
							  (@P_ShipmentMode = 0 OR i.[ShipmentMode] = @P_ShipmentMode) AND
							  (od.[ShipmentDate] = @P_WeekEndDate)*/
			END
		
END

GO