USE [Teralex]
GO

/****** Object:  Table [dbo].[Tax-Record]    Script Date: 2/19/2026 2:11:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tax-Record](
	[Id-Tax] [int] IDENTITY(1,1) NOT NULL,
	[Type-Tax] [nchar](10) NOT NULL,
	[Amount-Tax] [decimal](18, 2) NOT NULL,
	[Percentage-Tax] [decimal](18, 2) NOT NULL,
	[Payment-Date] [datetime] NOT NULL,
	[Receipt-number] [nvarchar](50) NOT NULL,
	[Receipt-path] [nvarchar](255) NOT NULL,
	[Created-at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id-Tax] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Notifications](
	[Notification-Id] [int] NOT NULL,
	[Notification-Type] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[Is-Read] [bit] NOT NULL,
	[Scheduled-date] [datetime] NOT NULL,
	[Sent-date] [datetime] NOT NULL,
	[Craeted-at] [datetime] NOT NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[Notification-Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

