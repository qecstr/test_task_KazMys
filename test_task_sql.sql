--тут 4 скрипта разделены комментариями

-- проверка наличия таблиц в content
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'content'
  AND table_name IN ('film_work', 'genre', 'genre_film_work', 'person', 'person_film_work');

-- внешние ключи в genre_film_work
SELECT
    conname AS constraint_name,
    conrelid::regclass AS table,
    a.attname AS column,
    confrelid::regclass AS foreign_table
FROM
    pg_constraint AS c
    JOIN pg_attribute AS a ON a.attrelid = c.conrelid AND a.attnum = ANY(c.conkey)
WHERE
    c.contype = 'f' -- foreign key
    AND conrelid = 'content.genre_film_work'::regclass;

-- внешние ключи в person_film_work
SELECT
    conname AS constraint_name,
    conrelid::regclass AS table,
    a.attname AS column,
    confrelid::regclass AS foreign_table
FROM
    pg_constraint AS c
    JOIN pg_attribute AS a ON a.attrelid = c.conrelid AND a.attnum = ANY(c.conkey)
WHERE
    c.contype = 'f'
    AND conrelid = 'content.person_film_work'::regclass;

-- проверка колонки role
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'content' AND table_name = 'person_film_work' AND column_name = 'role';
