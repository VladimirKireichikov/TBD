1.
SELECT h.name,s.name, s.surname
FROM students s, students_hobbies sh, hobbies h
WHERE (s.id = sh.student_id) AND(h.id = sh.hobby_id) AND  sh.date_finish is NULL

2 вариант решения.
SELECT s.name, s.surname, h.name 
FROM students_hobbies sh
INNER JOIN students s on sh.student_id = s.id 
INNER JOIN hobbies h on sh.hobby_id = h.id

2.
SELECT * FROM students s 
INNER JOIN 
  (SELECT 
    sh.student_id, 
    sh.date_finish - sh.date_start todo_time 
  FROM students_hobbies sh 
  WHERE sh.date_finish - sh.date_start IS NOT NULL) sh 
ON s.id = sh.student_id 
ORDER BY todo_time DESC 
LIMIT 1

3.
SELECT s.id, s.name, s.surname, s.date_birth
FROM students s,
  (SELECT sh.student_id, SUM(h.risk)
    FROM hobbies h
    INNER JOIN students_hobbies sh
    ON h.id = sh.hobby_id
    GROUP BY sh.student_id
    HAVING SUM(h.risk) > 9) hrisk
WHERE 
  s.score > (SELECT ROUND(AVG(s.score),2) FROM students s) AND  hrisk.student_id = s.id

4.
SELECT s.name,s.surname,s.date_birth, h.name, sh.todo_time
FROM students s 
INNER JOIN 
(SELECT 
    sh.student_id, 
    sh.hobby_id,
    (sh.date_finish - sh.date_start)/30 todo_time 
  FROM students_hobbies sh 
  WHERE sh.date_finish - sh.date_start IS NOT NULL) sh ON s.id = sh.student_id
INNER JOIN hobbies h
ON sh.hobby_id = h.id

5.
SELECT s.name, s.surname, s.date_birth
FROM students s,
(SELECT s.id
  FROM students s
  INNER JOIN
    (SELECT *
      FROM students_hobbies sh
      WHERE sh.date_finish IS NULL) sh
  ON s.id = sh.student_id
  GROUP BY s.id
  HAVING COUNT(sh.student_id) > 1) num_of_hobby
WHERE 
  EXTRACT(DAYS FROM NOW() - s.date_birth)/365 > 9 AND 
  s.id = num_of_hobby.id


6.
SELECT s.n_group, ROUND(AVG(s.score),1)
FROM students s
INNER JOIN 
(SELECT *
 FROM students_hobbies sh 
 WHERE sh.date_finish is null) sthob
ON s.id = sthob.student_id
GROUP BY s.n_group

7.
SELECT h.name, h.risk, max(sh.date_finish - sh.date_start)/30 maximum, s.id
FROM students s, hobbies h, students_hobbies sh
WHERE s.id = sh.id AND h.id = sh.hobby_id
GROUP BY h.name, h.risk, s.id
HAVING max(sh.date_finish - sh.date_start)/30  is not null
LIMIT 1

8.	
SELECT h.id,h.name  
FROM students s
INNER JOIN students_hobbies sh ON sh.student_id = s.id
INNER JOIN hobbies h ON sh.hobby_id = h.id
WHERE 
  s.score = (SELECT s.score
  FROM students s
  GROUP BY s.score
  ORDER BY s.score DESC
  LIMIT 1)

9.
SELECT h.name 
FROM students s
INNER JOIN students_hobbies sh ON sh.student_id = s.id
INNER JOIN hobbies h ON sh.hobby_id= h.id
WHERE 
  LEFT(s.n_group::VARCHAR, 1) = '2' AND 
  s.score = 3 AND 
  sh.date_finish IS NULL

10. 


11.
SELECT good.n_group
FROM
  (SELECT 
    s.n_group, 
    COUNT(s.id) total_count, 
    COUNT(s.score) FILTER (WHERE s.score >= 4) above_score_count
  FROM students s
  GROUP BY s.n_group) good
WHERE good.total_count*0.6 <= above_score_count

12.
SELECT LEFT(s.n_group::VARCHAR,1) course,
COUNT(DISTINCT h.id)
FROM students s
INNER JOIN students_hobbies sh
ON sh.student_id = s.id
INNER JOIN hobbies h
ON sh.hobby_id = h.id
GROUP BY LEFT(s.n_group::VARCHAR,1)

13.
SELECT s.id, s.name, s.surname,s.date_birth, ROUND(n_group/1000,0)
FROM students s, students_hobbies sh
WHERE s.id not in (SELECT sh.student_id FROM students_hobbies sh) AND s.score =5
GROUP BY s.id
ORDER BY
ROUND(n_group/1000,0), s.date_birth

14.
CREATE OR REPLACE VIEW Zadanie_14 AS
SELECT s.*, (now()::date - sh.date_start)/365 yrs
FROM students s, students_hobbies sh, hobbies h
WHERE sh.student_id = s.id AND sh.hobby_id = h.id AND (now()::date - sh.date_start)/365 > 5 AND sh.date_finish is not null
GROUP BY s.id,sh.date_start

15.
SELECT h.name, count(DISTINCT sh.student_id)
FROM hobbies h
INNER JOIN students_hobbies sh ON h.id = sh.hobby_id
GROUP BY h.name

16.
SELECT sh.hobby_id, count( sh.student_id) cont
FROM students_hobbies sh
GROUP BY sh.hobby_id
order by cont desc
LIMIT 1

17.
SELECT s.*
FROM students s
INNER JOIN students_hobbies sh ON s.id = sh.student_id
WHERE sh.hobby_id = (SELECT sh.hobby_id
FROM students_hobbies sh
GROUP BY sh.hobby_id
ORDER BY COUNT(hobby_id) DESC
LIMIT 1) AND sh.date_finish is null

18.
SELECT h.id
FROM hobbies h
ORDER BY h.risk DESC
LIMIT 3

19.
SELECT s.name
FROM students s
INNER JOIN
(SELECT sh.student_id, now()-sh.date_start
FROM students_hobbies sh
WHERE sh.date_finish IS NULL
ORDER BY (now()-sh.date_start) DESC
LIMIT 10) sh
on s.id=sh.student_id
GROUP BY s.name

20.
SELECT s.n_group
FROM students s
INNER JOIN
(SELECT sh.student_id, now()-sh.date_start
FROM students_hobbies sh
WHERE sh.date_finish IS NULL
ORDER BY (now()-sh.date_start) DESC
LIMIT 10) sh
on s.id=sh.student_id
GROUP BY s.n_group

21.
CREATE OR REPLACE VIEW Zadanie_21 AS
SELECT id, surname, name FROM Students
ORDER BY score

22.
CREATE VIEW popul_hob AS
SELECT ROUND(s.n_group/1000,0), COUNT(h.id)
FROM students s 
INNER JOIN students_hobbies sh ON s.id=sh.student_id
INNER JOIN hobbies h ON sh.hobby_id=h.id
GROUP BY ROUND(s.n_group/1000,0)

23.
CREATE VIEW Zadanie_23 AS
SELECT h.name, h.risk, COUNT(h.id)
FROM students s
INNER JOIN students_hobbies sh ON s.id=sh.student_id
INNER JOIN hobbies h ON sh.hobby_id=h.id
WHERE ROUND(s.n_group/1000,0)=2
GROUP BY h.name, h.risk
ORDER BY h.risk DESC, COUNT(h.id) DESC
LIMIT 1

24.
CREATE VIEW Zadanie_24 AS
SELECT ROUND(s.n_group/1000,0)"Номер курса", COUNT(s.id) "Количество студентов", COUNT(s.id) FILTER (WHERE(s.score=5))"Количество отличников"
FROM students s
GROUP BY ROUND(s.n_group/1000,0)

25.
CREATE VIEW Zadanie_25 AS
SELECT h.id, h.name
FROM hobbies h
INNER JOIN
(SELECT sh.hobby_id, COUNT(sh.hobby_id)
from students_hobbies sh
GROUP BY sh.hobby_id
ORDER BY COUNT(sh.hobby_id) DESC) sh
ON sh.hobby_id = h.id
LIMIT 1

26.
CREATE VIEW hobb AS 
SELECT *
FROM hobbies

27.
SELECT LEFT(s.name::VARCHAR,1), MAX(s.score) maxx, AVG(s.score) avgg, MIN(s.score) minn
FROM students s
GROUP BY LEFT(s.name::VARCHAR,1)
HAVING MAX(s.score)>3.6									
ORDER BY LEFT(s.name::VARCHAR,1)

28.

29. (Не уверен, что правильно понял смысл задания)
SELECT COUNT(h.id), EXTRACT(YEAR FROM date_birth)
FROM students
INNER JOIN students_hobbies sh ON sh.student_id=students.id
INNER JOIN hobbies h ON sh.hobby_id=h.id
GROUP BY EXTRACT(YEAR FROM students.date_birth)

30.(Не понял какую задачу мы должны выполнить)

31. 
SELECT s.name, s.score, EXTRACT(month FROM s.date_birth)
FROM students s,students_hobbies sh
WHERE s.id = sh.student_id AND sh.hobby_id = 2

32.


33.
SELECT s.surname,
  CASE
    WHEN POSITION('ов' IN s.surname) = 0
    THEN 'не найдено'
  ELSE POSITION('ов' IN s.surname)::VARCHAR
  END
FROM students s

34.
SELECT OVERLAY('##########' placing s.surname FROM 1)
FROM students s

35.
SELECT TRIM(TRAILING '#' FROM OVERLAY('##########' placing s.surname FROM 1)) 
FROM students s

36.
SELECT EXTRACT(DAY FROM '2018-05-01'::TIMESTAMP-'2018-04-01'::TIMESTAMP)

37.

38.
SELECT EXTRACT(CENTURY FROM now()) century,
	   EXTRACT(WEEK FROM now()) week,
	   EXTRACT(DAY FROM now()) days
39.
SELECT s.id, s.name, s.surname, h.name,
	CASE
		WHEN (sh.date_finish IS NULL) THEN 'Занимается!'
		WHEN (sh.date_finish IS NOT NULL) THEN 'Закончил =('
	END 
FROM students s
INNER JOIN students_hobbies sh ON s.id=sh.student_id
INNER JOIN hobbies h ON h.id=sh.hobby_id

40.(В примере название столбцов и строк расположены наоборот, но я не понимаю как этого добиться)
SELECT s.n_group,
COUNT(s.surname) FILTER (WHERE s.score=5) "5",
COUNT(s.surname) FILTER (WHERE s.score>=4 AND s.score<5) "4",
COUNT(s.surname) FILTER (WHERE s.score>=3 AND s.score<4) "3",
COUNT(s.surname) FILTER (WHERE s.score>=2 AND s.score<3) "2"
FROM students s
GROUP BY s.n_group 

