USE [Indico]
GO

-------- added coordinator submitted status-------

INSERT INTO [dbo].[OrderStatus]
           ([Name]
           ,[Description])
     VALUES
           ('Submitted by Coordinator','Coordinator Submitted')
GO
