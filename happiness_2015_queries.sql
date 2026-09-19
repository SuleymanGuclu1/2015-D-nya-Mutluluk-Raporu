-- =====================================================================
-- World Happiness Report 2015 - SQL Görevleri
-- Tablo: happiness_2015  (2015.csv içe aktarılmış hali, 158 satır)
-- Not: Sözdizimi MySQL / PostgreSQL / SQLite ile uyumludur.
--      SQL Server kullanıyorsan LIMIT 10 yerine SELECT TOP 10 yaz.
-- =====================================================================

CREATE TABLE happiness_2015 (
    Country           TEXT,
    Region            TEXT,
    Happiness_Rank    INT,
    Happiness_Score   REAL,
    Standard_Error    REAL,
    GDP_per_Capita    REAL,   -- CSV'de: "Economy (GDP per Capita)"
    Family            REAL,
    Life_Expectancy   REAL,   -- CSV'de: "Health (Life Expectancy)"
    Freedom           REAL,
    Trust_Corruption  REAL,   -- CSV'de: "Trust (Government Corruption)"
    Generosity        REAL,
    Dystopia_Residual REAL
);

-- ---------------------------------------------------------------------
-- 1) Bölgelere göre ortalama mutluluk puanı
-- ---------------------------------------------------------------------
SELECT
    Region,
    AVG(Happiness_Score) AS Avg_Happiness_Score
FROM happiness_2015
GROUP BY Region
ORDER BY Avg_Happiness_Score DESC;

-- ---------------------------------------------------------------------
-- 2) GSYİH ile mutluluk arasındaki korelasyon (Pearson)
--    Tablo, ortalamaları hesaplayan tek satırlık bir alt sorguyla
--    join edilir; sonra formül doğrudan uygulanır.
-- ---------------------------------------------------------------------
SELECT
    ROUND(
        SUM((h.GDP_per_Capita - s.avg_gdp) * (h.Happiness_Score - s.avg_score))
        / SQRT(
              SUM((h.GDP_per_Capita - s.avg_gdp)   * (h.GDP_per_Capita - s.avg_gdp))
            * SUM((h.Happiness_Score - s.avg_score) * (h.Happiness_Score - s.avg_score))
          )
    , 4) AS Corr_GDP_Happiness
FROM happiness_2015 AS h
CROSS JOIN (
    SELECT
        AVG(GDP_per_Capita)  AS avg_gdp,
        AVG(Happiness_Score) AS avg_score
    FROM happiness_2015
) AS s;

-- PostgreSQL kullanıyorsan aynı sonucu tek satırda verir:
-- SELECT CORR(GDP_per_Capita, Happiness_Score) FROM happiness_2015;

-- ---------------------------------------------------------------------
-- 3) En yüksek mutluluk puanına sahip 10 ülke
-- ---------------------------------------------------------------------
SELECT
    Country,
    Region,
    Happiness_Score
FROM happiness_2015
ORDER BY Happiness_Score DESC
LIMIT 10;
