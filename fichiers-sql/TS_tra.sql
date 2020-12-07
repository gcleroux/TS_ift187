/*
--############################################################################
Activité : IFT187
Trimestre : 2020-3
Composant : TS_req.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4 à 12.4
Responsables : Guillaume.Cleroux@USherbrooke.ca,
               Mathieu.Bouillon@USherbrooke.ca,
               Jonathan.Bouthiette@USherbrooke.ca,
               Leo.Chartrand@USherbrooke.ca
Version : 1.1.3
Statut : Pret pour la remise
--############################################################################
*/

/*############################################################################
 un script SQL pour les traitements proposés – routines équivalentes à des mises à jour
 ############################################################################*/



-- #####################################################################################################################
-- Les prochaines insertions sont erronees et inserees dans le but de demontrer les traitements proposes de update et delete.

INSERT INTO Films(titre, annee_de_parution, duree, synopsis, budget) VALUES
 ('Perates des caraibes', 2003, 143, 'Le film se termine avec Jack regardant son compas et chantant A Pirate''s Life for Me.', 140000000);
-- Faute de frappe dans l'insertion du titre du film.

INSERT INTO Films(titre, annee_de_parution, duree, synopsis, budget) VALUES
 ('Batman', 2008, 152, 'Gordon détruit le Bat-signal et une chasse au justicier s''ensuit.', 185000000);
-- Synonyme du film dans l'insertion au lieu du vrai titre tel que la db le reconnait.

INSERT INTO Films(titre, annee_de_parution, duree, synopsis, budget) VALUES
('Trenssandance', 2014, 119, 'En regardant plus attentivement, il remarque que la goutte d''eau tombant d''un pétale de tournesol nettoie instantanément une flaque d''huile.', 100000000);
-- Erreur d'orthographe dans la transcription d'un titre de film.

INSERT INTO Prix(nom_prix, categorie) VALUES
 ('Oscars', 'Meilleure musique de film');
-- Manque de precision dans l'insertion du prix.
-- Categorie du prix entree dans l'insertion au lieu de la categorie d'artisan.

-- #####################################################################################################################



-- #####################################################################################################################
-- Updates afin de modifier des entrees qui seraient incorrectes

UPDATE Films SET titre = 'Pirates of the Caribbean: The Curse of the Black Pearl' WHERE titre = 'Perates des caraibes';
-- Mise a jour du titre afin de corriger l'erreur de frappe.

UPDATE Films SET titre = 'The Dark Knight' WHERE titre = 'Batman';
-- Mise a jour du titre afin que la db reconnaissance le titre sous sa vraie forme.

UPDATE Films SET titre = 'Transcendence' WHERE titre = 'Trenssandance';
-- Mise a jour du titre pour corriger l'erreur d'orthographe commise lors de l'inscription de l'insertion.

UPDATE Prix SET nom_prix = 'Oscars du cinema - Meilleur musique de film' WHERE nom_prix = 'Oscars';
-- Mise a jour du nom du prix afin de preciser quel Oscar a ete remporte par l'artisan.

UPDATE Prix SET categorie = 'artisan' WHERE categorie = 'Meilleure musique de film';
-- Mise a jour de la categorie puisqu'ici on cherche la categorie d'artisan et non la categorie de prix.

-- #####################################################################################################################



-- #####################################################################################################################
-- Alter table afin de modifier le schema.

ALTER TABLE Films
ADD COLUMN id_genre genre;
-- On peut ajouter le genre pour mieux les comparer ou les grouper.

ALTER TABLE films
DROP COLUMN synopsis;
-- On peut retirer la colonne synopsis puisque cette colonne prend beaucoup de place et n'est pas toujours essentielle.

ALTER TABLE remises_prix_artisans
ADD COLUMN id_genre genre;
-- On peut ajouter le genre pour voir quel genre de film l'artisan est specialise.

ALTER TABLE evaluations_films
DROP COLUMN article;
-- On peut retirer l'article au besoin si on cherche seulement la note des articles.

-- #####################################################################################################################



-- #####################################################################################################################
-- Delete afin de supprimer des entrees en double

DELETE from Films where id_film = 47;
-- On vient delete le film entrer en double dans la table film.

DELETE from Films where id_film = 46;
-- Puisque le film a ete update et corrige dans une section precedente suite a une erreur de frappe,
-- on vient ici delete le doublon cree par la commande.

DELETE from Films where id_film = 36;
-- Delete le id_film entre en deuxieme dans la db puisque le meme film est deja present.

-- #####################################################################################################################