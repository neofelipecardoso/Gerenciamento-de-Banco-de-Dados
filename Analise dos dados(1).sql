Use SistemaGerenciamento;

-- 1. Taxa de analfabetismo por estado (15+ anos) - Homens vs Mulheres
-- ============================================
SELECT 
    l.nome AS Estado,
    d.nomeGrupoDemo AS Sexo,
    a.ano AS Ano,
    AVG(TRY_CAST(fa.TaxaDeAnalfabetismo AS FLOAT)) AS TaxaMediaAnalfabetismo
FROM Fact_Analfabetismo fa
INNER JOIN Dim_Local l ON fa.IdLocal = l.IdLocal
INNER JOIN Dim_Ano a ON fa.IdAno = a.IdAno
INNER JOIN Dim_GrupoDemografico d ON fa.IdGrupoDemo = d.IdGrupoDemo
INNER JOIN Dim_Faixa_Etaria f ON fa.IdFaixaEtaria = f.IdFaixaEtaria
WHERE d.nomeGrupoDemo IN ('Homens', 'Mulheres')
    AND f.nomeFaixaEtaria LIKE '%15%anos%'
    AND fa.TaxaDeAnalfabetismo IS NOT NULL
GROUP BY l.nome, d.nomeGrupoDemo, a.ano
ORDER BY TaxaMediaAnalfabetismo DESC;


-- ============================================
-- 2. Diferença no número médio de anos de estudo entre homens e mulheres (25+ anos)
-- ============================================
WITH MediaPorSexo AS (
    SELECT 
        l.nome AS Estado,
        d.nomeGrupoDemo AS Sexo,
        a.ano AS Ano,
        AVG(TRY_CAST(fe.NumeroMedioDeAnosDeEstudo AS FLOAT)) AS MediaAnos
    FROM Fact_Escolaridade fe
    INNER JOIN Dim_Local l ON fe.IdLocal = l.IdLocal
    INNER JOIN Dim_Ano a ON fe.IdAno = a.IdAno
    INNER JOIN Dim_GrupoDemografico d ON fe.IdGrupoDemo = d.IdGrupoDemo
    INNER JOIN Dim_Faixa_Etaria f ON fe.IdFaixaEtaria = f.IdFaixaEtaria
    WHERE d.nomeGrupoDemo IN ('Homens', 'Mulheres')
        AND f.nomeFaixaEtaria LIKE '%25%anos%'
        AND a.ano BETWEEN 2016 AND 2024
        AND fe.NumeroMedioDeAnosDeEstudo IS NOT NULL
    GROUP BY l.nome, d.nomeGrupoDemo, a.ano
)
SELECT 
    h.Estado,
    h.Ano,
    ROUND(h.MediaAnos, 2) AS MediaHomens,
    ROUND(m.MediaAnos, 2) AS MediaMulheres,
    ROUND((m.MediaAnos - h.MediaAnos), 2) AS DiferencaMulheresHomens
FROM MediaPorSexo h
INNER JOIN MediaPorSexo m ON h.Estado = m.Estado AND h.Ano = m.Ano
WHERE h.Sexo = 'Homens' AND m.Sexo = 'Mulheres'
ORDER BY DiferencaMulheresHomens DESC;


-- ============================================
-- 3. Desigualdade educacional entre brancos e pretos/pardos por estado -- pule
-- ============================================


WITH MediaBranca AS (
    -- 1. Média de anos de estudo APENAS para a Raça Branca
    SELECT
        l.nome AS Estado,
        AVG(TRY_CAST(fe.NumeroMedioDeAnosDeEstudo AS FLOAT)) AS MediaAnos
    FROM Fact_Escolaridade fe
    INNER JOIN Dim_Local l ON fe.IdLocal = l.IdLocal
    INNER JOIN Dim_GrupoDemografico d ON fe.IdGrupoDemo = d.IdGrupoDemo
    WHERE d.nomeGrupoDemo = 'Branca'
        AND TRY_CAST(fe.NumeroMedioDeAnosDeEstudo AS FLOAT) IS NOT NULL
    GROUP BY l.nome
),
MediaPretaParda AS (
    -- 2. Média de anos de estudo CONSOLIDADA para o grupo Preta/Parda
    SELECT
        l.nome AS Estado,
        AVG(TRY_CAST(fe.NumeroMedioDeAnosDeEstudo AS FLOAT)) AS MediaAnos
    FROM Fact_Escolaridade fe
    INNER JOIN Dim_Local l ON fe.IdLocal = l.IdLocal
    INNER JOIN Dim_GrupoDemografico d ON fe.IdGrupoDemo = d.IdGrupoDemo
    WHERE d.nomeGrupoDemo IN ('Preta', 'Parda', 'Preta ou parda') 
        AND TRY_CAST(fe.NumeroMedioDeAnosDeEstudo AS FLOAT) IS NOT NULL
    GROUP BY l.nome
)
-- 3. Usar LEFT JOIN para garantir que todos os estados com dados 'Branca' sejam exibidos
SELECT
    b.Estado,
    ROUND(b.MediaAnos, 2) AS MediaBrancos,
    -- A média do outro grupo pode ser NULL, mas será exibida.
    ROUND(p.MediaAnos, 2) AS MediaPretosOuPardos, 
    -- Se p.MediaAnos for NULL, a diferença também será NULL.
    ROUND((b.MediaAnos - p.MediaAnos), 2) AS DiferencaEmAnos,
    ROUND(((b.MediaAnos - p.MediaAnos) / NULLIF(p.MediaAnos, 0)) * 100, 2) AS PercentualDesigualdade
FROM MediaBranca b
LEFT JOIN MediaPretaParda p
    ON b.Estado = p.Estado
ORDER BY DiferencaEmAnos DESC;

-- ============================================
-- 4A. Idade média de abandono escolar por estado e sexo
-- ============================================
SELECT 
    l.nome AS Estado,
    a.ano AS Ano,
    d.nomeGrupoDemo AS Sexo,
    AVG(TRY_CAST(fe.IdadeQueDeixouDeFrequentarEscola AS FLOAT)) AS MediaIdadeAbandono,
    COUNT(*) AS QuantidadeRegistros
FROM Fact_Escolaridade fe
INNER JOIN Dim_Local l ON fe.IdLocal = l.IdLocal
INNER JOIN Dim_Ano a ON fe.IdAno = a.IdAno
LEFT JOIN Dim_GrupoDemografico d ON fe.IdGrupoDemo = d.IdGrupoDemo
WHERE 
    TRY_CAST(fe.IdadeQueDeixouDeFrequentarEscola AS FLOAT) IS NOT NULL
    AND TRY_CAST(fe.IdadeQueDeixouDeFrequentarEscola AS FLOAT) BETWEEN 10 AND 99
GROUP BY l.nome, a.ano, d.nomeGrupoDemo
ORDER BY MediaIdadeAbandono DESC;


-- ============================================
-- 4B. Condição de ocupação dos domicílios
-- ============================================
SELECT 
    l.nome AS Estado,
    cd.nomeDaCondicao AS CondicaoDomicilio,
    a.ano AS Ano,
    SUM(TRY_CAST(fd.QuantidadeDeDomicilios AS BIGINT)) AS TotalDomicilios
FROM Fact_Domicilio fd
INNER JOIN Dim_Local l ON fd.IdLocal = l.IdLocal
INNER JOIN Dim_Ano a ON fd.IdAno = a.IdAno
INNER JOIN Dim_Condicao_Domicilio cd ON fd.IdCondDomi = cd.IdCondDomi
WHERE fd.QuantidadeDeDomicilios IS NOT NULL
GROUP BY l.nome, cd.nomeDaCondicao, a.ano
ORDER BY l.nome, a.ano;


-- ============================================
-- 5. Média de anos de estudo por estado (25+ anos)
-- ============================================
SELECT 
    l.nome AS Estado,
    a.ano AS Ano,
    ROUND(AVG(TRY_CAST(fe.NumeroMedioDeAnosDeEstudo AS FLOAT)), 2) AS MediaAnosEstudo
FROM Fact_Escolaridade fe
INNER JOIN Dim_Local l ON fe.IdLocal = l.IdLocal
INNER JOIN Dim_Ano a ON fe.IdAno = a.IdAno
INNER JOIN Dim_Faixa_Etaria f ON fe.IdFaixaEtaria = f.IdFaixaEtaria
WHERE f.nomeFaixaEtaria LIKE '%25%anos%'
    AND fe.NumeroMedioDeAnosDeEstudo IS NOT NULL
GROUP BY l.nome, a.ano
ORDER BY MediaAnosEstudo DESC;


-- ============================================
-- 6. Informalidade no trabalho (emprego sem carteira)
-- ============================================
SELECT 
    l.nome AS Estado,
    e.nomeEmprego AS TipoEmprego,
    a.ano AS Ano,
    SUM(TRY_CAST(fo.QuantidadeDePessoas AS BIGINT)) AS TotalPessoas
FROM Fact_Ocupacao fo
INNER JOIN Dim_Local l ON fo.IdLocal = l.IdLocal
INNER JOIN Dim_Ano a ON fo.IdAno = a.IdAno
INNER JOIN Dim_Emprego e ON fo.IdEmprego = e.IdEmprego
WHERE (e.nomeEmprego LIKE '%sem carteira%' 
       OR e.nomeEmprego LIKE '%Conta própria sem CNPJ%')
    AND fo.QuantidadeDePessoas IS NOT NULL
GROUP BY l.nome, e.nomeEmprego, a.ano
ORDER BY l.nome, a.ano, TotalPessoas DESC;


-- ============================================
-- 7. Quantidade de estudantes por faixa etária (6-14 anos)
-- ============================================
SELECT 
    l.nome AS Estado,
    f.nomeFaixaEtaria AS FaixaEtaria,
    d.nomeGrupoDemo AS GrupoDemografico,
    a.ano AS Ano,
    SUM(TRY_CAST(fe.QuantidadeDeEstudantes AS BIGINT)) AS TotalEstudantes
FROM Fact_Escolaridade fe
INNER JOIN Dim_Local l ON fe.IdLocal = l.IdLocal
INNER JOIN Dim_Ano a ON fe.IdAno = a.IdAno
LEFT JOIN Dim_GrupoDemografico d ON fe.IdGrupoDemo = d.IdGrupoDemo
LEFT JOIN Dim_Faixa_Etaria f ON fe.IdFaixaEtaria = f.IdFaixaEtaria
WHERE fe.QuantidadeDeEstudantes IS NOT NULL
    AND (f.nomeFaixaEtaria LIKE '%6%' 
         OR f.nomeFaixaEtaria LIKE '%7%' 
         OR f.nomeFaixaEtaria LIKE '%14%')
GROUP BY l.nome, f.nomeFaixaEtaria, d.nomeGrupoDemo, a.ano
ORDER BY TotalEstudantes DESC;


-- ============================================
-- 8. Quantidade de estudantes por grupo de anos de estudo
-- ============================================
SELECT 
    l.nome AS Estado,
    fe.GrupoDeAnosDeEstudo AS GrupoAnosEstudo,
    d.nomeGrupoDemo AS GrupoDemografico,
    a.ano AS Ano,
    SUM(TRY_CAST(fe.QuantidadeDeEstudantes AS BIGINT)) AS TotalEstudantes
FROM Fact_Escolaridade fe
INNER JOIN Dim_Local l ON fe.IdLocal = l.IdLocal
INNER JOIN Dim_Ano a ON fe.IdAno = a.IdAno
LEFT JOIN Dim_GrupoDemografico d ON fe.IdGrupoDemo = d.IdGrupoDemo
WHERE fe.QuantidadeDeEstudantes IS NOT NULL
    AND fe.GrupoDeAnosDeEstudo IS NOT NULL
GROUP BY l.nome, fe.GrupoDeAnosDeEstudo, d.nomeGrupoDemo, a.ano
ORDER BY TotalEstudantes DESC;


-- ============================================
-- 9. Estudantes no ensino superior por tipo
-- ============================================
SELECT 
    l.nome AS Estado,
    fest.TipoDeEnsinoSuperior,
    a.ano AS Ano,
    SUM(TRY_CAST(fest.QuantidadeDeEstudantes AS BIGINT)) AS TotalEstudantes
FROM Fact_Estudante fest
INNER JOIN Dim_Local l ON fest.IdLocal = l.IdLocal
INNER JOIN Dim_Ano a ON fest.IdAno = a.IdAno
WHERE fest.TipoDeEnsinoSuperior IS NOT NULL
    AND fest.QuantidadeDeEstudantes IS NOT NULL
GROUP BY l.nome, fest.TipoDeEnsinoSuperior, a.ano
ORDER BY TotalEstudantes DESC;


-- ============================================
-- 10. Quantidade de estudantes por estado e grupo demográfico
-- ============================================
SELECT 
    l.nome AS Estado,
    d.nomeGrupoDemo AS GrupoDemografico,
    a.ano AS Ano,
    SUM(TRY_CAST(fe.QuantidadeDeEstudantes AS BIGINT)) AS TotalEstudantes
FROM Fact_Escolaridade fe
INNER JOIN Dim_Local l ON fe.IdLocal = l.IdLocal
INNER JOIN Dim_Ano a ON fe.IdAno = a.IdAno
INNER JOIN Dim_GrupoDemografico d ON fe.IdGrupoDemo = d.IdGrupoDemo
WHERE fe.QuantidadeDeEstudantes IS NOT NULL
GROUP BY l.nome, d.nomeGrupoDemo, a.ano
ORDER BY TotalEstudantes DESC;


-- ============================================
-- 11. Proporção crianças em idade escolar vs analfabetos (15+ anos)
-- ============================================
WITH CriancasIdadeEscolar AS (
    SELECT 
        fp.IdLocal,
        fp.IdAno,
        SUM(TRY_CAST(fp.Populacao AS BIGINT)) AS TotalCriancas
    FROM Fact_Populacao fp
    INNER JOIN Dim_Faixa_Etaria f ON fp.IdFaixaEtaria = f.IdFaixaEtaria
    WHERE (f.nomeFaixaEtaria LIKE '%6%' 
           OR f.nomeFaixaEtaria LIKE '%7%' 
           OR f.nomeFaixaEtaria LIKE '%14%')
        AND fp.Populacao IS NOT NULL
    GROUP BY fp.IdLocal, fp.IdAno
),
Analfabetos AS (
    SELECT 
        fa.IdLocal,
        fa.IdAno,
        SUM(TRY_CAST(fa.PessoasAnalfabetas AS BIGINT)) AS TotalAnalfabetos
    FROM Fact_Analfabetismo fa
    INNER JOIN Dim_Faixa_Etaria f ON fa.IdFaixaEtaria = f.IdFaixaEtaria
    WHERE f.nomeFaixaEtaria LIKE '%15%'
        AND fa.PessoasAnalfabetas IS NOT NULL
    GROUP BY fa.IdLocal, fa.IdAno
)
SELECT 
    l.nome AS Estado,
    a.ano AS Ano,
    c.TotalCriancas,
    an.TotalAnalfabetos,
    ROUND(CAST(c.TotalCriancas AS FLOAT) / NULLIF(CAST(an.TotalAnalfabetos AS FLOAT), 0), 2) AS ProporcaoCriancasPorAnalfabeto
FROM CriancasIdadeEscolar c
INNER JOIN Analfabetos an ON c.IdLocal = an.IdLocal AND c.IdAno = an.IdAno
INNER JOIN Dim_Local l ON c.IdLocal = l.IdLocal
INNER JOIN Dim_Ano a ON c.IdAno = a.IdAno
ORDER BY ProporcaoCriancasPorAnalfabeto DESC;


-- ============================================
-- 12. Evolução de matrículas no ensino superior (2016-2024)
-- ============================================
WITH MatriculasPorEstado AS (
    SELECT 
        l.nome AS Estado,
        a.ano AS Ano,
        SUM(TRY_CAST(fest.QuantidadeDeEstudantes AS BIGINT)) AS TotalMatriculados
    FROM Fact_Estudante fest
    INNER JOIN Dim_Local l ON fest.IdLocal = l.IdLocal
    INNER JOIN Dim_Ano a ON fest.IdAno = a.IdAno
    WHERE fest.TipoDeEnsinoSuperior IS NOT NULL
        AND a.ano BETWEEN 2016 AND 2024
        AND fest.QuantidadeDeEstudantes IS NOT NULL
    GROUP BY l.nome, a.ano
),
MediaNacional AS (
    SELECT 
        Ano,
        AVG(CAST(TotalMatriculados AS FLOAT)) AS MediaMatriculados
    FROM MatriculasPorEstado
    GROUP BY Ano
)
SELECT 
    m.Estado,
    m.Ano,
    m.TotalMatriculados,
    ROUND(mn.MediaMatriculados, 0) AS MediaMatriculados,
    ROUND((m.TotalMatriculados - mn.MediaMatriculados), 0) AS DiferencaDaMedia,
    CASE 
        WHEN m.TotalMatriculados < mn.MediaMatriculados THEN 'Abaixo da Média' 
        ELSE 'Acima da Média' 
    END AS Classificacao
FROM MatriculasPorEstado m
INNER JOIN MediaNacional mn ON m.Ano = mn.Ano
ORDER BY m.Estado, m.Ano;