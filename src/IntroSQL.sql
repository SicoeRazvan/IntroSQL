
--C.1 create tables

CREATE TABLE users
(
  id_user bigserial NOT NULL,
  username character(20),
  parola character(20),
  varsta character(20),
  oras character(20),
  blocat boolean,
  CONSTRAINT pk_users PRIMARY KEY (id_user)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE users
  OWNER TO fasttrackit_dev;


CREATE TABLE postari
(
  id_postare bigserial NOT NULL,
  mesaj character(20),
  data_postarii date,
  fk_user integer,
  CONSTRAINT pk_postari PRIMARY KEY (id_postare),
  CONSTRAINT fk_postari FOREIGN KEY (fk_user)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE postari
  OWNER TO fasttrackit_dev;

--C1- insert data in users table

INSERT INTO users(username, parola, varsta, oras, blocat) VALUES
('Ionel', '12345', '25', 'Dej', 'FALSE'),
('Razvan', 'abcde', '23', 'Dej', 'FALSE'),
('Dani', '78963', '17', 'Sibiu', 'TRUE'),
('Daniel', 'awefwef','19', 'Alba', 'FALSE'),
('Maria', 'qwerty', '45', 'Turda', 'TRUE'),
('Radu', '518484', '58', 'Turda', 'FALSE');


INSERT INTO postari(mesaj, data_postarii, fk_user) VALUES
('Ana are mere', '2017-11-11', 1),
('Merg la meci', '2016-03-05',1),
('Sunt la mare', '2017-05-07',1),
('Sunt la concert!', '2017-10-11', 2),
('Merg la cinema', '2016-03-17',2),
('Hello', '2017-05-24', 3),
('In politica exista multa coruptie', '2016-03-28',3),
('Ce faci?', '2016-03-15',4),
('Hi', '2016-01-07',4),
('Hai la un film', '2015-05-12',5),
('Merg la mall', '2016-03-29',6); 


--C2. Sa se afiseze toate postarile lui Ionel 

SELECT postari.mesaj, postari.data_postarii 
FROM postari
INNER JOIN users 
ON users.id_user = postari.fk_user
WHERE users.username = 'Ionel';


--C3. Sa se afiseze toti userii  

select username 
from users; 

--C4. Sa se afiseze toti userii care nu sunt blocati 

SELECT username
FROM users
WHERE blocat = false;

--C5. Sa se afiseze userul cu varsta cea mai mica

SELECT MIN(varsta) AS varsta_minima
FROM users; 



--C6. Sa se afiseze userii cu varsta intre 23 si 33 de ani , 
--ordonati dupa varsta 

SELECT username, varsta
FROM users
WHERE varsta BETWEEN 23 AND 33
ORDER BY varsta;


--C7. sa se afizeze media varstei userilor blocati 

SELECT AVG(varsta) AS medie_varsta
FROM users
WHERE blocat = true;



--C8.  sa se afiseze userii neblocati din dej 

SELECT username, oras
FROM users
WHERE blocat = false AND oras = 'Dej';



--C9. sa se afiseze postarile 
userilor neblocati din turda care au varsta peste 40 de ani 

SELECT postari.mesaj, postari.data_postarii 
FROM postari
INNER JOIN users 
ON users.id_user = postari.fk_user
WHERE users.blocat = false AND users.oras = 'Turda' AND users.varsta > 40;

--C10. sa sa afiseze userul cu cele mai multe postari 


SELECT COUNT(postari.fk_user), users.username
FROM users
INNER JOIN postari 
ON users.id_user = postari.fk_user
GROUP BY users.username
ORDER BY COUNT(postari.fk_user) DESC
LIMIT 1;


--C11. sa se afiseze postarile userilor care incep cu numele D si
-- sunt postate intre 1 si 31 martie 2016 


SELECT mesaj, username
FROM postari
JOIN users
ON users.id_user = postari.fk_user
WHERE username LIKE 'D%' AND (postari.data_postarii > '20160301' AND postari.data_postarii < '20160331'); 

--C12. sa se afiseze postarile ordonate dupa data postarii descendent, indiferent de user 

SELECT mesaj, username, data_postarii
FROM postari
JOIN users
ON users.id_user = postari.fk_user
ORDER BY data_Postarii DESC;

--C13. sa se stearga postarile userilor sub 18 ani care contin  textul ‘politica’

DELETE FROM postari 
USING users
WHERE users.id_user = postari.fk_user AND postari.mesaj LIKE '%politica%' AND users.varsta < 25;



















