USE [Indico]
GO

/****** Object:  StoredProcedure [dbo].[SPC_ValidateField]    Script Date: 2/5/2016 1:47:47 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPC_ValidateField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SPC_ValidateField]
GO

/****** Object:  StoredProcedure [dbo].[SPC_ValidateField]    Script Date: 2/5/2016 1:47:47 PM ******/
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
		
		SET @sqlText = N'SELECT TOP 1 ID FROM dbo.' + @P_TableName + ' WHERE ' + @P_Field+ ' = ''' + @P_Value  + ''' AND ( ( '+ CONVERT(VARCHAR(10), @P_ID) +' = 0 ) OR (ID != '+ CONVERT(VARCHAR(10), @P_ID) +' ) )' 

		--print(@sqlText)

		INSERT INTO @result EXEC (@sqlText)

		IF EXISTS (SELECT TOP 1 ID FROM @result)
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

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

ALTER TABLE [dbo].[CostSheet]
	ADD ShowToIndico bit NOT NULL DEFAULT (1)
GO 

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

/****** Object:  View [dbo].[CostSheetDetailsView]    Script Date: 08-Feb-16 3:29:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Script for SelectTopNRows command from SSMS  ******/
ALTER VIEW [dbo].[CostSheetDetailsView]
AS
SELECT ch.[ID] AS CostSheet
      ,p.[Number] + ' - ' + p.[NickName] AS Pattern
      ,fc.[Code] + ' - ' + fc.[Name]  AS Fabric    
      --,ISNULL(ch.[QuotedFOBCost], ISNULL(ch.[JKFOBCost], 0.00)) QuotedFOBCost 
      ,(
		ISNULL(ch.[QuotedFOBCost], ISNULL(
			((ISNULL(p.[SMV], 0.00) * ISNULL(ch.[SMVRate], 0.00)))
		   + ISNULL(ch.[TotalFabricCost], 0.00)
		   + ISNULL(ch.[TotalAccessoriesCost], 0.00)
		   + ISNULL(ch.[HPCost], 0.00)
		   + ISNULL(ch.[LabelCost], 0.00)
		   + ISNULL(ch.[Other], 0.00)
		   + ( (ISNULL(ch.[TotalAccessoriesCost], 0.00) + ISNULL(ch.[HPCost], 0.00)+ ISNULL(ch.[LabelCost], 0.00)+ ISNULL(ch.[Other], 0.00)) * 1.03  )
		   + ((ISNULL(ch.[TotalFabricCost], 0.00) + ISNULL(ch.[TotalAccessoriesCost], 0.00) + ISNULL(ch.[HPCost], 0.00) + ISNULL(ch.[LabelCost], 0.00) + ISNULL(ch.[Other], 0.00) + (( (ISNULL(ch.[TotalAccessoriesCost], 0.00) + ISNULL(ch.[HPCost], 0.00)+ ISNULL(ch.[LabelCost], 0.00)+ ISNULL(ch.[Other], 0.00)) * 1.03  )) ) * 1.04)
        , 0.00)
        )
        ) QuotedFOBCost    
      ,ISNULL(ch.[QuotedCIF], 0.00) AS QuotedCIF     
      ,ISNULL(ch.[QuotedMP], 0.00) AS QuotedMP
      ,ISNULL(ch.[ExchangeRate], 0.00) AS ExchangeRate   
      ,ISNULL(cat.[Name], '') AS Category
      ,ISNULL(p.[SMV], 0.00) AS SMV
      ,ISNULL(ch.[SMVRate], 0.00) AS SMVRate
      --,ISNULL(ch.[CalculateCM], 0.00) AS CalculateCM
      ,(ISNULL(p.[SMV], 0.00) * ISNULL(ch.[SMVRate], 0.00)) AS CalculateCM
      ,ISNULL(ch.[TotalFabricCost], 0.00) AS TotalFabricCost
      ,ISNULL(ch.[TotalAccessoriesCost], 0.00) AS TotalAccessoriesCost 
      ,ISNULL(ch.[HPCost], 0.00) AS HPCost
      ,ISNULL(ch.[LabelCost], 0.00) AS LabelCost 
      --,ISNULL(ch.[CM], 0.00) AS CM 
      ,(ISNULL(p.[SMV], 0.00) * ISNULL(ch.[SMVRate], 0.00)) AS CM 
      ,ISNULL(ch.[JKFOBCost], 0.00) AS JKFOBCost 
      ,ISNULL(ch.[Roundup], 0.00) AS Roundup 
      ,ISNULL(ch.[DutyRate], 0.00) AS DutyRate 
      ,ISNULL(ch.[SubCons], 0.00) AS SubCons 
      ,ISNULL(ch.[MarginRate], 0.00) AS MarginRate 
      --,ISNULL(ch.[Duty], 0.00) AS Duty 
      ,(((SELECT CASE WHEN (ISNULL(ch.[ExchangeRate], 0.00) =0) THEN 0 ELSE (ISNULL(ch.[QuotedFOBCost], ISNULL(ch.[JKFOBCost], 0.00)) / ISNULL(ch.[ExchangeRate], 0.00)) END )) * ISNULL(ch.[DutyRate], 0.00)) AS Duty 
      --,ISNULL(ch.[FOBAUD], 0.00) AS FOBAUD
      ,(SELECT CASE WHEN (ISNULL(ch.[ExchangeRate], 0.00) =0) THEN 0 ELSE (ISNULL(ch.[QuotedFOBCost], ISNULL(ch.[JKFOBCost], 0.00)) / ISNULL(ch.[ExchangeRate], 0.00)) END )  AS FOBAUD
      ,ISNULL(ch.[AirFregiht], 0.00) AS AirFregiht 
      ,ISNULL(ch.[ImpCharges], 0.00) AS ImpCharges 
      --,ISNULL(ch.[Landed], 0.00) AS Landed 
      ,(
			(SELECT CASE WHEN (ISNULL(ch.[ExchangeRate], 0.00) =0) THEN 0 ELSE (ISNULL(ch.[QuotedFOBCost], ISNULL(ch.[JKFOBCost], 0.00)) / ISNULL(ch.[ExchangeRate], 0.00)) END )
			+ (((SELECT CASE WHEN (ISNULL(ch.[ExchangeRate], 0.00) =0) THEN 0 ELSE (ISNULL(ch.[QuotedFOBCost], ISNULL(ch.[JKFOBCost], 0.00)) / ISNULL(ch.[ExchangeRate], 0.00)) END )) * ISNULL(ch.[DutyRate], 0.00))
			+ (ISNULL(ch.[CONS1], 0.00) * ISNULL(ch.[Rate1], 0.00) )
			+ (ISNULL(ch.[CONS2], 0.00) * ISNULL(ch.[Rate2], 0.00) )
			+ (ISNULL(ch.[CONS3], 0.00) * ISNULL(ch.[Rate3], 0.00) ) 
			+ (ISNULL(ch.[InkCons], 0.00) * ISNULL(ch.[InkRate], 0.00) * 1.02)
			+ (ISNULL(ch.[PaperCons], 0.00) * ISNULL(ch.[PaperRate], 0.00) * 1.02 )
			+ ISNULL(ch.[AirFregiht], 0.00)
			+ ISNULL(ch.[ImpCharges], 0.00)
			+ ISNULL(ch.[MGTOH], 0.00)
			+ ISNULL(ch.[IndicoOH], 0.00)
			+ ISNULL(ch.[Depr], 0.00)
      ) AS Landed
      ,ISNULL(ch.[MGTOH], 0.00) AS MGTOH
      ,ISNULL(ch.[IndicoOH], 0.00) AS IndicoOH 
      --,ISNULL(ch.[InkCost], 0.00) AS InkCost 
      ,(ISNULL(ch.[InkCons], 0.00) * ISNULL(ch.[InkRate], 0.00) * 1.02)  AS InkCost 
      --,ISNULL(ch.[PaperCost], 0.00) AS PaperCost 
      ,(ISNULL(ch.[PaperCons], 0.00) * ISNULL(ch.[PaperRate], 0.00) * 1.02 ) AS PaperCost
	  ,ch.ShowToIndico 
  FROM [Indico].[dbo].[CostSheet] ch
	JOIN [dbo].[Pattern] p
		ON ch.[Pattern] = p.[ID]
	JOIN [dbo].[FabricCode] fc
		ON ch.[Fabric] = fc.[ID]
	JOIN [dbo].[Category] cat
		ON p.[CoreCategory] = cat.[ID]
	WHERE p.[IsActive] = 1


GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

/****** Object:  StoredProcedure [dbo].[SPC_GetCostSheetDetails]    Script Date: 2/8/2016 5:35:05 PM ******/
DROP PROCEDURE [dbo].[SPC_GetCostSheetDetails]
GO

/****** Object:  StoredProcedure [dbo].[SPC_GetCostSheetDetails]    Script Date: 2/8/2016 5:35:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SPC_GetCostSheetDetails] (	
@P_SearchText nvarchar(max) 
)	
AS 
BEGIN
	
	DECLARE @CostSheets TABLE
	(
		CostSheet int,
		Pattern nvarchar(MAX),
		Fabric nvarchar(MAX),
		Category nvarchar(MAX),
		SMV decimal(8,2),
		SMVRate decimal(8,3),
		HPCost decimal(8,2),
		LabelCost decimal(8,2),
		Packing decimal(8,2),
		Wastage decimal(8,2),
		Finance decimal(8,2),
		QuotedFOBCost decimal(8,2),
		DutyRate decimal(8,2),
		CONS1 decimal(8,2),
		CONS2 decimal(8,2),
		CONS3 decimal(8,2),
		Rate1 decimal(8,2),
		Rate2 decimal(8,2),
		Rate3 decimal(8,2),
		ExchangeRate decimal(8,2),
		InkCons decimal(8,3),
		InkRate decimal(8,2),
		SubCons decimal(8,2),
		PaperRate decimal(8,2),
		AirFregiht decimal(8,2),
		ImpCharges decimal(8,2),
		MGTOH decimal(8,2),
		IndicoOH decimal(8,2),
		Depr decimal(8,2),
		MarginRate decimal(8,2),
		QuotedCIF decimal(8,2),
		IndimanCIF decimal(8,2),
		ShowToIndico bit NOT NULL 
	)	
	
	DECLARE @CostSheetDetails TABLE
	(
		CostSheet int,
		Pattern nvarchar(MAX),
		Fabric nvarchar(MAX),
		QuotedFOBCost decimal(8,2),
		QuotedCIF decimal(8,2),
		QuotedMP decimal(8,2),
		ExchangeRate decimal(8,2),
		Category nvarchar(MAX),
		SMV decimal(8,2),
		SMVRate decimal(8,3),
		CalculateCM decimal(8,2),
		TotalFabricCost decimal(8,2),
		TotalAccessoriesCost decimal(8,2),
		HPCost decimal(8,2),		
		LabelCost decimal(8,2),
		CM decimal(8,2),
		JKFOBCost decimal(8,2),
		Roundup decimal(8,2),
		DutyRate decimal(8,2),
		SubCons decimal(8,2),
		MarginRate decimal(8,2),
		Duty decimal(8,2),
		FOBAUD decimal(8,2),
		AirFregiht decimal(8,2),
		ImpCharges decimal(8,2),
		Landed decimal(8,2),
		MGTOH decimal(8,2),
		IndicoOH decimal(8,2),
		InkCost decimal(8,2),
		PaperCost decimal(8,2),
		ShowToIndico bit NOT NULL				
	)
	
	INSERT INTO @CostSheets
		SELECT	ch.[ID] AS CostSheet
				,p.[Number] + ' - ' + p.[NickName] AS Pattern
				,fc.[Code] + ' - ' + fc.[Name]  AS Fabric 
				,ISNULL(cat.[Name], '') AS Category,
				p.SMV ,
				SMVRate ,
				HPCost ,
				LabelCost ,
				Other AS Packing,
				Wastage ,
				Finance ,
				QuotedFOBCost ,
				DutyRate ,
				CONS1 ,
				CONS2 ,
				CONS3 ,
				Rate1 ,
				Rate2 ,
				Rate3 ,
				ExchangeRate ,
				InkCons ,
				InkRate ,
				SubCons ,
				PaperRate ,
				AirFregiht ,
				ImpCharges ,
				MGTOH ,
				IndicoOH ,
				Depr ,
				MarginRate ,
				QuotedCIF ,
				IndimanCIF,
				ch.ShowToIndico
		 FROM [dbo].[CostSheet] ch
			LEFT OUTER JOIN [dbo].[Pattern] p
				ON ch.[Pattern] = p.[ID]
			LEFT OUTER JOIN [dbo].[FabricCode] fc
				ON ch.[Fabric] = fc.[ID]
			LEFT OUTER JOIN [dbo].[Category] cat
				ON p.[CoreCategory] = cat.[ID]
			WHERE p.[IsActive] = 1 AND (
										@P_SearchText = '' OR
											(
												p.[Number] LIKE '%' + @P_SearchText +'%' OR
												fc.[Code] LIKE '%' + @P_SearchText +'%' OR
												fc.[Name] LIKE '%' + @P_SearchText +'%' OR
												cat.[Name] LIKE '%' + @P_SearchText +'%'
											)
										)
	
	DECLARE db_cursor CURSOR LOCAL FAST_FORWARD
					FOR SELECT * FROM @CostSheets; 
	DECLARE @CostSheet INT;
	DECLARE @Pattern NVARCHAR(MAX);
	DECLARE @Fabric NVARCHAR(MAX);
	DECLARE @Category NVARCHAR(MAX);
	DECLARE @SMV decimal(8,2);
	DECLARE @SMVRate decimal(8,3);
	DECLARE @HPCost decimal(8,2);
	DECLARE @LabelCost decimal(8,2);
	DECLARE @Packing decimal(8,2);
	DECLARE @Wastage decimal(8,2);
	DECLARE @Finance decimal(8,2);
	DECLARE @QuotedFOBCost decimal(8,2);
	DECLARE @DutyRate decimal(8,2);
	DECLARE @CONS1 decimal(8,2);
	DECLARE @CONS2 decimal(8,2);
	DECLARE @CONS3 decimal(8,2);
	DECLARE @Rate1 decimal(8,2);
	DECLARE @Rate2 decimal(8,2);
	DECLARE @Rate3 decimal(8,2);
	DECLARE @ExchangeRate decimal(8,2);
	DECLARE @InkCons decimal(8,3);
	DECLARE @InkRate decimal(8,2);
	DECLARE @SubCons decimal(8,2);
	DECLARE @PaperRate decimal(8,2);
	DECLARE @AirFregiht decimal(8,2);
	DECLARE @ImpCharges decimal(8,2);
	DECLARE @MGTOH decimal(8,2);
	DECLARE @IndicoOH decimal(8,2);
	DECLARE @Depr decimal(8,2);
	DECLARE @MarginRate decimal(8,2);
	DECLARE @QuotedCIF decimal(8,2);
	DECLARE @IndimanCIF decimal(8,2);
	DECLARE @ShowToIndico bit;

	OPEN db_cursor;
	FETCH NEXT FROM db_cursor INTO @CostSheet, @Pattern, @Fabric, @Category, @SMV, @SMVRate, @HPCost, @LabelCost, @Packing, @Wastage, @Finance, @QuotedFOBCost
	, @DutyRate, @CONS1, @CONS2, @CONS3, @Rate1, @Rate2, @Rate3, @ExchangeRate, @InkCons, @InkRate, @SubCons, @PaperRate, @AirFregiht, @ImpCharges, @MGTOH
	, @IndicoOH, @Depr, @MarginRate, @QuotedCIF, @IndimanCIF, @ShowToIndico;
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		 --Do stuff with scalar values
		DECLARE @calCM decimal(8,2)
		DECLARE @totalFabricCost decimal(8,2)
		DECLARE @totalAcccCost decimal(8,2)
				
		DECLARE @subWastage decimal(8,2)		
		DECLARE @subFinance decimal(8,2)
		DECLARE @fobCost decimal(8,2)
		DECLARE @quotedFOB decimal(8,2)
		
		DECLARE @roundUp decimal(8,2)
		DECLARE @cost1 decimal(8,2)
		DECLARE @cost2 decimal(8,2)
		DECLARE @cost3 decimal(8,2)
		
		DECLARE @fobAUD decimal(8,2)
		DECLARE @duty decimal(8,2)
		DECLARE @inkCost decimal(8,2)
		DECLARE @paperCost decimal(8,2)

		DECLARE @landed decimal(8,2)
		DECLARE @calMgn decimal(8,2)
		DECLARE @calMp decimal(8,2)		
		DECLARE @actMgn decimal(8,2)
		DECLARE @quotedMp decimal(8,2)
		   		
		SET @calCM = @SMV * @SMVRate
		SET @totalFabricCost = ( SELECT SUM( ROUND( psf.FabConstant * f.FabricPrice , 2) ) FROM PatternSupportFabric psf LEFT OUTER JOIN FabricCode f ON psf.Fabric = f.ID WHERE psf.CostSheet = @CostSheet )
		SET @totalAcccCost = ( SELECT SUM( ROUND( psa.AccConstant * a.Cost , 2) ) FROM PatternSupportAccessory psa LEFT OUTER JOIN Accessory a ON psa.Accessory = a.ID WHERE psa.CostSheet = @CostSheet )
		SET @subWastage = ( ( @totalAcccCost + @HPCost + @LabelCost + @Packing ) * 0.03 )
		SET @subFinance = ( ( @totalFabricCost + @totalAcccCost + @HPCost + @LabelCost + @Packing ) * 0.04 )
		SET @fobCost = @calCM + @totalFabricCost + @totalAcccCost + @HPCost + @LabelCost + @Packing + @subWastage + @subFinance
		SET @quotedFOB = ISNULL(@QuotedFOBCost, @fobCost)
		SET @roundUp = @quotedFOB - @fobCost
		SET @cost1 = @CONS1 * @Rate1
		SET @cost2 = @CONS2 * @Rate2
		SET @cost3 = @CONS3 * @Rate3
		SET @fobAUD = ( SELECT CASE WHEN (ISNULL(@ExchangeRate,0) > 0 ) THEN ( @quotedFOB / @ExchangeRate) ELSE 0 END )  -- ( @quotedFOB / @ExchangeRate)
		SET @duty = (@fobAUD * @DutyRate) / 100
		SET @inkCost = @InkCons * @InkRate * 1.02
		SET @paperCost = @SubCons * 1.1 * @PaperRate * 1.2
		SET @landed = @fobAUD + @duty + @cost1 + @cost2 + @cost3 + @inkCost + @paperCost + @AirFregiht + @ImpCharges + @MGTOH + @IndicoOH + @Depr
		SET @calMgn = @IndimanCIF - @landed
		SET @calMp = ( SELECT CASE WHEN (ISNULL(@IndimanCIF, 0)> 0 ) THEN (1 - (@landed / @IndimanCIF)) * 100 ELSE 0 END )		
		SET @actMgn = @QuotedCIF - @landed
		SET @quotedMp = ( SELECT CASE WHEN (ISNULL(@QuotedCIF, 0)>0 ) THEN (1 - (@landed / @QuotedCIF)) * 100 ELSE 0 END )
		
		INSERT INTO @CostSheetDetails
		VALUES
		(
			@CostSheet,
			@Pattern,
			@Fabric,
			ISNULL(@quotedFOB,0),
			ISNULL(@QuotedCIF,0),
			ISNULL(@quotedMp,0),
			ISNULL(@ExchangeRate,0),
			@Category,
			@SMV,
			ISNULL(@SMVRate,0),
			ISNULL(@calCM,0),
			ISNULL(@totalFabricCost,0),
			ISNULL(@totalAcccCost,0),
			@HPCost,
			@LabelCost,
			ISNULL(@calCM,0),
			ISNULL(@fobCost,0),
			ISNULL(@roundUp,0),
			@DutyRate,
			ISNULL(@SubCons,0),
			@MarginRate,
			ISNULL(@duty,0),
			ISNULL(@fobAUD,0),
			@AirFregiht,
			@ImpCharges,
			ISNULL(@landed,0),
			@MGTOH,
			@IndicoOH,
			@inkCost,
			ISNULL(@paperCost,0),
			@ShowToIndico			
		)		   

		   FETCH NEXT FROM db_cursor INTO @CostSheet, @Pattern, @Fabric, @Category, @SMV, @SMVRate, @HPCost, @LabelCost, @Packing, @Wastage, @Finance, @QuotedFOBCost
	, @DutyRate, @CONS1, @CONS2, @CONS3, @Rate1, @Rate2, @Rate3, @ExchangeRate, @InkCons, @InkRate, @SubCons, @PaperRate, @AirFregiht, @ImpCharges, @MGTOH
	, @IndicoOH, @Depr, @MarginRate, @QuotedCIF, @IndimanCIF, @ShowToIndico;
	END;
	CLOSE db_cursor;
	DEALLOCATE db_cursor;
	
	SELECT * FROM @CostSheetDetails ORDER BY CostSheet
		  
 END
 

GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

/****** Object:  View [dbo].[IndicoCIFPriceView]    Script Date: 09-Feb-16 5:25:51 PM ******/
DROP VIEW [dbo].[IndicoCIFPriceView]
GO

/****** Object:  View [dbo].[IndicoCIFPriceView]    Script Date: 09-Feb-16 5:25:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[IndicoCIFPriceView]
AS
	SELECT	c.ID AS CostSheetId,
			ca.Name AS CoreCategory,
			i.Name AS ItemCategory,
			p.ID AS PatternId,
			p.Number AS PatternCode,
			p.NickName AS PatternNickName,
			f.ID AS FabricId,
			f.Code AS FabricCode,
			f.Name AS FabricName,
			CAST (ISNULL((	SELECT TOP 1 ROUND(f.FabricPrice, 2) --(psf.FabConstant * f.FabricPrice , 2) 
							FROM PatternSupportFabric psf LEFT OUTER JOIN FabricCode f ON psf.Fabric = f.ID 
							WHERE psf.CostSheet = c.ID ), 0.0)AS DECIMAL(12,2)) AS FabricPrice,
			ISNULL(c.FOBFactor,0.0) AS ConversionFactor,
			ISNULL(c.QuotedCIF, 0.0) AS IndimanPrice,
			ISNULL(c.QuotedFOBCost, 0.0 ) AS QuotedFOBPrice,
			CAST ( ISNULL(
				ROUND (
					(p.SMV * c.SMVRate) +
					( SELECT SUM( ROUND( psf.FabConstant * f.FabricPrice , 2) ) FROM PatternSupportFabric psf LEFT OUTER JOIN FabricCode f ON psf.Fabric = f.ID WHERE psf.CostSheet = c.ID ) + 
					( SELECT SUM( ROUND( psa.AccConstant * a.Cost , 2) ) FROM PatternSupportAccessory psa LEFT OUTER JOIN Accessory a ON psa.Accessory = a.ID WHERE psa.CostSheet = c.ID ) + 
					c.HPCost + 
					c.LabelCost + 
					c.Other + 
					( ( ( SELECT SUM( ROUND( psa.AccConstant * a.Cost , 2) ) FROM PatternSupportAccessory psa LEFT OUTER JOIN Accessory a ON psa.Accessory = a.ID WHERE psa.CostSheet = c.ID ) + 
						c.HPCost + 
						c.LabelCost + 
						c.Other ) * 0.03 ) + 
					( ( ( SELECT SUM( ROUND( psf.FabConstant * f.FabricPrice , 2) ) FROM PatternSupportFabric psf LEFT OUTER JOIN FabricCode f ON psf.Fabric = f.ID WHERE psf.CostSheet = c.ID ) + 
						( SELECT SUM( ROUND( psa.AccConstant * a.Cost , 2) ) FROM PatternSupportAccessory psa LEFT OUTER JOIN Accessory a ON psa.Accessory = a.ID WHERE psa.CostSheet = c.ID ) + 
						c.HPCost + 
						c.LabelCost + 
						c.Other ) * 0.04 ), 2)
			, 0.0 ) AS DECIMAL(12,2)) AS FOBCost,
			ISNULL((SELECT TOP 1 (u.GivenName + ' ' + u.FamilyName) As LastModifier
				FROM IndimanCostSheetRemarks ir
				JOIN [User] u
				ON ir.Modifier = u.ID
				WHERE CostSheet = c.ID ORDER BY ir.ID DESC), 
				(SELECT GivenName + ' ' + u.FamilyName AS LastModifier FROM [User] WHERE ID = c.Modifier)
				) AS LastModifier,
			ISNULL((SELECT TOP 1 ModifiedDate FROM IndimanCostSheetRemarks WHERE CostSheet = c.ID  ORDER BY ID DESC), c.CreatedDate) AS ModifiedDate,
			ISNULL((SELECT TOP 1 Remarks FROM IndimanCostSheetRemarks WHERE CostSheet = c.ID  ORDER BY ID DESC),'') AS Remarks,
			CAST ( ISNULL(	
					ROUND(
						(
							ISNULL(c.QuotedCIF, 0.0) - 
							(
								(SELECT CASE WHEN (ISNULL(c.ExchangeRate,0) > 0 ) THEN ( c.QuotedFOBCost / c.ExchangeRate) ELSE 0 END) + 
								(((SELECT CASE WHEN (ISNULL(c.ExchangeRate,0) > 0 ) THEN ( c.QuotedFOBCost / c.ExchangeRate) ELSE 0 END) * c.DutyRate) / 100) + 
								(c.CONS1 * c.Rate1) + 
								(c.CONS2 * c.Rate2) + 
								(c.CONS3 * c.Rate3) + 
								(c.InkCons * c.InkRate * 1.02) + 
								(c.SubCons * 1.1 * c.PaperRate * 1.2) + 
								c.AirFregiht + c.ImpCharges + c.MGTOH + c.IndicoOH + c.Depr
							)
						), 2)
				, 0.0) AS DECIMAL(12,2)) AS ActMgn,
			CAST ( ISNULL(	
				 ROUND(
					(
						( SELECT CASE WHEN (ISNULL(c.QuotedCIF, 0)>0 ) THEN 
							(1 - 
								(
									ROUND( (
										(SELECT CASE WHEN (ISNULL(c.ExchangeRate,0) > 0 ) THEN ( c.QuotedFOBCost / c.ExchangeRate) ELSE 0 END) + 
										(((SELECT CASE WHEN (ISNULL(c.ExchangeRate,0) > 0 ) THEN ( c.QuotedFOBCost / c.ExchangeRate) ELSE 0 END) * c.DutyRate) / 100) + 
										(c.CONS1 * c.Rate1) + 
										(c.CONS2 * c.Rate2) + 
										(c.CONS3 * c.Rate3) + 
										(c.InkCons * c.InkRate * 1.02) + 
										(c.SubCons * 1.1 * c.PaperRate * 1.2) + 
										c.AirFregiht + c.ImpCharges + c.MGTOH + c.IndicoOH + c.Depr
									) , 2)
									/ c.QuotedCIF
								)
							) * 100 ELSE 0 END 
						) 
				), 2)
			,0.0) AS DECIMAL(12,2)) AS QuotedMp			 						
	FROM CostSheet c
		JOIN Pattern p
			ON c.Pattern = p.ID
		JOIN FabricCode f
			ON c.Fabric = f.ID
		LEFT OUTER JOIN [User] u
			ON c.Modifier = u.ID	
		LEFT OUTER JOIN Category ca
			ON p.CoreCategory = ca.ID 
		LEFT OUTER JOIN Item i
			ON p.Item = i.ID 	
	WHERE p.IsActive = 1 AND c.ShowToIndico = 1


GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**

/** Alter the table VisualLayout and Create BySizeArtWork column **/
ALTER TABLE [dbo].[VisualLayout] ADD BySizeArtWork 
	bit NOT NULL DEFAULT(0)GO

--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**






