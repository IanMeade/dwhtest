

USE [master]
GO

/****** Object:  Database [DWH]    Script Date: 07/02/2017 09:50:03 ******/
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'OracleLink')
BEGIN
	ALTER DATABASE [OracleLink] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [OracleLink]
END
GO

/****** Object:  Database [OracleLink]    Script Date: 06/07/2017 10:40:48 ******/
CREATE DATABASE [OracleLink]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OracleLink', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\OracleLink.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OracleLink_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\OracleLink_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [OracleLink] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OracleLink].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [OracleLink] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [OracleLink] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [OracleLink] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [OracleLink] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [OracleLink] SET ARITHABORT OFF 
GO

ALTER DATABASE [OracleLink] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [OracleLink] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [OracleLink] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [OracleLink] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [OracleLink] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [OracleLink] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [OracleLink] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [OracleLink] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [OracleLink] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [OracleLink] SET  DISABLE_BROKER 
GO

ALTER DATABASE [OracleLink] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [OracleLink] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [OracleLink] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [OracleLink] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [OracleLink] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [OracleLink] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [OracleLink] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [OracleLink] SET RECOVERY FULL 
GO

ALTER DATABASE [OracleLink] SET  MULTI_USER 
GO

ALTER DATABASE [OracleLink] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [OracleLink] SET DB_CHAINING OFF 
GO

ALTER DATABASE [OracleLink] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [OracleLink] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [OracleLink] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [OracleLink] SET QUERY_STORE = OFF
GO

USE [OracleLink]
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

ALTER DATABASE [OracleLink] SET  READ_WRITE 
GO

