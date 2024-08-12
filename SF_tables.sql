CREATE SCHEMA SF

CREATE TABLE SF.Client(
	
	client_id INT IDENTITY NOT NULL,
	client_name VARCHAR(30) NOT NULL,
	client_age INT NOT NULL,
	client_gender CHAR NOT NULL,
	client_height FLOAT NOT NULL,
	client_weight FLOAT NOT NULL,

	PRIMARY KEY(client_id)

)

CREATE TABLE SF.Admin(

	admin_id INT IDENTITY NOT NULL,
	admin_user VARCHAR(30) NOT NULL,
	admin_password VARCHAR(60) NOT NULL,

	PRIMARY KEY(admin_id)


)

insert into sf.Client values('a', 16, 'M', 1.8, 70.4)
insert into sf.Admin values('b', 'c')