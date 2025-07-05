select
    (select count(*) from (select "Н_ЛЮДИ"."ФАМИЛИЯ" from "Н_ЛЮДИ" group by "ФАМИЛИЯ") as unique_fam) as Уникальные_фамилии,
    (select count(*) from (select "Н_ЛЮДИ"."ОТЧЕСТВО" from "Н_ЛЮДИ" group by "ОТЧЕСТВО") as unique_otch) as Уникальные_отчества