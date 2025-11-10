DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql = @sql + 
    'DROP TABLE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + ';' + CHAR(13)
FROM 
    sys.tables
WHERE 
    name LIKE 'tabela%';

IF @sql <> N''
BEGIN

    PRINT 'Os seguintes comandos serão executados:';
    PRINT @sql;
    EXEC sp_executesql @sql;
    PRINT 'Tabelas dropadas';
END
ELSE
BEGIN
    PRINT 'Nenhuma tabela encontrada que comece com "tabela".';
END
GO
