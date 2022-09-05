CREATE SCHEMA IF NOT EXISTS `base_KeVeo` DEFAULT CHARACTER SET utf8 ;
-- drop database base_keveo;
USE `base_KeVeo` ;
CREATE TABLE IF NOT EXISTS `base_KeVeo`.`USERS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL UNIQUE,
  `PASSWORD` VARCHAR(255) NOT NULL,
  `account_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `active` tinyint default '1',
  `birth_date` DATE NULL,
  `register_date` DATETIME NULL,
  PRIMARY KEY (`ID`));

INSERT INTO USERS VALUES
(1, 'admin', '$2a$04$5sT3dri6bOOG2b9P1LETEujUeYMR46G/OVybuBjxBAohlEtDsxmi2',
'admin','admin@gmail.com',TRUE, '2022-05-08','2022-05-08T07:00:00'),
(2, 'noactivo', '$2a$04$5sT3dri6bOOG2b9P1LETEujUeYMR46G/OVybuBjxBAohlEtDsxmi2',
'noactivo','noactivo@gmail.com',False, '2022-05-08','2022-05-08T07:00:00'),
(3, 'anonymous', '$2a$04$5sT3dri6bOOG2b9P1LETEujUeYMR46G/OVybuBjxBAohlEtDsxmi2',
'anonymous','anonymous@gmail.com',False, '2022-05-08','2022-05-08T07:00:00');

CREATE TABLE IF NOT EXISTS `base_KeVeo`.`platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `commission` DOUBLE NOT NULL,
  PRIMARY KEY (`id`));



CREATE TABLE IF NOT EXISTS `base_KeVeo`.`films` (
  `id` INT NOT NULL AUTO_INCREMENT,
 `active` TINYINT,
  `name` VARCHAR(255) NOT NULL,
 `cast` LONGTEXT NOT NULL,
  `duration` INT NOT NULL,
  `year` INT NOT NULL,
  `description` LONGTEXT NOT NULL,
  `trailer` VARCHAR(255) NULL,
  `image` VARCHAR(255) NULL,
  PRIMARY KEY (`id`));


CREATE TABLE IF NOT EXISTS `base_KeVeo`.`notification` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


CREATE TABLE IF NOT EXISTS `base_KeVeo`.`notificationtype` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(255) NOT NULL,
  `notification_id` INT NOT NULL,
  `enumerator` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `notification_id`),
  INDEX `fk_tipo_notificacion_notificacion_idx` (`notification_id` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_notificacion_notificacion`
    FOREIGN KEY (`notification_id`)
    REFERENCES `base_KeVeo`.`notification` (`id`));


CREATE TABLE IF NOT EXISTS `base_KeVeo`.`notification_users` (
  `notification_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`notification_id`, `users_id`),
  INDEX `fk_notificacion_has_usuario_usuario1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_notificacion_has_usuario_notificacion1_idx` (`notification_id` ASC) VISIBLE,
  CONSTRAINT `fk_notificacion_has_usuario_notificacion1`
    FOREIGN KEY (`notification_id`)
    REFERENCES `base_KeVeo`.`notification` (`id`),
  CONSTRAINT `fk_notificacion_has_usuario_usuario1`
    FOREIGN KEY (`users_id`)
    REFERENCES `base_KeVeo`.`USERS` (`ID`));


CREATE TABLE IF NOT EXISTS `base_KeVeo`.`url` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `films_id` INT NOT NULL,
  `platform_id` INT NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  `url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`,`films_id`, `platform_id`),
  INDEX `fk_pelicula_has_plataforma_plataforma1_idx` (`platform_id` ASC) VISIBLE,
  INDEX `fk_pelicula_has_plataforma_pelicula1_idx` (`films_id` ASC) VISIBLE,
  CONSTRAINT `fk_pelicula_has_plataforma_pelicula1`
    FOREIGN KEY (`films_id`)
    REFERENCES `base_KeVeo`.`films` (`id`),
  CONSTRAINT `fk_pelicula_has_plataforma_plataforma1`
    FOREIGN KEY (`platform_id`)
    REFERENCES `base_KeVeo`.`platform` (`id`));


CREATE TABLE IF NOT EXISTS `base_KeVeo`.`bill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `platform_id` INT NOT NULL,
  PRIMARY KEY (`id`, `platform_id`),
  INDEX `fk_bill_platform1_idx` (`platform_id` ASC) VISIBLE,
  CONSTRAINT `fk_bill_platform1`
    FOREIGN KEY (`platform_id`)
    REFERENCES `base_KeVeo`.`platform` (`id`));


CREATE TABLE IF NOT EXISTS `base_KeVeo`.`clicks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `step` TINYINT NULL DEFAULT 0,
  `date` DATETIME NOT NULL,
  `platform_id` INT NOT NULL,
  PRIMARY KEY (`id`, `platform_id`),
  INDEX `fk_clicks_plataforma1_idx` (`platform_id` ASC) VISIBLE,
  CONSTRAINT `fk_clicks_plataforma1`
    FOREIGN KEY (`platform_id`)
    REFERENCES `base_KeVeo`.`platform` (`id`));


CREATE TABLE IF NOT EXISTS `base_KeVeo`.`punctuation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `opinion` VARCHAR(255) NULL,
  `users_id` INT NOT NULL,
  `films_id` INT NOT NULL,
  PRIMARY KEY (`id`, `users_id`, `films_id`),
  INDEX `fk_puntuation_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_puntuation_films1_idx` (`films_id` ASC) VISIBLE,
  CONSTRAINT `fk_puntuation_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `base_KeVeo`.`USERS` (`ID`),
  CONSTRAINT `fk_puntuation_films1`
    FOREIGN KEY (`films_id`)
    REFERENCES `base_KeVeo`.`films` (`id`));


CREATE TABLE IF NOT EXISTS `base_KeVeo`.`genres` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


CREATE TABLE IF NOT EXISTS `base_KeVeo`.`genres_films` (
  `genres_id` INT NOT NULL,
  `films_id` INT NOT NULL,
  PRIMARY KEY (`genres_id`, `films_id`),
  INDEX `fk_genres_films_films1_idx` (`films_id` ASC) VISIBLE,
  INDEX `fk_genres_films_genres1_idx` (`genres_id` ASC) VISIBLE,
  CONSTRAINT `fk_genres_films_genres1`
    FOREIGN KEY (`genres_id`)
    REFERENCES `base_KeVeo`.`genres` (`id`),
  CONSTRAINT `fk_genres_films_films1`
    FOREIGN KEY (`films_id`)
    REFERENCES `base_KeVeo`.`films` (`id`));
    
    CREATE  TABLE MENUS(
    ID INTEGER auto_increment,
    ACTIVE INTEGER,
    DESCRIPTION VARCHAR(255) NOT NULL,
    APP_ORDER INTEGER,
    URL VARCHAR(255),
    PARENT_ID INTEGER,
    CONSTRAINT CONSTRAINT_2 PRIMARY KEY(ID)
);             
   
-- 6 +/- SELECT COUNT(*) FROM PUBLIC.MENUS;   
INSERT INTO MENUS VALUES
(1, 1, 'Home', 0, '/', NULL),
(2, 1, 'Gestion de Usuarios', 1, '/gestionUser', NULL),
(3, 1, 'Películas', 10, '/film', NULL),
(4, 1, 'Gestión de Películas', 20, '/gestionfilms',NULL),
(5, 1, 'Recomendador', 30, '/recomendador',NULL);

             
CREATE TABLE MENUS_ROLES(
    MENUS_ID INTEGER NOT NULL,
    ROLES_ID INTEGER NOT NULL
);              
ALTER TABLE MENUS_ROLES ADD CONSTRAINT CONSTRAINT_4 PRIMARY KEY(MENUS_ID, ROLES_ID);  
-- 11 +/- SELECT COUNT(*) FROM PUBLIC.MENUS_ROLES;  

 INSERT INTO MENUS_ROLES VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2),
(3, 1),
(4, 1),
(5, 1),
(5, 2),
(1,3),
(3,3);

  
 
CREATE TABLE ROLES(
    ID INTEGER auto_increment,
    ROLE_NAME VARCHAR(255) NOT NULL,
    CONSTRAINT CONSTRAINT_26 PRIMARY KEY(ID)
);   
      
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.ROLES;    
INSERT INTO ROLES VALUES
(1, 'ROLE_ADMIN'),
(2, 'ROLE_USER'),
(3, 'ROLE_ANONYMOUS');     
	
-- 8 +/- SELECT COUNT(*) FROM PUBLIC.USERS;    

CREATE TABLE USERS_ROLES(
    USERS_ID INTEGER NOT NULL,
    ROLES_ID INTEGER NOT NULL

);             
ALTER TABLE USERS_ROLES ADD CONSTRAINT CONSTRAINT_C PRIMARY KEY(USERS_ID, ROLES_ID); 
-- 9 +/- SELECT COUNT(*) FROM PUBLIC.USERS_ROLES;                   

INSERT INTO USERS_ROLES VALUES
(1,1),
(2,2),
(3,3);

 
ALTER TABLE USERS_ROLES ADD CONSTRAINT FKJ9553ASS9UCTJRMH0GKQSMV0D FOREIGN KEY(ROLES_ID) REFERENCES ROLES(ID) ;     
ALTER TABLE MENUS_ROLES ADD CONSTRAINT FKQ7K54HB6F3NGDBFPBLWJ68BHG FOREIGN KEY(MENUS_ID) REFERENCES MENUS(ID) ;      
ALTER TABLE MENUS ADD CONSTRAINT FKGEUPUBDQNCC1LPGF2CN4FQWBC FOREIGN KEY(PARENT_ID) REFERENCES MENUS(ID) ;          
ALTER TABLE MENUS_ROLES ADD CONSTRAINT FKAUV6MBPEO296VHBM7AVTOI3O8 FOREIGN KEY(ROLES_ID) REFERENCES ROLES(ID) ; 



-- Datos para peliculas --
INSERT INTO `films` (`id`,`active`,`cast`,`image`,`duration`,`description`,`name`,`trailer`,`year`) 
VALUES 
(1,true,'Daniel Radcliffe, Rupert Grint, Emma Watson, Robbie Coltrane, Richard Harris, Maggie Smith, Alan Rickman.',
'https://i.pinimg.com/564x/68/ed/07/68ed0704993ba27dbb3af7779569f959.jpg',152,
'El día en que cumple once años, Harry Potter se entera de que es hijo de dos destacados hechiceros, de los que ha heredado poderes mágicos. En la escuela Hogwarts de Magia y Hechicería, donde se educa con otros niños que también tienen poderes especiales, aprenderá todo lo necesario para ser mago.'
,'Harry Potter y la Piedra Filosofal','https://www.youtube.com/embed/nnuRYwGw9bo',2001),
(2,true,'Daniel Radcliffe, Rupert Grint, Emma Watson, Robbie Coltrane, Richard Harris, Maggie Smith, Alan Rickman.',
'https://i.pinimg.com/564x/cd/5e/28/cd5e286a0af2cf3a2a82a04d37bfd575.jpg',152,
'Terminado el verano, Harry (Radcliffe) no ve la hora de abandonar la casa de sus odiosos tíos, pero, inesperadamente se presenta en su dormitorio Dobby, un elfo doméstico, que le anuncia que correrá un gran peligro si vuelve a Hogwarts. A pesar de los esfuerzos del elfo por retenerlo, Harry es rescatado por Ron y sus hermanos, con la ayuda de un coche volador, y recibido con los brazos abiertos en el cálido hogar de los Weasley.',
'Harry Potter y la cámara secreta','https://www.youtube.com/embed/2lSpGlsZtk0',2002),
(3,true,'Daniel Radcliffe, Rupert Grint, Emma Watson, Robbie Coltrane, Richard Harris, Maggie Smith, Alan Rickman.',
'https://i.pinimg.com/564x/9b/38/3c/9b383c8dbbe8e0f0314636145b49b983.jpg',137,
'Cuando Harry Potter y sus amigos vuelven a Hogwarts para cursar su tercer año de estudios, se ven involucrados en un misterio: de la prisión para magos de Azkaban se ha fugado Sirius Black, un peligroso mago que fue cómplice de Lord Voldemort y que intentará vengarse de Harry Potter. El joven aprendiz de mago contribuyó en gran medida a la condena de Sirius, por lo que hay razones para temer por su vida.',
'Harry Potter y el prisionero de Azkaban','https://www.youtube.com/embed/VwErvYgoH70',2004),
(4,true,'Daniel Radcliffe, Rupert Grint, Emma Watson, Robbie Coltrane, Richard Harris, Maggie Smith, Alan Rickman.',
'https://i.pinimg.com/564x/0e/30/2d/0e302d696482db312384492f215eca6d.jpg',137,
'La cuarta parte de la serie del niño mago comienza con la Copa Internacional de Quidditch. Cuenta también el inicio de la atracción por Cho Chang y otro año de magia, en el que una gran sorpresa obligará a Harry a enfrentarse a muchos desafíos temibles. También habrá un torneo de magia para tres escuelas, y el temido regreso de "Aquel-que-no-debe-ser-nombrado".',
'Harry Potter y el cáliz de fuego','https://www.youtube.com/embed/4xkFJgcCQRE',2005),
(5,true,'Chris Evans, Hugo Weaving, Hayley Atwell, Tommy Lee Jones, Sebastian Stan, Stanley Tucci, Dominic Cooper.',
'https://i.pinimg.com/564x/8e/94/84/8e948436e2b5c51d91a3a651f17d21ff.jpg',125,
'Nacido durante la Gran Depresión (años 30), Steve Rogers creció como un chico enclenque en una familia pobre. Horrorizado por las noticias que llegaban de Europa sobre los nazis, decidió enrolarse en el ejército; sin embargo, debido a su precaria salud, fue rechazado una y otra vez. Enternecido por sus súplicas, el General Chester Phillips le ofreció la oportunidad de participar en un experimento especial: la "Operación Renacimiento". Tras administrarle el “Suero Super-Soldado” y bombardearlo con “vitarrayos”, el cuerpo de Steve se hace perfecto.',
'Capitán América: El primer vengador','https://www.youtube.com/embed/Ics4g1xppFg',2011),
(6,true,'Robert Downey Jr., Terrence Howard, Gwyneth Paltrow, Jeff Bridges, Stan Lee, Leslie Bibb, Clark Gregg, Shaun Toub.',
'https://i.pinimg.com/564x/7f/27/9b/7f279b0a5219450f54b5915b3b318644.jpg',126,
'El multimillonario fabricante de armas Tony Stark (Robert Downey Jr.) debe enfrentarse a su turbio pasado después de sufrir un accidente con una de sus armas. Equipado con una armadura de última generación tecnológica, se convierte en "El hombre de hierro", un héroe que se dedica a combatir el mal en todo el mundo.',
'Iron Man','https://www.youtube.com/embed/8ugaeA-nMTc',2008),
(7,true,'Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Jeremy Renner, Scarlett Johansson, Tom Hiddleston, Samuel L. Jackson.',
'https://i.pinimg.com/564x/84/79/0a/84790aff58c3c7f50d07d5827193f631.jpg',135,
'Cuando un enemigo inesperado surge como una gran amenaza para la seguridad mundial, Nick Fury, director de la Agencia SHIELD, decide reclutar a un equipo para salvar al mundo de un desastre casi seguro. Adaptación del cómic de Marvel "Los Vengadores", el legendario grupo de superhéroes formado por Ironman, Hulk, Thor y el Capitán América entre otros.',
'Los Vengadores','https://www.youtube.com/embed/HQIiYqOVTWo',2012),
(8,true,'Chris Pratt, Zoe Saldana, Dave Bautista, Bradley Cooper, Vin Diesel, Kurt Russell, Michael Rooker, Karen Gillan, Elizabeth Debicki, Tommy Flanagan.',
'https://i.pinimg.com/564x/aa/40/29/aa4029e4e616c15ec370be3ae4ce08f5.jpg',137,
'Continúan las aventuras del equipo en su travesía por los confines del cosmos. Los Guardianes deberán luchar para mantener unida a su nueva familia mientras intentan resolver el misterio de los verdaderos orígenes de Peter Quill. Viejos rivales se convertirán en nuevos aliados, y queridos personajes de los cómics clásicos acudirán en ayuda de nuestros héroes a medida que el universo cinematográfico de Marvel continúa expandiéndose.',
'Guardians of the Galaxy Vol. 2','https://www.youtube.com/embed/ISS-a7b0iHw',2017),
(9,true,'Benedict Cumberbatch, Chiwetel Ejiofor, Rachel McAdams, Benedict Wong, Mads Mikkelsen, Tilda Swinton, Benjamin Bratt.',
'https://i.pinimg.com/564x/86/25/d1/8625d1c161bc68ad766009d6b15ef71e.jpg',115,
'La vida del Dr. Stephen Strange cambia para siempre tras un accidente automovilístico que le deja muy malheridas sus manos. Cuando la medicina tradicional falla, se ve obligado a buscar esperanza y una cura en un lugar impensable: una comunidad aislada en Nepal llamada Kamar-Taj. Rápidamente descubre que éste no es sólo un centro de recuperación, sino también la primera línea de una batalla en contra de fuerzas oscuras y ocultas empeñadas en destruir nuestra realidad.',
'Dr. Strange','https://www.youtube.com/embed/PqTILYUNU3s',2016),
(10,true,'Tom Holland, Michael Keaton, Robert Downey Jr., Jon Favreau, Marisa Tomei, Jacob Batalon, Zendaya, Tony Revolori.',
'https://i.pinimg.com/564x/cb/e0/80/cbe0805aea34cca87635e51a007598a7.jpg',133,
'Peter Parker (Tom Holland) comienza a experimentar su recién descubierta identidad como el superhéroe Spider-Man. Después de la experiencia vivida con los Vengadores, Peter regresa a casa, donde vive con su tía (Marisa Tomei). Bajo la atenta mirada de su mentor Tony Stark (Robert Downey Jr.).',
'Spider-Man: Homecoming','https://www.youtube.com/embed/grusgXCahH8',2017),
(11,true,'Tom Holland, Zendaya, Benedict Cumberbatch, Alfred Molina, Tobey Maguire, Andrew Garfield, Willem Dafoe, Marisa Tomei.',
'https://i.pinimg.com/564x/ea/46/fa/ea46fa1972c4f7739bfb1dfaccba2a0f.jpg',148,
'Por primera vez en la historia cinematográfica de Spider-Man, nuestro héroe, vecino y amigo es desenmascarado, y por tanto, ya no es capaz de separar su vida normal de los enormes riesgos que conlleva ser un superhéroe. Cuando pide ayuda al Doctor Strange, los riesgos pasan a ser aún más peligrosos, obligándole a descubrir lo que realmente significa ser él.',
'Spider-Man: No Way Home','https://www.youtube.com/embed/ldMn-1iQzKE',2021),
(12,true,'Brie Larson, Samuel L. Jackson, Jude Law, Ben Mendelsohn, Gemma Chan, Annette Bening, Lee Pace, Mckenna Grace.',
'https://i.pinimg.com/564x/a0/f6/a5/a0f6a5f8afc63d13aa42c3fcec5542b3.jpg',125,
'La historia sigue a Carol Danvers mientras se convierte en una de las heroínas más poderosas del universo, cuando la Tierra se encuentra atrapada en medio de una guerra galáctica entre dos razas alienígenas... Situada en los años 90, "Capitana Marvel" es una historia nueva de un período de tiempo nunca antes visto en la historia del Universo Cinematográfico de Marvel.',
'Captain Marvel','https://www.youtube.com/embed/MJIz2gf3Wa8',2019),
(13,true,'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss, Joe Pantoliano, Hugo Weaving, Marcus Chong, Gloria Foster, Matt Doran.',
'https://i.pinimg.com/564x/86/50/51/8650516349bfbb5c37fce873c8054ed1.jpg',131,
'Thomas Anderson es un brillante programador de una respetable compañía de software. Pero fuera del trabajo es Neo, un hacker que un día recibe una misteriosa visita y se adentra en el misterioso mundo de "Matrix".',
'The Matrix','https://www.youtube.com/embed/2FcZODI-zK0',1999),
(14,true,'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss, Hugo Weaving, Harold Perrineau, Jada Pinkett Smith, Anthony Zerbe.',
'https://i.pinimg.com/564x/7e/20/02/7e20026cc5bd2ede99022e82efc93103.jpg',138,
'Neo, Morpheus, Trinity y el resto de la tripulación continúan en la lucha contra las máquinas que han esclavizado a la raza humana. Ahora más humanos han sido despertados e intentan vivir en el mundo real. A medida que aumentan en número, la batalla se acerca a Sion, la última ciudad real en el mundo y centro de la resistencia humana. Y tiene poco tiempo, muy poco tiempo.',
'The Matrix Reloaded','https://www.youtube.com/embed/zmYE3tg26Qc',2003),
(15,true,'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss, Hugo Weaving, Harold Perrineau, Jada Pinkett Smith, Anthony Zerbe.',
'https://i.pinimg.com/564x/e5/ff/a2/e5ffa2c21fbf71019457e35892c94b05.jpg',130,
'En esta nueva entrega de la saga Matrix todo lo que tiene un comienzo tiene un final. La guerra estalla en la superficie de la tierra mientras las máquinas invaden Zion. Allí donde Reloaded significaba vida, Revolutions apunta a la muerte..',
'The Matrix Revolutions','https://www.youtube.com/embed/9ix7TUGVYIo',2003),
(16,true,'Elijah Wood, Ian McKellen, Viggo Mortensen, Sean Astin, Sean Bean, John Rhys-Davies, Orlando Bloom, Dominic Monaghan, Billy Boyd.',
'https://i.pinimg.com/564x/ab/0a/5b/ab0a5b075e5bb27137557536804f025b.jpg',180,
'En la Tierra Media, el Señor Oscuro Sauron ordenó a los Elfos que forjaran los Grandes Anillos de Poder. Tres para los reyes Elfos, siete para los Señores Enanos, y nueve para los Hombres Mortales. Pero Saurón también forjó, en secreto, el Anillo Único, que tiene el poder de esclavizar toda la Tierra Media. Con la ayuda de sus amigos y de valientes aliados, el joven hobbit Frodo emprende un peligroso viaje con la misión de destruir el Anillo Único. Pero el malvado Sauron ordena la persecución del grupo, compuesto por Frodo y sus leales amigos hobbits, un mago, un hombre, un elfo y un enano. ',
'El señor de los anillos: La comunidad del anillo','https://www.youtube.com/embed/2KTjutR3mGA',2001),
(17,true,'Elijah Wood, Ian McKellen, Viggo Mortensen, Sean Astin, Sean Bean, John Rhys-Davies, Orlando Bloom, Dominic Monaghan, Billy Boyd.',
'https://i.pinimg.com/564x/d7/10/b1/d710b132f7acec0cf6e4eeb46d23a9f5.jpg',179,
'Tras la disolución de la Compañía del Anillo, Frodo y su fiel amigo Sam se dirigen hacia Mordor para destruir el Anillo Único y acabar con el poder de Sauron, pero les sigue un siniestro personaje llamado Gollum. Mientras, y tras la dura batalla contra los orcos donde cayó Boromir, el hombre Aragorn, el elfo Legolas y el enano Gimli intentan rescatar a los medianos Merry y Pipin, secuestrados por los orcos de Mordor.',
'El señor de los anillos: Las dos torres','https://www.youtube.com/embed/Y7k6FpH5n50',2002),
(18,true,'Elijah Wood, Viggo Mortensen, Ian McKellen, Sean Astin, Andy Serkis, John Rhys-Davies, Orlando Bloom, John Noble, Miranda Otto.',
'https://i.pinimg.com/564x/df/1c/a6/df1ca6dddcc57ae659f9966d4d5f9fdf.jpg',179,
'Las fuerzas de Saruman han sido destruidas, y su fortaleza sitiada. Ha llegado el momento de decidir el destino de la Tierra Media, y, por primera vez, parece que hay una pequeña esperanza. El interés del señor oscuro Sauron se centra ahora en Gondor, el último reducto de los hombres, cuyo trono será reclamado por Aragorn. Sauron se dispone a lanzar un ataque decisivo contra Gondor.',
'El señor de los anillos: El retorno del rey','https://www.youtube.com/embed/PrZyTC7-Dic',2003),
(19,true,'Marlon Brando, Al Pacino, James Caan, Robert Duvall, Diane Keaton, John Cazale, Talia Shire, Richard S. Castellano.',
'https://i.pinimg.com/564x/74/f4/65/74f465d3ada4455e2f6defbe0fe11f67.jpg',175,
'América, años 40. Don Vito Corleone (Marlon Brando) es el respetado y temido jefe de una de las cinco familias de la mafia de Nueva York. Tiene cuatro hijos: Connie (Talia Shire), el impulsivo Sonny (James Caan), el pusilánime Fredo (John Cazale) y Michael (Al Pacino), que no quiere saber nada de los negocios de su padre. Cuando Corleone, en contra de los consejos de Tom Hagen (Robert Duvall), se niega a participar en el negocio de las drogas, el jefe de otra banda ordena su asesinato. Empieza entonces una violenta y cruenta guerra entre las familias mafiosas.',
'El padrino','https://www.youtube.com/embed/v72XprPxy3E',1972),
(20,true,'Pixar Animation Studios, Walt Disney Pictures.',
'https://i.pinimg.com/564x/03/63/6c/03636c163760207c44d7372b6f88df8e.jpg',100,
'Mei Lee, una niña de 13 años un poco rara pero segura de sí misma, se debate entre ser la hija obediente que su madre quiere que sea y el caos propio de la adolescencia. Ming, su protectora y ligeramente exigente madre, no se separa nunca de ella lo que es una situación poco deseable para una adolescente. Y por si los cambios en su vida y en su cuerpo no fueran suficientes, cada vez que se emociona demasiado, se convierte en un panda rojo gigante.',
'Turning Red','https://www.youtube.com/embed/3QoJsp-MKt0',2022),
(21,true,'Robert Pattinson, Zöe Kravitz, Jeffrey Wright, John Turturro, Paul Dano, Colin Farrell, Andy Serkis, Peter Sarsgaard, Jayme Lawson, Con O Neill, Barry Keoghan.',
'https://i.pinimg.com/564x/7f/06/9b/7f069bae8bb02bf5eb7ce863ee35e493.jpg',175,
'Después de dos años acechando por las calles de la ciudad como Batman, e infundiendo miedo en las mentes perversas de los criminales, Bruce Wayne está sumido en las profundidades de las sombras de Gotham City. Este vigilante solitario cuenta con pocos aliados de confianza y eso le ha llevado a convertirse en la única encarnación de la venganza entre sus conciudadanos.',
'The Batman','https://www.youtube.com/embed/IqRRLA6pZvo',2022),
(22,true,'Chris Hemsworth, Natalie Portman, Christian Bale, Tessa Thompson, Chris Pratt, Taika Waititi, Jaimie Alexander, Karen Gillan, Dave Bautista, Pom Klementieff, Russell Crowe.',
'https://i.pinimg.com/564x/10/6e/18/106e18c1229ba46ae37bba17cb19b9e6.jpg',118,
'El Dios del Trueno (Chris Hemsworth) emprende un viaje que no se parece en nada a lo que se ha enfrentado hasta ahora: una búsqueda de la paz interior. Pero el retiro de Thor se ve interrumpido por un asesino galáctico conocido como Gorr el Carnicero de Dioses (Christian Bale), que busca la extinción de los dioses. Para hacer frente a la amenaza.',
'Thor: Love and Thunder','https://www.youtube.com/embed/9jrffoywRUU',2022),
(23,true,'Tom Cruise, Miles Teller, Jennifer Connelly, Jon Hamm, Glen Powell, Ed Harris, Val Kilmer, Lewis Pullman, Charles Parnell, Bashir Salahuddin.',
'https://i.pinimg.com/564x/79/59/47/79594732f49e4ec63aa7d921a05787db.jpg',132,
'Después de más de treinta años de servicio como uno de los mejores aviadores de la Armada, Pete "Mavericks" Mitchel (Tom Cruise) se encuentra donde siempre quiso estar: superando los límites como un valiente piloto de pruebas y esquivando el ascenso de rango, que no le dejaría volar emplazándolo en tierra. Cuando es destinado a la academia de Top Gun con el objetivo de entrenar a los pilotos de élite para realizar una peligrosa misión en territorio enemigo.',
'Top Gun: Maverick','https://www.youtube.com/embed/zmFdhZ6gyUM',2022),
(24,true,'Benedict Cumberbatch, Elizabeth Olsen, Xochitl Gomez, Chiwetel Ejiofor, Rachel McAdams, Benedict Wong, Michael Stuhlbarg, Sheila Atim, Adam Hugill.',
'https://i.pinimg.com/564x/e4/83/c9/e483c938f5c1ac337ea1723d4a2c6077.jpg',126,
'Viaja a lo desconocido con el Doctor Strange, quien, con la ayuda de tanto antiguos como nuevos aliados místicos, recorre las complejas y peligrosas realidades alternativas del multiverso para enfrentarse a un nuevo y misterioso adversario.',
'Doctor Strange en el Multiverso de la Locura','https://www.youtube.com/embed/NOpzldCE7GY',2022),
(25,true,'Brad Pitt, Joey King, Aaron Taylor-Johnson, Brian Tyree Henry, Andrew Koji, Hiroyuki Sanada, Michael Shannon, Logan Lerman.',
'https://i.pinimg.com/564x/f1/b8/04/f1b8042c4257e9828f87a2c3d781d432.jpg',126,
'Cinco asesinos a sueldo se encuentran a bordo de un tren bala que viaja de Tokio a Morioka con unas pocas paradas intermedias. Descubren que sus misiones no son ajenas entre sí. La pregunta es quién saldrá vivo del tren y qué les espera en la estación final.',
'Bullet Train','https://www.youtube.com/embed/C1rWd1iQfd0',2022),
(26,true,'Tom Holland, Mark Wahlberg, Sophia Ali, Antonio Banderas, Tati Gabrielle, Steven Waddington, Patricia Meeden, Sarah Petrick.',
'https://i.pinimg.com/564x/14/df/f0/14dff03d8050c07b5a1aeca560626d67.jpg',115,
'Basada en una de las series de videojuegos más vendidas y aclamadas por la crítica de todos los tiempos, "Uncharted" presenta a un joven, astuto y carismático, Nathan Drake (Tom Holland) en su primera aventura como cazatesoros con su ingenioso compañero Victor “Sully” Sullivan (Mark Wahlberg).',
'Uncharted','https://www.youtube.com/embed/t_uYnyHWOsY',2022),
(27,true,'Pixar Animation Studios, Walt Disney Pictures.',
'https://i.pinimg.com/564x/58/2f/58/582f5820051ffb9d98e2b06d865b5e02.jpg',100,
'La historia del origen de Buzz Lightyear, el héroe que inspiró el juguete, y que nos da a conocer al legendario Guardián Espacial que acabaría contando con generaciones de fans.',
'Lightyear','https://www.youtube.com/embed/qGAvNA7xkss',2022),
(28,true,'Daisy Ridley, John Boyega, Harrison Ford, Adam Driver, Oscar Isaac, Carrie Fisher, Peter Mayhew, Domhnall Gleeson, Max von Sydowo.',
'https://i.pinimg.com/564x/3b/22/37/3b223779abd81c534cd14fbd3694f503.jpg',175,
'Treinta años después de la victoria de la Alianza Rebelde sobre la segunda Estrella de la Muerte, la galaxia está todavía en guerra. Una nueva República se ha constituido, pero una siniestra organización, la Primera Orden, ha resurgido de las cenizas del Imperio Galáctico. A los héroes de antaño, que luchan ahora en la Resistencia, se suman nuevos héroes.',
'Star Wars: El despertar de la Fuerza','https://www.youtube.com/embed/V8qlIZsutAQ',2015),
(29,true,'Jessica Chastain, James McAvoy, Isaiah Mustafa, James Ransone, Bill Skarsgård, Jay Ryan, Bill Hader, Andy Bean, Xavier Dolan, Will Beinbrink.',
'https://i.pinimg.com/564x/6d/34/98/6d349803f049b437c6130c0f1fe3a585.jpg',169,
'Han pasado casi 30 años desde que el "Club de los Perdedores", formado por Bill, Berverly, Richie, Ben, Eddie, Mike y Stanley, se enfrentaran al macabro y despiadado Pennywise (Bill Skarsgård). En cuanto tuvieron oportunidad, abandonaron el pueblo de Derry, en el estado de Maine, que tantos problemas les había ocasionado. Sin embargo, ahora, siendo adultos, parece que no pueden escapar de su pasado.',
'It. Capítulo 2','https://www.youtube.com/embed/nN1CqQgWFCM',2019),
(30,true,'Matthew McConaughey, Anne Hathaway, David Gyasi, Jessica Chastain, Mackenzie Foy, Matt Damon, Michael Caine, John Lithgow.',
'https://i.pinimg.com/564x/0b/9a/7a/0b9a7a677aaf10e3179fdac1436edd65.jpg',169,
'Al ver que la vida en la Tierra está llegando a su fin, un grupo de exploradores dirigidos por el piloto Cooper (McConaughey) y la científica Amelia (Hathaway) emprende una misión que puede ser la más importante de la historia de la humanidad: viajar más allá de nuestra galaxia para descubrir algún planeta en otra que pueda garantizar el futuro de la raza humana.',
'Interstellar','https://www.youtube.com/embed/UoSSbmD9vqc',2014),
(31,true,'Song Kang-ho, Lee Seon-gyun, Jang Hye-jin, Cho Yeo-jeong, Choi Woo-sik, Park So-dam, Park Seo-joon, Lee Jeong-eun.',
'https://i.pinimg.com/564x/06/d3/17/06d317438b3a60e50693823193f95046.jpg',132,
'Tanto Gi Taek (Song Kang-ho) como su familia están sin trabajo. Cuando su hijo mayor, Gi Woo (Choi Woo-sik), empieza a dar clases particulares en casa de Park (Lee Seon-gyun), las dos familias, que tienen mucho en común pese a pertenecer a dos mundos totalmente distintos, comienzan una interrelación de resultados imprevisibles. ',
'Parásitos','https://www.youtube.com/embed/Z7SiFLgoFQM',2019),
(32,true,'Natalie Portman, Mila Kunis, Vincent Cassel, Winona Ryder, Barbara Hershey, Tina Sloan, Christopher Gartin, Sebastian Stan, Benjamin Millepied.',
'https://i.pinimg.com/564x/b9/1c/2e/b91c2ed177c8887a2de63408bacd18db.jpg',109,
'Nina (Natalie Portman), una brillante bailarina que forma parte de una compañía de ballet de Nueva York, vive completamente absorbida por la danza. La presión de su controladora madre (Barbara Hershey), la rivalidad con su compañera Lily (Mila Kunis) y las exigencias del severo director (Vincent Cassel) se irán incrementando a medida que se acerca el día del estreno. ',
'Cisne negro','https://www.youtube.com/embed/uPnB_Bjh5fo',2019),
(33, true, 'Miki Esparbé, Aura Garrido, Luis Callejo, Álvaro Cervantes, Manel Llunell, Jesús Carroza, María Botto, Dafnis Balduz',
'https://i.pinimg.com/originals/52/79/cd/5279cd3b5cbfe1ba69e120c75c894f72.jpg', 101,
'Malnazidos',101,2022,'En plena guerra civil española, unos enemigos acérrimos se ven obligados a luchar codo con codo contra los zombis caníbales creados en un experimento nazi.'
'Malnazidos', 'https://www.youtube.com/embed/MGnCUnJVse4',2022),
(34, true, 'Julio Bohigas-Couto, Carmen Ruiz, Joaquín Reyes, Milene Mayer, Jorge Usón, Toni Acosta, Norma Ruíz',
'https://i.pinimg.com/564x/d7/b2/ee/d7b2eeb8e218795441744681c90b5909.jpg','95', 'Los jugadores de un equipo de fútbol juvenil deben averiguar por qué pierden continuamente. Si siguen así, el cole cancelará el equipo y destinará los fondos a un coro.'
'Los Futbolísimos', 'https://www.youtube.com/embed/F5d6P6yCOSw', '2018'),

(35, true, 'Dwayne Johnson, Gal Gadot, Ryan Reynolds, Ritu Arya, Chris Diamantopoulos, Ivan Mbakop', 'https://i.pinimg.com/564x/e0/1b/b7/e01bb724df7fcfa22f1cc875fcbd95a0.jpg', 
'115', 'Un criminólogo del FBI y el ladrón de arte más buscado del mundo se hacen compinches para atrapar a una escurridiza 
estafadora que siempre va un paso por delante.','Alerta Roja', 'https://www.youtube.com/embed/wQZSGXUjdeo', '2021'),

(36, true, 'Ashley Judd, Jonah Hauer-King, Alexandra Shipp, John Cassini, Wes Studi, Edward James Olmos', 'https://i.pinimg.com/564x/cf/b0/ea/cfb0eabcf68814584ed09cef005740c2.jpg', 
'95', 'Una fiel perrita, que echa de menos su hogar, emprende un peligroso viaje por el corazón de los Estados Unidos para volver con su dueño.',
'Uno más de la familia', 'https://www.youtube.com/embed/CRhSIUFFRgU', '2019'),

(37, true, 'Kevin Hart, Woody Harrelson, Kaley Cuoco, Melanie Liburd, Ellen Barkin, Lela Loren, Pierson Fode', 'https://i.pinimg.com/564x/57/3b/dc/573bdc6951a0c5d0ad46f2ffd21010ef.jpg', 
'112', 'Un caso de identidad equivocada obliga a un empresario inepto a colaborar con el asesino conocido como el «Hombre de Toronto» para sobrevivir',
'El hombre de Toronto', 'https://www.youtube.com/embed/YKCquaZk_A8', '2022'),



(38, true, 'Tom Holland, Samuel L. Jackson, Jake Gyllenhaal, Marisa Tomei, Jon Favreau, Zendaya', 'https://i.pinimg.com/564x/83/9c/2b/839c2ba7b57703adea38fa79a6e9ba2a.jpg', 
'133', 'Peter Parker regresa a su vida cotidiana de estudiante. Pero la aparición de un villano le da la oportunidad de demostrar que es todo un superhéroe arácnido.',
'Spider-Man: Homecoming', 'https://www.youtube.com/embed/grusgXCahH8', '2017'),

(39, true, 'Adam Sandler, Michelle Monaghan, Peter Dinklage, Kevin James, Sean Bean, Josh Gad', 'https://i.pinimg.com/564x/e1/6f/f6/e16ff6f568a2d44b745b3e0bba77f6f0.jpg',
 '105', 'Cuando los extraterrestres invaden la Tierra como en un videojuego clásico, el presidente y sus amigos de infancia, antiguos reyes de los recreativos, entran en acción.',
 'Pixels', 'https://www.youtube.com/embed/FNDFd6GrK-A', '2015'),

(40, true, 
'Ryan Reynolds, Walker Scobell, Zoe Saldana, Catherine Keener, Jennifer Garner, Mark Ruffalo', 
'https://i.pinimg.com/564x/8b/aa/ad/8baaad9b1244b2b4abc560a86da821cb.jpg', 
'106', 
'Adam Reed es un piloto de caza que viaja en el tiempo. Cuando se estrella en el año 2022, conoce a su yo de 12 años y juntos emprenden una misión para salvar el futuro.',
'El proyecto Adam',
 'https://www.youtube.com/embed/ewrZh1kfDH0', 
 '2022'),
 
 (41, true, 
'Denzel Washington, Marton Csokas, Chloë Grace Moretz, David Harbour, Melissa Leo, Bill Pullman', 
'https://i.pinimg.com/564x/b5/17/bf/b517bf03419d1f728c921f8b449cccba.jpg', 
'128', 
'Robert McCall, un antiguo agente de la CIA que lleva ahora una vida tranquila, abandona su retiro para ayudar a Teri, una joven prostituta que está siendo explotada por la mafia rusa. A pesar de que aseguró no volver a ser violento, contemplar tanta crueldad despertará en Robert un implacable y renovado deseo de justicia.',
'The Equalizer',
 'https://www.youtube.com/embed/rlMaxFG7blg', 
 '2014'),
 
 
 
 (42, true, 
'Denzel Washington, Pedro Pascal, Bill Pullman, Melissa Leo, Ashton Sanders, Jonathan Scarfe', 
'https://i.pinimg.com/564x/84/1d/73/841d73e512f73a50c66888a5638eea66.jpg', 
'120', 
'Robert McCall, un exagente de la CIA convertido en justiciero, vuelve a hacer uso de sus habilidades letales para vengar la muerte de una excolega muy amiga suya.',
'The Equalizer 2',
 'https://www.youtube.com/embed/IibsmbB6PXQ', 
 '2018'),
 
 
 
 (43, true, 
'Millie Bobby Brown, Henry Cavill, Helena Bonham Carter, Sam Claflin, Burn Gorman', 
'https://i.pinimg.com/564x/f2/d4/d6/f2d4d64fea92b782d85a45c34a9d5bba.jpg', 
'123', 
'Enola Holmes, una intrépida joven que busca a su madre, utiliza su brillante instinto investigador para superar a su hermano Sherlock y ayudar a un lord en su fuga.',
'Enola Holmes',
 'https://www.youtube.com/embed/JlrAwZAVUr4', 
 '2020'),
 
 
 
 (44, true, 
'Roy Scheider, Robert Shaw, Richard Dreyfuss, Lorraine Gary, Murray Hamilton, Carl Gottlieb', 
'https://i.pinimg.com/564x/15/ce/6b/15ce6b2d50bb1fedb57367f430eb2a35.jpg', 
'124', 
'Cuando un insaciable gran tiburón blanco siembra el terror en Amity Island, un oceanógrafo y un curtido cazador de escualos se unen para acabar con la bestia.',
'Tiburón',
 'https://www.youtube.com/embed/ycuUsbLkOII', 
 '1975'),
 
 
 
 (45, true, 
'Shia LaBeouf, Megan Fox, Josh Duhamel, Tyrese Gibson, Jon Voight, John Turturro, Bernie Mac', 
'https://i.pinimg.com/564x/ef/14/e8/ef14e87280802f40647ca897ef99aff0.jpg', 
'144', 
'Los Autobots y los Decepticons luchan por hacerse con los recursos de la Tierra, y Sam Witwicky no sabe que él es la única esperanza de supervivencia para la raza humana.',
'Transformers',
 'https://www.youtube.com/embed/B_CzSjhOGzM', 
 '2007'),
 
 
 
 (46, true, 
'Shia LaBeouf, Rosie Huntington-Whiteley, John Malkovich, Josh Duhamel, Patrick Dempsey', 
'https://i.pinimg.com/564x/53/14/92/5314927868f66094dd8588b0b1646be0.jpg', 
'155', 
'Cuando Optimus Prime se entera de que una nave de Transformers ha caído en la luna, se pone al mando de una misión para rescatar al piloto, su mentor, Sentinel Prime',
'Transformers: El lado oscuro de la luna',
 'https://www.youtube.com/embed/UD9qER2sZGc', 
 '2011'),
 
 
 
 (47, true, 
'Ryan Gosling, Harrison Ford, Ana de Armas, Jared Leto, Sylvia Hoeks, Robin Wright', 
'https://i.pinimg.com/564x/6c/98/c3/6c98c3d9aea4f2d0a74a2828b0817d5a.jpg', 
'163', 
'Los contenidos de una tumba atraen la atención de un magnate y obligan al agente K, un blade runner de la Policía de Los Ángeles, a seguir la pista de una leyenda.',
'Blade Runner 2049',
 'https://www.youtube.com/embed/BkBM0gL3s2M', 
 '2017'),
 
 
 
 (48, true, 
'Michael Fassbender, Marion Cotillard, Jeremy Irons, Charlotte Rampling, Brendan Gleeson', 
'https://i.pinimg.com/564x/ae/08/d4/ae08d45f3ff2c2193904f9822da9ab8d.jpg', 
'115', 
'En esta adaptación de la aclamada franquicia de videojuegos, una misteriosa organización rescata a un hombre condenado a muerte.',
'Assassins Creed',
 'https://www.youtube.com/embed/uNOnq5YaNxg', 
 '2016'),
 
 
 
 (49, true, 
'Ryôsuke Yamada, Tsubasa Honda, Dean Fujioka, Fumiyo Kohinata, Ryûta Satô, Misako Renbutsu', 
'https://i.pinimg.com/564x/b1/9f/e0/b19fe097f92f6af27535c22d3d74a383.jpg', 
'133', 
'El alquimista Edward Elric busca la manera de devolverle el cuerpo a su hermano Al. Pero tanto los militares como unos misteriosos monstruos le vigilan atentamente.',
'FullMetal Alchemist',
 'https://www.youtube.com/embed/8RFwGe94rzw', 
 '2017'),
 
 
 
 (50, true, 
'Karl Urban, Jared Harris, Dan Stevens, Marianne Jean-Baptiste, Jum Carter, Kathy Burke, Doon Mackichan, Shannon Chan-Kent', 
'https://i.pinimg.com/736x/31/73/fa/3173faac31ae5c1c0dd1f108e5507876.jpg', 
'115', 
'Una joven polizona se cuela en el navío de un cazador legendario de monstruos marinos y juntos emprenden un viaje épico por mares inexplorados. Y hacen historia.',
'El monstruo marino',
 'https://www.youtube.com/embed/Ol2XYzaJrOo', 
 '2022'),
 
 
 (51, true, 
'Demi Lovato, Kelly Asbury, Mandy Patinkin, Julia Roberts, Danny Pudi, Meghan Trainor', 
'https://i.pinimg.com/564x/3a/0f/85/3a0f85fe042774005c961d4c031b3fe4.jpg', 
'89', 
'Pitufina se adentra en el Bosque Prohibido con sus grandes amigos Filósofo, Torpe y Fortachón para librar a una misteriosa aldea de las garras del malvado mago Gárgamel.',
'Los pitufos: La aldea escondida',
 'https://www.youtube.com/embed/jlkeR7ocvNw', 
 '2017'),
 
 
 
  (52, true, 
'Felix Auer, Natalie Dormer, Patrick Roche, Eddie Marsan,  Stephen Mangan, Teresa Gallagher, Bryan Larkin', 
'https://i.pinimg.com/564x/1c/10/fd/1c10fdbc5a60c37c7da7fbc3dd6ff5ad.jpg', 
'89', 
'Un perro callejero y una gata mimada lideran a unos peculiares héroes dispuestos a liberar la ciudad de las garras del malvado alcalde y su ejército de robots.',
'Mascotas unidas',
 'https://www.youtube.com/embed/y96BsYbJ5fU', 
 '2019'),
 
  (53, true, 
'Robin Williams, Kirsten Dunst, David Alan Grier, Bonnie Hunt, Jonathan Hyde, Bradley Pierce', 
'https://i.pinimg.com/564x/d7/ac/cc/d7accc849aea36f38c6424396d0e2c83.jpg', 
'104', 
'Dos hermanos descubren un juego de mesa encantado que abre una puerta a un mundo mágico y, sin saberlo, liberan a un hombre que ha estado atrapado dentro durante años',
'Jumanji',
'https://www.youtube.com/embed/KcgsDnt3CIw', 
 '1995'),
 
  (54, true, 
'Dwayne Johnson, Jack Black, Kevin Hart, Karen Gillan, Nick Jonas, Alex Wolff, Bobby Cannavale, Madison Iseman', 
'https://i.pinimg.com/564x/d2/c1/02/d2c102478790175c5a090a2a2232e6a3.jpg', 
'119', 
'Cuatro adolescentes son absorbidos por un videojuego, en el que se convierten en avatares de personajes arquetípicos. Allí vivirán múltiples aventuras, al tiempo que buscan cómo salir de allí para volver a su mundo.',
'Jumanji: Bienvenidos a la jungla',
 'https://www.youtube.com/embed/leIrosWRbYQ', 
 '2017'),
 
  (55, true, 
'Eddie Redmayne, Dan Fogler, Katherine Waterston, Alison Sudol, Colin Farrell, Carmen Ejogo, Ezra Miller', 
'https://i.pinimg.com/564x/39/1d/5c/391d5c3839017edb4da724053e0199d1.jpg', 
'133', 
'Año 1926. Newt Scamander acaba de completar un viaje por todo el mundo para encontrar y documentar una extraordinaria selección de criaturas mágicas. Llegando a Nueva York para hacer una breve parada en su camino, donde podría haber llegado y salido sin incidentes… pero no para un Muggle llamado Jacob, un caso perdido de magia, y la fuga de algunas criaturas fantásticas de Newt, que podrían causar problemas el mundo mágico y en el mundo Muggle.',
'Animales fantásticos y dónde encontrarlos',
 'https://www.youtube.com/embed/W45vhTxKeQE', 
 '2016'),
 
  (56, true, 
'Mads Mikkelsen, Jude Law, Eddie Redmayne, Ezra Miller, Katherine Waterston, Alison Sudol, Dan Fogler', 
'https://i.pinimg.com/564x/35/f5/c9/35f5c950fb0349f3f468466911240011.jpg', 
'142', 
'El profesor Albus Dumbledore (Jude Law) sabe que el poderoso mago oscuro Gellert Grindelwald (Mads Mikkelsen) está haciendo planes para apoderarse del mundo mágico. Incapaz de detenerlo él solo, confía en el Magizoólogo Newt Scamander (Eddie Redmayne) para dirigir un intrépido equipo de magos, brujas y un valiente panadero Muggle en una misión peligrosa, donde se encuentran con antiguos y nuevos animales y se enfrentan a una legión cada vez más numerosa de seguidores de Grindelwald. Hay mucho en juego así que nos preguntamos hasta cuándo podrá permanecer Dumbledore al margen.',
'Animales fantásticos: Los secretos de Dumbledore',
 'trailer', 
 '2022'),
 
  (57, true, 
'Robert Pattinson, Zöe Kravitz, Jeffrey Wright, John Turturro, Paul Dano, Colin Farrell, Andy Serkis', 
'https://i.pinimg.com/564x/04/42/cf/0442cf0bbf2e4962472ea1c242d5bcbe.jpg', 
'176', 
'Después de dos años acechando por las calles de la ciudad como Batman (Robert Pattinson), e infundiendo miedo en las mentes perversas de los criminales, Bruce Wayne está sumido en las profundidades de las sombras de Gotham City. Este vigilante solitario cuenta con pocos aliados de confianza y eso le ha llevado a convertirse en la única encarnación de la venganza entre sus conciudadanos. Cuando un asesino apunta a la élite de Gotham con una serie de maquinaciones sádicas, un rastro de pistas crípticas lleva a Batman a realizar una investigación en el inframundo.',
'The Batman',
 'https://www.youtube.com/embed/gRdF4mbJ4Vo', 
 '2022'),
 
  (58, true, 
'Tom Cruise, Andrea Riseborough, Olga Kurylenko, Morgan Freeman, Nikolaj Coster-Waldau', 
'https://i.pinimg.com/736x/52/38/51/523851614d78ef6848c07c7cef86ad60.jpg', 
'119', 
'Año 2073. Hace más de 60 años la Tierra fue atacada; se ganó la guerra, pero la mitad del planeta quedó destruido, y todos los seres humanos fueron evacuados. Jack Harper (Tom Cruise), un antiguo marine, es uno de los últimos hombres que la habitan. Es un ingeniero de Drones que participa en una operación para extraer los recursos vitales del planeta. Su misión consiste en patrullar diariamente los cielos. Un día, rescata a una desconocida de una nave espacial y, entonces, se ve obligado a replantearse sus convicciones más profundas.',
'Oblivion',
 'https://www.youtube.com/embed/Pt7TGR8wwdw', 
 '2013'),
 
  (59, true, 
'Fionn Whitehead, Mark Rylance, Kenneth Branagh, Tom Hardy, Cillian Murphy, Barry Keoghan', 
'https://i.pinimg.com/564x/5a/5f/6f/5a5f6f1e7586a9a95ddce5b12a514d5e.jpg', 
'102', 
'Año 1940, en plena 2ª Guerra Mundial. En las playas de Dunkerque, cientos de miles de soldados de las tropas británicas y francesas se encuentran rodeados por el avance del ejército alemán, que ha invadido Francia. Atrapados en la playa, con el mar cortándoles el paso, las tropas se enfrentan a una situación angustiosa que empeora a medida que el enemigo se acerca.',
'Dunkerque',
 'https://www.youtube.com/embed/DsRcqwGOmUU', 
 '2017'),
 
 
  (60, true, 
'Brad Pitt, Marion Cotillard, Jared Harris, Daniel Betts, Lizzy Caplan, August Diehl, Simon McBurney', 
'https://i.pinimg.com/564x/98/2e/67/982e67c2490079738ff3280b2508b793.jpg', 
'119', 
'Año 1942 en el protectorado francés de Marruecos, durante la Segunda Guerra Mundial. Max (Brad Pitt) es un espía canadiense del bando aliado que llega a Casablanca y se hace pasar por marido de Marianne (Marion Cotillard), una francesa miembro de la resistencia con buenas relaciones con el régimen de Vichy. Ambos deberán cumplir una peligrosa misión en el norte de África por órdenes de Londres.',
'Aliados',
 'https://www.youtube.com/embed/FHT8k84yYNc', 
 '2016'),
 
 
  (61, true, 
'Tom Hanks, Felicity Jones, Ben Foster, Irrfan Khan, Omar Sy, Sidse Babett Knudsen', 
'https://i.pinimg.com/564x/d0/21/74/d0217405f57122f97679fc232881469b.jpg', 
'116', 
'Robert Langdon, el famoso profesor de simbología (nuevamente interpretado por Tom Hanks) se encuentra tras el rastro de una serie de pistas conectadas con el mismísimo Dante. Cuando Langdon despierta con amnesia en un hospital italiano, hará equipo con Sienna Brooks (Felicity Jones), una doctora de la que él espera le ayude a recuperar sus recuerdos. Juntos recorrerán Europa en una carrera a contrarreloj para desbaratar una letal conspiración global. Adaptación del best-seller homónimo de Dan Brown.',
'Inferno',
 'https://www.youtube.com/embed/-_9ML-xA1Co', 
 '2016'),
 
 
  (62, true, 
'Will Smith, Aunjanue Ellis, Jon Bernthal, Saniyya Sidney, Demi Singleton, Tony Goldwyn', 
'https://i.pinimg.com/564x/6e/00/d0/6e00d00a03619b9c02185bb14d05bed4.jpg', 
'144', 
'Biopic sobre Richard Williams, un padre inasequible que ayudó a formar a dos de las deportistas más extraordinarias de todos los tiempos, dos atletas que acabarían marcando época en el deporte del tenis. Richard tenía una visión muy clara del futuro de sus hijas, y sirviéndose de métodos arriesgados y poco convencionales, elaboró un plan que llevaría a Venus y Serena Williams de las calles de Compton, California, al olimpo del deporte, convirtiéndolas en iconos del tenis.',
'El método Williams',
 'https://www.youtube.com/embed/NHvWx5kp8js', 
 '2021'),
 
 
 
  (63, true, 
'Chris Hemsworth, Benjamin Walker, Cillian Murphy, Tom Holland, Ben Whishaw, Brendan Gleeson', 
'https://i.pinimg.com/564x/f5/53/4b/f5534b75f594e76c91dc634fe05b9d15.jpg', 
'116', 
'En el invierno de 1820, Owen Chase (Hemsworth) y otros marineros de la tripulación del Essex sobrevivieron en alta mar en durísimas condiciones después de que el barco chocara con una enorme ballena blanca. Owen, obsesionado con la idea de dar caza al cetáceo, se enfrentó a las tormentas, al hambre y a la desesperación. Inspirada en la historia real en la que se basó Herman Melville para escribir el famoso relato 'Moby Dick'.',
'En el corazón del mar',
 'https://www.youtube.com/embed/iS13XWZUbg8', 
 '2015'),
 
 
  (64, true, 
'Nicolas Cage, Ryan Reynolds, Emma Stone, Chris Sanders, Catherine Keener, Cloris Leachman', 
'https://i.pinimg.com/564x/91/97/73/9197731e474b50f0dbbd6a0d57a43d36.jpg', 
'90', 
'Prehistoria. Tras la destrucción de su hogar por un gran terremoto, Grug se ve obligado a emigrar con su familia. Mientras avanzan por un mundo desconocido y aterrador, se encuentran con un nómada de mente abierta que los deja a todos fascinados, sobre todo a la hija de Grug.',
'Los Croods. Una aventura prehistórica',
 'https://www.youtube.com/embed/h-woGn1FCM0', 
 '2013'),
 
 
  (65, true, 
'Mike Myers, Eddie Murphy, Cameron Diaz, Chris Miller, Conrad Vernon, John Lithgow', 
'https://i.pinimg.com/564x/82/58/d5/8258d5d80e06df3581b603530e17e7de.jpg', 
'86', 
'Hace mucho tiempo, en una lejanísima ciénaga, vivía un feroz ogro llamado Shrek. De repente, un día, su soledad se ve interrumpida por una invasión de sorprendentes personajes. Hay ratoncitos ciegos en su comida, un enorme y malísimo lobo en su cama, tres cerditos sin hogar y otros seres que han sido deportados de su tierra por el malvado Lord Farquaad. Para salvar su territorio, Shrek hace un pacto con Farquaad y emprende viaje para conseguir que la bella princesa Fiona acceda a ser la novia del Lord. En tan importante misión le acompaña un divertido burro, dispuesto a hacer cualquier cosa por Shrek: todo, menos guardar silencio.',
'Shrek',
 'https://www.youtube.com/embed/qhFPeFv4znA', 
 '2001'),
 
 
 
  (66, true, 
'Leonardo DiCaprio, Brad Pitt, Margot Robbie, Emile Hirsch, Margaret Qualley, Al Pacino, Kurt Russell', 
'https://i.pinimg.com/564x/bf/3a/a9/bf3aa961ff9fa283e818213611ec1f99.jpg', 
'165', 
'Hollywood, años 60. La estrella de un western televisivo, Rick Dalton (DiCaprio), intenta amoldarse a los cambios del medio al mismo tiempo que su doble (Pitt). La vida de Dalton está ligada completamente a Hollywood, y es vecino de la joven y prometedora actriz y modelo Sharon Tate (Robbie) que acaba de casarse con el prestigioso director Roman Polanski. ',
'Érase una vez en... Hollywood',
 'https://www.youtube.com/embed/J0rFGJV3cYw', 
 '2019'),
 
 
  (67, true, 
'George Clooney, Mark Wahlberg, Ice Cube, Spike Jonze, Nora Dunn, Jamie Kennedy', 
'https://i.pinimg.com/564x/7d/dd/7f/7ddd7fcdbe259f19252156c5f37e5ccd.jpg', 
'115', 
'En marzo de 1991, el capitán Archie Gates, los sargentos Troy Barlow y Chief Elgin y el soldado Conrad Vig matan el tiempo en el desierto iraquí mientras aguardan el fin de la guerra y la vuelta a la aburrida y desesperanzada vida civil. Pero la monotonía se rompe cuando descubren un mapa que indica el lugar donde se encuentra una reserva de oro kuwaití robada por los iraquíes. Inmediatamente, los cuatro deciden buscar el tesoro. Pero, mientras lo hacen, van descubriendo cuáles son las condiciones de vida del pueblo iraquí y, a partir de entonces, la búsqueda del tesoro se convertirá en una historia de redención que los cambiará profundamente y pondrá a prueba su humanidad. ',
'Tres reyes',
 'https://www.youtube.com/embed/96bnzCOEh6U', 
 '1999'),
 
 
  (68, true, 
'Joaquin Phoenix, Robert De Niro, Zazie Beetz, Frances Conroy, Brett Cullen, Bill Camp', 
'https://i.pinimg.com/564x/a1/70/54/a17054ba876b0069d2002d8c8d308915.jpg', 
'121', 
'Arthur Fleck (Phoenix) vive en Gotham con su madre, y su única motivación en la vida es hacer reír a la gente. Actúa haciendo de payaso en pequeños trabajos, pero tiene problemas mentales que hacen que la gente le vea como un bicho raro. Su gran sueño es actuar como cómico delante del público, pero una serie de trágicos acontecimientos le hará ir incrementando su ira contra una sociedad que le ignora.',
'Joker',
 'https://www.youtube.com/embed/ECtK_IR4j5I', 
 '2019'),
 
 
  (69, true, 
'Leo Harlem, Alejandro Serrano, Toni Acosta, Maggie Civantos, Jordi Sánchez, Isabel Ordaz, Stephanie Gil', 
'https://i.pinimg.com/564x/ad/49/8c/ad498c6ee482e28860fa27706e1cc931.jpg', 
'90', 
'Curro es un fantasioso vendedor de robots de cocina que sueña con un trabajo en el mundo financiero. En plena crisis de pareja, y con fuertes deudas, hace una promesa que no puede cumplir: si su hijo Nico, de 9 años, saca todo sobresalientes, le llevará a unas vacaciones de verano inolvidables. El niño lo consigue y padre e hijo emprenden un viaje que les llevará a conocer gente y vivir situaciones que jamás hubiesen imaginado. ',
'El mejor verano de mi vida',
 'https://www.youtube.com/embed/IZn--VYwhR0" title="YouTube video player', 
 '2018'),
 
 
  (70, true, 
'Matthew McConaughey, Anne Hathaway, David Gyasi, Jessica Chastain, Mackenzie Foy', 
'https://i.pinimg.com/564x/0b/9a/7a/0b9a7a677aaf10e3179fdac1436edd65.jpg', 
'169', 
'Al ver que la vida en la Tierra está llegando a su fin, un grupo de exploradores dirigidos por el piloto Cooper (McConaughey) y la científica Amelia (Hathaway) emprende una misión que puede ser la más importante de la historia de la humanidad: viajar más allá de nuestra galaxia para descubrir algún planeta en otra que pueda garantizar el futuro de la raza humana.',
'Interstellar',
 'https://www.youtube.com/embed/hhCtMhk8eHo', 
 '2014'),
 
 
  (71, true, 
'Taissa Farmiga, Demian Bichir, Jonas Bloquet, Bonnie Aarons, Charlotte Hope, Ingrid Bisu', 
'https://i.pinimg.com/564x/c6/38/53/c63853ed38e6f5688c1b3f4dc72acd1a.jpg', 
'96', 
'Cuando una joven monja se suicida en una abadía de clausura en Rumanía, un sacerdote experto en posesiones demoniacas y una novicia a punto de tomar sus votos, son enviados por el Vaticano para investigar. Juntos descubren el profano secreto de la orden. Arriesgando no solo sus propias vidas sino su fe y hasta sus almas, se enfrentan a una fuerza maléfica en forma de monja demoníaca, en una abadía que se convierte en un campo de batalla de horror entre los vivos y los condenados.',
'La Monja',
 'https://www.youtube.com/embed/AKpPeLAMY9I', 
 '2018'),
 
 
  (72, true, 
'Robin Williams, Elijah Wood, Brittany Murphy, Elizabeth Daily, Hugh Jackman, Nicole Kidman', 
'https://i.pinimg.com/564x/15/f6/f6/15f6f6dab939a1b553a57e6f9606a5cf.jpg', 
'108', 
'Comedia familiar que narra la historia de unos pingüinos en la Antártida. Para atraer a su pareja los pingüinos deben entonar una canción, pero uno de ellos no sabe cantar, pero es un gran bailarín de claqué.',
'Happy Feet',
 'https://www.youtube.com/embed/E4Bf-zf7Y40', 
 '2006'),
 
 
  (73, true, 
'Tom Hiddleston, Brie Larson, Samuel L. Jackson, John C. Reilly, John Goodman, Corey Hawkins', 
'https://i.pinimg.com/564x/ff/06/c6/ff06c61795a2bffdacf7d4829b650524.jpg', 
'120', 
'En los años 70, un variopinto grupo de exploradores y soldados es reclutado para viajar a una misteriosa isla del Pacífico. Entre ellos están el capitán James Conrad (Tom Hiddleston), el teniente coronel Packard (Samuel L. Jackson) y una fotoperiodista (Brie Larson). Pero al adentrarse en esta bella pero traicionera isla, los exploradores encontrarán algo absolutamente sorprendente. Sin saberlo, estarán invadiendo los dominios del mítico Kong, el gorila gigante rey de esta isla. Será Marlow (John C. Reilly), un peculiar habitante del lugar, quien les enseñe los secretos de Isla Calavera, además del resto de seres monstruosos que la habitan.',
'Kong: La Isla Calavera',
 'https://www.youtube.com/embed/8wP_3OO3Res', 
 '2017'),
 
 
  (74, true, 
'Zöe Kravitz, Erika Christensen, Emily Kuroda, Jaime Camil, India de Beaufort, Devin Ratray, Jacob Vargas', 
'https://i.pinimg.com/564x/49/21/56/492156b48f52c7bc9589d4114a8c078d.jpg', 
'89', 
'Una empleada de una empresa tecnológica que sufre agorafobia descubre un crimen e intenta alertar a sus superiores. ',
'Kimi',
 'https://www.youtube.com/embed/AXfFtcdtFtQ', 
 '2022');
INSERT INTO `genres` (`id`,`title`) 
values
(1, 'Acción'),
(2, 'Comedia'),
(3, 'Familiar'),
(4, 'Ciencia Ficción'),
(5, 'Aventura'),
(6, 'Suspense'),
(7, 'Drama'),
(8, 'Fantasía'),
(9, 'Bélico'),
(10, 'Terror'),
(11, 'Infantil');

INSERT INTO `genres_films` (`genres_id`,`films_id`) 
values
(1,1),
(2,2),
(1,3),
(3,4),
(1,5),
(4,6),
(2,7),
(4,8),
(1,9),
(5,10),
(6,11),
(2,12),
(4,13),
(4,14),
(1,15),
(7,16),
(5,17),
(3,18),
(3,19),
(5,20),
(8,21),
(6,22),
(8,23),
(4,24),
(9,25),
(9,26),
(6,27),
(7,28),
(5,29),
(3,30),
(3,31),
(7,32);


