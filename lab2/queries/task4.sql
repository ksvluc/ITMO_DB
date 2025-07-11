select "Н_ЛЮДИ"."ИМЯ", count("Н_ЛЮДИ"."ИД") as Количество_людей
from "Н_ЛЮДИ"
         join "Н_УЧЕНИКИ" on "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД"
         join "Н_ПЛАНЫ" on "Н_ПЛАНЫ"."ИД" = "Н_УЧЕНИКИ"."ПЛАН_ИД"
         join "Н_ФОРМЫ_ОБУЧЕНИЯ" on "Н_ПЛАНЫ"."ФО_ИД" = "Н_ФОРМЫ_ОБУЧЕНИЯ"."ИД"
where "Н_ФОРМЫ_ОБУЧЕНИЯ"."НАИМЕНОВАНИЕ" = 'Очная'
group by "Н_ЛЮДИ"."ИМЯ"  having  count("Н_ЛЮДИ"."ИД") < 50;
