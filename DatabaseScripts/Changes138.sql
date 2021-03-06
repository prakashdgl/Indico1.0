USE [Indico]
GO

/****** Object:  Table [dbo].[ArtWork]    Script Date: 06/15/2015 16:13:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ArtWork](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceNo] [nvarchar](64) NOT NULL,	
	[Pattern] [int] NOT NULL,
	[FabricCode] [int] NOT NULL,
	[Client] [int] NULL,
	[NNPFilePath] [nvarchar](512) NULL,	
	[CreatedDate] [datetime2](7) NULL,	
	[ResolutionProfile] [int] NULL,
	[PocketType] [int] NULL,
	[IsConvertedToVL] [bit] NOT NULL,
 CONSTRAINT [PK_ArtWork] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArtWork', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The ReferenceNo of the ArtWork' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArtWork', @level2type=N'COLUMN',@level2name=N'ReferenceNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Pattern associated with this ArtWork' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArtWork', @level2type=N'COLUMN',@level2name=N'Pattern'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Fabric code associated with this ArtWork' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArtWork', @level2type=N'COLUMN',@level2name=N'FabricCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Client associated with this ArtWork' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArtWork', @level2type=N'COLUMN',@level2name=N'Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The names and numbers' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArtWork', @level2type=N'COLUMN',@level2name=N'NNPFilePath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is converted to a VL' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArtWork', @level2type=N'COLUMN',@level2name=N'IsConvertedToVL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ArtWork'
GO

ALTER TABLE [dbo].[ArtWork]  WITH CHECK ADD  CONSTRAINT [FK_ArtWork_Client] FOREIGN KEY([Client])
REFERENCES [dbo].[Client] ([ID])
GO

ALTER TABLE [dbo].[ArtWork] CHECK CONSTRAINT [FK_ArtWork_Client]
GO

ALTER TABLE [dbo].[ArtWork]  WITH CHECK ADD  CONSTRAINT [FK_ArtWork_FabricCode] FOREIGN KEY([FabricCode])
REFERENCES [dbo].[FabricCode] ([ID])
GO

ALTER TABLE [dbo].[ArtWork] CHECK CONSTRAINT [FK_ArtWork_FabricCode]
GO

ALTER TABLE [dbo].[ArtWork]  WITH CHECK ADD  CONSTRAINT [FK_ArtWork_Pattern] FOREIGN KEY([Pattern])
REFERENCES [dbo].[Pattern] ([ID])
GO

ALTER TABLE [dbo].[ArtWork] CHECK CONSTRAINT [FK_ArtWork_Pattern]
GO

ALTER TABLE [dbo].[ArtWork]  WITH CHECK ADD  CONSTRAINT [FK_ArtWork_PocketType] FOREIGN KEY([PocketType])
REFERENCES [dbo].[PocketType] ([ID])
GO

ALTER TABLE [dbo].[ArtWork] CHECK CONSTRAINT [FK_ArtWork_PocketType]
GO

ALTER TABLE [dbo].[ArtWork]  WITH CHECK ADD  CONSTRAINT [FK_ArtWork_ResolutionProfile] FOREIGN KEY([ResolutionProfile])
REFERENCES [dbo].[ResolutionProfile] ([ID])
GO

ALTER TABLE [dbo].[ArtWork] CHECK CONSTRAINT [FK_ArtWork_ResolutionProfile]
GO

ALTER TABLE [dbo].[ArtWork] ADD CONSTRAINT DF_IsConvertedToVL DEFAULT (0) FOR [IsConvertedToVL]
GO


----------------------------------------------------------------------------------------

/****** Object:  Table [dbo].[ArtWorkAccessory]    Script Date: 06/15/2015 16:18:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ArtWorktAccessory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ArtWork] [int] NOT NULL,
	[Accessory] [int] NULL,
	[AccessoryColor] [int] NULL,
 CONSTRAINT [PK_ArtWorktAccessory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ArtWorktAccessory]  WITH CHECK ADD  CONSTRAINT [FK_ArtWorktAccessory_Accessory] FOREIGN KEY([Accessory])
REFERENCES [dbo].[Accessory] ([ID])
GO

ALTER TABLE [dbo].[ArtWorktAccessory] CHECK CONSTRAINT [FK_ArtWorktAccessory_Accessory]
GO

ALTER TABLE [dbo].[ArtWorktAccessory]  WITH CHECK ADD  CONSTRAINT [FK_ArtWorktAccessory_AccessoryColor] FOREIGN KEY([AccessoryColor])
REFERENCES [dbo].[AccessoryColor] ([ID])
GO

ALTER TABLE [dbo].[ArtWorktAccessory] CHECK CONSTRAINT [FK_ArtWorktAccessory_AccessoryColor]
GO

ALTER TABLE [dbo].[ArtWorktAccessory]  WITH CHECK ADD  CONSTRAINT [FK_ArtWorktAccessory_ArtWork] FOREIGN KEY([ArtWork])
REFERENCES [dbo].[ArtWork] ([ID])
GO

ALTER TABLE [dbo].[ArtWorktAccessory] CHECK CONSTRAINT [FK_ArtWorktAccessory_ArtWork]
GO

-------------Add column to OrderDetail-------------

ALTER TABLE [dbo].[OrderDetail] ADD IsLockerPatch bit NOT NULL CONSTRAINT DF_IsLockerPatch DEFAULT (0)
GO

--------------- AddEditArtWork page --------------------

DECLARE @PageId int
DECLARE @MenuItemMenuId int
DECLARE @MenuItemId int

DECLARE @IndimanAdministrator int
DECLARE @IndimanCoordinator int
DECLARE @IndicoAdministrator int
DECLARE @IndicoCoordinator int
DECLARE @DistributorAdministrator int
DECLARE @DistributorCoordinator int

SET @MenuItemMenuId =  (SELECT ID FROM [dbo].[MenuItem] WHERE 
						(Page = (SELECT ID FROM [dbo].Page WHERE Name = '/ViewVisualLayouts.aspx'))
						AND Parent IS NULL )

SET @IndimanAdministrator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indiman Administrator')
SET @IndimanCoordinator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indiman Coordinator')
SET @IndicoAdministrator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indico Administrator')
SET @IndicoCoordinator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Indico Coordinator')
SET @DistributorAdministrator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Distributor Administrator')
SET @DistributorCoordinator = (SELECT ID FROM [dbo].[Role] WHERE [Description] = 'Distributor Coordinator')

INSERT INTO [dbo].[Page]([Name],[Title],[Heading])
	 VALUES('/AddEditArtWork.aspx','Art Work','Art Work')
SET @PageId = SCOPE_IDENTITY()

INSERT INTO [dbo].[MenuItem]
			([Page],[Name],[Description],[IsActive],[Parent],[Position],[IsVisible])
	 VALUES (@PageId, 'Art Work', 'Art Work', 1, @MenuItemMenuId, 2, 0)
SET @MenuItemId = SCOPE_IDENTITY()	

INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndimanAdministrator)
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndimanCoordinator)
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndicoAdministrator)
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @IndicoCoordinator)
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @DistributorAdministrator)
INSERT INTO [dbo].[MenuItemRole] ([MenuItem],[Role])
	 VALUES (@MenuItemId, @DistributorCoordinator) 	 
	 	 
GO

---------- Alter Table OrderDetail ------

ALTER TABLE dbo.[OrderDetail] ALTER COLUMN [VisualLayout] [int] NULL
GO

ALTER TABLE dbo.[OrderDetail] ADD [ArtWork] [int] NULL
GO

ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_ArtWork] FOREIGN KEY([ArtWork])
REFERENCES [dbo].[ArtWork] ([ID])
GO

ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_ArtWork]
GO

--------- Alter Table Order -----

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Order_Printer]') AND parent_object_id = OBJECT_ID(N'[dbo].[Order]'))
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Order_Printer]
GO

ALTER TABLE dbo.[Order] DROP COLUMN [Printer]
GO

--------- Alter Table VisualLayout -----

ALTER TABLE dbo.[VisualLayout] ADD [Printer] [int] NULL
GO

ALTER TABLE [dbo].[VisualLayout]  WITH CHECK ADD  CONSTRAINT [FK_VisualLayout_Printer] FOREIGN KEY([Printer])
REFERENCES [dbo].[Printer] ([ID])
GO

--------------------------- Sp and View changes to get artwork -------------

/****** Object:  View [dbo].[ReturnOrderDetailsIndicoPriceView]    Script Date: 06/19/2015 10:32:29 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReturnOrderDetailsIndicoPriceView]'))
DROP VIEW [dbo].[ReturnOrderDetailsIndicoPriceView]
GO

/****** Object:  View [dbo].[ReturnOrderDetailsIndicoPriceView]    Script Date: 06/19/2015 10:32:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ReturnOrderDetailsIndicoPriceView]
AS
	SELECT 
		0 AS OrderDetail,
		'' AS 'OrderType',
		'' AS 'VisualLayout',		
		0 AS VisualLayoutID,
		0 AS ArtWorkID,		
		'' AS Pattern,
		0 AS PatternID,
		0 AS FabricID,
		0 AS Distributor,
		'' AS 'Fabric',
		'' AS VisualLayoutNotes,
		0 AS 'Order',
		0 AS Label,
		'' AS 'Status',
		0 AS 'StatusID',
		GETDATE() AS ShipmentDate,
		GETDATE() AS SheduledDate,
		CONVERT(bit,0)AS IsRepeat,	
		GETDATE() AS RequestedDate,
		0.0 AS EditedPrice,
		'' AS EditedPriceRemarks,
		0 AS Quantity,
		0.0 AS EditedIndicoPrice,
		0.0 AS TotalIndicoPrice

GO

/****** Object:  StoredProcedure [dbo].[SPC_GetOrderDetailIndicoPrice]    Script Date: 06/19/2015 10:24:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_GetOrderDetailIndicoPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_GetOrderDetailIndicoPrice]
GO


/****** Object:  StoredProcedure [dbo].[SPC_GetOrderDetailIndicoPrice]    Script Date: 06/19/2015 10:24:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SPC_GetOrderDetailIndicoPrice]
(
	@P_Order AS int,
	@P_PriceTerm AS int	
)
AS 

BEGIN

DECLARE @j int
SET @j = 0
DECLARE @TempOrderDetail TABLE 
(
	ID int NOT NULL,
	[OrderDetail] [int] NOT NULL,
	[OrderType] [nvarchar] (255) NOT NULL,
	[VisualLayout] [nvarchar] (255) NOT NULL ,
	[VisualLayoutID] [int]  NULL,
	[ArtWorkID] [int]  NULL,
	[Pattern] [nvarchar] (255) NOT NULL,
	[PatternID] [int] NOT NULL,
	[FabricID] [int] NOT NULL,
	[Distributor] [int] NOT NULL,
	[Fabric] [nvarchar] (255) NOT NULL,
	[VisualLayoutNotes] [nvarchar] (255) NULL,
	[Order] [int] NOT NULL,
	[Label] [int] NULL,
	[Status] [nvarchar] (255) NULL,
	[StatusID] [int] NULL,
	[ShipmentDate] [datetime2](7) NOT NULL,
	[SheduledDate] [datetime2](7) NOT NULL,	
	[IsRepeat] [bit] NOT NULL,
	[RequestedDate] [datetime2](7) NOT NULL,
	[EditedPrice] [decimal](8, 2) NULL,
	[EditedPriceRemarks] [nvarchar](255) NULL,
	[Quantity] [int] NULL,
	[EditedIndicoPrice] [decimal](8, 2) NULL,	
	[TotalIndicoPrice] [decimal](8, 2) NULL	
)

	INSERT INTO @TempOrderDetail (ID, [OrderDetail], [OrderType],  [VisualLayout], [VisualLayoutID],[ArtWorkID], [Pattern], [PatternID], [FabricID], [Distributor],  [Fabric], [VisualLayoutNotes] , [Order], [Label], [Status], 
							  [StatusID], [ShipmentDate], [SheduledDate], [IsRepeat], [RequestedDate], [EditedPrice], [EditedPriceRemarks], [Quantity], [EditedIndicoPrice], [TotalIndicoPrice])
	SELECT CONVERT(int, ROW_NUMBER() OVER (ORDER BY od.ID)) AS ID
		  ,od.[ID] AS OrderDetail
		  ,ot.[Name] AS OrderType
		  ,vl.[NamePrefix] + ''+ ISNULL(CAST(vl.[NameSuffix] AS NVARCHAR(64)), '') AS VisualLayout
		  ,od.[VisualLayout] AS VisualLayoutID
		  ,od.[ArtWork] AS ArtWorkID
		  ,p.[Number] AS Pattern
		  ,od.[Pattern] AS PatternID
		  ,od.[FabricCode] AS FabricID
		  ,o.[Distributor] AS Distributor
		  ,fc.[Name] AS Fabric
		  ,od.[VisualLayoutNotes] AS VisualLayoutNotes
		  ,od.[Order] AS 'Order'
		  ,ISNULL(o.[Label],0) AS Label
		  ,ISNULL(ods.[Name], 'New') AS 'Status'
		  ,ISNULL(od.[Status],0) AS StatusID 
		  ,od.[ShipmentDate] AS ShipmentDate
		  ,od.[SheduledDate] AS SheduledDate
		  ,od.[IsRepeat] AS IsRepeat
		  ,od.[RequestedDate] AS RequestedDate
		  ,ISNULL(od.[EditedPrice], 0.00) AS DistributoEditedPrice
		  ,ISNULL(od.[EditedPriceRemarks], '') AS DistributorEditedPriceComments
		  ,ISNULL((SELECT SUM(odq.[Qty]) FROM [dbo].[OrderDetailQty] odq WHERE odq.[OrderDetail] = od.[ID]), 0) AS Quantity
		  ,NULL
		  ,NULL
	FROM [dbo].[OrderDetail] od
		JOIN [dbo].[OrderType] ot 
			ON od.[OrderType] = ot.[ID]
		JOIN [dbo].[VisualLayout] vl 
			ON od.[VisualLayout] =  vl.[ID]
		JOIN [dbo].[Pattern] p
			ON od.[Pattern] = p.[ID]
		JOIN [dbo].[FabricCode] fc
			ON od.[FabricCode] = fc.[ID]
		JOIN [dbo].[Order] o
			ON od.[Order] = o.[ID]
		LEFT OUTER JOIN [dbo].[OrderDetailStatus] ods
			ON ods.[ID] = od.[Status]	
	WHERE od.[Order] = @P_Order	
	
		
		DECLARE @i int
		DECLARE @LevelID AS int
		DECLARE @Quantity AS decimal(8,2)
		DECLARE @Pattern AS int		
		DECLARE @Fabric AS int
		DECLARE @Distributor AS int
		DECLARE @Price AS decimal(8,2)
		DECLARE @OrderDetail AS int
		DECLARE @TotalPrice AS decimal(8,2)
		DECLARE @HasDistributor AS int
		
		SET @i = 1
		
		DECLARE @Count int
		SELECT @Count = COUNT(ID) FROM @TempOrderDetail 
		
		WHILE (@i <= @Count)
		BEGIN
		
		SET @Quantity = (SELECT CAST(tod.[Quantity] AS INT) FROM @TempOrderDetail tod WHERE tod.[ID] = @i)
		SET @Pattern = (SELECT tod.[PatternID] FROM @TempOrderDetail tod WHERE tod.[ID] = @i)
		SET @Fabric = (SELECT tod.[FabricID] FROM @TempOrderDetail tod WHERE tod.[ID] = @i)
		SET @Distributor = (SELECT tod.[Distributor] FROM @TempOrderDetail tod WHERE tod.[ID] = @i)
		SET @OrderDetail = (SELECT tod.[OrderDetail] FROM @TempOrderDetail tod WHERE tod.[ID] = @i)
		SET @HasDistributor = (SELECT COUNT(*) FROM [dbo].[DistributorPriceLevelCost] WHERE [Distributor] = @Distributor)
						
				IF (@Quantity < 6)
				 BEGIN  
					SET @LevelID =  1					
				 END
				ELSE IF (@Quantity > 5 AND @Quantity < 10)
				 BEGIN
					 SET @LevelID = 2 					
				 END
				ELSE IF (@Quantity > 9 AND @Quantity < 20)
				 BEGIN 
					SET @LevelID = 3 					
				 END
				ELSE IF (@Quantity > 19 AND @Quantity < 50)
				 BEGIN
				 	SET @LevelID = 4				 
				 END
					ELSE IF (@Quantity > 49 AND @Quantity < 100)
				 BEGIN
					SET @LevelID = 5
				 END
				ELSE IF (@Quantity > 99 AND @Quantity < 250)
				 BEGIN	
					SET @LevelID = 6
				 END
				ELSE IF (@Quantity > 249 AND @Quantity < 500)
				 BEGIN
					 SET @LevelID = 7
				 END
				ELSE IF (@Quantity > 499)
				 BEGIN	
					SET @LevelID = 8
				 END	 

			SET @i = @i + 1	
			
			
			SET	@Price = (SELECT ISNULL(dplc.[IndicoCost], NULL)
																			  
							FROM [Indico].[dbo].[DistributorPriceLevelCost] dplc
								JOIN [dbo].[PriceLevelCost] plc  
									ON dplc.[PriceLevelCost] = plc.[ID]
								JOIN [dbo].[Price] pr 
									ON plc.[Price] = pr.[ID]
								JOIN [dbo].[PriceLevel] pl
									ON plc.[PriceLevel] = pl.[ID]							
							WHERE pr.[Pattern] = @Pattern AND 
							  pr.[FabricCode] = @Fabric AND 
							  ((@HasDistributor =0 AND dplc.[Distributor] IS NULL) OR dplc.[Distributor] = @Distributor ) AND 
							  dplc.[PriceTerm] = @P_PriceTerm AND
							  pl.[ID] = @LevelID)
							  
			
			IF (@Price IS NUll)
				BEGIN
					
					IF (@P_PriceTerm = 1)
						BEGIN													
						
							 SET @Price = (SELECT ISNULL(((ISNULL(plc.[IndimanCost],0.00) * 100) / (100 - (SELECT dpm.[Markup] 
																							  FROM [dbo].[DistributorPriceMarkup] dpm 
																							  WHERE  ((@HasDistributor = 0 AND dpm.[Distributor] IS NULL) OR dpm.[Distributor] = @Distributor ) 
																							  AND dpm.[PriceLevel] = @LevelID))), 0.00)
											FROM  [dbo].[PriceLevelCost] plc  
													JOIN [dbo].[Price] pr 
															ON plc.[Price] = pr.[ID]
													JOIN [dbo].[PriceLevel] pl
															ON plc.[PriceLevel] = pl.[ID]							
											WHERE pr.[Pattern] = @Pattern AND 
												  pr.[FabricCode] = @Fabric AND 						  
												  pl.[ID] = @LevelID)
						END
					ELSE 
						BEGIN
							SET @Price = (SELECT ISNULL(((ISNULL((plc.[IndimanCost] - p.[ConvertionFactor]) ,0.00)) / (1 - ((SELECT dpm.[Markup] 
																														    FROM [dbo].[DistributorPriceMarkup] dpm 
																															WHERE  ((@HasDistributor = 0 AND dpm.[Distributor] IS NULL) OR dpm.[Distributor] = @Distributor) 
																															AND dpm.[PriceLevel] = @LevelID)/100))), 0.00)
											FROM  [dbo].[PriceLevelCost] plc  
													JOIN [dbo].[Price] pr 
															ON plc.[Price] = pr.[ID]
													JOIN [dbo].[PriceLevel] pl
															ON plc.[PriceLevel] = pl.[ID]
													JOIN [dbo].[Pattern] p
															ON pr.[Pattern] = p.[ID]							
											WHERE pr.[Pattern] = @Pattern AND 
												  pr.[FabricCode] = @Fabric AND 						  
												  pl.[ID] = @LevelID)
						END							  
								 
				END							  
			
							  
			SET @TotalPrice = (@Price *	@Quantity)			
												 
			UPDATE @TempOrderDetail SET [EditedIndicoPrice] = ISNULL(@Price, 0.00),
										[TotalIndicoPrice] = ISNULL(@TotalPrice, 0.00) WHERE [OrderDetail] = @OrderDetail
				
		END		
	
	SELECT * FROM @TempOrderDetail
END 

GO

--------------------------- Sp and View changes to get Printer -------------

/****** Object:  View [dbo].[ReturnVisualLayoutDetailsView]    Script Date: 06/19/2015 14:48:21 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReturnVisualLayoutDetailsView]'))
DROP VIEW [dbo].[ReturnVisualLayoutDetailsView]
GO

/****** Object:  View [dbo].[ReturnVisualLayoutDetailsView]    Script Date: 06/19/2015 14:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ReturnVisualLayoutDetailsView]
AS
	SELECT 
		0 AS VisualLayout,
		'' AS Name,
		'' AS 'Description',
		'' AS Pattern,
		'' AS Fabric,
		'' AS Client,
		'' AS Distributor,
		'' AS Coordinator,
		'' AS NNPFilePath,
		GETDATE() AS CreatedDate,
		CONVERT(bit,0)AS IsCommonProduct,
		0 AS ResolutionProfile,
		0 AS Printer,
		'' AS SizeSet,
		CONVERT(bit,0)AS OrderDetails

GO


/****** Object:  StoredProcedure [dbo].[SPC_ViewVisualLayoutDetails]    Script Date: 06/19/2015 14:46:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_ViewVisualLayoutDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_ViewVisualLayoutDetails]
GO

/****** Object:  StoredProcedure [dbo].[SPC_ViewVisualLayoutDetails]    Script Date: 06/19/2015 14:46:29 ******/
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
			LEFT OUTER JOIN [dbo].[Client] c
				ON v.[Client] = c.[ID]
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
			   AND (@P_Coordinator = '' OR (u.[GivenName] + ' ' + u.[FamilyName])  LIKE + '%' + @P_Coordinator + '%')
			   AND(@P_Distributor = '' OR  d.[Name] LIKE '%' + @P_Distributor + '%')
			   AND(@P_Client = '' OR c.[Name] LIKE '%' + @P_SearchText + '%')
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


---------  Updating all resolution profiles in VisualLayout -------------------

UPDATE dbo.[VisualLayout] SET ResolutionProfile = (SELECT ID FROM dbo.[ResolutionProfile] WHERE Name= 'CMYK HIGH RES')
GO

--------- Alter Table VisualLayout----------------------

ALTER TABLE dbo.[VisualLayout] ADD [ArtWork] [int] NULL
GO

ALTER TABLE [dbo].[VisualLayout]  WITH CHECK ADD CONSTRAINT [FK_VisualLayout_ArtWork] FOREIGN KEY([ArtWork])
REFERENCES [dbo].[ArtWork] ([ID])
GO

----- Changing SPC_GetOrderDetailIndicoPrice to handle artwork------------------------

/****** Object:  StoredProcedure [dbo].[SPC_GetOrderDetailIndicoPrice]    Script Date: 06/22/2015 15:39:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_GetOrderDetailIndicoPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_GetOrderDetailIndicoPrice]
GO
/****** Object:  StoredProcedure [dbo].[SPC_GetOrderDetailIndicoPrice]    Script Date: 06/22/2015 15:39:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SPC_GetOrderDetailIndicoPrice]
(
	@P_Order AS int,
	@P_PriceTerm AS int	
)
AS 

BEGIN

DECLARE @j int
SET @j = 0
DECLARE @TempOrderDetail TABLE 
(
	ID int NOT NULL,
	[OrderDetail] [int] NOT NULL,
	[OrderType] [nvarchar] (255) NOT NULL,
	[VisualLayout] [nvarchar] (255),
	[VisualLayoutID] [int]  NULL,
	[ArtWorkID] [int]  NULL,
	[Pattern] [nvarchar] (255) NOT NULL,
	[PatternID] [int] NOT NULL,
	[FabricID] [int] NOT NULL,
	[Distributor] [int] NOT NULL,
	[Fabric] [nvarchar] (255) NOT NULL,
	[VisualLayoutNotes] [nvarchar] (255) NULL,
	[Order] [int] NOT NULL,
	[Label] [int] NULL,
	[Status] [nvarchar] (255) NULL,
	[StatusID] [int] NULL,
	[ShipmentDate] [datetime2](7) NOT NULL,
	[SheduledDate] [datetime2](7) NOT NULL,	
	[IsRepeat] [bit] NOT NULL,
	[RequestedDate] [datetime2](7) NOT NULL,
	[EditedPrice] [decimal](8, 2) NULL,
	[EditedPriceRemarks] [nvarchar](255) NULL,
	[Quantity] [int] NULL,
	[EditedIndicoPrice] [decimal](8, 2) NULL,	
	[TotalIndicoPrice] [decimal](8, 2) NULL	
)

	INSERT INTO @TempOrderDetail (ID, [OrderDetail], [OrderType],  [VisualLayout], [VisualLayoutID],[ArtWorkID], [Pattern], [PatternID], [FabricID], [Distributor],  [Fabric], [VisualLayoutNotes] , [Order], [Label], [Status], 
							  [StatusID], [ShipmentDate], [SheduledDate], [IsRepeat], [RequestedDate], [EditedPrice], [EditedPriceRemarks], [Quantity], [EditedIndicoPrice], [TotalIndicoPrice])
	SELECT CONVERT(int, ROW_NUMBER() OVER (ORDER BY od.ID)) AS ID
		  ,od.[ID] AS OrderDetail
		  ,ot.[Name] AS OrderType
		  ,ISNULL(vl.[NamePrefix] + ''+ ISNULL(CAST(vl.[NameSuffix] AS NVARCHAR(64)), ''),'') AS VisualLayout
		  ,ISNULL(od.[VisualLayout],0) AS VisualLayoutID
		  ,ISNULL(od.[ArtWork],0) AS ArtWorkID
		  ,p.[Number] AS Pattern
		  ,od.[Pattern] AS PatternID
		  ,od.[FabricCode] AS FabricID
		  ,o.[Distributor] AS Distributor
		  ,fc.[Name] AS Fabric
		  ,od.[VisualLayoutNotes] AS VisualLayoutNotes
		  ,od.[Order] AS 'Order'
		  ,ISNULL(o.[Label],0) AS Label
		  ,ISNULL(ods.[Name], 'New') AS 'Status'
		  ,ISNULL(od.[Status],0) AS StatusID 
		  ,od.[ShipmentDate] AS ShipmentDate
		  ,od.[SheduledDate] AS SheduledDate
		  ,od.[IsRepeat] AS IsRepeat
		  ,od.[RequestedDate] AS RequestedDate
		  ,ISNULL(od.[EditedPrice], 0.00) AS DistributoEditedPrice
		  ,ISNULL(od.[EditedPriceRemarks], '') AS DistributorEditedPriceComments
		  ,ISNULL((SELECT SUM(odq.[Qty]) FROM [dbo].[OrderDetailQty] odq WHERE odq.[OrderDetail] = od.[ID]), 0) AS Quantity
		  ,NULL
		  ,NULL
	FROM [dbo].[Order] o
		LEFT OUTER JOIN [dbo].[OrderDetail] od
		ON o.[ID] = od.[Order]
		LEFT OUTER JOIN [dbo].[OrderType] ot 
			ON od.[OrderType] = ot.[ID]		
		LEFT OUTER JOIN [dbo].[Pattern] p
			ON od.[Pattern] = p.[ID]
		LEFT OUTER JOIN [dbo].[FabricCode] fc
			ON od.[FabricCode] = fc.[ID]
		LEFT OUTER JOIN [dbo].[OrderDetailStatus] ods
			ON  od.[Status] = ods.[ID]		
		LEFT OUTER JOIN [dbo].[VisualLayout] vl 
			ON od.[VisualLayout] = vl.[ID]		
	WHERE od.[Order] = @P_Order	
	
		
		DECLARE @i int
		DECLARE @LevelID AS int
		DECLARE @Quantity AS decimal(8,2)
		DECLARE @Pattern AS int		
		DECLARE @Fabric AS int
		DECLARE @Distributor AS int
		DECLARE @Price AS decimal(8,2)
		DECLARE @OrderDetail AS int
		DECLARE @TotalPrice AS decimal(8,2)
		DECLARE @HasDistributor AS int
		
		SET @i = 1
		
		DECLARE @Count int
		SELECT @Count = COUNT(ID) FROM @TempOrderDetail 
		
		WHILE (@i <= @Count)
		BEGIN
		
		SET @Quantity = (SELECT CAST(tod.[Quantity] AS INT) FROM @TempOrderDetail tod WHERE tod.[ID] = @i)
		SET @Pattern = (SELECT tod.[PatternID] FROM @TempOrderDetail tod WHERE tod.[ID] = @i)
		SET @Fabric = (SELECT tod.[FabricID] FROM @TempOrderDetail tod WHERE tod.[ID] = @i)
		SET @Distributor = (SELECT tod.[Distributor] FROM @TempOrderDetail tod WHERE tod.[ID] = @i)
		SET @OrderDetail = (SELECT tod.[OrderDetail] FROM @TempOrderDetail tod WHERE tod.[ID] = @i)
		SET @HasDistributor = (SELECT COUNT(*) FROM [dbo].[DistributorPriceLevelCost] WHERE [Distributor] = @Distributor)
						
				IF (@Quantity < 6)
				 BEGIN  
					SET @LevelID =  1					
				 END
				ELSE IF (@Quantity > 5 AND @Quantity < 10)
				 BEGIN
					 SET @LevelID = 2 					
				 END
				ELSE IF (@Quantity > 9 AND @Quantity < 20)
				 BEGIN 
					SET @LevelID = 3 					
				 END
				ELSE IF (@Quantity > 19 AND @Quantity < 50)
				 BEGIN
				 	SET @LevelID = 4				 
				 END
					ELSE IF (@Quantity > 49 AND @Quantity < 100)
				 BEGIN
					SET @LevelID = 5
				 END
				ELSE IF (@Quantity > 99 AND @Quantity < 250)
				 BEGIN	
					SET @LevelID = 6
				 END
				ELSE IF (@Quantity > 249 AND @Quantity < 500)
				 BEGIN
					 SET @LevelID = 7
				 END
				ELSE IF (@Quantity > 499)
				 BEGIN	
					SET @LevelID = 8
				 END	 

			SET @i = @i + 1	
			
			
			SET	@Price = (SELECT ISNULL(dplc.[IndicoCost], NULL)
																			  
							FROM [Indico].[dbo].[DistributorPriceLevelCost] dplc
								JOIN [dbo].[PriceLevelCost] plc  
									ON dplc.[PriceLevelCost] = plc.[ID]
								JOIN [dbo].[Price] pr 
									ON plc.[Price] = pr.[ID]
								JOIN [dbo].[PriceLevel] pl
									ON plc.[PriceLevel] = pl.[ID]							
							WHERE pr.[Pattern] = @Pattern AND 
							  pr.[FabricCode] = @Fabric AND 
							  ((@HasDistributor =0 AND dplc.[Distributor] IS NULL) OR dplc.[Distributor] = @Distributor ) AND 
							  dplc.[PriceTerm] = @P_PriceTerm AND
							  pl.[ID] = @LevelID)
							  
			
			IF (@Price IS NUll)
				BEGIN
					
					IF (@P_PriceTerm = 1)
						BEGIN													
						
							 SET @Price = (SELECT ISNULL(((ISNULL(plc.[IndimanCost],0.00) * 100) / (100 - (SELECT dpm.[Markup] 
																							  FROM [dbo].[DistributorPriceMarkup] dpm 
																							  WHERE  ((@HasDistributor = 0 AND dpm.[Distributor] IS NULL) OR dpm.[Distributor] = @Distributor ) 
																							  AND dpm.[PriceLevel] = @LevelID))), 0.00)
											FROM  [dbo].[PriceLevelCost] plc  
													JOIN [dbo].[Price] pr 
															ON plc.[Price] = pr.[ID]
													JOIN [dbo].[PriceLevel] pl
															ON plc.[PriceLevel] = pl.[ID]							
											WHERE pr.[Pattern] = @Pattern AND 
												  pr.[FabricCode] = @Fabric AND 						  
												  pl.[ID] = @LevelID)
						END
					ELSE 
						BEGIN
							SET @Price = (SELECT ISNULL(((ISNULL((plc.[IndimanCost] - p.[ConvertionFactor]) ,0.00)) / (1 - ((SELECT dpm.[Markup] 
																														    FROM [dbo].[DistributorPriceMarkup] dpm 
																															WHERE  ((@HasDistributor = 0 AND dpm.[Distributor] IS NULL) OR dpm.[Distributor] = @Distributor) 
																															AND dpm.[PriceLevel] = @LevelID)/100))), 0.00)
											FROM  [dbo].[PriceLevelCost] plc  
													JOIN [dbo].[Price] pr 
															ON plc.[Price] = pr.[ID]
													JOIN [dbo].[PriceLevel] pl
															ON plc.[PriceLevel] = pl.[ID]
													JOIN [dbo].[Pattern] p
															ON pr.[Pattern] = p.[ID]							
											WHERE pr.[Pattern] = @Pattern AND 
												  pr.[FabricCode] = @Fabric AND 						  
												  pl.[ID] = @LevelID)
						END							  
								 
				END							  
			
							  
			SET @TotalPrice = (@Price *	@Quantity)			
												 
			UPDATE @TempOrderDetail SET [EditedIndicoPrice] = ISNULL(@Price, 0.00),
										[TotalIndicoPrice] = ISNULL(@TotalPrice, 0.00) WHERE [OrderDetail] = @OrderDetail
				
		END		
	
	SELECT * FROM @TempOrderDetail
END 


GO

/****** Object:  StoredProcedure [dbo].[SPC_ViewOrderDetails]    Script Date: 06/22/2015 18:17:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_ViewOrderDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_ViewOrderDetails]
GO

/****** Object:  StoredProcedure [dbo].[SPC_ViewOrderDetails]    Script Date: 06/22/2015 18:17:20 ******/
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
		  ,ISNULL(vl.[NamePrefix] + ISNULL(CAST(vl.[NameSuffix] AS nvarchar(255)),''),'') AS VisualLayout
		  ,ISNULL(od.[VisualLayout],0) AS VisualLayoutID
		  ,od.[Pattern] AS PatternID
		  ,p.[Number] + ' - ' + p.[NickName] AS Pattern
		  ,od.[FabricCode] AS FabricID
		  ,fc.[Code] + ' - ' + fc.[Name] AS Fabric
		  ,ISNULL(od.[VisualLayoutNotes],'') AS VisualLayoutNotes      
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
		  ,o.[IsAcceptedTermsAndConditions] AS IsAcceptedTermsAndConditions
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
		  ((@P_SelectedDate1 IS NULL AND @P_SelectedDate2 IS NULL) OR (o.[Date] BETWEEN @P_SelectedDate1 AND @P_SelectedDate2))
	--ORDER BY o.[ID] DESC
				
END


GO










