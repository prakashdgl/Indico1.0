USE [Indico]
GO

-- Update direct sales [owner]

  UPDATE [dbo].[company]   SET [Owner] = 1137  WHERE ID = 1435 -- Travis
  UPDATE [dbo].[company]   SET [Owner] = 55  WHERE ID = 1438 -- Troy
  UPDATE [dbo].[company]   SET [Owner] = 1182  WHERE ID = 1496 -- Glyns
  -- UPDATE [dbo].[company]   SET [Owner] = 1137  WHERE ID = 1503 -- Dennis / not found user
  UPDATE [dbo].[company]   SET [Owner] = 1157  WHERE ID = 1512 -- Emily
  -- UPDATE [dbo].[company]   SET [Owner] = 1137  WHERE ID = 1535 -- Andrea / not found user
  -- UPDATE [dbo].[company]   SET [Owner] = 1137  WHERE ID = 1539 -- Juniata / not found user
  UPDATE [dbo].[company]   SET [Owner] = 1184  WHERE ID = 1564 -- Sales Test
  UPDATE [dbo].[company]   SET [Owner] = 1185  WHERE ID = 1565 -- Scott
  UPDATE [dbo].[company]   SET [Owner] = 1186  WHERE ID = 1566 -- Shannon
  
  GO
  
  ALTER TABLE [dbo].OrderStatus ADD [Sequence] int null
  
  UPDATE [dbo].OrderStatus SET Sequence = 1 WHERE Name = 'New'
  UPDATE [dbo].OrderStatus SET Sequence = 2 WHERE Name = 'Submitted by Distributor'
  UPDATE [dbo].OrderStatus SET Sequence = 3 WHERE Name = 'Submitted by Coordinator'
  UPDATE [dbo].OrderStatus SET Sequence = 4 WHERE Name = 'Indiman Submitted'
  UPDATE [dbo].OrderStatus SET Sequence = 5 WHERE Name = 'In Progress'
  UPDATE [dbo].OrderStatus SET Sequence = 6 WHERE Name = 'Factory Hold'
  UPDATE [dbo].OrderStatus SET Sequence = 7 WHERE Name = 'Completed'
  UPDATE [dbo].OrderStatus SET Sequence = 8 WHERE Name = 'Partialy Completed'  
  
  