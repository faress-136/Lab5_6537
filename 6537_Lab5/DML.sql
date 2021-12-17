1-
SELECT
    *
FROM
    student
WHERE
    student.level = "SR" AND student.student_id IN(
    SELECT
        enrolled.student_id
    FROM
        enrolled
    NATURAL JOIN semester_course WHERE enrolled.course_code = semester_course.course_code AND semester_course.prof_id = '1')


SELECT MAX(student.age)
FROM student
WHERE student.major = "History"




2-
SELECT
    MAX(student.age)
FROM
    Professor
NATURAL JOIN semester_course NATURAL JOIN enrolled NATURAL JOIN student WHERE Professor.prof_name = "Michael Miller" OR student.major = "History"




3-
    SELECT DISTINCT
    student.student_name,
    course.name,
    student.student_id
FROM
    student
LEFT JOIN enrolled ON student.student_id = enrolled.student_id
LEFT JOIN course ON course.course_code = enrolled.course_code




4-
SELECT Professor.prof_name,COUNT(semester_course.course_code)
FROM Professor JOIN semester_course on Professor.prof_id = semester_course.prof_id
GROUP BY Professor.prof_id
HAVING COUNT(semester_course.course_code)<5



5-
SELECT student.student_name,Professor.prof_id
FROM Professor JOIN semester_course on semester_course.prof_id = Professor.prof_id NATURAL JOIN enrolled NATURAL JOIN student
WHERE Professor.prof_id = "2"



6-
SELECT
    course.name
FROM
    course
WHERE
    course.course_code NOT IN(
    SELECT
        enrolled.course_code
    FROM
        enrolled
) OR course.course_code IN(
    SELECT
        semester_course.course_code
    FROM
        semester_course
    NATURAL JOIN Professor NATURAL JOIN Department WHERE Department.dept_name = "Computer Science"
)



7-
(
    SELECT
        Professor.prof_name
    FROM
        Professor
    NATURAL JOIN semester_course WHERE Professor.prof_name LIKE 'M%'
    GROUP BY
        Professor.prof_id
    HAVING
        COUNT(semester_course.course_code) > 2
)
UNION
    (
    SELECT
        student.student_name
    FROM
        student
    WHERE
        student.student_name LIKE 'M%' AND student.age < '20'
)



8-
SELECT
    Professor.prof_name,
    Professor.prof_id
FROM
    semester_course
NATURAL JOIN Professor NATURAL JOIN Department WHERE Department.dept_id BETWEEN 1 AND 4
GROUP BY
    Professor.prof_id
HAVING
    COUNT(semester_course.course_code) < 2




9-
SELECT
    student.student_name,
    Professor.prof_name
FROM
    enrolled
NATURAL JOIN semester_course RIGHT OUTER JOIN student ON student.student_id = enrolled.student_id
RIGHT OUTER JOIN Professor ON semester_course.prof_id = Professor.prof_id
UNION
SELECT
    student.student_name,
    Professor.prof_name
FROM
    enrolled
NATURAL JOIN semester_course RIGHT OUTER JOIN student ON student.student_id = enrolled.student_id
LEFT OUTER JOIN Professor ON semester_course.prof_id = Professor.prof_id;



10-
SELECT
    course.name,
    semester_course.course_code,
    Professor.prof_id,
    Professor.prof_name,
    COUNT(semester_course.prof_id)
FROM
    course
NATURAL JOIN semester_course NATURAL JOIN Professor GROUP BY semester_course.course_code,
    semester_course.prof_id
HAVING
    COUNT(semester_course.prof_id) >= 2





11-
SELECT
    Department.dept_id,
    Department.dept_name
FROM
    Department
LEFT JOIN Professor ON Department.dept_id = Professor.dept_id
LEFT JOIN semester_course ON Professor.prof_id = semester_course.prof_id
GROUP BY
    Department.dept_id
HAVING
    COUNT(semester_course.course_code) < 3