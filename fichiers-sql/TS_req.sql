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
 un script SQL pour les requêtes proposées – routines équivalentes à des sélections
 ############################################################################*/



--######################################################################################################################
-- 1. Quels sont les films réalisés par Sergio Leone et tournés en Espagne (en tout ou en partie)?
--------------------------------------------------------------------------------------------------
select films.id_film, films.titre
from films
join participations_films pf using (id_film)
join pays_tournages pt using (id_film)

-- On veut selectionner l'artisan Sergio Leone
where id_artisan = (
    select id_artisan
    from artisans
    where prenom = 'Sergio' and
          nom = 'Leone'
    )

-- On veut que le poste associe a Sergio Leone soit le realisateur
and pf.id_emploi = (
    select id_emploi
    from emplois
    where emploi = 'Realisateur'
    )

-- Le film doit etre tourne en espagne
and pt.id_pays = 'ES'
;
--######################################################################################################################



--######################################################################################################################
-- 2. Quels sont les films produits aux États-Unis pour lesquels il existe une version doublée au Québec?
---------------------------------------------------------------------------------------------------------
select distinct films.id_film, films.titre  -- On veut que les films apparaissent seulement une fois chaque
from films
join productions_films pf using (id_film)
join studios_productions sp using (id_studio)
join doublages_films df using (id_film)

-- Selection du pays de production.
where sp.localisation = 'US' and

-- Selection de la langue en francais quebecois
df.id_langue = 'frqc'
;
--######################################################################################################################



--######################################################################################################################
-- 3. Dans quels films Ingrid Bergman et Marcello Mastroianni ont-ils joué ensemble?
------------------------------------------------------------------------------------
select distinct f.id_film, f.titre
from participations_films pf
join participations_films x using (id_film)
join films f using (id_film)

-- On veut que le film contienne l'actrice Ingrid Bergman
where pf.id_artisan = (
    select a.id_artisan
    from artisans a
    where prenom = 'Ingrid' and
          nom = 'Bergman'
    )

-- On veut que le film contienne l'actrice Marcello Mastroianni
and x.id_artisan = (
    select a.id_artisan
    from artisans a
    where prenom = 'Marcello' and
          nom = 'Mastroianni'
    )
;
--######################################################################################################################



--######################################################################################################################
-- 4. Quels sont les films coproduits par un producteur français et un producteur italien?
------------------------------------------------------------------------------------------
select distinct f.id_film, f.titre
from films f
join productions_films pf using (id_film)

-- On veut que le film soit produit en France
where exists(
    select *
    from productions_films
    join studios_productions sp using (id_studio)
    where localisation = 'FR' and
          productions_films.id_film = pf.id_film
    )

-- On veut que le film soit produit en Italie
and exists(
    select *
    from productions_films
    join studios_productions sp using (id_studio)
    where localisation = 'IT' and
          productions_films.id_film = pf.id_film
    )
;
--######################################################################################################################



--######################################################################################################################
-- 5. Quels sont les acteurs italiens ayant gagné le prix d’interprétation masculine au Festival de Cannes?
-----------------------------------------------------------------------------------------------------------
select artisans.id_artisan, artisans.prenom, artisans.nom
from artisans
join remises_prix_artisans using (id_artisan)
join nationalites using (id_artisan)

-- L'acteur doit etre italien
where nationalites.id_pays = 'IT' and
      remises_prix_artisans.id_prix = ( -- Selection du id_prix correspondant a la palmes d'or de Cannes
          select id_prix
          from prix
          where nom_prix ilike '%Festival de Cannes%interpretation masculine%'
      )
;
--######################################################################################################################



--######################################################################################################################
-- 6. Quelles sont les actrices ayant une triple nationalité?
-------------------------------------------------------------

-- On cree une table temporaire pour compter et classer le nb de nationalites de toutes les femmes
with nb_nationalites_femme(id_artisan, prenom, nom, total_nationalites) as (
    select a.id_artisan, a.prenom, a.nom, count(*) as total_nationalites
    from nationalites n
    join artisans a using (id_artisan)
    where sexe = 'F'
    group by a.id_artisan
)

-- On cherche dans notre table temporaire toutes les femmes qui on 3 nationalites
select *
from nb_nationalites_femme nnf
where nnf.total_nationalites = 3
;
--######################################################################################################################



--######################################################################################################################
-- 7. Qui sont les réalisateurs polonais ayant tourné des films avant 1939?
---------------------------------------------------------------------------
select a.id_artisan, a.prenom, a.nom
from films f
join participations_films pf using (id_film)
join artisans a using (id_artisan)
join nationalites n using (id_artisan)

-- Le film doit etre sorti avant 1939
where f.annee_de_parution < 1939

-- Le realisateur doit avoir la nationalite polonaise
and n.id_pays = (
        select id_pays
        from pays_monde
        where nom_pays like 'Pologne'
        )

-- L'emploi de l'artisan dans la participation du film doit etre Realisateur
and pf.id_emploi = (
    select id_emploi
    from emplois
    where emploi like 'Realisateur'
    )
;
--######################################################################################################################



--######################################################################################################################
-- 8. Quelle est la distribution par pays des Palmes d’or au Festival de Cannes?
--------------------------------------------------------------------------------
select sp.localisation, count(*) as nb_total_de_palmes_dor
from remises_prix_films rpf
join productions_films pf using (id_film)
join studios_productions sp using (id_studio)
join prix p using (id_prix)

-- Le prix doit etre la palme d'or de Cannes
where p.nom_prix ilike '%Festival de Cannes%Palmes d''or%'

-- On regroupe les films selon leur origine
group by (sp.localisation)
;
--######################################################################################################################



--######################################################################################################################
-- 9. Quels sont les 10 films québécois ayant eu le plus d’entrées payantes à leur sortie en salle, au Québec, au Canada, en France, aux États-Unis?
----------------------------------------------------------------------------------------------------------------------------------------------------

-- Comme nous ne considerons pas que le Quebec est un pays, nous allons remplacer cette selection par la suivante qui est plus idoine
-- 9. Quels sont les 10 films canadiens ayant eu le plus d’entrées payantes à leur sortie en salle, au Canada, en France, aux États-Unis?

-- Creation d'une view qui regroupe tous les films canadiens de la DB
CREATE OR REPLACE VIEW films_canadiens(id_film, titre, annee_de_parution, origine) as (
    select f.id_film, f.titre, f.annee_de_parution, sp.localisation
    from films f
    join productions_films pf using (id_film)
    join studios_productions sp using (id_studio)
    where sp.localisation = 'CA' -- Le film est canadien
);

-- Les films canadiens qui ont eu le plus de revenus dans leur annee de sortie au Canada
select fc.id_film, fc.titre, r.revenus
from films_canadiens fc
join recettes r using (id_film)
where r.annee = fc.annee_de_parution and
      r.id_pays = 'CA'
order by revenus desc
limit 10;

-- Les films canadiens qui ont eu le plus de revenus dans leur annee de sortie en France
select fc.id_film, fc.titre, r.revenus
from films_canadiens fc
join recettes r using (id_film)
where r.annee = fc.annee_de_parution and
      r.id_pays = 'FR'
order by revenus desc
limit 10;

-- Les films canadiens qui ont eu le plus de revenus dans leur annee de sortie aux Etats-Unis
select fc.id_film, fc.titre, r.revenus
from films_canadiens fc
join recettes r using (id_film)
where r.annee = fc.annee_de_parution and
      r.id_pays = 'US'
order by revenus desc
limit 10;
--######################################################################################################################



--######################################################################################################################
-- 10. Quels sont les acteurs ayant doublé Clint Eastwood en français dans au moins deux films?
-----------------------------------------------------------------------------------------------
with nb_doublages_clint_eastwood(id_artisan, prenom, nom, total_doublages) as(
    select a.id_artisan, a.prenom, a.nom, count(*)
    from doublages_films df
    join artisans a on df.artisan_doubleur = a.id_artisan

    -- On veut le id_artisan de Clint Eastwood
    where artisan_double = (
        select id_artisan
        from artisans
        where prenom = 'Clint' and
              nom = 'Eastwood')

    -- On confond toutes les varietes linguistiques de la langue francaise
    and df.id_langue like 'fr%'
    group by id_artisan
)

-- On selectionne dans la table des doublages de Clint Eastwood les artisans qui l'ont double plus de 2 fois
select *
from nb_doublages_clint_eastwood
where total_doublages >= 2
;
--######################################################################################################################
