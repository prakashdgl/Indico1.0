/****** Script for SelectTopNRows command from SSMS  ******/
  drop table #temp

  Select Pattern, Fabric , p.Number, f.Code, Count(*) AS DuplicateRows into #temp
  FROM [Indico].[dbo].[CostSheet] cs
  JOIN Pattern p
  ON cs.Pattern = p.id
  JOIN FabricCode f
  ON cs.Fabric = f.ID
  Group by Pattern, Fabric, p.Number, f.Code Having Count(* ) > 1
  order by pattern

  --select * from #temp

  SELECT c.ID AS CostSheetID, c.pattern AS PatternID, c.fabric AS fabricID, p.Number AS PatternNumber, p.NickName AS PatternName, f.Code AS FabricCode, f.NickName AS FabricName, c.QuotedFOBCost, c.QuotedCIF
  FROM [Indico].[dbo].[CostSheet] c
	JOIN #temp t
		on c.Pattern = t.Pattern
			and c.fabric = t.Fabric
	JOin Pattern p
		on c.Pattern = p.ID
	join fabricCode f
		on c.Fabric = f.ID
order by c.Pattern, c.Fabric
  --where pattern = 1204 and Fabric = 5

