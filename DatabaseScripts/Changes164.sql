USE [Indico]
GO

INSERT INTO [dbo].[DeliveryOption]
           ([Name]
           ,[Description])
     VALUES
           ('Pick up', 'Pick up')
GO

  
  UPDATE [dbo].OrderStatus SET Sequence = 9 WHERE Name = 'Indico Hold'
  UPDATE [dbo].OrderStatus SET Sequence = 10 WHERE Name = 'Indico Submitted'
  UPDATE [dbo].OrderStatus SET Sequence = 11 WHERE Name = 'Indiman Hold'  
  UPDATE [dbo].OrderStatus SET Sequence = 12 WHERE Name = 'Cancelled'  
  
  GO
  