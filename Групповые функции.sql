1.
SELECT n_group, count(*)
FROM students
GROUP BY n_group

2. 
SELECT MAX(score),n_group
FROM students
GROUP BY n_group

3.
SELECT distinct surname, count(surname)
FROM students
GROUP BY surname

4. 
SELECT EXTRACT(YEAR FROM date_birth) AS year,count(id)
FROM students
GROUP BY year

5. 
SELECT ROUND(n_group/1000,1) , ROUND(AVG(score),1)
FROM students
GROUP BY n_group/1000

6.
SELECT n_group, MAX(score)
FROM students
WHERE
LEFT(n_group::VARCHAR,1) = '2'
GROUP BY n_group
LIMIT 1
7.
SELECT n_group, ROUND(AVG(score),1)
FROM students
GROUP BY n_group
having AVG(students.score)>=3.5
ORDER BY AVG(students.score)

8.
SELECT n_group, count(id), MAX(score), ROUND(AVG(score),1), MIN(score)
FROM students
GROUP BY n_group

9.
SELECT *
FROM students
WHERE score = (SELECT MAX(score) FROM students WHERE n_group=2281)

10.
SELECT s.*
FROM students s
INNER JOIN (SELECT n_group, MAX(score) FROM students GROUP BY n_group) AS stud on s.n_group=stud.n_group and s.score=stud.MAX