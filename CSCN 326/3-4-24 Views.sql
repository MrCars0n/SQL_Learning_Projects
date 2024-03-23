use storedprocsandtriggers

CREATE VIEW vw_Lollipops AS
select distinct Lollipopflavor from Lollipops

select * from vw_Lollipops

drop view vw_Lollipops