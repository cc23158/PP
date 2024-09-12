select * from sf.Client
select * from sf.Adm
select * from sf.Exercise
select * from sf.Muscle
select * from sf.Recipe
select * from sf.History

delete sf.Client
delete sf.Adm
delete sf.Exercise
delete sf.Muscle
delete sf.Recipe

drop table sf.Client
drop table sf.Adm
drop table sf.Exercise
drop table sf.Muscle
drop table sf.Recipe

DBCC CHECKIDENT ('SF.Client', RESEED, 0)
DBCC CHECKIDENT ('SF.Adm', RESEED, 0)
DBCC CHECKIDENT ('SF.Exercise', RESEED, 0)
DBCC CHECKIDENT ('SF.Muscle', RESEED, 0)
DBCC CHECKIDENT ('SF.Recipe', RESEED, 0)