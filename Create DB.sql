-- 1. Create the Database
DROP DATABASE IF EXISTS universityroutinedb;
CREATE DATABASE UniversityRoutineDB;

-- 2. Use the Database
USE UniversityRoutineDB;

-- 3. Create the Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL,
    DepartmentCode VARCHAR(100) NOT NULL
);

-- 4. Create the Professors Table
-- Create the Professors Table with ShortName
CREATE TABLE Professors (
    ProfessorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    ShortName VARCHAR(10) NOT NULL, -- Short name for the professor
    DepartmentID INT,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Status ENUM('Active', 'LPR', 'Leave', 'PRL', 'Retired') DEFAULT 'Active',
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 5. Create the Semesters Table
CREATE TABLE Semesters (
    SemesterID INT PRIMARY KEY AUTO_INCREMENT,
    SemesterName VARCHAR(50) NOT NULL,
    SemesterCode VARCHAR(5) NOT NULL,
    IsActive BOOLEAN DEFAULT FALSE -- Indicates if the semester is currently running
);

-- 6. Create the Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    CourseCode VARCHAR(20) NOT NULL, -- Course code starting with 'CSE'
    DepartmentID INT,
    Credits INT,
    CourseType ENUM('Theory', 'Lab') NOT NULL, -- Specifies the type of course
    IsActive BOOLEAN DEFAULT FALSE, -- Indicates if the course is currently active
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 7. Create CourseProfessors Table
CREATE TABLE CourseProfessors (
    CourseProfessorID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    ProfessorID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID)
);

-- 8. Create SemestersCourses Table
CREATE TABLE SemestersCourses (
    SemesterCourseID INT PRIMARY KEY AUTO_INCREMENT,
    SemesterID INT,
    CourseID INT,
    FOREIGN KEY (SemesterID) REFERENCES Semesters(SemesterID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 7. Create the Rooms Table
CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    RoomNumber VARCHAR(10) NOT NULL,
    Capacity INT NOT NULL,
    RoomType ENUM('Classroom', 'Lab') NOT NULL, -- Specifies whether the room is a classroom or a lab
    Status ENUM('Available', 'Not Available') DEFAULT 'Available'
);

-- 8. Create the Time Slots Table
CREATE TABLE TimeSlots (
    TimeSlotID INT PRIMARY KEY AUTO_INCREMENT,
    DayOfWeek ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL
);

-- 9. Create the Preference Table
CREATE TABLE Preferences (
    PreferenceID INT PRIMARY KEY AUTO_INCREMENT,
    ProfessorID INT,
    TimeSlotID INT,
    Preferred BOOLEAN DEFAULT TRUE, -- Indicates if it's a preferred time slot
    FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID),
    FOREIGN KEY (TimeSlotID) REFERENCES TimeSlots(TimeSlotID)
);

-- 10. Create the Schedules Table
CREATE TABLE Schedules (
    ScheduleID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    TimeSlotID INT,
    RoomID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (TimeSlotID) REFERENCES TimeSlots(TimeSlotID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    UNIQUE (CourseID, TimeSlotID, RoomID) -- Prevents scheduling conflicts
);
