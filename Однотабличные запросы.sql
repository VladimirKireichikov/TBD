1.
SELECT students.name, students.surname
FROM students
WHERE students.score>=4 AND students.score<=5

SELECT students.name, students.surname
FROM students
WHERE students.score BETWEEN 4 AND 5

2.
SELECT students.name, students.surname
FROM students
WHERE CAST(n_group AS VARCHAR) LIKE '22%'

3.
SELECT students.name, students.surname, students.n_group
FROM students
ORDER BY students.n_group desc, students.surname

4.
SELECT students.name, students.surname,students.n_group,students.score
FROM students
WHERE students.score>=4
ORDER BY students.score desc

5.
SELECT hobbies.name, hobbies.risk 
FROM hobbies
WHERE hobbies.name LIKE 'Сон' or hobbies.name LIKE 'Рыбалка'

6.
SELECT students_hobbies.student_id, students_hobbies.hobby_id
FROM students_hobbies
WHERE students_hobbies.date_start between '2007-01-01' AND '2016-01-01' AND students_hobbies.date_finish IS NULL

7.
SELECT students.name, students.surname,students.score
FROM students
WHERE students.score>4.5
ORDER BY students.score desc

8.
SELECT students.name, students.surname,students.score
FROM students
WHERE students.score>4.5
ORDER BYstudents.score desc FETCH FIRST 5 ROWS ONLY

SELECT students.name, students.surname,students.score
FROM students
WHERE students.score>4.5
ORDER BY students.score 
LIMIT 5

9.
SELECT h.name, h.risk,
	CASE 
	 WHEN h.risk >= 8 THEN 'Очень опасный'
	 WHEN h.risk >= 6 AND h.risk <8 THEN 'Опасный'
	 WHEN h.risk >= 4 AND h.risk <6 THEN 'Так себе опасный, но если захотеть!!!'
	 WHEN h.risk >= 2 AND h.risk <4 THEN 'Нужно постараться, чтобы навредить себе'
	 WHEN h.risk <2 THEN 'Беобидный'
	END Dangerous
FROM hobbies h
10.
SELECT h.name, h.risk
FROM hobbies h
ORDER BYh.risk desc 
LIMIT 3


