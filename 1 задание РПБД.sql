-- Список задач:
-- 1.Выведите на экран любое сообщение
-- 2.Выведите на экран текущую дату
-- 3.Создайте две числовые переменные и присвойте им значение. Выполните математические действия с этими числами и выведите результат на экран.
-- 4.Написать программу двумя способами 1 - использование IF, 2 - использование CASE. Объявите числовую переменную и присвоейте ей значение. Если число равно 5 - выведите на экран "Отлично". 4 - "Хорошо". 3 - Удовлетворительно". 2 - "Неуд". В остальных случаях выведите на экран сообщение, что введённая оценка не верна.
-- 5.Выведите все квадраты чисел от 20 до 30 3-мя разными способами (LOOP, WHILE, FOR).
-- 6.Последовательность Коллатца. Берётся любое натуральное число. Если чётное - делим его на 2, если нечётное, то умножаем его на 3 и прибавляем 1. Такие действия выполняются до тех пор, пока не будет получена единица. Гипотеза заключается в том, что какое бы начальное число n не было выбрано, всегда получится 1 на каком-то шаге. Задания: написать функцию, входной параметр - начальное число, на выходе - количество чисел, пока не получим 1; написать процедуру, которая выводит все числа последовательности. Входной параметр - начальное число.
-- 7.Числа Люка. Объявляем и присваиваем значение переменной - количество числе Люка. Вывести на экран последовательность чисел. Где L0 = 2, L1 = 1 ; Ln=Ln-1 + Ln-2 (сумма двух предыдущих чисел). Задания: написать фунцию, входной параметр - количество чисел, на выходе - последнее число (Например: входной 5, 2 1 3 4 7 - на выходе число 7); написать процедуру, которая выводит все числа последовательности. Входной параметр - количество чисел.
-- 8.Напишите функцию, которая возвращает количество человек родившихся в заданном году.
-- 9.Напишите функцию, которая возвращает количество человек с заданным цветом глаз.
-- 10.Напишите функцию, которая возвращает ID самого молодого человека в таблице.
-- 11.Напишите процедуру, которая возвращает людей с индексом массы тела больше заданного. ИМТ = масса в кг / (рост в м)^2.
-- 12.Измените схему БД так, чтобы в БД можно было хранить родственные связи между людьми. Код должен быть представлен в виде транзакции (Например (добавление атрибута): BEGIN; ALTER TABLE people ADD COLUMN leg_size REAL; COMMIT;). Дополните БД данными.
-- 13.Напишите процедуру, которая позволяет создать в БД нового человека с указанным родством.
-- 14.Измените схему БД так, чтобы в БД можно было хранить время актуальности данных человека (выполнить также, как п.12).
-- 15.Напишите процедуру, которая позволяет актуализировать рост и вес человека.

1.
CREATE OR REPLACE FUNCTION show_message() RETURNS VARCHAR(50) 
AS $$ 
BEGIN
	RETURN 'Hello world';
END;
$$ LANGUAGE plpgsql;

SELECT show_message()
2.
CREATE OR REPLACE FUNCTION date_() RETURNS timestamp 
AS $$ 
BEGIN
	RETURN localtimestamp;
END;
$$ LANGUAGE plpgsql;

SELECT date_()
3.
CREATE OR REPLACE FUNCTION del(ch1 int, ch2 int) RETURNS int
AS $$ 
BEGIN
	RETURN ch1/ch2;
END;
$$ LANGUAGE plpgsql;

SELECT del(44,11)
4.
	4.1 С использованием If
		CREATE OR REPLACE FUNCTION Zadanie_4(b int) RETURNS VARCHAR(50)
		AS $$ 
		BEGIN
			IF b = 5 THEN RETURN 'Отлично.';
			ELSIF b = 4 THEN RETURN 'Хорошо.';
			ELSIF b = 3 THEN RETURN 'Удовлетворительно.';
			ELSIF b = 2 THEN RETURN 'Неуд.';
			ELSE RETURN 'Введённая оценка не верна.';
			END IF;
		END;
		$$ LANGUAGE plpgsql;

		SELECT Zadanie_4(4)

	4.2 С использованием Case
		CREATE OR REPLACE FUNCTION Zadanie_4(b int) RETURNS VARCHAR(50)
		AS $$ 
		BEGIN
	
			CASE WHEN b = 5 THEN RETURN  'Отлично.';
			WHEN b = 4 THEN RETURN 'Хорошо.';
			WHEN b = 3 THEN RETURN  'Удовлетворительно.';
			WHEN b = 2 THEN RETURN 'Неуд.';
			ELSE RETURN 'Введённая оценка не верна.';
			END CASE;
		END;
		$$ LANGUAGE plpgsql;

		SELECT Zadanie_4(4)

5.
5.1 Loop
CREATE OR REPLACE FUNCTION Zadanie_5(x int) RETURNS SETOF int
AS $$
BEGIN
	LOOP
		RETURN NEXT x^2;
		x=x+1;
		EXIT WHEN x=31;
	END LOOP;
	RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT Zadanie_5(20)

5.2 While	
CREATE OR REPLACE FUNCTION Zadanie_5(x int) RETURNS SETOF int
AS $$
BEGIN
	WHILE x<=30 LOOP
		RETURN NEXT x^2;
		x=x+1;
		EXIT WHEN x=31;
	END LOOP;
	RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT Zadanie_5(20)

5.3 For
CREATE OR REPLACE FUNCTION Zadanie_5(x int, y int) RETURNS SETOF int
AS $$
BEGIN
	FOR i IN x..y LOOP
		RETURN NEXT i^2;
	END LOOP;
	RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT Zadanie_5(20,30)

6.
6.1 Функция
CREATE OR REPLACE FUNCTION Zadanie_6(x int) RETURNS int
AS $$
DECLARE
BEGIN
	IF x=1 THEN RETURN 0;
	ELSE
		WHILE x != 1 LOOP
			IF mod(x,2) = 0 THEN x = x / 2;
			RAISE NOTICE 'x = %', x;
			ELSE x = x * 3 + 1;
			RAISE NOTICE 'x = %', x;
			END IF;
		END LOOP;
	END IF;
END;
$$ LANGUAGE plpgsql;

SELECT Zadanie_6(7)

6.2 Процедура
CREATE OR REPLACE PROCEDURE Zadanie_6_2(x int)
AS $$
BEGIN
	IF x=1 THEN RETURN;
	ELSE
		WHILE x != 1 LOOP
			IF mod(x,2) = 0 THEN x = x / 2; 
			RAISE NOTICE 'x = %', x; 
			ELSE x = x * 3 + 1;
			RAISE NOTICE 'x = %', x; 
			END IF;
		END LOOP;
	END IF;
END;
$$ LANGUAGE plpgsql;

CALL Zadanie_6_2(5)

7.
7.1 Функция
CREATE OR REPLACE FUNCTION Zadanie_7(count_of_ch int) RETURNS int
AS $$ 
DECLARE
Count_ int;
Ch1 int;
Ch2 int;
Ch3 int;
BEGIN
	Count_=0;
	Ch1=2;
	Ch2=1;
	LOOP
		Ch3=Ch1+Ch2;
		Ch1=Ch2;
		Ch2=Ch3;
		Count_=Count_+1;
		Exit When Count_=count_of_ch-2;
	END LOOP;
	RETURN Ch3;
END;
$$ LANGUAGE plpgsql;

SELECT Zadanie_7(24)

7.2 Процедура
CREATE OR REPLACE PROCEDURE Zadanie_7_2(count_of_ch int)
AS $$
DECLARE
Count_ int;
Ch1 int;
Ch2 int;
Ch3 int;
BEGIN
	Count_=0;
	Ch1=2;
	Ch2=1;
	LOOP
		Ch3=Ch1+Ch2;
		Ch1=Ch2;
		Ch2=Ch3;
		Count_=Count_+1;
		Exit When Count_=count_of_ch-2;
	END LOOP;
	RAISE NOTICE 'x = %', Ch3;
END;
$$ LANGUAGE plpgsql;

CALL Zadanie_7_2(5)

8.
CREATE OR REPLACE FUNCTION Zadanie_8(year_ int) RETURNS SETOF people
AS $$ 
BEGIN
	RETURN QUERY
	SELECT * FROM people WHERE EXTRACT(YEAR FROM people.birth_date) = Zadanie_8.year_;
END;
$$ LANGUAGE plpgsql;

SELECT COUNT(*)
FROM Zadanie_8(1995)

9.
CREATE OR REPLACE FUNCTION Zadanie_9(color varchar(255)) RETURNS SETOF people
AS $$ 
BEGIN
	SELECT * FROM people WHERE people.eyes = Zadanie_9.color;
END;
$$ LANGUAGE plpgsql;

SELECT COUNT(*)
FROM Zadanie_9('blue')0

10.
CREATE OR REPLACE FUNCTION Zadanie_10() RETURNS SETOF people
AS $$ 
BEGIN
	RETURN QUERY
	SELECT * FROM people
	ORDER BY EXTRACT(YEAR FROM people.birth_date) DESC
	LIMIT 1;
END;
$$ LANGUAGE plpgsql;

SELECT Zadanie_10.id FROM Zadanie_10()

11.
CREATE OR REPLACE PROCEDURE Zadanie_11(IMT int)
AS $$
DECLARE
	p people%ROWTYPE;
BEGIN
	FOR p IN 
		SELECT * FROM people
	LOOP
		IF p.weight / (p.growth/100)^2 > IMT THEN
			RAISE NOTICE 'Имя: % Фамилия: %', p.name, p.surname;
		END IF;
	END LOOP;
END;
$$ LANGUAGE plpgsql;

CALL Zadanie_11(23)

-- Дальше я не до конца понимаю, что от меня требуется, поэтому, если будет возможность, то спрошу, а после выполню остальные пункты
12.


13.


14.

15.