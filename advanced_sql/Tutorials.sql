CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

SELECT * FROM job_applied;

INSERT INTO job_applied (
    job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
) VALUES
(
    1,
    '2024-02-01',
    true,
    'resume_o1.pdf',
    true,
    'cover_letter_01.pdf',
    'submitted'
),
(
    2,
    '2024-03-01',
    true,
    'resume_o2.pdf',
    true,
    'cover_letter_02.pdf',
    'submitted'
),
(
    3,
    '2024-03-01',
    true,
    'resume_o3.pdf',
    true,
    'cover_letter_03.pdf',
    'submitted'
)

SELECT * FROM job_applied ORDER BY job_id ASC

ALTER TABLE job_applied
ADD COLUMN Gender VARCHAR(50);

UPDATE job_applied SET contact = 'Julius Finish' WHERE job_id = 1;
UPDATE job_applied SET contact = 'Anabel Collins' WHERE job_id = 2;
UPDATE job_applied SET contact = 'Jigga Dollop' WHERE job_id = 3

ALTER TABLE job_applied RENAME COLUMN status TO "Sub_Status";

ALTER TABLE job_applied 
ALTER COLUMN Gender TYPE VARCHAR(255);

ALTER TABLE job_applied
DROP COLUMN Gender;