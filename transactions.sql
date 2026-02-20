USE [master]
/****** Object:  Database [terralex]    Script Date: 2/20/2026 1:51:58 AM ******/
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [terralex].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [terralex] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [terralex] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [terralex] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [terralex] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [terralex] SET ARITHABORT OFF 
GO
ALTER DATABASE [terralex] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [terralex] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [terralex] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [terralex] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [terralex] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [terralex] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [terralex] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [terralex] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [terralex] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [terralex] SET  ENABLE_BROKER 
GO
ALTER DATABASE [terralex] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [terralex] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [terralex] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [terralex] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [terralex] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [terralex] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [terralex] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [terralex] SET RECOVERY FULL 
GO
ALTER DATABASE [terralex] SET  MULTI_USER 
GO
ALTER DATABASE [terralex] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [terralex] SET DB_CHAINING OFF 
GO
ALTER DATABASE [terralex] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [terralex] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [terralex] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'terralex', N'ON'
GO
ALTER DATABASE [terralex] SET QUERY_STORE = ON
GO
ALTER DATABASE [terralex] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200)
GO
USE [terralex]
GO
/****** Object:  Table [dbo].[Stages_checklist]    Script Date: 2/20/2026 1:51:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Stages_checklist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Stages_checklist](
	[checklist_id] [int] IDENTITY(1,1) NOT NULL,
	[transaction_stage_id] [int] NOT NULL,
	[item_name] [varchar](50) NOT NULL,
	[is_completed] [bit] NOT NULL,
	[completed_date] [datetime] NOT NULL,
	[completed_by] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[checklist_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 2/20/2026 1:51:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Transactions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Transactions](
	[transaction_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[property_id] [int] NOT NULL,
	[client_id] [int] NOT NULL,
	[status] [varchar](50) NOT NULL,
	[transaction_type] [varchar](50) NOT NULL,
	[transaction_Value] [decimal](20, 0) NOT NULL,
	[transaction_stage_id] [int] NOT NULL,
	[down_payment] [int] NOT NULL,
	[remaining_amount] [int] NOT NULL,
	[start_date] [datetime] NOT NULL,
	[expected_end_date] [datetime] NOT NULL,
	[actual_end_date] [datetime] NOT NULL,
	[notes] [varchar](500) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[transactions_stage]    Script Date: 2/20/2026 1:51:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[transactions_stage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[transactions_stage](
	[transaction_stage_id] [int] IDENTITY(1,1) NOT NULL,
	[transaction_id] [int] NOT NULL,
	[stage_template_id] [int] NOT NULL,
	[stage_name] [varchar](50) NOT NULL,
	[status] [varchar](50) NOT NULL,
	[stage_order] [int] NOT NULL,
	[start_date] [datetime] NOT NULL,
	[expected_end_date] [datetime] NOT NULL,
	[completed_date] [datetime] NOT NULL,
	[progress_percentage] [int] NOT NULL,
	[notes] [varchar](500) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[transaction_stage_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Stages_ch__trans__656C112C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Stages_checklist]'))
ALTER TABLE [dbo].[Stages_checklist]  WITH CHECK ADD FOREIGN KEY([transaction_stage_id])
REFERENCES [dbo].[transactions_stage] ([transaction_stage_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Transacti__trans__619B8048]') AND parent_object_id = OBJECT_ID(N'[dbo].[Transactions]'))
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD FOREIGN KEY([transaction_stage_id])
REFERENCES [dbo].[transactions_stage] ([transaction_stage_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__transacti__trans__628FA481]') AND parent_object_id = OBJECT_ID(N'[dbo].[transactions_stage]'))
ALTER TABLE [dbo].[transactions_stage]  WITH CHECK ADD FOREIGN KEY([transaction_id])
REFERENCES [dbo].[Transactions] ([transaction_id])
GO
USE [master]
GO
ALTER DATABASE [terralex] SET  READ_WRITE 
GO
