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
 un script SQL pour supprimer les domaines, tables, triggers, etc. de la DB
 ############################################################################*/



/*################################################
  GESTION DE LA BASE DE DONNEES
 ################################################*/

-- Supprimer toute la DB
DROP DATABASE dbfilms;

-- Supprimer le schema public qui contient l'ensemble de la DB
DROP SCHEMA public CASCADE;

-- ################################################



/*################################################
  GESTION DES DOMAINES DE LA DB
 ################################################*/

drop domain annee cascade ;

drop domain genre cascade ;

drop domain nom cascade ;

drop domain pays cascade ;

drop domain sexe cascade ;

drop domain langue cascade ;

-- ################################################



/*################################################
  GESTION DES TABLES DE LA DB
 ################################################*/

drop table artisans cascade;

drop table date_deces cascade;

drop table DATES_NAISSANCE cascade;

drop table doublages_films cascade;

drop table emplois cascade;

drop table evaluations_films cascade;

drop table films cascade;

drop table genres_films cascade;

drop table langues cascade;

drop table nationalites cascade;

drop table participations_films cascade;

drop table pays_monde cascade;

drop table pays_presentes cascade;

drop table pays_tournages cascade;

drop table prix cascade;

drop table recettes cascade;

drop table remises_prix_artisans cascade;

drop table remises_prix_films cascade;

drop table sous_titrages_films cascade;

drop table studios_productions cascade;

drop table productions_films cascade;

-- ################################################



/*################################################
  GESTION DES VIEWS DE LA DB
 ################################################*/

drop view films_canadiens;

drop view artisans_complet;

-- ################################################



/*################################################
  GESTION DES TRIGGERS DE LA DB
 ################################################*/

drop trigger insertions_doublages_films_participations on doublages_films;
drop function validation_doublages_films_participations();

drop trigger insertions_doublages_films_duplicata on doublages_films;
drop function validation_doublages_films_duplicata();

drop trigger insertions_participations_films on participations_films;
drop function validation_participations_films_date_naissance();

drop trigger insertions_remises_prix_films on remises_prix_films;
drop function validation_remises_prix_films_annee();

drop trigger insertions_remises_prix_artisans_participation on remises_prix_artisans;
drop function validation_remises_prix_artisans_participation();

drop trigger insertions_remises_prix_artisans_annee on remises_prix_artisans;
drop function validation_remises_prix_artisans_annee();

drop trigger insertions_recettes_pays on recettes;
drop function validation_recettes_pays();

drop trigger insertions_recettes_annee on recettes;
drop function validation_recettes_annee();

drop trigger insertions_date_deces on date_deces;
drop function validation_date_deces();

-- ################################################
