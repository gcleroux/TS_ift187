/* ########################################################################
 un script SQL d’insertions de données de test positives
 ####################################################################### */

/* ####################################################################
 Liste des modifications a faire dans le doc

DONE   - Modifier les insertions de genres pour enlever les accents
DONE   - Refaire les insertions de PRIX. Elles ne suivent pas les restrictions sur la categorie
   - Verifier la validite de toutes les requetes, notamment la relation entre doublages et participation ne fonctionne pas avec les insertions actuelles
DONE   - Ajouter les insertions requises pour pouvoir faires les exemples de selection
DONE   - Ajouter plus d'insertions dans certaines tables
   - Refaire la mise en page pour separer les insertions et les delimiter


   **ASSUREZ VOUS QUE VOUS ENTREZ BIEN LES BONS TYPES DANS VOS INSERTIONS! BEAUCOUP DE INT ETAIT ENTRES COMME DES VARCHAR!**
   **SI VOUS AJOUTEZ DE NOUVELLES DONNÉES, AJOUTEZ LES À LA FIN D'UNE LISTE SINON ÇA DÉTRUIT TOUTES LES BIGSERIAL**

 #################################################################### */


/**
 * Emplois
 */
INSERT INTO Emplois(emploi) VALUES
 ('Producteur'),
 ('Assistant producteur'),
 ('Scenariste'),
 ('Realisateur'),
 ('Assistant realisateur'), --#5
 ('Acteur'),
 ('Monteur'),
 ('Cameraman'),
 ('Preneur de son'),
 ('Chef décorateur'), --#10
 ('Maquilleur'),
 ('Costumier'),
 ('Directeur technique'),
 ('Cascadeur'),
 ('Auteur de doublage'), --#15
 ('Auteur de sous-titrage'),
 ('Doubleur'),
 ('Compositeur');


/**
 * Genre
 */
INSERT INTO Genres(id_genre) VALUES
 ('Action'),
 ('Animation'),
 ('Aventure'),
 ('Catastrophe'),
 ('Comedie'),
 ('Comedie dramatique'),
 ('Comedie musicale'),
 ('Comedie policiere'),
 ('Comedie romantique'),
 ('Court metrage'),
 ('Dessin anime'),
 ('Documentaire'),
 ('Drame'),
 ('Drame psychologique'),
 ('Epouvante'),
 ('Erotique'),
 ('Espionnage'),
 ('Fantastique'),
 ('Film musical'),
 ('Guerre'),
 ('Historique'),
 ('Horreur'),
 ('Karate'),
 ('Manga'),
 ('Melodrame'),
 ('Muet'),
 ('Policier'),
 ('Politique'),
 ('Romance'),
 ('Science-fiction'),
 ('Spectacle'),
 ('Telefilm'),
 ('Theatre'),
 ('Thriller'),
 ('Western'),
 ('Autre');


/**
 * Studios de productions
 */
INSERT INTO Studios_Productions(nom_studio, localisation) VALUES
 ('LGM Productions', 'FR'),
 ('Gaumont', 'FR'),
 ('Walt Disney Pictures', 'US'),
 ('Walt Disney Animation', 'US'),
 ('Malposo Productions', 'US'),         --#5
 ('Village Roadshow Pictures', 'US'),
 ('Cinecitta', 'IT'),
 ('Pathé Consortium Cinéma', 'FR'),
 ('Universal', 'US'),
 ('United Artists', 'US'),          --#10
 ('Pathe', 'FR'),
 ('Loews Incorporated', 'US'),
 ('Warner Bros. Pictures', 'US'),
 ('Paramount Pictures', 'US'),
 ('20th Century Fox Film Corporation', 'US'),   --#15
 ('RKO Radio Pictures', 'US'),
 ('Columbia Pictures', 'US'),
 ('Metro-Goldwyn-Mayer', 'US'),
 ('New Line Cinema', 'US'),
 ('Miramax Films', 'US'),   --#20
 ('Lionsgate Films', 'US'),
 ('Touchstone Pictures', 'US'),
 ('Marvel Entertainment Group', 'US'),
 ('Regency Enterprises', 'US'),
 ('Alcon Entertainment', 'US'),   --#25
 ('DMG Entertainment', 'US'),
 ('DC Comics', 'US'),
 ('Syncopy', 'US'),
 ('River Road Entertainment', 'US'),
 ('Cine-Produzioni Associate', 'IT'),   --#30
 ('Barunson E&A', 'KR'),
 ('Fuji Television', 'JP'),
 ('Park Ex Pictures', 'CA'),
 ('Les Productions La Fete', 'CA');


/**
 * Artisans
 */
 INSERT INTO Artisans (prenom, nom, sexe) VALUES
 ('Johnny', 'Depp', 'M'),
 ('Orlando','Bloom','M'),
 ('Keira','Nightley', 'F'),
 ('Jack','Davenport', 'M'),
 ('Sean','Astin', 'M'), --#5
 ('Andy','Serkis', 'M'),
 ('Ian','McKellen', 'M'),
 ('Vigo','Mortensen', 'M'),
 ('Elijah','Wood', 'M'),
 ('Rebecca','Hall', 'F'), --#10
 ('Hugh','Jackman', 'M'),
 ('Christian','Bale', 'M'),
 ('Michael','Caine', 'M'),
 ('Patrick','Stewart', 'M'),
 ('Winona','Ryder', 'F'), --#15
 ('Cillian','Murphy', 'M'),
 ('Morgan','Freeman', 'M'),
 ('Heath','Ledger', 'M'),
 ('Jake','GyllenHaal', 'M'),
 ('David','Tomlinson', 'M'), --#20
 ('John','Wayne', 'M'),
 ('Gregory','Peck', 'M'),
 ('Robert','Conrad', 'M'),
 ('Louis','de Funes', 'M'),
 ('Charlie','Chaplin', 'M'), --#25
 ('Cary','Grant', 'M'),
 ('Ryan','Gosling', 'M'),
 ('Shahrukh','Khan', 'M'),
 ('Errol','Flynn', 'M'),
 ('Kirk','Douglas', 'M'), --#30
 ('Roger','Ebert', 'M'),
 ('Alexandre', 'Gillet', 'M'),
 ('Sergio', 'Leone', 'M'),
 ('Gilbert', 'Lachance', 'M'),
 ('Ingrid', 'Bergman', 'F'), --#35
 ('Marcello', 'Mastroianni', 'M'),
 ('Pascal', 'Imaginaire', 'M'),
 ('Joanne', 'Pas-Reel', 'F'),
 ('J. Gordon', 'Edwards', 'M'),
 ('Clint', 'Eastwood', 'M'), --#40
 ('Marc', 'Cassot', 'M'),
 ('Jean-Marie', 'Moncelet', 'M'),
 ('Jo','Critique','M'),
 ('Georgette', 'La-Lichette', 'F');


/*
 * Date de naissance
 */
INSERT INTO Date_naissances(id_artisan, date_naissance) VALUES
 (1, '1963-06-09'),
 (2, '1977-01-13'),
 (3, '1985-03-26'),
 (4, '1973-03-01'),
 (5, '1971-02-25'),
 (6, '1964-04-20'),
 (7, '1939-05-25'),
 (8, '1958-10-20'),
 (9, '1981-01-28'),
 (10, '1982-05-03'),
 (11, '1968-10-12'),
 (12, '1974-01-30'),
 (13, '1933-03-14'),
 (14, '1940-07-13'),
 (15, '1971-10-29'),
 (16, '1976-05-25'),
 (17, '1937-06-01'),
 (18, '1979-04-04'),
 (19, '1980-12-19'),
 (20, '1917-05-07'),
 (21, '1907-05-26'),
 (22, '1916-04-05'),
 (23, '1935-03-01'),
 (24, '1914-07-31'),
 (25, '1889-04-16'),
 (26, '1904-01-18'),
 (27, '1980-11-12'),
 (28, '1965-11-02'),
 (29, '1909-06-20'),
 (30, '1916-12-09');


/*
 * Date de décès
 */
INSERT INTO Date_deces(id_artisan, date_deces) VALUES
 (18, '2008-01-22'),
 (20, '2000-06-24'),
 (21, '1979-06-11'),
 (22, '2003-06-12'),
 (23, '2020-02-08'),
 (24, '1983-01-27'),
 (25, '1977-12-25'),
 (26, '1986-11-29'),
 (29, '1959-10-14'),
 (30, '2020-02-05');


/**
 * Films
 */
INSERT INTO Films(titre, annee_de_parution, duree, synopsis, budget) VALUES
  ('Pirates of the Caribbean: The Curse of the Black Pearl', 2003, 143, 'Le film se termine avec Jack regardant son compas et chantant A Pirate''s Life for Me.', 140000000),
  ('The Lord of The Rings: The FellowShip of the Ring', 2001, 178, 'La Communaute de l''anneau se dissout.', 93000000),
  ('The Prestige', 2006, 130, 'Le « prestige », titre du film donc, et étape finale de l''illusion, est la partie du tour de magie où l''imprévu se produit.' , 40000000),
  ('X-Men', 2000, 104, 'Wolverine se voit informé par le Professeur d''une piste possible vers son passé et quitte l''école après avoir promis à Malicia de revenir la voir, en profitant au passage pour voler la moto de Cyclope.', 75000000),
  ('Little Women', 1994, 115, 'Beth connaît quant à elle un destin plus tragique.', 15000000), --#05
  ('Edward Scissorhands', 1990, 105, 'Il provoque parfois des chutes de flocons de neige sur le quartier en travaillant sur ses sculptures de glace : ainsi, Kim sait qu''il est toujours en vie.', 20000000),
  ('Transcendence', 2014, 119, 'En regardant plus attentivement, il remarque que la goutte d''eau tombant d''un pétale de tournesol nettoie instantanément une flaque d''huile.', 100000000),
  ('The Dark Knight', 2008, 152, 'Gordon détruit le Bat-signal et une chasse au justicier s''ensuit.', 185000000),
  ('Prisoners', 2013, 153, 'Resté seul un soir dans la cour, l''inspecteur Loki perçoit un faible signal insistant, celui du sifflet d''alarme d''Anna.', 46000000),
  ('Brokeback Mountain', 2005, 134, 'Ils ne se retrouvent que quatre ans plus tard et vivent une histoire d''amour caché, ne se rencontrant qu''épisodiquement pendant quinze ans entre le Wyoming et le Texas, avant que Jack Twist ne soit tué dans des circonstances dramatiques, victime d''un crime homophobe, laissant Ennis seul avec ses souvenirs.', 14000000),
  ('The Colossus of Rhodes', 1961, 128, 'Un héro grecque du nom de Darios affronte le Colosse de Rhodes', 200000), --#11
  ('Joan of Arc', 1950, 145, 'A straightforward recounting of the life of the French heroine', 4650506),
  ('The Pizza Triangle', 1970, 107, 'The story of Adelaine the florist who dates Oreste', 9000000),
  ('La Reine des Cesars', 1917, 125, 'L''histoire de Cleopatre, reine d''Egypte, et la romance la liant  Jules César a et a Antoine.', 150000),
  ('Parasite', 2019, 132, 'The Kim family have low-paying temporary jobs as pizza box folders, and struggle to make ends meet.', 11400000), --#15
  ('Shoplifters', 2018, 121, 'In Tokyo, a group lives in poverty', 50000000),
  ('La fille a un million de dollars', 2004, 132, 'Frankie dirige une petite salle de boxe régionale avec son meilleur ami', 30000000),
  ('Bon Cop, Bad Cop', 2006, 116, 'Un Québecois et un Ontarien font équipe pour arrêter un tueur en série', 8000000),
  ('La Guerres des tuques', 1984, 92, 'C''est le congé des Fêtes qui commence', 1340000);


/**
  *Prix
 */
INSERT INTO Prix(nom_prix, categorie) VALUES
 ('Oscars du cinema - Meilleure musique de film', 'Artisan'),
 ('Oscars du cinema - Meilleure photographie', 'Artisan'),
 ('Oscars du cinema - Meilleurs effets visuels', 'Artisan'),
 ('Oscars du cinema - Meilleur maquillage', 'Artisan'),
 ('BAFTA Awards - Meilleur film', 'Film'), --#5
 ('BAFTA Awards - Meilleur realisateur', 'Artisan'),
 ('BAFTA Awards - Meilleurs effets visuels', 'Artisan'),
 ('BAFTA Awards - Meilleur maquillage', 'Artisan'),
 ('Saturn Awards - Meilleur film de fantasy', 'Film'),
 ('Saturn Awards - Meilleure realisation', 'Artisan'), --#10
 ('Saturn Awards - Meilleur acteur dans un second role', 'Artisan'),
 ('Satellite Awards - Meilleur film animation ou comportant des effets speciaux', 'Film'),
 ('Satellite Awards - Meilleur montage', 'Artisan'),
 ('Satellite Awards - Meilleur son', 'Artisan'),
 ('Prix Hugo - Meilleur film', 'Film'), --#15
 ('Empire Awards - Meilleur film', 'Film'),
 ('Empire Awards - Meilleur acteur', 'Artisan'),
 ('Empire Awards - Meilleur espoir', 'Artisan'),
 ('MTV Movie Awards - Meilleur film', 'Film'),
 ('MTV Movie Awards - Meilleure revelation masculine', 'Artisan'), --#20
 ('Screen Actors Guild Awards - Meilleur acteur dans un second rôle', 'Artisan'),
 ('Critics Choice Movie Awards - Meilleur compositeur', 'Artisan'),
 ('Critics Choice Movie Awards - Meilleure chanson originale', 'Artisan'),
 ('NBR Awards - Meilleurs décors', 'Artisan'),
 ('NBR Awards - Meilleure actrice dans un second rôle', 'Artisan'), --#25
 ('Chlotrudis Awards - Meilleur scénario adapté', 'Artisan'),
 ('Australian Film Institute Awards - Meilleur film étranger', 'Film'),
 ('Bodil - Meilleur film américain', 'Film'),
 ('World Soundtrack Awards - Meilleure bande originale de film', 'Artisan'),
 ('Grammy Awards - Meilleur bande originale de film', 'Artisan'), --#30
 ('Prix Nebula - Meilleur script', 'Artisan'),
 ('Festival de Cannes - Interpretation masculine', 'Artisan'),
 ('Festival de Cannes - Palmes d''or', 'Film');


/**
  *RemisesPrixArtisans
 */
INSERT INTO Remises_Prix_Artisans(id_artisan, id_film, id_prix, annee) VALUES
 (2, 2, 19, 2002),
 (2, 2, 21, 2002),
 (9, 2, 18, 2002),
 (7, 2, 12, 2002),
 (7, 2, 22, 2002),
 (36, 13, 32, 1970);


/**
  *RemisesPrixFilms
 */
INSERT INTO Remises_Prix_Films(id_film, id_prix, annee) VALUES
 (2, 6, 2002),
 (2, 10, 2002),
 (2, 13, 2002),
 (2, 16, 2002),
 (2, 17, 2002),
 (2, 20, 2002),
 (15, 33, 2019),
 (16, 33, 2018);


/**
  *Recettes
 */
INSERT INTO Recettes(id_film, id_pays, annee, revenus) VALUES
 (2, 'GB', 2001, 90228837),
 (18, 'CA', 2006, 50000000),
 (18, 'FR', 2006, 25000000),
 (18, 'US', 2006, 40000000),
 (19, 'CA', 1984, 9000000),
 (19, 'FR', 1984, 0),
 (19, 'US', 1984, 0);


/**
  *Pays tournages
 */
INSERT INTO Pays_tournages(id_film, id_pays) VALUES
 (4, 'CA'),
 (2, 'NZ'),
 (1, 'VE'),
 (1, 'DO'),
 (11, 'IT');


/**
  *Sous-titrages de films
 */
INSERT INTO SOUS_TITRES_FILMS(id_film, id_langue) VALUES
(1, 'en'),
(1, 'fr'),
(1, 'es'),
(1, 'de'),
(2, 'en'),
(2, 'fr'),
(2, 'es'),
(2, 'de'),
(2, 'it'),
(3, 'en'),
(3, 'fr'),
(3, 'es'),
(3, 'de'),
(3, 'it');


/**
  *Doublage de films
 */
INSERT INTO DOUBLAGES_FILMS(id_film, artisan_doubleur, artisan_double, id_langue) VALUES
 (2, 3, 4, 'fr'),
 (1, 1, 34, 'frqc'),
 (17, 41, 40, 'fr'),
 (17, 42, 40, 'frqc');


/**
  *Participation film
 */
INSERT INTO Participations_films(id_artisan,id_film, id_emploi) VALUES
 (1, 1, 6),
 (9, 2, 6),
 (11, 4, 6),
 (12, 8, 6),
 (33, 11, 4),
 (35, 12, 6),
 (36, 12, 6),
 (37, 12, 1),
 (38, 12, 1),
 (40, 17, 6),
 (41, 17, 17),
 (42, 17, 17);


/**
  *Nationalités
 */
INSERT INTO Nationalites(id_artisan, id_pays) VALUES
 (1, 'US'),
 (2, 'GB'),
 (3, 'GB'),
 (4, 'GB'),
 (5, 'US'),
 (6, 'GB'),
 (7, 'GB'),
 (35, 'SE'),
 (35, 'IT'),
 (35, 'US'),
 (36, 'IT'),
 (37, 'FR'),
 (38, 'IT'),
 (39, 'PL');


/**
  *Pays présentés
 */
INSERT INTO PAYS_PRESENTES(id_film, id_pays) VALUES
(2, 'US'),
(2, 'GB'),
(2, 'CA'),
(18, 'CA'),
(18, 'FR'),
(18, 'US'),
(19, 'CA'),
(19, 'FR'),
(19, 'US');


/**
  *Evaluation des films
 */
INSERT INTO Evaluations_films(id_artisan, id_film, note, article) VALUES
 (31, 2, 75, 'We invest Hobbits with qualities that cannot be visualized. In my mind, they are good-hearted, bustling, chatty little creatures who live in twee houses or burrows, and dress like the merry men of Robin Hood--in smaller sizes, of course. They eat seven or eight times a day, like to take naps, have never been far from home and have eyes that grow wide at the sounds of the night. They are like children grown up or grown old, and when they rise to an occasion, it takes true heroism, for they are timid by nature and would rather avoid a fight.
Such notions about Hobbits can be found in "Lord of the Rings: The Fellowship of the Ring," but the Hobbits themselves have been pushed off center stage. If the books are about brave little creatures who enlist powerful men and wizards to help them in a dangerous crusade, the movie is about powerful men and wizards who embark on a dangerous crusade, and take along the Hobbits. That is not true of every scene or episode, but by the end "Fellowship" adds up to more of a sword and sorcery epic than a realization of the more naive and guileless vision of J. R. R. Tolkien.
The Ring Trilogy embodies the kind of innocence that belongs to an earlier, gentler time. The Hollywood that made "The Wizard of Oz" might have been equal to it. But "Fellowship" is a film that comes after "Gladiator" and "Matrix," and it instinctively ramps up to the genre of the overwrought special-effects action picture. That it transcends this genre--that it is a well-crafted and sometimes stirring adventure--is to its credit. But a true visualization of Tolkien''s Middle-earth it is not.
Wondering if the trilogy could possibly be as action-packed as this film, I searched my memory for sustained action scenes and finally turned to the books themselves, which I had not read since the 1970s. The chapter "The Bridge of Khazad-Dum" provides the basis for perhaps the most sensational action scene in the film, in which Gandalf the wizard stands on an unstable rock bridge over a chasm, and must engage in a deadly swordfight with the monstrous Balrog. This is an exciting scene, done with state-of-the-art special effects and sound that shakes the theater. In the book, I was not surprised to discover, the entire scene requires less than 500 words.
Settling down with my book, the one-volume, 1969 India paper edition, I read or skimmed for an hour or so. It was as I remembered it. The trilogy is mostly about leaving places, going places, being places, and going on to other places, all amid fearful portents and speculations. There are a great many mountains, valleys, streams, villages, caves, residences, grottos, bowers, fields, high roads, low roads, and along them the Hobbits and their larger companions travel while paying great attention to mealtimes. Landscapes are described with the faithful detail of a Victorian travel writer. The travelers meet strange and fascinating characters along the way, some of them friendly, some of them not, some of them of an order far above Hobbits or even men. Sometimes they must fight to defend themselves or to keep possession of the ring, but mostly the trilogy is an unfolding, a quest, a journey, told in an elevated, archaic, romantic prose style that tests our capacity for the declarative voice.
Reading it, I remembered why I liked it in the first place. It was reassuring. You could tell by holding the book in your hands that there were many pages to go, many sights to see, many adventures to share. I cherished the way it paused for songs and poems, which the movie has no time for. Like The Tale of Genji, which some say is the first novel, "The Lord of the Rings" is not about a narrative arc or the growth of the characters, but about a long series of episodes in which the essential nature of the characters is demonstrated again and again (and again). The ring, which provides the purpose for the journey, serves Tolkien as the ideal MacGuffin, motivating an epic quest while mostly staying right there on a chain around Frodo Baggins'' neck.
Peter Jackson, the New Zealand director who masterminded this film (and two more to follow, in a $300 million undertaking), has made a work for, and of, our times. It will be embraced, I suspect, by many Tolkien fans and take on aspects of a cult. It is a candidate for many Oscars. It is an awesome production in its daring and breadth, and there are small touches that are just right; the Hobbits may not look like my idea of Hobbits (may, indeed, look like full-sized humans made to seem smaller through visual trickery), but they have the right combination of twinkle and pluck in their gaze--especially Elijah Wood as Frodo and Ian Holm as the worried Bilbo.
Yet the taller characters seem to stand astride the little Hobbit world and steal the story away. Gandalf the good wizard (Ian McKellen) and Saruman the treacherous wizard (Christopher Lee) and Aragorn (Viggo Mortensen), who is the warrior known as Strider, are so well-seen and acted, so fearsome in battle, that we can''t imagine the Hobbits getting anywhere without them. The elf Arwen (Liv Tyler), the Elf Queen Galadriel (Cate Blanchett) and Arwen''s father, Elrond (Hugo Weaving), are not small like literary elves ("very tall they were," the book tells us), and here they tower like Norse gods and goddesses, accompanied by so much dramatic sound and lighting that it''s a wonder they can think to speak, with all the distractions.
Jackson has used modern special effects to great purpose in several shots, especially one where a massive wall of water forms and reforms into the wraiths of charging stallions. I like the way he handles crowds of Orcs in the big battle scenes, wisely knowing that in a film of this kind, realism has to be tempered with a certain fanciful fudging. The film is remarkably well made. But it does go on, and on, and on--more vistas, more forests, more sounds in the night, more fearsome creatures, more prophecies, more visions, more dire warnings, more close calls, until we realize this sort of thing can continue indefinitely. "This tale grew in the telling," Tolkien tells us in the famous first words of his foreword; it''s as if Tolkien, and now Jackson, grew so fond of the journey, they dreaded the destination.
That "Fellowship of the Ring" doesn''t match my imaginary vision of Middle-earth is my problem, not yours. Perhaps it will look exactly as you think it should. But some may regret that the Hobbits have been pushed out of the foreground and reduced to supporting characters. And the movie depends on action scenes much more than Tolkien did. In a statement last week, Tolkien''s son Christopher, who is the "literary protector" of his father''s works, said, "My own position is that ''The Lord of the Rings'' is peculiarly unsuitable to transformation into visual dramatic form." That is probably true, and Jackson, instead of transforming it, has transmuted it, into a sword-and-sorcery epic in the modern style, containing many of the same characters and incidents.'),
 (43, 15, 100, 'Ça mérite une palmes d''or ce film là!'),
 (44, 15, 99, 'Good, but could have been better.');


/**
  *Productions_films
 */
INSERT INTO Production_films(id_film, id_studio, localisation) VALUES
(1, 3,'US'),
(2, 19,'US'),
(3, 22,'US'),
(3, 13,'US'),
(3, 28,'US'),
(4, 23,'US'),
(5, 17,'US'),
(5, 24,'US'),
(6, 15,'US'),
(7, 25,'US'),
(7, 26,'US'),
(8, 13,'US'),
(8, 27,'US'),
(8, 28,'US'),
(9, 25,'US'),
(10, 29,'US'),
(11, 30,'IT'),
(15, 31,'KR'),
(18, 33,'CA'),
(19, 34,'CA');


/**
  *Pays_monde
 */
-- Pour inserer les pays, on prend les donnees d'un fichier csv qui est fourni dans la documentation
COPY PAYS_MONDE
FROM '~/projet_ift187/fichiers-csv/pays.csv'
WITH (HEADER, FORMAT CSV, DELIMITER ',');

/*
Insertions a partir de psql
---------------------------
\copy pays_monde from '~/projet_ift187/fichiers-csv/pays.csv' with delimiter ',' header csv;
*/


/**
 *Langues
 */
-- Pour inserer les pays, on prend les donnees d'un fichier csv qui est fourni dans la documentation
COPY LANGUES
FROM '~/projet_ift187/fichiers-csv/langues.csv'
WITH (HEADER, FORMAT CSV, DELIMITER ',');


/*
Insertions a partir de psql
---------------------------
\copy langues from '~/projet_ift187/fichiers-csv/langues.csv' with delimiter ',' header csv;
*/