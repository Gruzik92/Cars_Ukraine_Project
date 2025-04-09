WITH temp_table AS (
    SELECT *, 
           ROW_NUMBER() OVER () AS row_num  -- Додає унікальний номер кожному рядку
    FROM cars
), new_vin AS (
SELECT 
    *,
    CASE 
        WHEN "VIN" = '0' THEN CONCAT("VIN", '_', row_num)  -- Змінюємо VIN тільки для "0"
        ELSE "VIN" 
    END AS modified_vin
FROM temp_table
ORDER BY modified_vin ASC),
final_table AS(
SELECT DISTINCT ON (modified_vin) *
FROM new_vin
ORDER BY modified_vin, "D_REG" DESC
)
SELECT "PERSON", "D_REG",
"BRAND",
"MODEL",
"MAKE_YEAR",
"COLOR",
"KIND",
"BODY",
"FUEL",
"CAPACITY",
"OWN_WEIGHT"
,modified_vin
FROM final_table
WHERE "PERSON" = 'P' AND
"KIND" = 'ЛЕГКОВИЙ' AND
"FUEL" != '0';
