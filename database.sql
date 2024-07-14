CREATE TABLE students(
   student_id INT AUTO_INCREMENT,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   birthdate DATE,
   email VARCHAR(100),
   password VARCHAR(100),
   country_code VARCHAR(5),
   phone_number VARCHAR(10),
   address TEXT,
   PRIMARY KEY(student_id)
);

CREATE TABLE teachers(
   teacher_id INT AUTO_INCREMENT,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   email VARCHAR(100),
   password VARCHAR(100),
   country_code VARCHAR(5),
   phone_number VARCHAR(10),
   address TEXT,
   department VARCHAR(50),
   PRIMARY KEY(teacher_id)
);

CREATE TABLE admin(
   id_admin INT AUTO_INCREMENT,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   email VARCHAR(100),
   password VARCHAR(100),
   country_code VARCHAR(5),
   phone_number VARCHAR(10),
   PRIMARY KEY(id_admin)
);

CREATE TABLE classes(
   class_id INT AUTO_INCREMENT,
   name VARCHAR(50),
   year_classe  YEAR,
   PRIMARY KEY(class_id)
);

CREATE TABLE login_logs(
   log_id INT AUTO_INCREMENT,
   user_type  NOT NULL ENUM('admin', 'teacher', 'student'),
   login_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
   ip_address VARCHAR(45),
   id_user INT NOT NULL,
   PRIMARY KEY(log_id),
   FOREIGN KEY(id_user) REFERENCES admin(id_admin),
   FOREIGN KEY(id_user) REFERENCES students(student_id),
   FOREIGN KEY(id_user) REFERENCES teachers(teacher_id)
);

CREATE TABLE courses(
   course_id INT AUTO_INCREMENT,
   name VARCHAR(50),
   description TEXT,
   teacher_id INT NOT NULL,
   PRIMARY KEY(course_id),
   FOREIGN KEY(teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE schedules(
   schedule_id INT AUTO_INCREMENT,
   day_of_week DATE,
   start_time TIME,
   end_time TIME,
   class_id INT NOT NULL,
   course_id INT NOT NULL,
   PRIMARY KEY(schedule_id),
   FOREIGN KEY(class_id) REFERENCES classes(class_id),
   FOREIGN KEY(course_id) REFERENCES courses(course_id)
);

CREATE TABLE grades(
   grade_id INT AUTO_INCREMENT,
   grade DECIMAL(2,2),
   comments TEXT,
   course_id INT NOT NULL,
   student_id INT NOT NULL,
   PRIMARY KEY(grade_id),
   FOREIGN KEY(course_id) REFERENCES courses(course_id),
   FOREIGN KEY(student_id) REFERENCES students(student_id)
);

CREATE TABLE parents(
   parent_id INT AUTO_INCREMENT,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   email VARCHAR(100),
   country_code VARCHAR(5),
   phone_number VARCHAR(20),
   address TEXT,
   relationship  ENUM('mother', 'father', 'guardian'),
   PRIMARY KEY(parent_id)
);

CREATE TABLE resources(
   resource_id INT AUTO_INCREMENT,
   title VARCHAR(100),
   description TEXT,
   upload_date DATE,
   class_id INT NOT NULL,
   teacher_id INT NOT NULL,
   PRIMARY KEY(resource_id),
   FOREIGN KEY(class_id) REFERENCES classes(class_id),
   FOREIGN KEY(teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE assignments(
   assignment_id INT AUTO_INCREMENT,
   title VARCHAR(100),
   description TEXT,
   due_date DATETIME,
   class_id INT NOT NULL,
   course_id INT NOT NULL,
   PRIMARY KEY(assignment_id),
   FOREIGN KEY(class_id) REFERENCES classes(class_id),
   FOREIGN KEY(course_id) REFERENCES courses(course_id)
);

CREATE TABLE submissions(
   submission_id INT AUTO_INCREMENT,
   submission_date DATETIME,
   grade DECIMAL(2,2),
   feedback TEXT,
   student_id INT NOT NULL,
   assignment_id INT NOT NULL,
   PRIMARY KEY(submission_id),
   FOREIGN KEY(student_id) REFERENCES students(student_id),
   FOREIGN KEY(assignment_id) REFERENCES assignments(assignment_id)
);

CREATE TABLE submission_file(
   submission_file_id INT AUTO_INCREMENT,
   submission_id INT NOT NULL,
   PRIMARY KEY(submission_file_id),
   FOREIGN KEY(submission_id) REFERENCES submissions(submission_id)
);

CREATE TABLE assignments_file(
   assignments_file_id INT AUTO_INCREMENT,
   assignment_id INT NOT NULL,
   PRIMARY KEY(assignments_file_id),
   FOREIGN KEY(assignment_id) REFERENCES assignments(assignment_id)
);

CREATE TABLE resources_file(
   resources_file_id INT AUTO_INCREMENT,
   file_path VARCHAR(255),
   resource_id INT NOT NULL,
   PRIMARY KEY(resources_file_id),
   FOREIGN KEY(resource_id) REFERENCES resources(resource_id)
);

CREATE TABLE student_classe(
   student_id INT,
   class_id INT,
   PRIMARY KEY(student_id, class_id),
   FOREIGN KEY(student_id) REFERENCES students(student_id),
   FOREIGN KEY(class_id) REFERENCES classes(class_id)
);

CREATE TABLE student_parent(
   student_id INT,
   parent_id INT,
   PRIMARY KEY(student_id, parent_id),
   FOREIGN KEY(student_id) REFERENCES students(student_id),
   FOREIGN KEY(parent_id) REFERENCES parents(parent_id)
);
