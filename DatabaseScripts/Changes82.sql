USE[Indico]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetInvoiceOrderDetails]    Script Date: 01/07/2014 09:28:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_GetInvoiceOrderDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_GetInvoiceOrderDetails]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetInvoiceOrderDetails]    Script Date: 01/07/2014 09:28:42 ******/
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
	@P_WeekEndDate datetime2(7),
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
						WHERE (@P_ShipTo = 0 OR o.[DespatchToExistingClient] = @P_ShipTo) AND
							  (@P_ShipmentMode = 0 OR o.[ShipmentMode] = @P_ShipmentMode) AND
							  (od.[SheduledDate] > DATEADD(day, -7, @P_WeekEndDate) AND od.[SheduledDate] <= @P_WeekEndDate)
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
						WHERE (@P_ShipTo = 0 OR o.[DespatchToExistingClient] = @P_ShipTo) AND
							  (@P_Invoice = 0 OR iod.[Invoice] = @P_Invoice) AND
							  (@P_ShipmentMode = 0 OR o.[ShipmentMode] = @P_ShipmentMode) AND
							  (od.[SheduledDate] > DATEADD(day, -7, @P_WeekEndDate) AND od.[SheduledDate] <= @P_WeekEndDate)
			END
		
END


GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

/****** Object:  View [dbo].[ReturnInvoiceOrderDetailView]    Script Date: 01/07/2014 12:59:56 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReturnInvoiceOrderDetailView]'))
DROP VIEW [dbo].[ReturnInvoiceOrderDetailView]
GO


/****** Object:  View [dbo].[ReturnInvoiceOrderDetailView]    Script Date: 01/07/2014 12:59:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ReturnInvoiceOrderDetailView]
AS
			
					    SELECT 0  AS OrderDetail
							  ,'' AS OrderType
							  ,'' AS VisualLayout
							  ,0  AS VisualLayoutID
							  ,0  AS PatternID
							  ,'' AS Pattern
							  ,0  AS FabricID
							  ,'' AS Fabric							  
							  ,0  AS 'Order'	
							  ,0  AS Quantity       
							  ,'' AS 'PurONo'
							  ,'' AS Distributor
							  ,'' AS Coordinator
							  ,'' AS Client							 
							  ,0.0 AS 'FactoryRate'
							  ,0  AS 'Qty'
							  ,'' AS 'Gender'
							  ,'' AS 'AgeGroup'
							  ,0.0 AS 'IndimanRate'	
							  ,0 AS 'InvoiceOrder'			 




GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** ADD IndimanInvoiceNo. column to the Invoice Table --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**
ALTER TABLE [dbo].[Invoice]
ADD [IndimanInvoiceNo][nvarchar](64) NULL
GO
--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** ADD ShipmentMode column to the Invoice Table --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**

ALTER TABLE [dbo].[Invoice]
ADD [ShipmentMode][int] NOT NULL
GO

ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_ShipmentMode] FOREIGN KEY([ShipmentMode])
REFERENCES [dbo].[ShipmentMode] ([ID])
GO

ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_ShipmentMode]
GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** Access to Invoice for Indiman --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**

DECLARE @Page As int
DECLARE @MenuItem AS int 
DECLARE @Role AS int


SET @Page = (SELECT [ID] FROM [dbo].[Page] WHERE [Name] = '/ViewInvoices.aspx')
SET @MenuItem = (SELECT [ID] FROM [dbo].[MenuItem] WHERE [Page] = @Page AND [Parent] IS NULL)
SET @Role = (SELECT [ID] FROM [dbo].[Role] WHERE [Description] = 'Indiman Administrator' )

INSERT INTO [Indico].[dbo].[MenuItemRole] ([MenuItem], [Role]) VALUES (@MenuItem , @Role)
GO


DECLARE @Page As int
DECLARE @MenuItem AS int 
DECLARE @Parent AS int
DECLARE @Role AS int


SET @Page = (SELECT [ID] FROM [dbo].[Page] WHERE [Name] = '/ViewInvoices.aspx')
SET @Parent = (SELECT [ID] FROM [dbo].[MenuItem] WHERE [Page] = @Page AND [Parent] IS NULL)
SET @MenuItem = (SELECT [ID] FROM [dbo].[MenuItem] WHERE [Page] = @Page AND [Parent] = @Parent)
SET @Role = (SELECT [ID] FROM [dbo].[Role] WHERE [Description] = 'Indiman Administrator' )

INSERT INTO [Indico].[dbo].[MenuItemRole] ([MenuItem], [Role]) VALUES (@MenuItem , @Role)
GO

DECLARE @Page As int
DECLARE @MenuItem AS int 
DECLARE @Parent AS int
DECLARE @Role AS int
DECLARE @ParentPage AS int


SET @Page = (SELECT [ID] FROM [dbo].[Page] WHERE [Name] = '/AddEditInvoice.aspx')
SET @ParentPage = (SELECT [ID] FROM [dbo].[Page] WHERE [Name] = '/ViewInvoices.aspx')
SET @Parent = (SELECT [ID] FROM [dbo].[MenuItem] WHERE [Page] = @ParentPage AND [Parent] IS NOT NULL)
SET @MenuItem = (SELECT [ID] FROM [dbo].[MenuItem] WHERE [Page] = @Page AND [Parent] = @Parent)
SET @Role = (SELECT [ID] FROM [dbo].[Role] WHERE [Description] = 'Indiman Administrator' )

INSERT INTO [Indico].[dbo].[MenuItemRole] ([MenuItem], [Role]) VALUES (@MenuItem , @Role)
GO


--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**


--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** Add Indiman Invoice Date for invoice Table --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**

ALTER TABLE [dbo].[Invoice]
ADD [IndimanInvoiceDate] [datetime2](7) NULL
GO

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** Add Invoice Creator for invoice Table --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**


ALTER TABLE [dbo].[Invoice]
ADD [Creator] [int] NOT NULL
GO

ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Creator] FOREIGN KEY([Creator])
REFERENCES [dbo].[User] ([ID])
GO

ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Creator]
GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**


--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** Add Invoice Created Date for invoice Table --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**

ALTER TABLE [dbo].[Invoice]
ADD [CreatedDate] [datetime2](7) NOT NULL
GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** Add Invoice Modifier for invoice Table --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**

ALTER TABLE [dbo].[Invoice]
ADD [Modifier] [int] NOT NULL
GO

ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Modifier] FOREIGN KEY([Modifier])
REFERENCES [dbo].[User] ([ID])
GO

ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Modifier]
GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** Add Invoice Modified Date for invoice Table --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**


ALTER TABLE [dbo].[Invoice]
ADD [ModifiedDate] [datetime2](7) NOT NULL
GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** Add View to Get Invoice Details --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**


/****** Object:  View [dbo].[ReturnInvoiceDetails]    Script Date: 01/13/2014 10:32:21 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReturnInvoiceDetails]'))
DROP VIEW [dbo].[ReturnInvoiceDetails]
GO

/****** Object:  View [dbo].[ReturnInvoiceDetails]    Script Date: 01/13/2014 10:32:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ReturnInvoiceDetails]
AS

SELECT inv.[ID] AS 'Invoice'
      ,inv.[InvoiceNo] AS 'InvoiceNo'
      ,CONVERT(VARCHAR(30), inv.[InvoiceDate], 106)AS 'InvoiceDate'       
      ,dca.[CompanyName] AS 'ShipTo'
      ,ISNULL(inv.[AWBNo], '') AS 'AWBNo'
      ,CONVERT(VARCHAR(30), wpc.[WeekendDate], 106)AS 'ETD'    
      ,ISNULL(inv.[IndimanInvoiceNo],'') AS 'IndimanInvoiceNo'
      ,sm.[Name] AS 'ShipmentMode'
      ,ISNULL(CONVERT(VARCHAR(30), inv.[IndimanInvoiceDate], 106), '') AS 'IndimanInvoiceDate'  
      ,ISNULL((SELECT SUM(invo.[FactoryPrice]) FROM [dbo].[InvoiceOrder] invo WHERE invo.[Invoice] = inv.[ID]), 0.00) AS 'FactoryRate'   
      ,ISNULL((SELECT SUM(invo.[IndimanPrice]) FROM [dbo].[InvoiceOrder] invo WHERE invo.[Invoice] = inv.[ID]), 0.00) AS 'IndimanRate'   
      ,ISNULL((SELECT SUM(odq.[Qty]) FROM [dbo].[OrderDetailQty] odq 
											JOIN [dbo].[OrderDetail] od
												  ON odq.[OrderDetail] = od.[ID]
											JOIN [dbo].[InvoiceOrder] invo
												  ON od.[ID] = invo.[OrderDetail]
									 WHERE invo.[Invoice] = inv.[ID]), 0) AS 'Qty' 
	  ,[inv].[WeeklyProductionCapacity] AS 'WeeklyProductionCapacity'
   FROM [Indico].[dbo].[Invoice] inv
	JOIN [dbo].[DistributorClientAddress] dca
		ON inv.[ShipTo] = dca.[ID]
	JOIN [dbo].[ShipmentMode] sm
		ON inv.[ShipmentMode] = sm.[ID]
	JOIN [dbo].[WeeklyProductionCapacity] wpc
		ON inv.[WeeklyProductionCapacity] = wpc.[ID]
  

GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** CREATE NEW TABLE HSCODE --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HSCode_Gender]') AND parent_object_id = OBJECT_ID(N'[dbo].[HSCode]'))
ALTER TABLE [dbo].[HSCode] DROP CONSTRAINT [FK_HSCode_Gender]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HSCode_ItemSubCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[HSCode]'))
ALTER TABLE [dbo].[HSCode] DROP CONSTRAINT [FK_HSCode_ItemSubCategory]
GO

/****** Object:  Table [dbo].[HSCode]    Script Date: 01/17/2014 12:21:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HSCode]') AND type in (N'U'))
DROP TABLE [dbo].[HSCode]
GO

/****** Object:  Table [dbo].[HSCode]    Script Date: 01/17/2014 12:21:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HSCode](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemSubCategory] [int] NOT NULL,
	[Gender] [int] NOT NULL,
	[Code] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_HSCode] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[HSCode]  WITH CHECK ADD  CONSTRAINT [FK_HSCode_Gender] FOREIGN KEY([Gender])
REFERENCES [dbo].[Gender] ([ID])
GO

ALTER TABLE [dbo].[HSCode] CHECK CONSTRAINT [FK_HSCode_Gender]
GO

ALTER TABLE [dbo].[HSCode]  WITH CHECK ADD  CONSTRAINT [FK_HSCode_ItemSubCategory] FOREIGN KEY([ItemSubCategory])
REFERENCES [dbo].[Item] ([ID])
GO

ALTER TABLE [dbo].[HSCode] CHECK CONSTRAINT [FK_HSCode_ItemSubCategory]
GO
--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** Add New Page and menuItem Role for HSCode  --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**

DECLARE @Page AS int
DECLARE @ParentPage AS int
DECLARE @Parent AS int
DECLARE @Position AS int
DECLARE @MenuItem AS int
DECLARE @Role AS int 

INSERT INTO [Indico].[dbo].[Page] ([Name], [Title], [Heading]) VALUES ('/ViewHSCode.aspx' ,'HS Codes', 'HS Codes')

SET @Page = (SCOPE_IDENTITY())

SET @ParentPage = (SELECT [ID] FROM [dbo].[Page] WHERE [Name] = '/ViewPatterns.aspx')

SET @Parent = (SELECT [ID] FROM [dbo].[MenuItem] WHERE [Page] = @ParentPage AND [Parent] IS NULL)

SET @Position = (SELECT MAX([Position])+1 FROM [dbo].[MenuItem] WHERE [Parent] = @Parent)

INSERT INTO [Indico].[dbo].[MenuItem] ([Page], [Name], [Description], [IsActive], [Parent], [Position], [IsVisible])
   VALUES (@Page ,'HS Codes' ,'HS Codes', 1, @Parent, @Position, 1)

SET @MenuItem = (SCOPE_IDENTITY())


SET @Role = (SELECT [ID] FROM [dbo].[Role] WHERE [Description] = 'Indiman Administrator')

INSERT INTO [Indico].[dbo].[MenuItemRole] ([MenuItem], [Role]) VALUES (@MenuItem, @Role)
GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** INSERT DATA To The HS Code --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**

INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'HOODIE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6101.30.00 06')
GO	
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'WINDCHEATER WITH BUTTONS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6101.30.00 06')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'WINDCHEATER WITH ZIP' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6101.30.00 06')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE HOODIE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6101.30.00 06')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE TRACK JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6101.30.00 06')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE TRACK JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'),'6101.30.00 06')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'WINDCHEATER WITH ZIP' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6101.30.00 06')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE TRACK JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6103.33.00 53')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SUBJACKET HOODIE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6103.33.00 53')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SUBJACKET HOODIE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6103.33.00 53')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE RAIN JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'),'6103.33.00 53')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BOWLES JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'),'6103.33.00 53')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BOWLES JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6103.33.00 53')	
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'HOODIE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 53')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'HOODIE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6103.33.00 53')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'HUNT JACKET' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6103.33.00 53')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'JACKET 6 IN 1' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6103.33.00 53')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'elite RAIN JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 53')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SPRAY JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 53')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SPRAY JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6103.33.00 53')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SUBJACKET STANDUP COLLAR' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6103.33.00 53')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SUBJACKET STANDUP COLLAR' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6103.33.00 53') 	
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'TRACK JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6103.33.00 53')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'TRACK JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6103.33.00 53')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'TRACK JACKET' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')
GO

INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'TRACK JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6103.33.00 57')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SUBJACKET STANDUP COLLAR' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')	
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SPRAY JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'STANDUP COLLAR JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')	
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'LEISURE JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'JACKET 3 IN 1' AND [Parent] IS NOT NULL),(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'HOODIE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'FLYING JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = '3/4 ALL WEATHER JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = '3/4 ALL WEATHER JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6103.33.00 57')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'ALL WEATHER JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BOWLES JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SUBJACKET HOODIE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING JACKET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.33.00 57')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CRICKET PANTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 32')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE PANTS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 32')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRAINING TIGHTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRI SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CRICKET PANTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING KNICKS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELASTIC WAIST SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'LONG TIGHTS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NON-SUBLIMATED SCHOOL SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')
--GO

INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRACK PANTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRACK PANTS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6103.43.00 44')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'RUNNING SHORTS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SHORTS WITH SIDE PANELS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6103.43.00 44')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SHORTS WITH SIDE PANELS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6103.43.00 44')	
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NETBALL DRESS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.43.00 17')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'GRID GIRL DRESS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.43.00 17')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'A-LINE SKIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.53.00 56')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NETBALL SKIRT WITH BRIEFS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.53.00 56')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SKIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.53.00 56')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SKIRT WITH BRIEFS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.53.00 56')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CRICKET PANTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6104.63.00 38')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CRICKET PANTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6104.63.00 38')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE PANTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.63.00 38')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRI SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.63.00 39')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRI SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6104.63.00 39')	
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRAINING TIGHTS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.63.00 39')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRAINING TIGHTS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6104.63.00 39')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.63.00 39')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'BOYLEG SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.63.00 39')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'BOYLEG SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6104.63.00 39')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELASTIC WAIST SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6104.63.00 39')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELASTIC WAIST SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.63.00 39')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELASTIC WAIST SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6104.63.00 39')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING KNICKS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6104.63.00 39')
--GO

INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'POLO SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6105.20.00 04')
GO  	 	 	 
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'POLO SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6106.20.00 04')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'POLO SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6106.20.00 04')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'RASHIE VEST' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6106.20.00 04')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'RASHIE VEST' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6106.20.00 04')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'RASHIE VEST' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6106.20.00 04')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'RODEO SHIRT' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6106.20.00 04')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NETBALL BODYSUIT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6106.20.00 04')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'SOCCER SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6106.20.00 04')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SHOWGIRL SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6106.20.00 04')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'POLO SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6106.90.00 06')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NETBALL BOYLEG BRIEFS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6108.22.00 42')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ATHLETICS BRIEFS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6108.22.00 42')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'T SHIRT SPURS NECK' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 05')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'T SHIRT V NECK' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 05')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'T SHIRT CREW NECK' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 05')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE BUTTON UP' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 05') 
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE T-SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 05')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE T-SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 05')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE T-SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES')	, '6109.90.00 06')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE POLO' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 06')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE BUTTON UP' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS')	, '6109.90.00 06')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE BUTTON UP' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6109.90.00 06')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'T SHIRT CREW NECK' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6109.90.00 06')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'T SHIRT CREW NECK' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 06')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'T SHIRT ROUND NECK' AND [Parent] IS NOT NULL),(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 06')
--GO

--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'T SHIRT V NECK' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 06')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'T SHIRT V NECK' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6109.90.00 06')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'T SHIRT V NECK' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 06')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'HIGH NECK T SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 06')	
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SINGLET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 28')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BASKETBALL JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 28')	
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CRICKET VEST' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 28')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING VEST' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 28')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE SINGLET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 28')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRI SINGLET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS')	, '6109.90.00 28')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRI SINGLET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6109.90.00 37')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRI SINGLET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 37')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'VEST' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6109.90.00 37')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'VEST' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6109.90.00 37')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'VEST' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 37')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BOWLES VEST' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 37')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BASKETBALL JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6109.90.00 37')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BASKETBALL JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX')	, '6109.90.00 37')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SINGLET' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6109.90.00 37')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SINGLET' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 37')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SAFETY VEST' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 37')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'REVERSIBLE PINNIE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6109.90.00 37')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NETBALL SINGLET' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6109.90.00 37')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'RUGBY JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6110.30.00 53')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'AUSSIE RULES JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6110.30.00 53')
GO


INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'AUSSIE RULES JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6110.30.00 53')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'AUSSIE RULES JERSEY' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6110.30.00 53')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6110.30.00 53')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6110.30.00 53')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6110.30.00 53')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6110.30.00 57')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'DOWNHILL JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6110.30.00 57')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'GRID IRON JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6110.30.00 57')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'AUSSIE RULES JERSEY' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6110.30.00 57')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'AUSSIE RULES JERSEY' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6110.30.00 57')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'RUGBY JERSEY' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6110.30.00 57')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT TOP 1 [ID] FROM [dbo].[Item] WHERE [Name] = 'RUGBY JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6110.30.00 57')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'T SHIRT V NECK' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS')	, '6110.30.00 57')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'MOUNTAIN BIKE JERSEY' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS')	, '6110.30.00 57')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BREIFS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6112.31.00 15')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'KNEE LENGTH SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6112.31.00 15')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ONE PIECE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6112.41.00 16')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'V NECK FITTED TOP' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 06')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'GRID GIRL CROP TOP' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 06')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ATHLETICS CROP TOP' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 06')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NETBALL CROP TOP' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 06')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SINGLET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6114.30.00 06')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SKINSUIT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS')	, '6114.30.00 88')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NETBALL BIB' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'N/A'), '6114.30.00 88')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NETBALL BODYSUIT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 88')
--GO

--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ROWING SUIT' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6114.30.00 88')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ROWING SUIT' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 88')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ATHLETICS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6114.30.00 88')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ATHLETICS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 88')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'FULL ZIP ALL IN ONE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS')	, '6114.30.00 88')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'FULL ZIP ALL IN ONE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6114.30.00 88')	
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'GRID GIRL BODYSUIT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 88')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING BIB' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6114.30.00 88')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CYCLING BIB' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 88')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'V NECK FITTED TOP' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6114.30.00 88')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'V NECK NETBALL BODYSUIT' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 88')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRI SUIT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6114.30.00 88')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'TRI SUIT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6114.30.00 88')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'LEG WARMER' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6115.96.90 09')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'EMBELLISHED COLLARS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6117.80.90 08')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'EMBELLISHED CUFFS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6117.80.90 08')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ARM WARMER' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6117.80.90 08')	
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BOARD SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS')	, '6203.43.00 04')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NON-SUBLIMATED SCHOOL SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6203.43.00 04')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6203.43.00 04')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'RACING SILKS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6203.43.00 26')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NON-SUBLIMATED SCHOOL SKIRTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6204.53.00 11')	
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NON-SUBLIMATED SCHOOL CULOTTES' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6204.53.00 11')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NON-SUBLIMATED SCHOOL SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6204.63.00 04')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NON-SUBLIMATED SCHOOL SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6204.63.00 04')
--GO

INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BOARD SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6204.63.00 04')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ELITE SHORTS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6204.63.00 04')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'COVERALLS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6204.63.00 07')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'BIB COVERALLS' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6204.63.00 07')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SHOW PANTS' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6204.63.00 07')	
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NON-SUBLIMATED SCHOOL SHIRT' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6205.30.00 59')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NON-SUBLIMATED FORMAL SCHOOL SHIRT' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6205.30.00 59')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'COWBOY SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6205.30.00 59')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CUT AND SEWN SHIRT' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'MENS'), '6205.30.00 59')
GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'COWGIRL SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6206.40.00 56') 
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'NON-SUBLIMATED SCHOOL BLOUSE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6206.40.00 56')
--GO
INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SHOWMAN SHIRT' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6206.40.00 56')
GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CORSET' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'LADIES'), '6211.43.00 27')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'SCHOOL TIE' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6215.20.00 54')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'ALLEY CURTAIN' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'N/A'), '6303.12.10 27')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CAP 4 PANEL' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6505.00.90 44')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CAP 5 PANEL' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6505.00.90 44')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'CAP 6 PANEL' AND [Parent] IS NOT NULL), (SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6505.00.90 44')
--GO
--INSERT INTO [Indico].[dbo].[HSCode] ([ItemSubCategory], [Gender], [Code]) VALUES((SELECT [ID] FROM [dbo].[Item] WHERE [Name] = 'VISOR' AND [Parent] IS NOT NULL),	(SELECT [ID] FROM [dbo].[Gender] WHERE [Name] = 'UNISEX'), '6505.00.90 44')
--GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** Modify SPC_GetWeeklyAddressDetails --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**


/****** Object:  StoredProcedure [dbo].[SPC_GetWeeklyAddressDetails]    Script Date: 01/20/2014 14:45:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_GetWeeklyAddressDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_GetWeeklyAddressDetails]
GO


/****** Object:  StoredProcedure [dbo].[SPC_GetWeeklyAddressDetails]    Script Date: 01/20/2014 14:45:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SPC_GetWeeklyAddressDetails] (	
@P_WeekEndDate datetime2(7),
@P_CompanyName NVARCHAR(255) = '',
@P_ShipmentMode int = 0 
)	
AS 
BEGIN
	
		SELECT	   od.[ID] AS OrderDetail
				  ,ot.[Name] AS OrderType
				  ,vl.[NamePrefix] + ISNULL(CAST(vl.[NameSuffix] AS nvarchar(255)),'') AS VisualLayout
				  ,od.[VisualLayout] AS VisualLayoutID
				  ,od.[Pattern] AS PatternID
				  ,p.[Number] + ' - ' + p.[NickName] AS Pattern
				  ,od.[FabricCode] AS FabricID
				  ,fc.[Code] + ' - ' + fc.[Name] AS Fabric
				  ,od.[VisualLayoutNotes] AS VisualLayoutNotes      
				  ,od.[Order] AS 'Order'
				  ,ISNULL(od.[Label], 0) AS Label
				  ,ISNULL(ods.[Name], 'New') AS OrderDetailStatus
				  ,ISNULL(od.[Status], 0) AS OrderDetailStatusID
				  ,od.[ShipmentDate] AS ShipmentDate
				  ,od.[SheduledDate] AS SheduledDate      
				  ,od.[RequestedDate] AS RequestedDate
				  ,ISNULL((SELECT SUM(odq.[Qty]) FROM [dbo].[OrderDetailQty] odq WHERE odq.[OrderDetail] = od.[ID]),0) AS Quantity       
				  ,ISNULL(o.[OldPONo], '') AS 'PurONo'
				  ,c.[Name] AS Distributor
				  ,u.[GivenName] + ' ' + u.[FamilyName] AS Coordinator
				  ,cl.[Name] AS Client
				  ,os.[Name] AS OrderStatus
				  ,o.[Status] AS OrderStatusID				  
				  ,ISNULL(o.[ShipmentMode], 0) AS ShimentModeID
				  ,ISNULL(shm.[Name], 'AIR') AS ShipmentMode
				  ,ISNULL(dca.[CompanyName], '') AS 'CompanyName'
				  ,dca.[Address] AS 'Address'
				  ,dca.[Suburb]  AS 'Suberb' 
				  ,ISNULL(dca.[State],'') AS 'State'
				  ,dca.[PostCode]  AS 'PostCode'				 
				  ,coun.[ShortName] AS 'Country'
				  ,dca.[ContactName] + ' ' + dca.[ContactPhone] AS 'ContactDetails'
				  ,o.[IsWeeklyShipment] AS 'IsWeeklyShipment'
				  ,[IsAdelaideWareHouse] AS 'IsAdelaideWareHouse'
				  ,ISNULL(o.[DespatchToExistingClient], 0) AS 'ShipTo'
				  ,ISNULL(CAST((SELECT CASE
										WHEN (p.[SubItem] IS NULL)
											THEN  	('')
										ELSE (CAST((SELECT TOP 1 hsc.[Code] FROM [dbo].[HSCode] hsc WHERE hsc.[ItemSubCategory] = p.[SubItem] AND hsc.[Gender] = p.[Gender]) AS nvarchar(64)))
								END) AS nvarchar (64)), '') AS 'HSCode'
			  FROM [Indico].[dbo].[OrderDetail] od
				JOIN [dbo].[Order] o
					ON od.[Order] = o.[ID]
				JOIN [dbo].[VisualLayout] vl
					ON od.[VisualLayout] = vl.[ID]
				JOIN [dbo].[Pattern] p 
					ON od.[Pattern] = p.[ID]
				JOIN [dbo].[FabricCode] fc
					ON od.[FabricCode] = fc.[ID]
				LEFT OUTER JOIN [dbo].[OrderDetailStatus] ods
					ON od.[Status] = ods.[ID]
				JOIN [dbo].[OrderType] ot
					ON od.[OrderType] = ot.[ID]
				JOIN [dbo].[Company] c
					ON c.[ID] = o.[Distributor]
				JOIN [dbo].[User] u
					ON c.[Coordinator] = u.[ID]
				JOIN [dbo].[Client] cl
					ON o.[Client] = cl.[ID]
				JOIN [dbo].[OrderStatus] os
					ON o.[Status] = os.[ID]				
				JOIN [dbo].[ShipmentMode] shm
					ON o.[ShipmentMode] = shm.[ID] 
				JOIN [dbo].[DistributorClientAddress] dca
					ON o.[DespatchToExistingClient] = dca.[ID]
				JOIN [dbo].[Country] coun
					ON dca.[Country] = coun.[ID]
			WHERE (od.[SheduledDate] > DATEADD(day, -7, @P_WeekEndDate) AND od.[SheduledDate] <= @P_WeekEndDate) AND
				  (@P_CompanyName = '' OR dca.[CompanyName] = @P_CompanyName ) AND
				  (@P_ShipmentMode = 0 OR shm.[ID] = @P_ShipmentMode)
			ORDER BY cl.[Name]

	END 


GO


--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

--**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-** Modify [ReturnWeeklyAddressDetails] --**-**-**-**--**-**-**-**--**-**-**-**--**-**-**-**

/****** Object:  View [dbo].[ReturnWeeklyAddressDetails]    Script Date: 01/20/2014 14:53:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReturnWeeklyAddressDetails]'))
DROP VIEW [dbo].[ReturnWeeklyAddressDetails]
GO

/****** Object:  View [dbo].[ReturnWeeklyAddressDetails]    Script Date: 01/20/2014 14:53:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ReturnWeeklyAddressDetails]
AS
			SELECT
				  0 AS OrderDetail,
				  '' AS OrderType,
				  '' AS VisualLayout,
				  0 AS VisualLayoutID,
				  0 AS PatternID,
				  '' AS Pattern,
				  0 AS FabricID,
				  '' AS Fabric,
				  '' AS VisualLayoutNotes,      
				  0 AS 'Order',
				  0 AS Label,
				  '' AS OrderDetailStatus,
				  0 AS OrderDetailStatusID,
				  GETDATE() AS ShipmentDate,
				  GETDATE() AS SheduledDate,
				  GETDATE() AS RequestedDate,
				  0 AS Quantity,				 
				  '' AS 'PurONo',
				  '' AS Distributor,
				  '' AS Coordinator,
				  '' AS Client,
				  '' AS OrderStatus,
				  0 AS OrderStatusID,				  
				  0 AS ShimentModeID,
				  '' AS ShipmentMode,
				  '' AS 'CompanyName',
				  '' AS 'Address',
				  '' AS 'Suberb',
				  '' AS 'State',
				  '' AS 'PostCode',
				  '' AS 'Country',
				  '' AS 'ContactDetails',
				  CONVERT(bit,0) AS 'IsWeeklyShipment',
				  CONVERT(bit,0) AS 'IsAdelaideWareHouse',
				  0 AS 'ShipTo',
				  '' AS 'HSCode'	 

GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

