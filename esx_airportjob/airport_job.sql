
INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_airport', 'Los Santos Airport', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_airport', 'Los Santos Airport', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_airport', 'Los Santos Airport', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('airport', 'Los Santos Airport')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('airport',0,'stagiaire','Stagiaire',20,'{}','{}'),
	('airport',1,'employer','Pilote',40,'{}','{}'),
	('airport',2,'respequipe','Responsable Pilote',60,'{}','{}'),
	('airport',3,'copdg','Co-PDG',85,'{}','{}'),
	('airport',4,'boss','PDG',100,'{}','{}')
;

INSERT INTO `items` (`name`, `label`) VALUES
	('colis', 'Colis')

;