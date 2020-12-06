/*############################################################################
 un script SQL d’insertions de données de test négatives
 ############################################################################*/

/* ####################################################################
 Liste des modifications a faire dans le doc

   - Ajouter des insertions qui ne sont pas supposees fonctionner
   - Expliquer pour chaque insertion pourquoi elle ne fonctionne pas avec un predicat
   - Faire la mise en page

 ####################################################################*/



/* ###################################################################
 * Emplois
 ####################################################################*/

INSERT INTO Emplois(emploi) VALUES
 ('Sert vraiment a riennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
-- Insertion invalide, car le nombre de lettres depasse la limite de varchar(50).

INSERT INTO Emplois(emploi) VALUES
 ('');
-- Insertion invalide, car ( length(emploi) < 0 ).



/* ###################################################################
 * Genre
 ####################################################################*/

INSERT INTO Genres(id_genre) VALUES
 ('Film');
-- Insertion invalide, car Film ne fait pas partie de la liste autorisee du domaine.

INSERT INTO Genres(id_genre) VALUES
 ('Film peplum autobiographique de science-fiction');
-- Insertion invalide, car le nombre de lettres depasse la limite de varchar(30).



/* ###################################################################
 * Studios de production
 ####################################################################*/

INSERT INTO Studios_Productions(nom_studio, localisation) VALUES
 ('Studio de production', 'ZZ');
-- Insertion invalide, car le localisation ZZ n'existe pas dans la table pays_monde.

INSERT INTO Studios_Productions(nom_studio, localisation) VALUES
 ('Studio de production', 'ZZZ');
-- Insertion invalide, car le localisation est 3 caracteres au lieu de 2.



/* ###################################################################
 * Artisans
 ####################################################################*/

INSERT INTO Artisans (prenom, nom, sexe) VALUES
 ('Alright', 'McConaughey', 'A');
-- Insertion invalide, car le sexe ne fait pas partie du domaine.



/* ###################################################################
 * Date de naissance
 ####################################################################*/

INSERT INTO Date_naissances(id_artisan, date_naissance) VALUES
 (1, '1800-01-01');
-- Insertion invalide, car la date precede la limite etablie de annee de 1850.



/* ###################################################################
 * Date de deces
 ####################################################################*/

INSERT INTO Date_deces(id_artisan, date_deces) VALUES
 (1, '1850-01-01');
-- Insertion invalide, car l'artisan ne peut pas mourir avant de naitre.



/* ###################################################################
 * Films
 ####################################################################*/

INSERT INTO Films(titre, annee_de_parution, duree, synopsis, budget) VALUES
 ('Pirates of the Caribbean: The Curse of the Black Pearl', 2003, 143, 'Le film se termine avec Jack regardant son compas et chantant A Pirate''s Life for Me.', 1400000000);
-- Insertion invalide, car le budget du film depasse 1 milliard $.

INSERT INTO Films(titre, annee_de_parution, duree, synopsis, budget) VALUES
 ('Pirates of the Caribbean: The Curse of the Black Pearl', 2003, 1000, 'Le film se termine avec Jack regardant son compas et chantant A Pirate''s Life for Me.', 140000000);
-- Insertion invalide, car la duree du film est superieure a 999 minutes.



/* ###################################################################
 * Prix
 ####################################################################*/

INSERT INTO Prix(nom_prix, categorie) VALUES
 ('Oscars du cinema - Meilleure musique de film', 'Proprietaire');
-- Insertion invalide, car le prix doit etre remis a la categorie artisan ou film.



/* ###################################################################
 * Remise prix artisans
 ####################################################################*/

INSERT INTO Remises_Prix_Artisans(id_artisan, id_film, id_prix, annee) VALUES
 (2, 2, 19, 2000);
-- Insertion invalide, car le film n'etait pas sorti a l'annee de la remise de ce prix.
-- Tel qu'indique par l'invariant validation_remises_prix_artisans_annee().

INSERT INTO Remises_Prix_Artisans(id_artisan, id_film, id_prix, annee) VALUES
 (2, 5, 19, 2002);
-- Insertion invalide, car l'artisan ne fait pas parti de ce film
-- Tel qu'indique par l'invariant validation_remises_prix_artisans_participation().



/* ###################################################################
 * Remise prix films
 ####################################################################*/

INSERT INTO Remises_Prix_Films(id_film, id_prix, annee) VALUES
 (2, 19, 2000);
-- Insertion invalide, car le film n'etait pas sorti a l'annee de la remise de ce prix.
-- Tel qu'indique par l'invariant validation_remises_prix_films_annee().



/* ###################################################################
 * Recettes
 ####################################################################*/

INSERT INTO Recettes(id_film, id_pays, annee, revenus) VALUES
 (3, 'AF', 2001, 1000000);
-- Insertion invalide, car le film n'a pas ete presente dans ce pays.
-- Tel qu'indique par l'invariant validation_recettes_pays().

INSERT INTO Recettes(id_film, id_pays, annee, revenus) VALUES
 (3, 'US', 2000, 1000000);
-- Insertion invalide, car le film n'etait pas sorti a l'annee entree.
-- Tel qu'indique par l'invariant validation_recettes_annee().



/* ###################################################################
 * Pays tournage
 ####################################################################*/

INSERT INTO Pays_tournages(id_film, id_pays) VALUES
 (4, 'ZZ');
-- Insertion invalide, car le localisation ZZ n'existe pas dans la table pays_monde.



/* ###################################################################
 * Sous-titrage de films
 ####################################################################*/

INSERT INTO SOUS_TITRES_FILMS(id_film, id_langue) VALUES
 (2, 'zz');
-- Insertion invalide, car la langue ZZ n'existe pas dans la table langues.



/* ###################################################################
 * Doublage de films
 ####################################################################*/

INSERT INTO DOUBLAGES_FILMS(id_film, artisan_doubleur, artisan_double, id_langue) VALUES
 (2, 3, 3, 'fr');
-- Insertion invalide, car l'artisan doubleur ne peut pas etre l'artisan double.
-- Tel qu'indique par l'invariant validation_doublages_films_duplicata().

INSERT INTO DOUBLAGES_FILMS(id_film, artisan_doubleur, artisan_double, id_langue) VALUES
 (2, 4, 5, 'fr');
-- Insertion invalide, car Erreur dans la selection des artisans.
-- Veuillez verifier qu'ils sont bien dans la table participation_films avec les bon emplois.
-- Tel qu'indique par l'invariant validation_doublages_films_participations().



/* ###################################################################
 * Participation film
 ####################################################################*/

INSERT INTO Participations_films(id_artisan,id_film, id_emploi) VALUES
 (1, 12, 6);
-- Insertion invalide, car l'artisan n'etait pas ne a la sortie du film.
-- Tel qu'indique par l'invariant validation_participations_films_date_naissance().



/* ###################################################################
 * Nationalites
 ####################################################################*/

INSERT INTO Nationalites(id_artisan, id_pays) VALUES
 (1, 'ZZ');
-- Insertion invalide, car id_pays n'existe pas dans la tablea pays_monde.



/* ###################################################################
 * Pays presentes
 ####################################################################*/

INSERT INTO PAYS_PRESENTES(id_film, id_pays) VALUES
(2, 'ZZ');
-- Insertion invalide, car id_pays n'existe pas dans la tablea pays_monde.



/* ###################################################################
 * Evaluation film
 ####################################################################*/

INSERT INTO Evaluations_films(id_artisan, id_film, note, article) VALUES
 (31, 2, 150, 'Mauvais film.');
-- Insertion invalide, car la note depasse la limite attribuable de 100.


























