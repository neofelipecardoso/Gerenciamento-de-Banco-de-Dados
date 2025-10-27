SET NOCOUNT ON;

DECLARE @TableName SYSNAME;
DECLARE @ColumnName SYSNAME;
DECLARE @NewColumnValue NVARCHAR(MAX);
DECLARE @SQL NVARCHAR(MAX);
DECLARE @FirstColNameCurrent SYSNAME; 
DECLARE @FirstColNameTarget SYSNAME = 'Unidade_da_Federacao'; 
DECLARE @NewName SYSNAME;

IF OBJECT_ID('tempdb..#Renomeacoes') IS NOT NULL DROP TABLE #Renomeacoes;
CREATE TABLE #Renomeacoes (
    TableName SYSNAME,
    OldColumnName SYSNAME,
    NewColumnName VARCHAR(128)
);

DECLARE TableCursor CURSOR LOCAL FORWARD_ONLY FOR
    SELECT name
    FROM sys.tables
    WHERE is_ms_shipped = 0 
      AND name NOT LIKE 'flyway_schema_history' 
    ORDER BY name;

OPEN TableCursor;
FETCH NEXT FROM TableCursor INTO @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN

    DELETE FROM #Renomeacoes;

    SELECT TOP 1 @FirstColNameCurrent = name
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@TableName)
    ORDER BY column_id;

    IF @FirstColNameCurrent IS NOT NULL AND @FirstColNameCurrent <> @FirstColNameTarget
    BEGIN
        SET @SQL = N'EXEC sp_rename ''' + QUOTENAME(@TableName) + '.' + QUOTENAME(@FirstColNameCurrent) + ''', ' + QUOTENAME(@FirstColNameTarget) + ', ''COLUMN''';
    
        EXECUTE sp_executesql @SQL;
    
        SET @FirstColNameCurrent = @FirstColNameTarget;
    END
    ELSE
    BEGIN
        PRINT '  Coluna 1 já possui nome alvo ou nome atual é NULL.';
    END

    DECLARE ColumnCursor CURSOR LOCAL FORWARD_ONLY FOR
        SELECT name
        FROM sys.columns
        WHERE object_id = OBJECT_ID(@TableName)
          AND name <> @FirstColNameCurrent 
        ORDER BY column_id;

    OPEN ColumnCursor;
    FETCH NEXT FROM ColumnCursor INTO @ColumnName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SQL = N'
            SELECT TOP 1 @Value = CAST(' + QUOTENAME(@ColumnName) + ' AS NVARCHAR(MAX))
            FROM ' + QUOTENAME(@TableName) + '
            ORDER BY (SELECT 1);
        ';

        EXECUTE sp_executesql @SQL, N'@Value NVARCHAR(MAX) OUTPUT', @Value = @NewColumnValue OUTPUT;

        IF @NewColumnValue IS NOT NULL AND LTRIM(RTRIM(@NewColumnValue)) <> ''
        BEGIN
            SET @NewColumnValue = REPLACE(@NewColumnValue, '.0', '');
            SET @NewColumnValue = REPLACE(@NewColumnValue, ' ', '_');
            SET @NewColumnValue = REPLACE(@NewColumnValue, '-', '_');
            SET @NewColumnValue = REPLACE(@NewColumnValue, '.', '');
            SET @NewColumnValue = REPLACE(@NewColumnValue, '(', '');
            SET @NewColumnValue = REPLACE(@NewColumnValue, ')', '');
            SET @NewColumnValue = REPLACE(REPLACE(@NewColumnValue, CHAR(13), ''), CHAR(10), '');
        
            SET @NewColumnValue = LEFT(@NewColumnValue, 128);

            IF @ColumnName <> @NewColumnValue
            BEGIN
                INSERT INTO #Renomeacoes (TableName, OldColumnName, NewColumnName)
                VALUES (@TableName, @ColumnName, @NewColumnValue);
            END
        END

        FETCH NEXT FROM ColumnCursor INTO @ColumnName;
    END

    CLOSE ColumnCursor;
    DEALLOCATE ColumnCursor;


    DECLARE RenameCursor CURSOR LOCAL FORWARD_ONLY FOR
        SELECT OldColumnName, NewColumnName
        FROM #Renomeacoes
        WHERE OldColumnName <> NewColumnName;

    OPEN RenameCursor;
    FETCH NEXT FROM RenameCursor INTO @ColumnName, @NewName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SQL = N'EXEC sp_rename ''' + QUOTENAME(@TableName) + '.' + QUOTENAME(@ColumnName) + ''', ' + QUOTENAME(@NewName) + ', ''COLUMN''';
    
        EXECUTE sp_executesql @SQL;

        FETCH NEXT FROM RenameCursor INTO @ColumnName, @NewName;
    END
    CLOSE RenameCursor;
    DEALLOCATE RenameCursor;

    SET @SQL = N'
        WITH RowToDelete AS (
            SELECT TOP 1 * FROM ' + QUOTENAME(@TableName) + ' 
            ORDER BY (SELECT 1)
        )
        DELETE FROM RowToDelete;
    ';

    EXECUTE sp_executesql @SQL;


    FETCH NEXT FROM TableCursor INTO @TableName;
END

CLOSE TableCursor;
DEALLOCATE TableCursor;

IF OBJECT_ID('tempdb..#Renomeacoes') IS NOT NULL DROP TABLE #Renomeacoes;
GO
