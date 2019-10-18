CREATE DATABASE School;

USE School;

CREATE TABLE Students
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(30) NOT NULL,
	MiddleName NVARCHAR(25),
	LastName NVARCHAR(30) NOT NULL,
	Age INT NOT NULL CHECK(Age BETWEEN 5 AND 100),
	[Address] VARCHAR(50),
	Phone NCHAR(10)
);

CREATE TABLE Subjects
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(20) NOT NULL,
	Lessons INT NOT NULL CHECK(Lessons > 0)
);

CREATE TABLE StudentsSubjects
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	StudentId INT FOREIGN KEY REFERENCES [dbo].[Students]([Id]) NOT NULL,
	SubjectId INT FOREIGN KEY REFERENCES [dbo].[Subjects]([Id]) NOT NULL,
	Grade DECIMAL(15, 2) CHECK(Grade BETWEEN 2 AND 6) NOT NULL
);

CREATE TABLE Exams
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Date] DATETIME,
	SubjectId INT FOREIGN KEY REFERENCES [dbo].[Subjects]([Id]) NOT NULL
);

CREATE TABLE StudentsExams
(
	StudentId INT FOREIGN KEY REFERENCES [dbo].[Students]([Id]) NOT NULL,
	ExamId INT FOREIGN KEY REFERENCES [dbo].[Exams]([Id]) NOT NULL,
	Grade DECIMAL(15, 2) CHECK(Grade BETWEEN 2 AND 6) NOT NULL,
	CONSTRAINT PK_StudentsExams PRIMARY KEY (StudentId, ExamId)
);

CREATE TABLE Teachers
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	[Address] VARCHAR(50) NOT NULL,
	Phone CHAR(10),
	SubjectId INT FOREIGN KEY REFERENCES [dbo].[Subjects]([Id]) NOT NULL
);

CREATE TABLE StudentsTeachers
(
	StudentId INT FOREIGN KEY REFERENCES [dbo].[Students]([Id]) NOT NULL,
	TeacherId INT FOREIGN KEY REFERENCES [dbo].[Teachers]([Id]) NOT NULL,
	CONSTRAINT PK_StudentsTeachers PRIMARY KEY (StudentId, TeacherId)
);