DROP TABLE IF EXISTS course_prerequisite CASCADE;
DROP TABLE IF EXISTS enrolment CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS student_group CASCADE;
DROP TABLE IF EXISTS teacher CASCADE;
DROP TABLE IF EXISTS contact_data CASCADE;
DROP TYPE IF EXISTS qualification_name CASCADE;

CREATE TABLE IF NOT EXISTS contact_data
(
     contact_data_id serial PRIMARY KEY,
     email varchar(32) NOT NULL,
     phone varchar(32) NOT NULL
);

CREATE TYPE qualification_name AS ENUM ('бакалавр', 'магістр', 'доктор філософії', 'доктор наук');

CREATE TABLE IF NOT EXISTS teacher
(
     teacher_id serial PRIMARY KEY,
     name varchar(32) NOT NULL,
     surname varchar(32) NOT NULL,
     contact_data_id integer not null references contact_data(contact_data_id),
     qualification qualification_name
);

CREATE TABLE IF NOT EXISTS student_group
(
     group_id serial PRIMARY KEY,
     name char(7) NOT NULL CHECK (name LIKE '__-%'),
     start_year SMALLINT NOT NULL CHECK (start_year >= 1898),
     curator_id INTEGER NOT NULL REFERENCES teacher(teacher_id)
);

CREATE TABLE IF NOT EXISTS student
(
     student_id serial PRIMARY KEY,
     name varchar(32) NOT NULL,
     surname varchar(32) NOT NULL,
	 profession integer,
     contact_data_id integer not null references contact_data(contact_data_id),
     group_id integer not null references student_group(group_id)
);

CREATE TABLE IF NOT EXISTS course
(
     course_id serial PRIMARY KEY,
     name varchar(32) NOT NULL,
     credits SMALLINT NOT NULL CHECK (credits > 0 AND credits < 100),
     student_year SMALLINT NOT NULL CHECK (student_year >= 1 AND student_year <= 4),
     is_active BOOLEAN NOT NULL,
     teacher_id INTEGER NOT NULL REFERENCES teacher(teacher_id)
);

CREATE TABLE IF NOT EXISTS enrolment
(
     course_id INTEGER not null references course(course_id),
     student_id INTEGER not null references student(student_id),
     grade SMALLINT,
     PRIMARY KEY (course_id, student_id)
);

CREATE TABLE IF NOT EXISTS course_prerequisite
(
     course_id INTEGER NOT NULL references course(course_id),
     prerequisite_course_id INTEGER NOT NULL references course(course_id) CHECK (course_id <> prerequisite_course_id),
     PRIMARY KEY (course_id, prerequisite_course_id)
);

INSERT INTO contact_data (email, phone)
VALUES ('ivan.sirenko@email.com', '+380501234567'),
       ('maria.chernenko@email.com', '+380672345678'),
       ('oleksandr.volkov@email.com', '+380933456789'),
       ('natalia.yakovenko@email.com', '+380504567890'),
       ('viktor.zhurenko@email.com', '+380675678901'),
       ('oksana.doroshenko@email.com', '+380936789012'),
       ('dmytro.rudenko@email.com', '+380507890123'),
       ('tetiana.mikhailenko@email.com', '+380678901234'),
       ('sergiy.timoshenko@email.com', '+380939012345'),
       ('yulia.andrienko@email.com', '+380501023456'),
       ('andriy.kovalchuk@email.com', '+380671134567'),
       ('lesia.pavlenko@email.com', '+380932245678'),
       ('pavlo.demchenko@email.com', '+380503356789'),
       ('iryna.bilenko@email.com', '+380674467890'),
       ('maksym.novenko@email.com', '+380935578901'),
       ('inna.kornenko@email.com', '+380506689012'),
       ('roman.belenko@email.com', '+380677790123'),
       ('svitlana.petrushenko@email.com', '+380938801234'),
       ('vitaliy.semenko@email.com', '+380509912345'),
       ('anna.trofimenko@email.com', '+380671023456');

INSERT INTO teacher (name, surname, contact_data_id, qualification)
VALUES ('Іван', 'Сіренко', 1, 'доктор наук'),
       ('Марія', 'Черненко', 2, 'доктор філософії'),
       ('Олександр', 'Волков', 3, NULL),
       ('Наталія', 'Яковенко', 4, 'доктор наук'),
       ('Віктор', 'Журенко', 5, NULL),
       ('Оксана', 'Дорошенко', 6, 'магістр'),
       ('Дмитро', 'Руденко', 7, 'доктор наук'),
       ('Тетяна', 'Михайленко', 8, 'доктор філософії'),
       ('Сергій', 'Тимошенко', 9, NULL),
       ('Юлія', 'Андрієнко', 10, 'магістр');

INSERT INTO student_group (name, start_year, curator_id)
VALUES ('КН-01', 2020, 1),
       ('ІТ-12', 2021, 2),
       ('МА-92', 2019, 3),
       ('ФІ-23', 2022, 4),
       ('ЕК-04', 2020, 5),
       ('БІ-14', 2021, 6),
       ('ПС-91', 2019, 7),
       ('ХІ-22', 2022, 8);

INSERT INTO student (name, surname, profession, contact_data_id, group_id)
VALUES ('Андрій', 'Ковальчук', 121, 11, 1),
       ('Леся', 'Павленко', 121, 12, 1),
       ('Павло', 'Демченко', 122, 13, 2),
       ('Ірина', 'Біленко', 122, 14, 2),
       ('Максим', 'Новенко', 123, 15, 3),
       ('Інна', 'Корненко', 123, 16, 3),
       ('Роман', 'Беленко', NULL, 17, 4),
       ('Світлана', 'Петрушенко', NULL, 18, 4),
       ('Віталій', 'Семенко', 121, 19, 5),
       ('Анна', 'Трофименко', 121, 20, 5),
       ('Олег', 'Гавриленко', 123, 1, 6),
       ('Катерина', 'Мироненко', 123, 2, 6),
       ('Михайло', 'Костенко', 122, 3, 7),
       ('Тамара', 'Юрченко', 122, 4, 7),
       ('Богдан', 'Самойленко', NULL, 5, 8);

INSERT INTO course (name, credits, student_year, is_active, teacher_id)
VALUES ('Програмування', 6, 1, true, 1),
       ('Математичний аналіз', 8, 1, true, 2),
       ('Дискретна математика', 5, 1, true, 3),
       ('Алгоритми та структури даних', 7, 2, true, 4),
       ('ООП', 6, 2, true, 5),
       ('Операційні системи', 5, 2, true, 6),
       ('Архітектура комп''ютерів', 4, 2, true, 7),
       ('Веб-технології', 5, 3, true, 8),
       ('Машинне навчання', 6, 3, true, 9),
       ('Комп''ютерні мережі', 5, 3, true, 10),
       ('Інженерія ПЗ', 7, 4, true, 1),
       ('Кібербезпека', 5, 4, false, 2);

INSERT INTO enrolment (course_id, student_id, grade)
VALUES (1, 1, 85),
       (1, 2, 92),
       (1, 3, NULL),
       (2, 1, 88),
       (2, 2, 95),
       (2, 4, NULL),
       (3, 1, 90),
       (3, 3, 76),
       (4, 5, NULL),
       (4, 6, 93),
       (5, 5, 87),
       (5, 7, NULL),
       (6, 7, 84),
       (6, 8, 79),
       (8, 9, NULL),
       (8, 10, 88),
       (9, 11, 92),
       (9, 12, NULL),
       (10, 13, 83),
       (11, 14, NULL);

INSERT INTO course_prerequisite (course_id, prerequisite_course_id)
VALUES (4, 1),  -- Алгоритми потребують Програмування
       (5, 1),  -- ООП потребує Програмування
       (8, 1),  -- Веб-технології потребують Програмування
       (9, 2),  -- Машинне навчання потребує Математичний аналіз
       (9, 4),  -- Машинне навчання потребує Алгоритми
       (10, 6), -- Комп'ютерні мережі потребують Операційні системи
       (11, 5); -- Інженерія ПЗ потребує ООП


-- Завдання1: порахувати успішність студентів залежно від року навчання
-- Коментар: я інтерпретувала це так, що треба порахувати середню оцінку студента по всім предметам (у 
-- випадку, якщо у студента одна оцінка 76, а інша NULL, то буде (76 + 0) / 2, бо вважаємо, що підрахунок
-- успішності проходить в кінці семестру, тобто NULL це 0), потім середню оцінку всіх студентів 
-- за певним навчальним роком. В результаті виводимо ім'я, прізвище студента, його навчальний рік,
-- середню оцінку з усіх предметів та середню оцінку по його навчальному року (і для зручності посортувати)
/*
SELECT 
    s.name || ' ' || s.surname AS full_name,
    c.student_year AS study_year,
    ROUND(AVG(COALESCE(e.grade, 0)), 1) AS avg_student_grade,
	ROUND(AVG(AVG(COALESCE(e.grade, 0)))OVER (PARTITION BY c.student_year), 1) AS avg_course_grade
FROM student s
	INNER JOIN enrolment e USING (student_id)
	INNER JOIN course c USING (course_id)
GROUP BY s.name, s.surname, c.student_year
ORDER BY study_year ASC, full_name ASC;
*/

-- Завдання2: для кожного з студентів знайти його середній бал у порівнянні з середнім балом по групі
-- Коментар: я це інтерпретувала, що треба знайти середній бал сутдента та середній бал групи
-- і вивести ім'я, прізвище студента, назву групи, середній бал студента та групи 
/*
SELECT DISTINCT
    s.name || ' ' || s.surname as full_name,
	g.name as group_name,
    ROUND(AVG(e.grade) OVER (PARTITION BY s.student_id), 1) AS avg_student_grade,
    ROUND(AVG(e.grade) OVER (PARTITION BY g.group_id), 1) AS avg_group_grade
FROM student s 
	INNER JOIN enrolment e USING (student_id) 
	INNER JOIN student_group g USING (group_id)
ORDER BY group_name ASC, full_name ASC;
*/


-- Завдання3: порахувати статистику записів на курси для кожного року навчання:
-- кількість курсів, кількість записів та кількість студентів, що вже отримали бали
-- Коментар: порахували для кожного навчального року (курсу) кількість курсів (предметів), кількість 
-- записів студентів на ці предмети та скільки судентів цих навчальних років мають 1 або більше оцінок, які не NULL
/*
SELECT
	c.student_year AS course_year,
	COUNT (DISTINCT c.course_id) AS quantity_of_courses,
	COUNT (e.course_id) AS quantity_of_enrolment,
	COUNT(DISTINCT e.student_id) FILTER (WHERE e.grade IS NOT NULL) AS students_with_marks
FROM course c
	LEFT JOIN enrolment e USING (course_id)
GROUP BY c.student_year
ORDER BY course_year ASC;
*/


-- Завдання4: Для кожного курсу знайти в якому мінімальному семестрі він може читатись
-- Коментар: Інтерпретація: нам треба знайти курси та їх пререквізити. Враховуючи, що у нас
-- є курси, які мають косвену залежність (курс А потребує курс В потребує курс С), то нам 
-- треба використовувати рекурсію для такого пошуку вглиб. 
-- у мене не вийшло повністю це зробити, але вирішила залишити приблизне щось, хоч воно і недопрацьовує
/*
WITH RECURSIVE course_semester AS (
    SELECT
        c.course_id,
        c.name,
        1::INTEGER AS min_semester
    FROM course c
    	LEFT JOIN course_prerequisite cp USING (course_id)
    WHERE cp.course_id IS NULL OR cp.prerequisite_course_id IS NULL
    UNION ALL
    SELECT
        c.course_id,
        c.name,
        cs.min_semester + 1 AS min_semester
    FROM course_prerequisite cp
    	INNER JOIN course_semester cs ON cp.prerequisite_course_id = cs.course_id
    	INNER JOIN course c ON cp.course_id = c.course_id
)
SELECT 
    course_id,
    name,
    MAX(min_semester) AS min_semester
FROM course_semester
GROUP BY course_id, name
ORDER BY min_semester, course_id;
*/


-- Завдання5: Знайти всіх студентів, які записані на більше курсів ніж в середньому студенти
-- Коментар: Як я зрозуміла: спершу знаходимо кількість курсів (предметів) у одного студента,
-- далі рахуємо середню кількість курсів у всіх студентів. Далі виводимо всіх, хто має
-- кількість курсів більше за середню кількість.
/*
WITH courses_per_student AS (
    SELECT student_id, COUNT(course_id) AS quantity_of_courses
    FROM enrolment
    GROUP BY student_id
),
avg_courses_per_student AS (
    SELECT AVG(quantity_of_courses) AS avg_count
    FROM courses_per_student
)
SELECT 
	s.student_id, 
	s.name || ' ' || s.surname AS full_name, 
	cps.quantity_of_courses
FROM courses_per_student cps
	INNER JOIN student s USING(student_id)
	CROSS JOIN avg_courses_per_student acps
WHERE cps.quantity_of_courses > acps.avg_count;
*/


-- Завдання6: Знайти топ-3 студенти у кожному курсі за отриманими балами
-- Коментар: як я зрозуміла, то нам треба зробити рейтинг по курсам(предметам), в яких 
-- студенти з вищіми оцінками будуть вище в топі і з нижчими нижче, а якщо у них оцінка
-- null, то в топ вони не попадуть. топ може бути неповний. можна було зробити з 
-- корельованим підзапитом, але там виходило трохи повільніше.
/*
WITH rank_list AS (
    SELECT 
        e.course_id, 
        e.student_id, 
        s.name || ' ' || s.surname AS full_name, 
        e.grade,
        ROW_NUMBER() OVER (PARTITION BY e.course_id ORDER BY e.grade DESC) AS rank_of_student
    FROM enrolment e
   		INNER JOIN student s USING (student_id)
    WHERE e.grade IS NOT NULL
)
SELECT course_id, rank_of_student, full_name, grade
FROM rank_list
WHERE rank_of_student <= 3
ORDER BY course_id, rank_of_student;
*/

