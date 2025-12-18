USE [master]
GO
/****** Object:  Database [TaskManagementDB]    Script Date: 18-12-2025 08:10:51 ******/
CREATE DATABASE [TaskManagementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TaskManagementDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\TaskManagementDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TaskManagementDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\TaskManagementDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TaskManagementDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TaskManagementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TaskManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TaskManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TaskManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TaskManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TaskManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TaskManagementDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TaskManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TaskManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TaskManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TaskManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TaskManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TaskManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TaskManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TaskManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TaskManagementDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TaskManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TaskManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TaskManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TaskManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TaskManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TaskManagementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TaskManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TaskManagementDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TaskManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [TaskManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TaskManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TaskManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TaskManagementDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TaskManagementDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TaskManagementDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TaskManagementDB] SET QUERY_STORE = OFF
GO
USE [TaskManagementDB]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 18-12-2025 08:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[TaskTitle] [nvarchar](200) NOT NULL,
	[TaskDescription] [nvarchar](max) NULL,
	[TaskDueDate] [date] NULL,
	[TaskStatus] [nvarchar](50) NULL,
	[TaskRemarks] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[LastUpdatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 18-12-2025 08:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](150) NULL,
	[Password] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK__Users__1788CC4CC2D92ABD] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tasks] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__CreatedOn__24927208]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  StoredProcedure [dbo].[SP_User_Login]    Script Date: 18-12-2025 08:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_User_Login]
    @Email NVARCHAR(100),
    @Password NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 
        FROM Users 
        WHERE Email = @Email 
          AND Password = @Password
    )
    BEGIN
        SELECT 
            UserId,
            UserName,
            'Login Successful' AS Message
        FROM Users
        WHERE Email = @Email 
          AND Password = @Password;
    END
    ELSE
    BEGIN
        SELECT 
            0 AS UserId,
            '' AS UserName,
            'Invalid Email or Password' AS Message;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[Task_Delete]    Script Date: 18-12-2025 08:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Task_Delete]
    @TaskId INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Message NVARCHAR(4000);

    BEGIN TRY
      
        BEGIN TRANSACTION;

        DELETE FROM Tasks 
        WHERE TaskId = @TaskId;

        SET @Message = 'Task deleted successfully.';

        COMMIT TRANSACTION;

        SELECT 1 AS Status, @Message AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SELECT 
            0 AS Status, 
            ERROR_MESSAGE() AS Message;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[Task_GetAllOrSearch]    Script Date: 18-12-2025 08:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Task_GetAllOrSearch]
(
    @SearchText NVARCHAR(100) = NULL,   -- Task Title / Description
    @Status NVARCHAR(50) = NULL,        -- Pending / InProgress / Completed
    @FromDate DATE = NULL,              -- Due date from
    @ToDate DATE = NULL                 -- Due date to
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        T.TaskId,
        T.TaskTitle,
        T.TaskDescription,
        T.TaskDueDate,
        T.TaskStatus,
        T.TaskRemarks,
        T.CreatedOn,
        T.LastUpdatedOn,
        U1.UserName AS CreatedBy,
        U2.UserName AS LastUpdatedBy
    FROM Tasks T
    INNER JOIN Users U1 ON T.CreatedBy = U1.UserId
    LEFT JOIN Users U2 ON T.LastUpdatedBy = U2.UserId
    WHERE
        ( @SearchText IS NULL 
          OR T.TaskTitle LIKE '%' + @SearchText + '%' 
          OR T.TaskDescription LIKE '%' + @SearchText + '%'
        )
        AND ( @Status IS NULL OR T.TaskStatus = @Status )
        AND ( @FromDate IS NULL OR T.TaskDueDate >= @FromDate )
        AND ( @ToDate IS NULL OR T.TaskDueDate <= @ToDate )
    ORDER BY T.CreatedOn DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[Task_Save]    Script Date: 18-12-2025 08:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Task_Save]  
(  
    @TaskId INT = NULL,        
    @TaskTitle NVARCHAR(200),  
    @TaskDescription NVARCHAR(MAX),  
    @TaskDueDate DATE,  
    @TaskStatus NVARCHAR(50),  
    @TaskRemarks NVARCHAR(MAX),  
    @UserId INT              
)  
AS  
BEGIN  
    SET NOCOUNT ON;

    DECLARE @Message NVARCHAR(200);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- INSERT
        IF ISNULL(@TaskId, 0) = 0  
        BEGIN  
            INSERT INTO Tasks  
            (  
                TaskTitle,  
                TaskDescription,  
                TaskDueDate,  
                TaskStatus,  
                TaskRemarks,  
                CreatedBy,  
                CreatedOn  
            )  
            VALUES  
            (  
                @TaskTitle,  
                @TaskDescription,  
                @TaskDueDate,  
                @TaskStatus,  
                @TaskRemarks,  
                @UserId,  
                GETDATE()  
            );  

            SET @Message = 'Task inserted successfully';
        END  

        ELSE  
        BEGIN  
            UPDATE Tasks  
            SET  
                TaskTitle = @TaskTitle,  
                TaskDescription = @TaskDescription,  
                TaskDueDate = @TaskDueDate,  
                TaskStatus = @TaskStatus,  
                TaskRemarks = @TaskRemarks,  
                LastUpdatedBy = @UserId,  
                LastUpdatedOn = GETDATE()  
            WHERE TaskId = @TaskId;  

            SET @Message = 'Task updated successfully';
        END  

        COMMIT TRANSACTION;

        SELECT  1 AS Status,     @Message AS Message;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SELECT     0 AS Status,   ERROR_MESSAGE() AS Message
    END CATCH
END;
GO
USE [master]
GO
ALTER DATABASE [TaskManagementDB] SET  READ_WRITE 
GO
