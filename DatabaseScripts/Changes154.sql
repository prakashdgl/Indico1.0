USE [Indico]
GO

ALTER TABLE [dbo].[FabricCode] ADD [IsLiningFabric] [bit] NOT NULL CONSTRAINT [DF_FabricCode_IsLiningFabric] DEFAULT ((0)) 

GO