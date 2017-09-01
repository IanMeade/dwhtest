
/* CREATE DATABASE SCRIPTS */
/* Ian Meade 7/2/2017 */

/* Added XT_ODS 24/2/2017*/

/* Added Reuters_ODS, Stoxx_ODS, StateStreet_ODS */


/* Creates: DWH, MDM, ProcessControl, Staging, T7_ODS */
/* Includes XT_ODS - may be removed in later releases */
/* All DBs are empty */
/* All DB files are creaated in C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\  */
/* Deletes any pre-exisintg copy */

/* Delete any existing databases */

USE [master]
GO

/****** Object:  Database [DWH]    Script Date: 07/02/2017 09:50:03 ******/
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'DWH')
BEGIN
	ALTER DATABASE DWH SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [DWH]
END
GO


USE [master]
GO

/****** Object:  Database [MDM]    Script Date: 07/02/2017 09:50:03 ******/
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'MDM')
BEGIN
	ALTER DATABASE MDM SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [MDM]
END
GO

USE [master]
GO

/****** Object:  Database [ProcessControl]    Script Date: 07/02/2017 09:50:03 ******/
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'ProcessControl')
BEGIN
	ALTER DATABASE ProcessControl SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [ProcessControl]
END
GO

USE [master]
GO

/****** Object:  Database [Staging]    Script Date: 07/02/2017 09:50:03 ******/
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'Staging')
BEGIN
	ALTER DATABASE Staging SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [Staging]
END
GO

USE [master]
GO

/****** Object:  Database [T7_ODS]    Script Date: 07/02/2017 09:50:03 ******/
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'T7_ODS')
BEGIN
	ALTER DATABASE T7_ODS SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [T7_ODS]
END
GO

/****** Object:  Database [XT_ODS]    Script Date: 24/02/2017 09:50:03 ******/
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'XT_ODS')
BEGIN
	ALTER DATABASE XT_ODS SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [XT_ODS]
END
GO


/* NEW ODS DBS 28/4/2017 */

/****** Object:  Database [Reuters_ODS]    Script Date: 24/02/2017 09:50:03 ******/
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'Reuters_ODS')
BEGIN
	ALTER DATABASE Reuters_ODS SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [Reuters_ODS]
END
GO
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'StateStreet_ODS')
BEGIN
	ALTER DATABASE StateStreet_ODS SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [StateStreet_ODS]
END
GO
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'Stoxx_ODS')
BEGIN
	ALTER DATABASE Stoxx_ODS SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [Stoxx_ODS]
END
GO




/* DWH */

USE [master]
GO

/****** Object:  Database [DWH]    Script Date: 07/02/2017 09:43:34 ******/
CREATE DATABASE [DWH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DWH', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DWH.mdf' , SIZE = 1024000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 122880KB )
 LOG ON 
( NAME = N'DWH_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\DWH_log.ldf' , SIZE = 225280KB , MAXSIZE = 2048GB , FILEGROWTH = 122880KB )
GO

ALTER DATABASE [DWH] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DWH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [DWH] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [DWH] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [DWH] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [DWH] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [DWH] SET ARITHABORT OFF 
GO

ALTER DATABASE [DWH] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [DWH] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [DWH] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [DWH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [DWH] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [DWH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [DWH] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [DWH] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [DWH] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [DWH] SET  DISABLE_BROKER 
GO

ALTER DATABASE [DWH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [DWH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [DWH] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [DWH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [DWH] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [DWH] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [DWH] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [DWH] SET RECOVERY FULL 
GO

ALTER DATABASE [DWH] SET  MULTI_USER 
GO

ALTER DATABASE [DWH] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [DWH] SET DB_CHAINING OFF 
GO

ALTER DATABASE [DWH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [DWH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [DWH] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [DWH] SET QUERY_STORE = OFF
GO

USE [DWH]
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

ALTER DATABASE [DWH] SET  READ_WRITE 
GO



/* MDM */

USE [master]
GO

/****** Object:  Database [MDM]    Script Date: 07/02/2017 09:43:40 ******/
CREATE DATABASE [MDM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MDM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\MDM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MDM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\MDM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [MDM] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MDM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [MDM] SET ANSI_NULL_DEFAULT ON 
GO

ALTER DATABASE [MDM] SET ANSI_NULLS ON 
GO

ALTER DATABASE [MDM] SET ANSI_PADDING ON 
GO

ALTER DATABASE [MDM] SET ANSI_WARNINGS ON 
GO

ALTER DATABASE [MDM] SET ARITHABORT ON 
GO

ALTER DATABASE [MDM] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [MDM] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [MDM] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [MDM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [MDM] SET CURSOR_DEFAULT  LOCAL 
GO

ALTER DATABASE [MDM] SET CONCAT_NULL_YIELDS_NULL ON 
GO

ALTER DATABASE [MDM] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [MDM] SET QUOTED_IDENTIFIER ON 
GO

ALTER DATABASE [MDM] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [MDM] SET  DISABLE_BROKER 
GO

ALTER DATABASE [MDM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [MDM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [MDM] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [MDM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [MDM] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [MDM] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [MDM] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [MDM] SET RECOVERY FULL 
GO

ALTER DATABASE [MDM] SET  MULTI_USER 
GO

ALTER DATABASE [MDM] SET PAGE_VERIFY NONE  
GO

ALTER DATABASE [MDM] SET DB_CHAINING OFF 
GO

ALTER DATABASE [MDM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [MDM] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [MDM] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [MDM] SET QUERY_STORE = OFF
GO

USE [MDM]
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

ALTER DATABASE [MDM] SET  READ_WRITE 
GO



/* ProcessControl */


USE [master]
GO

/****** Object:  Database [ProcessControl]    Script Date: 07/02/2017 09:43:46 ******/
CREATE DATABASE [ProcessControl]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProcessControl', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ProcessControl.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProcessControl_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ProcessControl_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [ProcessControl] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProcessControl].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [ProcessControl] SET ANSI_NULL_DEFAULT ON 
GO

ALTER DATABASE [ProcessControl] SET ANSI_NULLS ON 
GO

ALTER DATABASE [ProcessControl] SET ANSI_PADDING ON 
GO

ALTER DATABASE [ProcessControl] SET ANSI_WARNINGS ON 
GO

ALTER DATABASE [ProcessControl] SET ARITHABORT ON 
GO

ALTER DATABASE [ProcessControl] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [ProcessControl] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [ProcessControl] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [ProcessControl] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [ProcessControl] SET CURSOR_DEFAULT  LOCAL 
GO

ALTER DATABASE [ProcessControl] SET CONCAT_NULL_YIELDS_NULL ON 
GO

ALTER DATABASE [ProcessControl] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [ProcessControl] SET QUOTED_IDENTIFIER ON 
GO

ALTER DATABASE [ProcessControl] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [ProcessControl] SET  DISABLE_BROKER 
GO

ALTER DATABASE [ProcessControl] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [ProcessControl] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [ProcessControl] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [ProcessControl] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [ProcessControl] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [ProcessControl] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [ProcessControl] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [ProcessControl] SET RECOVERY FULL 
GO

ALTER DATABASE [ProcessControl] SET  MULTI_USER 
GO

ALTER DATABASE [ProcessControl] SET PAGE_VERIFY NONE  
GO

ALTER DATABASE [ProcessControl] SET DB_CHAINING OFF 
GO

ALTER DATABASE [ProcessControl] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [ProcessControl] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [ProcessControl] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [ProcessControl] SET QUERY_STORE = OFF
GO

USE [ProcessControl]
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

ALTER DATABASE [ProcessControl] SET  READ_WRITE 
GO



/* Staging */


USE [master]
GO

/****** Object:  Database [Staging]    Script Date: 07/02/2017 09:43:51 ******/
CREATE DATABASE [Staging]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Staging', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Staging.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Staging_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Staging_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [Staging] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Staging].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Staging] SET ANSI_NULL_DEFAULT ON 
GO

ALTER DATABASE [Staging] SET ANSI_NULLS ON 
GO

ALTER DATABASE [Staging] SET ANSI_PADDING ON 
GO

ALTER DATABASE [Staging] SET ANSI_WARNINGS ON 
GO

ALTER DATABASE [Staging] SET ARITHABORT ON 
GO

ALTER DATABASE [Staging] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Staging] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Staging] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Staging] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Staging] SET CURSOR_DEFAULT  LOCAL 
GO

ALTER DATABASE [Staging] SET CONCAT_NULL_YIELDS_NULL ON 
GO

ALTER DATABASE [Staging] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Staging] SET QUOTED_IDENTIFIER ON 
GO

ALTER DATABASE [Staging] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Staging] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Staging] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Staging] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Staging] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Staging] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Staging] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Staging] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Staging] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Staging] SET RECOVERY FULL 
GO

ALTER DATABASE [Staging] SET  MULTI_USER 
GO

ALTER DATABASE [Staging] SET PAGE_VERIFY NONE  
GO

ALTER DATABASE [Staging] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Staging] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Staging] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [Staging] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Staging] SET QUERY_STORE = OFF
GO

USE [Staging]
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

ALTER DATABASE [Staging] SET  READ_WRITE 
GO




/* T7_ODS */


USE [master]
GO

/****** Object:  Database [T7_ODS]    Script Date: 07/02/2017 09:43:58 ******/
CREATE DATABASE [T7_ODS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'T7_ODS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\T7_ODS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'T7_ODS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\T7_ODS_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [T7_ODS] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [T7_ODS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [T7_ODS] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [T7_ODS] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [T7_ODS] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [T7_ODS] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [T7_ODS] SET ARITHABORT OFF 
GO

ALTER DATABASE [T7_ODS] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [T7_ODS] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [T7_ODS] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [T7_ODS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [T7_ODS] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [T7_ODS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [T7_ODS] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [T7_ODS] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [T7_ODS] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [T7_ODS] SET  DISABLE_BROKER 
GO

ALTER DATABASE [T7_ODS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [T7_ODS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [T7_ODS] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [T7_ODS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [T7_ODS] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [T7_ODS] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [T7_ODS] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [T7_ODS] SET RECOVERY FULL 
GO

ALTER DATABASE [T7_ODS] SET  MULTI_USER 
GO

ALTER DATABASE [T7_ODS] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [T7_ODS] SET DB_CHAINING OFF 
GO

ALTER DATABASE [T7_ODS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [T7_ODS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [T7_ODS] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [T7_ODS] SET QUERY_STORE = OFF
GO

USE [T7_ODS]
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

ALTER DATABASE [T7_ODS] SET  READ_WRITE 
GO



/****** Object:  Database [XT_ODS]    Script Date: 24/02/2017 12:15:26 ******/
CREATE DATABASE [XT_ODS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Staging', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\XT_ODS.mdf' , SIZE = 10240KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Staging_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\XT_ODS_log.ldf' , SIZE = 26816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [XT_ODS] SET COMPATIBILITY_LEVEL = 120
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [XT_ODS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [XT_ODS] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [XT_ODS] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [XT_ODS] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [XT_ODS] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [XT_ODS] SET ARITHABORT OFF 
GO

ALTER DATABASE [XT_ODS] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [XT_ODS] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [XT_ODS] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [XT_ODS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [XT_ODS] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [XT_ODS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [XT_ODS] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [XT_ODS] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [XT_ODS] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [XT_ODS] SET  DISABLE_BROKER 
GO

ALTER DATABASE [XT_ODS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [XT_ODS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [XT_ODS] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [XT_ODS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [XT_ODS] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [XT_ODS] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [XT_ODS] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [XT_ODS] SET RECOVERY FULL 
GO

ALTER DATABASE [XT_ODS] SET  MULTI_USER 
GO

ALTER DATABASE [XT_ODS] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [XT_ODS] SET DB_CHAINING OFF 
GO

ALTER DATABASE [XT_ODS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [XT_ODS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [XT_ODS] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [XT_ODS] SET QUERY_STORE = OFF
GO

USE [XT_ODS]
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

ALTER DATABASE [XT_ODS] SET  READ_WRITE 
GO


/* REUTERS ODS */

USE [master]
GO

/****** Object:  Database [Reuters_ODS]    Script Date: 28/04/2017 15:11:07 ******/
CREATE DATABASE [Reuters_ODS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Reuters_ODS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Reuters_ODS.mdf' , SIZE = 307200KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Reuters_ODS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Reuters_ODS_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [Reuters_ODS] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Reuters_ODS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Reuters_ODS] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Reuters_ODS] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Reuters_ODS] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Reuters_ODS] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Reuters_ODS] SET ARITHABORT OFF 
GO

ALTER DATABASE [Reuters_ODS] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Reuters_ODS] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Reuters_ODS] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Reuters_ODS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Reuters_ODS] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Reuters_ODS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Reuters_ODS] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Reuters_ODS] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Reuters_ODS] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Reuters_ODS] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Reuters_ODS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Reuters_ODS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Reuters_ODS] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Reuters_ODS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Reuters_ODS] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Reuters_ODS] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Reuters_ODS] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Reuters_ODS] SET RECOVERY FULL 
GO

ALTER DATABASE [Reuters_ODS] SET  MULTI_USER 
GO

ALTER DATABASE [Reuters_ODS] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Reuters_ODS] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Reuters_ODS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Reuters_ODS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Reuters_ODS] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Reuters_ODS] SET QUERY_STORE = OFF
GO

USE [Reuters_ODS]
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

ALTER DATABASE [Reuters_ODS] SET  READ_WRITE 
GO

/* StateStreet ODS */

USE [master]
GO

/****** Object:  Database [StateStreet_ODS]    Script Date: 28/04/2017 15:11:38 ******/
CREATE DATABASE [StateStreet_ODS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StateStreet_ODS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\StateStreet_ODS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StateStreet_ODS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\StateStreet_ODS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [StateStreet_ODS] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StateStreet_ODS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [StateStreet_ODS] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET ARITHABORT OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [StateStreet_ODS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [StateStreet_ODS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET  DISABLE_BROKER 
GO

ALTER DATABASE [StateStreet_ODS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [StateStreet_ODS] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET RECOVERY FULL 
GO

ALTER DATABASE [StateStreet_ODS] SET  MULTI_USER 
GO

ALTER DATABASE [StateStreet_ODS] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [StateStreet_ODS] SET DB_CHAINING OFF 
GO

ALTER DATABASE [StateStreet_ODS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [StateStreet_ODS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [StateStreet_ODS] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [StateStreet_ODS] SET QUERY_STORE = OFF
GO

USE [StateStreet_ODS]
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

ALTER DATABASE [StateStreet_ODS] SET  READ_WRITE 
GO

/* Stoxx_ODS */

USE [master]
GO

/****** Object:  Database [Stoxx_ODS]    Script Date: 28/04/2017 15:12:00 ******/
CREATE DATABASE [Stoxx_ODS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Stoxx_ODS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Stoxx_ODS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Stoxx_ODS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Stoxx_ODS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [Stoxx_ODS] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Stoxx_ODS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Stoxx_ODS] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET ARITHABORT OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Stoxx_ODS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Stoxx_ODS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Stoxx_ODS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Stoxx_ODS] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET RECOVERY FULL 
GO

ALTER DATABASE [Stoxx_ODS] SET  MULTI_USER 
GO

ALTER DATABASE [Stoxx_ODS] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Stoxx_ODS] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Stoxx_ODS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Stoxx_ODS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Stoxx_ODS] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Stoxx_ODS] SET QUERY_STORE = OFF
GO

USE [Stoxx_ODS]
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

ALTER DATABASE [Stoxx_ODS] SET  READ_WRITE 
GO


