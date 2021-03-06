USE [Indico]
GO

-------------- Adding IsBrandingKit Column to Order Detail-----------------------------------

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Order__IsBrandin__17D92C16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [DF__Order__IsBrandin__17D92C16]
END

GO

ALTER TABLE [dbo].[Order] 
DROP COLUMN IsBrandingKit

GO

ALTER TABLE [dbo].[OrderDetail] 
ADD IsBrandingKit BIT NOT NULL 
DEFAULT 0

GO
