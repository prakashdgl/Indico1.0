USE [Indico]
GO

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

