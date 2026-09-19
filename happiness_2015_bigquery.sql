-- =====================================================================
-- World Happiness Report 2015 - BigQuery (GoogleSQL / Standart SQL)
-- =====================================================================
--
-- HAZIRLIK (bir kez yapılır)
-- 1) BigQuery konsolunda (console.cloud.google.com/bigquery) projeni seç.
-- 2) Explorer panelinde projenin yanındaki ⋮ → "Create dataset" → ad: mutluluk
-- 3) Oluşan "mutluluk" veri setinin yanındaki ⋮ → "Create table":
--      Source ........ Upload → 2015.csv dosyasını seç (format: CSV)
--      Table name .... happiness_2015
--      Schema ........ "Edit as text" aç ve aşağıdaki satırı yapıştır:
--
--   Country:STRING,Region:STRING,Happiness_Rank:INTEGER,Happiness_Score:FLOAT,Standard_Error:FLOAT,GDP_per_Capita:FLOAT,Family:FLOAT,Life_Expectancy:FLOAT,Freedom:FLOAT,Trust_Corruption:FLOAT,Generosity:FLOAT,Dystopia_Residual:FLOAT
--
--      Advanced options → "Header rows to skip" = 1
--      Create table'a bas.
--
-- 4) AŞAĞIDAKİ SORGULARDA PROJE_ID yazan yeri kendi proje kimliğinle değiştir
--    (Ctrl+H ile tümünü tek seferde değiştirebilirsin).
--    Her sorguyu ayrı ayrı seçip "Run" ile çalıştır.
--
-- BigQuery'de grafik: sorgu sonucunda "Verileri keşfet → Looker Studio ile
-- keşfet" seçeneğiyle bölge ortalamaları için çubuk grafik çizebilirsin.
-- =====================================================================


-- ---------------------------------------------------------------------
-- A) Ülkeleri mutluluk puanına göre sırala
-- ---------------------------------------------------------------------
SELECT
  RANK() OVER (ORDER BY Happiness_Score DESC) AS Sira,
  Country,
  Region,
  Happiness_Score
FROM `PROJE_ID.mutluluk.happiness_2015`
ORDER BY Happiness_Score DESC;


-- ---------------------------------------------------------------------
-- B) Bölgelere göre ortalama mutluluk puanı (grafik için de bu sonuç kullanılır)
-- ---------------------------------------------------------------------
SELECT
  Region,
  AVG(Happiness_Score) AS Avg_Happiness_Score
FROM `PROJE_ID.mutluluk.happiness_2015`
GROUP BY Region
ORDER BY Avg_Happiness_Score DESC;


-- ---------------------------------------------------------------------
-- C) GSYİH ve yaşam beklentisini normalize et (min-max, 0-1 arası)
--    Not: Congo (Kinshasa) GSYİH'si ve Sierra Leone yaşam beklentisi 0
--    görünüyor (muhtemelen eksik veri); min değerleri bu yüzden 0'dır.
-- ---------------------------------------------------------------------
SELECT
  Country,
  GDP_per_Capita,
  (GDP_per_Capita - MIN(GDP_per_Capita) OVER ())
    / NULLIF(MAX(GDP_per_Capita) OVER () - MIN(GDP_per_Capita) OVER (), 0)
    AS GDP_Normalize,
  Life_Expectancy,
  (Life_Expectancy - MIN(Life_Expectancy) OVER ())
    / NULLIF(MAX(Life_Expectancy) OVER () - MIN(Life_Expectancy) OVER (), 0)
    AS Life_Expectancy_Normalize
FROM `PROJE_ID.mutluluk.happiness_2015`
ORDER BY Country;


-- ---------------------------------------------------------------------
-- D) GSYİH ile mutluluk arasındaki korelasyon (Pearson) - join ile
--    Tablo, ortalamaları hesaplayan tek satırlık bir alt sorguyla
--    CROSS JOIN edilir, sonra formül uygulanır.
-- ---------------------------------------------------------------------
SELECT
  ROUND(
    SUM((h.GDP_per_Capita - s.avg_gdp) * (h.Happiness_Score - s.avg_score))
    / SQRT(
          SUM((h.GDP_per_Capita - s.avg_gdp)   * (h.GDP_per_Capita - s.avg_gdp))
        * SUM((h.Happiness_Score - s.avg_score) * (h.Happiness_Score - s.avg_score))
      )
  , 4) AS Corr_GDP_Happiness
FROM `PROJE_ID.mutluluk.happiness_2015` AS h
CROSS JOIN (
  SELECT
    AVG(GDP_per_Capita)  AS avg_gdp,
    AVG(Happiness_Score) AS avg_score
  FROM `PROJE_ID.mutluluk.happiness_2015`
) AS s;

-- Doğrulama: BigQuery'nin yerleşik fonksiyonu aynı sonucu vermeli (≈ 0.781)
SELECT ROUND(CORR(GDP_per_Capita, Happiness_Score), 4) AS Corr_Builtin
FROM `PROJE_ID.mutluluk.happiness_2015`;


-- ---------------------------------------------------------------------
-- E) En yüksek mutluluk puanına sahip 10 ülke
-- ---------------------------------------------------------------------
SELECT
  Country,
  Region,
  Happiness_Score
FROM `PROJE_ID.mutluluk.happiness_2015`
ORDER BY Happiness_Score DESC
LIMIT 10;
