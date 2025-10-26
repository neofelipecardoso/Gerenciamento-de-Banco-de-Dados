DECLARE @TableName SYSNAME;
DECLARE @ColumnName SYSNAME;
DECLARE @DeleteSQL NVARCHAR(MAX);
DECLARE @WhereClause NVARCHAR(MAX);

DECLARE TableCursor CURSOR FOR
    SELECT name
    FROM sys.tables
    WHERE is_ms_shipped = 0 AND name NOT LIKE 'flyway_schema_history'; 

OPEN TableCursor;
FETCH NEXT FROM TableCursor INTO @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @WhereClause = '';

    DECLARE ColumnCursor CURSOR FOR
        SELECT name
        FROM sys.columns
        WHERE object_id = OBJECT_ID(@TableName)
        ORDER BY column_id;

    OPEN ColumnCursor;
    FETCH NEXT FROM ColumnCursor INTO @ColumnName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @WhereClause = @WhereClause + QUOTENAME(@ColumnName) + ' IS NULL OR ';

        FETCH NEXT FROM ColumnCursor INTO @ColumnName;
    END

    CLOSE ColumnCursor;
    DEALLOCATE ColumnCursor;

    IF LEN(@WhereClause) > 0
    BEGIN
        SET @WhereClause = LEFT(@WhereClause, LEN(@WhereClause) - 3);

        SET @DeleteSQL = N'DELETE FROM ' + QUOTENAME(@TableName) + ' WHERE ' + @WhereClause + ';';

        PRINT 'Executando: ' + @DeleteSQL;
        EXECUTE sp_executesql @DeleteSQL;
    END
    ELSE
    BEGIN
        PRINT 'Aviso: Tabela ' + QUOTENAME(@TableName) + ' não possui colunas para verificar.';
    END

    FETCH NEXT FROM TableCursor INTO @TableName;
END

CLOSE TableCursor;
DEALLOCATE TableCursor;
GO
