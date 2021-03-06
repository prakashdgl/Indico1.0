USE [Indico]
GO
--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*
-- POCKET --

-- Create table "Pocket Type"
CREATE TABLE	[dbo].[PocketType](
				[ID] [int] IDENTITY(1,1) NOT NULL,
				[Name] [nvarchar](64) NOT NULL,
				[Key] [nvarchar](4) NOT NULL,
CONSTRAINT [PK_PocketType] PRIMARY KEY CLUSTERED ( [ID] ASC )
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]) ON [PRIMARY]
GO

-- Add pocket type forien key column to the VisualLayout table
ALTER TABLE [dbo].[VisualLayout]
		ADD [PocketType] [int] NULL
GO

ALTER TABLE [dbo].[VisualLayout]  WITH CHECK ADD  CONSTRAINT [FK_VisualLayout_PocketType] FOREIGN KEY([PocketType])
REFERENCES [dbo].[PocketType] ([ID])
GO
ALTER TABLE [dbo].[VisualLayout] CHECK CONSTRAINT [FK_VisualLayout_PocketType]
GO

INSERT INTO [dbo].[PocketType]
            ([Name],[Key])
     VALUES ('NO POCKET','NOPO')
INSERT INTO [dbo].[PocketType]
            ([Name],[Key])
     VALUES ('WITH ONE POCKET','ONPO')
INSERT INTO [dbo].[PocketType]
            ([Name],[Key])
     VALUES ('WITH TWO POCKETS','TWPO')
GO
--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*
