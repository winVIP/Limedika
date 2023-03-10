USE [master]
GO
/****** Object:  Database [Limedika]    Script Date: 2023-02-01 22:49:41 ******/
CREATE DATABASE [Limedika]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Limedika', FILENAME = N'C:\Users\vyten\Limedika.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Limedika_log', FILENAME = N'C:\Users\vyten\Limedika_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Limedika] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Limedika].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Limedika] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Limedika] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Limedika] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Limedika] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Limedika] SET ARITHABORT OFF 
GO
ALTER DATABASE [Limedika] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Limedika] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Limedika] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Limedika] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Limedika] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Limedika] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Limedika] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Limedika] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Limedika] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Limedika] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Limedika] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Limedika] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Limedika] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Limedika] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Limedika] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Limedika] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Limedika] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Limedika] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Limedika] SET  MULTI_USER 
GO
ALTER DATABASE [Limedika] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Limedika] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Limedika] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Limedika] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Limedika] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Limedika] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Limedika] SET QUERY_STORE = OFF
GO
USE [Limedika]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 2023-02-01 22:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[PostCode] [nvarchar](20) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientChangesLog]    Script Date: 2023-02-01 22:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientChangesLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Action] [nvarchar](100) NOT NULL,
	[Date] [datetime] NOT NULL,
	[ClientId] [int] NOT NULL,
 CONSTRAINT [PK_ClientChangesLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClientChangesLog]  WITH CHECK ADD  CONSTRAINT [FK_ClientChangesLog_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[ClientChangesLog] CHECK CONSTRAINT [FK_ClientChangesLog_Client]
GO
USE [master]
GO
ALTER DATABASE [Limedika] SET  READ_WRITE 
GO
