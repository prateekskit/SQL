use db_2

/*The setting of SET SHOWPLAN_TEXT is set at execute or run time and not at parse time.*/
SET SHOWPLAN_TEXT OFF-- ON

/*The setting of SET SHOWPLAN_ALL is set at execute or run time and not at parse time.*/
SET SHOWPLAN_ALL OFF

/*he setting of SET SHOWPLAN_XML is set at execute or run time and not at parse time.*/
SET SHOWPLAN_XML OFF


SET STATISTICS PROFILE ON
select * from gender

SET STATISTICS XML ON
select * from gender

select * from gender

sp_helptext gender