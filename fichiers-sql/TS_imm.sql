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
 un script SQL pour les interfaces MM offertes – vues, routines et déclencheurs (triggers)
 ############################################################################*/



--######################################################################################################################
-- Creation d'une view qui regroupe tous les films canadiens de la DB
---------------------------------------------------------------------
CREATE OR REPLACE VIEW films_canadiens(id_film, titre, annee_de_parution, origine) as (
    select f.id_film, f.titre, f.annee_de_parution, pf.localisation
    from films f
    join productions_films pf using (id_film)
    where pf.localisation = 'CA' -- Le film est canadien
);
--######################################################################################################################



--######################################################################################################################
-- Creation d'une view qui regroupe tous les attributs des artisans
-------------------------------------------------------------------

-- Comme les attributs des artisans sont separes lors de la normalisation, nous avons cree une view qui nous permet de
-- regrouper tous les attributs comme il etait mentionne a la base lors de l'elaboration de notre schema conceptuel
CREATE OR REPLACE VIEW artisans_complet(id_artisan, prenom, nom, sexe, date_naissance, date_deces) as (
select a.id_artisan, a.prenom, a.nom, a.sexe, dn.date_naissance, dd.date_deces
from artisans a
full join date_naissances dn using (id_artisan) -- On veut toutes les valeurs des tables meme s'il n'y a pas de match dans la jointure
full join date_deces dd using (id_artisan)      -- On veut toutes les valeurs des tables meme s'il n'y a pas de match dans la jointure
);
--######################################################################################################################
