create database 2024_4ax_erindvora_Interview;
use `2024_4ax_erindvora_Interview`;


-- Create table for Open Questions
CREATE TABLE OpenQuestions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    frage TEXT
);
drop table OpenQuestions;

-- Create table for Closed Questions
CREATE TABLE ClosedQuestions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    frage TEXT
);
drop table ClosedQuestions;

-- Create table for Answers

CREATE TABLE Answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT,
    antwort TEXT,
    anzahl INT,
    FOREIGN KEY (question_id) REFERENCES OpenQuestions(id),  -- For open questions
    -- You can add another column for closed question foreign key if needed
    closed_question_id INT,
    FOREIGN KEY (closed_question_id) REFERENCES ClosedQuestions(id)
);

drop table Answers;



CREATE TABLE Plakate (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gebaude VARCHAR(100),  -- e.g., Gebäude A, C, Sporthalle
    problem TEXT,  -- e.g., "HDMI-Kabel im Raum K21 defekt"
    status VARCHAR(50) DEFAULT 'Pending'  -- e.g., "Pending", "In Progress"
);

alter table Plakate
change column gebaude bereich varchar(255);


-- Insert open-ended questions
INSERT INTO OpenQuestions (frage) VALUES
('Welche Aspekte der Instandhaltung der Schule sollten Ihrer Meinung nach verbessert werden?'),
('Wie empfinden Sie den Zustand der Klassenräume und Schulgebäude?');


-- Insert closed-ended questions
INSERT INTO ClosedQuestions (frage) VALUES
('Wie oft siehst du Handwerker in der Schule?'),
('Wie findest du die Sauberkeit in der Schule?'),
('Welche Schulräume müssten deiner Meinung nach am meisten repariert werden?'),
('Wie lange dauert es, bis etwas in der Schule repariert wird?');


-- Insert answers for Open Questions
INSERT INTO Answers (question_id, antwort, anzahl) VALUES
(1, 'Die Toiletten sollten häufiger gereinigt werden, und einige Fenster in den Klassenzimmern sind kaputt.', 1),
(1, 'Der Pausenhof könnte sauberer sein, und einige Türen schließen nicht richtig.', 1),
(2, 'Die Klassenräume sind okay, aber einige Tische sind beschädigt, und die Wände brauchen einen neuen Anstrich.', 1),
(2, 'Die Klassenzimmer sind in Ordnung, aber die Beleuchtung könnte besser sein.', 1);

-- Insert answers for Closed Questions
INSERT INTO Answers (closed_question_id, antwort, anzahl) VALUES
(1, 'Sehr oft', 5),
(1, 'Manchmal', 10),
(1, 'Fast nie', 3),
(2, 'Sehr gut', 4),
(2, 'Okay', 10),
(2, 'Nicht gut', 4),
(3, 'Klassenräume', 8),
(3, 'Toiletten', 6),
(3, 'Sporthalle', 4),
(4, 'Weniger als 1 Woche', 7),
(4, '1-2 Wochen', 6),
(4, 'Mehr als 2 Wochen', 5);



-- Daten von Plakaten (Instandhaltungsprobleme)
INSERT INTO Plakate (gebaude, problem, status) VALUES
('Gebäude A', 'HDMI-Kabel im Raum K21 defekt und muss repariert oder ersetzt werden.', 'Pending'),
('Gebäude C', 'Verkabelung von PC und Beamer im Raum muss richtiggestellt werden.', 'Pending'),
('Sporthalle', 'Probleme mit der Maus im Raum PR2, die entweder repariert oder ausgetauscht werden muss.', 'Pending'),
('Gebäude A', 'Neue Geräte müssen in den Klassenräumen aufgestellt werden.', 'Pending'),
('Gebäude A', 'Die Netzwerkverbindung im Raum SW2 ist zu langsam und sollte verbessert werden.', 'Pending'),
('Gebäude A', 'Die Verkabelung im Raum SW2 muss geändert werden, um eine bessere Netzwerkverbindung zu ermöglichen.', 'Pending'),
('Toiletten', 'Die Türen sind kaputt und müssen repariert oder ersetzt werden.', 'Pending'),
('Gebäude A', 'Die Steckdosen im Raum K21 sind defekt und müssen repariert oder ersetzt werden.', 'Pending'),
('Gebäude A', 'Ein Elektrotechniker muss beauftragt werden, um die elektrischen Probleme zu beheben.', 'Pending'),
('Gebäude C', 'Die Schlösser in der Schule sind kaputt und müssen entweder repariert oder ersetzt werden.', 'Pending'),
('Nachbargebäude', 'Es fehlt eine Tür zu den Herren-Toiletten, die installiert werden muss.', 'Pending'),
('Toiletten', 'Die Toiletten müssen insgesamt einer vollständigen Kontrolle unterzogen werden.', 'Pending'),
('Klassenräume', 'Einige Klassenräume sind ohne wichtige Ausstattungen wie Uhren und Whiteboards.', 'Pending'),
('Toiletten', 'In den Toiletten fehlt Toilettenpapier, welches regelmäßig nachgefüllt werden muss.', 'In Progress'),
('Sporthalle', 'Die Sportgeräte sind teilweise kaputt und müssen repariert oder ersetzt werden.', 'Pending'),
('Schule', 'Die Wände sind verschmiert und sollten gereinigt oder gestrichen werden.', 'Pending'),
('Schule', 'Es gibt defekte Lampen in der Schule, die repariert oder ersetzt werden müssen.', 'Pending'),
('Gebäude A', 'Einige Stühle und Tische in den Klassenräumen sind kaputt und sollten ersetzt werden.', 'Pending'),
('Labor', 'Es gibt Probleme mit den Laborgeräten, die repariert oder ersetzt werden müssen.', 'Pending'),
('Wasserversorgung', 'Die Trinkwasseranlage muss überprüft und ggf. in den Wasserkreislauf investiert werden.', 'Pending'),
('Schule', 'Es müssen neue Schränke und Stühle aufgestellt werden.', 'Pending'),
('Flur', 'Die Decke ist schimmelig und muss saniert werden.', 'Pending'),
('K24', 'Die Wand ist gebrochen und muss repariert werden.', 'Pending'),
('S-Lab', 'Die Tür ist kaputt und muss repariert werden.', 'Pending'),
('2. Stock', 'Die Toilette stinkt und benötigt regelmäßige Kontrolle und Reinigung.', 'In Progress');


-- Counts the number of problems that are for each zone
CREATE VIEW ProblemsByBuilding AS
SELECT bereich, COUNT(*) AS problem_count
FROM Plakate
GROUP BY bereich;

select * from ProblemsByBuilding;




-- Problems by Status
CREATE VIEW ProblemsByStatus AS
SELECT status, COUNT(*) AS problem_count
FROM Plakate
GROUP BY status;

select  * from ProblemsByStatus;

-- Pending problems
CREATE VIEW PendingProblemsByStatusAndArea AS
SELECT
    Plakate.bereich,
    status,
    COUNT(*) AS pending_problem_count
FROM Plakate
WHERE status = 'Pending'
GROUP BY Plakate.bereich, status;


select * from PendingProblemsByStatusAndArea;

-- SELECT commands for each table:

SELECT * FROM OpenQuestions;

SELECT * FROM ClosedQuestions;

SELECT * FROM Answers;

SELECT * FROM Plakate;

-- SELECT commands for views:

SELECT * FROM ProblemsByBuilding;

SELECT * FROM ProblemsByStatus;

SELECT * FROM PendingProblemsByStatusAndArea;


