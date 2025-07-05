SELECT
    "ИМЯ", COUNT(DISTINCT "ИД") AS "Количество людей"
FROM "Н_ЛЮДИ"
where "ИМЯ" IS NOT NULL and trim("ИМЯ") != '' and "ИМЯ" != '.'
GROUP BY
    "ИМЯ"
