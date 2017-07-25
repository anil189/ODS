

/* RUN ON ANY SAMPLE DB */


CREATE TABLE Sampletbl (ID int,Name varchar(max),Add1 varchar(max),Add2 varchar(max))


INSERT [dbo].[Sampletbl] ([ID], [Name], [Add1], [Add2]) VALUES (1, N'ABC', N'sdfsdfsd', N'adfadag')

INSERT [dbo].[Sampletbl] ([ID], [Name], [Add1], [Add2]) VALUES (6, N'pqr', NULL, NULL)

INSERT [dbo].[Sampletbl] ([ID], [Name], [Add1], [Add2]) VALUES (5, N'mno', N'sdfsdfsd', NULL)

INSERT [dbo].[Sampletbl] ([ID], [Name], [Add1], [Add2]) VALUES (4, N'jkl', NULL, N'adfadag')

INSERT [dbo].[Sampletbl] ([ID], [Name], [Add1], [Add2]) VALUES (3, N'ghi', NULL, NULL)

INSERT [dbo].[Sampletbl] ([ID], [Name], [Add1], [Add2]) VALUES (2, N'def', NULL, N'adfadag')

INSERT [dbo].[Sampletbl] ([ID], [Name], [Add1], [Add2]) VALUES (7, N'NULL', 'asdas ', N'adfadag')


/* Table Content */
Select * FROM [dbo].[Sampletbl] 



/* CODE TO IDENTIFY NULL COLUMNS */


DECLARE @Column_Count INT
DECLARE @Column_Name VARCHAR(50)
DECLARE @Init INT = 1
DECLARE @SQL NVARCHAR(max)=''
DECLARE @Input NVARCHAR(max)
DECLARE @Tbl_Name NVARCHAR(25)='SampleTbl'

SELECT @Column_Count = MAX(Ordinal_position) 
	FROM INFORMATION_SCHEMA.COLUMNS 
WHERE Table_Name =@Tbl_Name and Column_Name IN ('Add1','Add2')

SET @SQL = N'IF(Object_ID(''tempdb..##Tmp_Mahesh'')) IS NOT NULL 
				DROP TABLE ##Tmp_Mahesh
			CREATE TABLE ##Tmp_Mahesh ( ID INT,Input Varchar(max))'
EXEC (@SQL)

WHILE @Init <= @Column_Count
BEGIN 
		SELECT @Column_Name=Column_Name 
			FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE Table_Name =@Tbl_Name AND Ordinal_position =@init

		SET @SQL = N'INSERT INTO ##Tmp_Mahesh Select ID,''' + @Column_Name + '''+'' is having NULL '' FROM '+ @Tbl_Name + ' WHERE '+ @Column_Name + ' IS NULL'

	EXEC (@SQL)
		SET @init = @init+1
END

	SELECT * FROM ##Tmp_Mahesh ORDER BY ID
