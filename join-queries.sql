-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`name`, `students`.`surname`, `degrees`.`name`, `degrees`.`level`
FROM `students`
JOIN `degrees` 
ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` LIKE '%economia%'
ORDER BY `students`.`name`;

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT `degrees`.`name`, `degrees`.`level`, `departments`.`name`
FROM `degrees`
JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` LIKE '%neuroscienz%';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `courses`.`name` AS `course_name`, CONCAT(`teachers`.`name`, ' ', `teachers`.`surname`) AS `teacher`
FROM `courses`
JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers`
ON `course_teacher`.`teacher_id` = `teachers`.`id`
WHERE `teachers`.`name` LIKE 'fulvio' AND `teachers`.`surname` LIKE 'amato';

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT CONCAT(`students`.`surname`, ' ', `students`.`name`) AS `student`, CONCAT(`courses`.`name`, ' ', `courses`.`cfu`) AS `course`, CONCAT(`degrees`.`name`, ' ', `degrees`.`level`) AS `degree`
FROM `students`
JOIN `degrees` 
ON `students`.`degree_id` = `degrees`.`id`
JOIN `courses`
ON `courses`.`degree_id`= `degrees`.`id`
ORDER BY `student` ASC;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT CONCAT(`degrees`.`name`, ' ', `degrees`.`level`) AS `degree`, CONCAT(`courses`.`name`, ' ', `courses`.`cfu`) AS `course`, CONCAT(`teachers`.`name`, ' ', `teachers`.`surname`) AS `teacher`
FROM `degrees`
JOIN `courses`
ON `courses`.`degree_id` = `degrees`.`id`
JOIN `course_teacher` 
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT CONCAT(`teachers`.`name`, ' ', `teachers`.`surname`) AS `teacher`, `departments`.`name`
FROM `departments`
JOIN `degrees`
ON `degrees`.`department_id` = `departments`.`id`
JOIN `courses`
ON `courses`.`degree_id` = `degrees`.`id`
JOIN `course_teacher` 
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`
WHERE `departments`.`name` LIKE '%matematica%';

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT `courses`.`name` AS `course`, CONCAT(`students`.`surname`, ' ', `students`.`name`) AS `student`, COUNT(`exams`.`id`) AS `tentatives`
FROM `students`
JOIN `exam_student`
ON `exam_student`.`student_id` = `students`.`id`
JOIN `exams` 
ON `exams`.`id` = `exam_student`.`exam_id`
JOIN `courses`
ON `courses`.`id` = `exams`.`course_id`
GROUP BY `exams`.`id`;