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
Version : 1.0.3
Statut : Pret pour la remise
--############################################################################
*/

/*############################################################################
  un script SQL de création du schéma de base de données – domaines, types, tables
 ############################################################################*/



drop schema public cascade ;
/*######################################################################################################################
CREATION DE LA DB
######################################################################################################################*/

-- Creation de la DB
CREATE DATABASE dbfilms;

-- Creation du schema de la DB
CREATE SCHEMA public;

--######################################################################################################################



/*######################################################################################################################
CREATION DES DOMAINES DE LA DB
######################################################################################################################*/

-- Creation des domaines
CREATE DOMAIN Annee
    INT
    CONSTRAINT Annee_inv CHECK (VALUE BETWEEN 1850 AND extract(YEAR FROM now()));

CREATE DOMAIN Genre
    VARCHAR(30)
    CONSTRAINT Genre_inv CHECK ( VALUE IN ('Action', 'Animation', 'Aventure', 'Biographique', 'Catastrophe', 'Comedie',
                                           'Comedie dramatique', 'Comedie musicale', 'Comedie policiere', 'Comedie romantique',
                                           'Court metrage', 'Dessin anime', 'Documentaire', 'Drame', 'Drame psychologique',
                                           'Epouvante', 'Erotique', 'Espionnage', 'Fantastique', 'Film musical', 'Guerre',
                                           'Historique', 'Horreur', 'Karate', 'Manga', 'Melodrame', 'Muet', 'Policier',
                                           'Politique', 'Romance', 'Science fiction', 'Spectacle', 'Telefilm', 'Theatre',
                                           'Thriller',  'Western', 'Autre'));

CREATE DOMAIN Langue
    VARCHAR(4)
    CONSTRAINT Langue_inv CHECK ( VALUE SIMILAR TO '[a-z]{2}%');

CREATE DOMAIN Nom
    VARCHAR(50)
    CONSTRAINT Nom_inv CHECK ( length(VALUE) > 0 );

CREATE DOMAIN Pays
    CHAR(2)
    CONSTRAINT Pays_inv CHECK ( VALUE SIMILAR TO '[A-Z]{2}');

CREATE DOMAIN Sexe
    CHAR(1)
    CONSTRAINT Sexe_inv CHECK ( VALUE IN ('M', 'F', 'I') );
--######################################################################################################################



--######################################################################################################################

CREATE TABLE ARTISANS (
  id_artisan BIGSERIAL NOT NULL,
  prenom Nom NOT NULL,
  nom Nom NOT NULL,
  sexe Sexe NOT NULL,

  CONSTRAINT ARTISANS_cc0 PRIMARY KEY (id_artisan)
);


CREATE TABLE FILMS (
  id_film BIGSERIAL NOT NULL,
  titre TEXT NOT NULL,
  annee_de_parution Annee NOT NULL,
  duree INT NOT NULL,
  synopsis TEXT NOT NULL,
  budget NUMERIC(9,0) NOT NULL,

  CONSTRAINT FILMS_cc0 PRIMARY KEY (id_film),
  CONSTRAINT Titre_inv CHECK ( length(titre) > 0 ),
  CONSTRAINT Duree_inv CHECK ( duree BETWEEN 1 AND 999 ),
  CONSTRAINT Synopsis_inv CHECK ( length(synopsis) > 0 ),
  CONSTRAINT Budget_inv CHECK ( budget >= 0 )
);


CREATE TABLE PAYS_MONDE (
  id_pays Pays NOT NULL,
  nom_pays VARCHAR(50) NOT NULL,

  CONSTRAINT PAYS_cc0 PRIMARY KEY (id_pays),
  CONSTRAINT Nom_pays_inv CHECK ( length(nom_pays) > 0 )
);


CREATE TABLE EMPLOIS (
  id_emploi BIGSERIAL NOT NULL,
  emploi VARCHAR(50) NOT NULL,

  CONSTRAINT EMPLOIS_cc0 PRIMARY KEY (id_emploi),
  CONSTRAINT Emploi_inv CHECK ( length(emploi) > 0 )
);


CREATE TABLE GENRES (
  id_genre Genre NOT NULL,

  CONSTRAINT GENRES_cc0 PRIMARY KEY (id_genre)
);


CREATE TABLE LANGUES (
  id_langue Langue NOT NULL,
  nom_langue VARCHAR(60) NOT NULL,

  CONSTRAINT LANGUES_cc0 PRIMARY KEY (id_langue),
  CONSTRAINT Nom_langue_inv CHECK ( length(nom_langue) > 0 )
);


CREATE TABLE PRIX (
  id_prix BIGSERIAL NOT NULL,
  nom_prix TEXT NOT NULL,
  categorie VARCHAR(7) NOT NULL,

  CONSTRAINT PRIX_cc0 PRIMARY KEY (id_prix),
  CONSTRAINT Nom_prix_inv CHECK ( length(nom_prix) > 0 ),
  CONSTRAINT Categorie_inv CHECK ( categorie IN ('Artisan', 'Film') )
);


CREATE TABLE DATE_NAISSANCES (
    id_artisan BIGINT NOT NULL,
    date_naissance DATE NOT NULL,

    CONSTRAINT DATE_NAISSANCES_cc0 PRIMARY KEY (id_artisan),
    CONSTRAINT DATE_NAISSANCES_ce0 FOREIGN KEY (id_artisan) REFERENCES ARTISANS(id_artisan),
    CONSTRAINT Date_naissance_inv CHECK ( date_naissance <= now()::DATE )
);


CREATE TABLE DATE_DECES (
    id_artisan BIGINT NOT NULL,
    date_deces DATE NOT NULL,

    CONSTRAINT DATE_DECES_cc0 PRIMARY KEY (id_artisan),
    CONSTRAINT DATE_DECES_ce0 FOREIGN KEY (id_artisan) REFERENCES ARTISANS(id_artisan),
    CONSTRAINT Date_deces_inv CHECK ( date_deces <= now()::DATE )
);


CREATE TABLE STUDIOS_PRODUCTIONS (
  id_studio BIGSERIAL NOT NULL,
  localisation Pays NOT NULL ,
  nom_studio TEXT NOT NULL,

  CONSTRAINT STUDIOS_PRODUCTIONS_cc0 PRIMARY KEY (id_studio, localisation),
  CONSTRAINT STUDIOS_PRODUCTIONS_ce0 FOREIGN KEY (localisation) REFERENCES PAYS_MONDE(id_pays)
);


CREATE TABLE PAYS_TOURNAGES (
  id_film BIGINT NOT NULL,
  id_pays Pays NOT NULL,

  CONSTRAINT PAYS_TOURNAGES_cc0 PRIMARY KEY (id_film, id_pays),
  CONSTRAINT PAYS_TOURNAGES_ce0 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
  CONSTRAINT PAYS_TOURNAGES_ce1 FOREIGN KEY (id_pays) REFERENCES PAYS_MONDE(id_pays)
);

CREATE TABLE PAYS_PRESENTES (
  id_film BIGINT NOT NULL,
  id_pays Pays NOT NULL,

  CONSTRAINT PAYS_PRESENTES_cc0 PRIMARY KEY (id_film, id_pays),
  CONSTRAINT PAYS_PRESENTES_ce0 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
  CONSTRAINT PAYS_PRESENTES_ce1 FOREIGN KEY (id_pays) REFERENCES PAYS_MONDE(id_pays)
);

CREATE TABLE GENRES_FILMS (
  id_film BIGINT NOT NULL ,
  id_genre Genre NOT NULL ,

  CONSTRAINT GENRES_FILMS_cc0 PRIMARY KEY (id_film, id_genre),
  CONSTRAINT GENRES_FILMS_ce0 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
  CONSTRAINT GENRES_FILMS_ce1 FOREIGN KEY (id_genre) REFERENCES GENRES(id_genre)
);

CREATE TABLE PRODUCTIONS_FILMS (
    id_film BIGINT NOT NULL,
    id_studio BIGINT NOT NULL,
    localisation Pays NOT NULL,

    CONSTRAINT PRODUCTIONS_FILMS_cc0 PRIMARY KEY (id_film, id_studio, localisation),
    CONSTRAINT PARTICIPATIONS_FILMS_ce0 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
    CONSTRAINT PARTICIPATIONS_FILMS_ce1 FOREIGN KEY (id_studio, localisation) REFERENCES STUDIOS_PRODUCTIONS(id_studio, localisation)
);

CREATE TABLE PARTICIPATIONS_FILMS (
  id_artisan BIGINT NOT NULL,
  id_film BIGINT NOT NULL,
  id_emploi BIGINT NOT NULL,

  CONSTRAINT PARTICIPATIONS_FILMS_cc0 PRIMARY KEY (id_artisan, id_film, id_emploi),
  CONSTRAINT PARTICIPATIONS_FILMS_ce0 FOREIGN KEY (id_artisan) REFERENCES ARTISANS(id_artisan),
  CONSTRAINT PARTICIPATIONS_FILMS_ce1 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
  CONSTRAINT PARTICIPATIONS_FILMS_ce2 FOREIGN KEY (id_emploi) REFERENCES EMPLOIS(id_emploi)
);


CREATE TABLE EVALUATIONS_FILMS (
  id_artisan BIGINT NOT NULL,
  id_film BIGINT NOT NULL,
  note INT NOT NULL,
  article TEXT NOT NULL,

  CONSTRAINT EVALUATIONS_FILMS_cc0 PRIMARY KEY (id_artisan, id_film),
  CONSTRAINT EVALUATIONS_FILMS_ce0 FOREIGN KEY (id_artisan) REFERENCES ARTISANS(id_artisan),
  CONSTRAINT EVALUATIONS_FILMS_ce1 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
  CONSTRAINT Note_inv CHECK ( note BETWEEN 0 AND 100),
  CONSTRAINT Article_inv CHECK ( length(article) > 0 )
);


CREATE TABLE REMISES_PRIX_FILMS (
  id_film BIGINT NOT NULL,
  id_prix BIGINT NOT NULL,
  annee Annee NOT NULL,

  CONSTRAINT REMISES_PRIX_FILMS_cc0 PRIMARY KEY (id_film, id_prix),
  CONSTRAINT REMISES_PRIX_FILMS_ce0 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
  CONSTRAINT REMISES_PRIX_FILMS_ce1 FOREIGN KEY (id_prix) REFERENCES PRIX(id_prix)
);


CREATE TABLE SOUS_TITRES_FILMS (
  id_film BIGINT NOT NULL,
  id_langue Langue NOT NULL,

  CONSTRAINT SOUS_TITRES_FILMS_cc0 PRIMARY KEY (id_film, id_langue),
  CONSTRAINT SOUS_TITRES_FILMS_ce0 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
  CONSTRAINT SOUS_TITRES_FILMS_ce1 FOREIGN KEY (id_langue) REFERENCES LANGUES(id_langue)
);

CREATE TABLE DOUBLAGES_FILMS (
    id_film BIGINT NOT NULL,
    artisan_doubleur BIGINT NOT NULL,
    artisan_double BIGINT NOT NULL,
    id_langue Langue NOT NULL,

    CONSTRAINT DOUBLAGES_FILMS_cc0 PRIMARY KEY (id_film, artisan_doubleur, artisan_double, id_langue),
    CONSTRAINT DOUBLAGES_FILMS_ce0 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
    CONSTRAINT DOUBLAGES_FILMS_ce1 FOREIGN KEY (artisan_doubleur) REFERENCES ARTISANS(id_artisan),
    CONSTRAINT DOUBLAGES_FILMS_ce2 FOREIGN KEY (artisan_double) REFERENCES ARTISANS(id_artisan),
    CONSTRAINT DOUBLAGES_FILMS_ce3 FOREIGN KEY (id_langue) REFERENCES LANGUES(id_langue)
);


CREATE TABLE REMISES_PRIX_ARTISANS (
  id_artisan BIGINT NOT NULL,
  id_film BIGINT NOT NULL,
  id_prix BIGINT NOT NULL,
  annee Annee NOT NULL,

  CONSTRAINT REMISES_PRIX_ARTISANS_cc0 PRIMARY KEY (id_artisan, id_film, id_prix, annee),
  CONSTRAINT REMISES_PRIX_ARTISANS_ce0 FOREIGN KEY (id_artisan) REFERENCES ARTISANS(id_artisan),
  CONSTRAINT REMISES_PRIX_ARTISANS_ce1 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
  CONSTRAINT REMISES_PRIX_ARTISANS_ce2 FOREIGN KEY (id_prix) REFERENCES PRIX(id_prix)
);


CREATE TABLE RECETTES (
  id_film BIGINT NOT NULL,
  id_pays Pays NOT NULL,
  annee Annee NOT NULL,
  revenus NUMERIC(9,0) NOT NULL,

  CONSTRAINT REVENUS_FILMS_cc0 PRIMARY KEY (id_film, id_pays, annee),
  CONSTRAINT REMISES_PRIX_FILMS_ce0 FOREIGN KEY (id_film) REFERENCES FILMS(id_film),
  CONSTRAINT REVENUS_FILMS_ce1 FOREIGN KEY (id_pays) REFERENCES PAYS_MONDE(id_pays),
  CONSTRAINT Revenus_inv CHECK ( revenus >= 0 )
);

CREATE TABLE NATIONALITES (
    id_artisan BIGINT NOT NULL,
    id_pays Pays NOT NULL,

    CONSTRAINT NATIONALITES_cc0 PRIMARY KEY (id_artisan, id_pays),
    CONSTRAINT NATIONALITES_ce0 FOREIGN KEY (id_artisan) REFERENCES ARTISANS(id_artisan),
    CONSTRAINT NATIONALITES_ce1 FOREIGN KEY (id_pays) REFERENCES PAYS_MONDE(id_pays)
);