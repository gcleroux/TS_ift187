/*############################################################################
 un script SQL pour les requêtes proposées – routines équivalentes à des sélections
 ############################################################################*/

/* ####################################################################
 Liste des modifications a faire dans le doc

   - Ajouter les requetes exemples du prof
   - Faire une mise en page et des predicats qui separe individuellement chaque requetes
####################################################################*/

/*
1. Quels sont les films réalisés par Sergio Leone et tournés en Espagne (en tout ou en partie)?
2. Quels sont les films produits aux États-Unis pour lesquels il existe une version doublée au Québec?
3. Dans quels films Ingrid Bergman et Marcello Mastroianni ont-ils joué ensemble?
4. Quels sont les films coproduits par un producteur français et un producteur italien?
5. Quels sont les acteurs italiens ayant gagné le prix d’interprétation masculine au Festival de Cannes?
6. Quelles sont les actrices ayant une triple nationalité?
7. Qui sont les réalisateurs polonais ayant tourné des films avant 1939?
8. Quelle est la distribution par pays des Palmes d’or au Festival de Cannes?
9. Quels sont les 10 films québécois ayant eu le plus d’entrées payantes à leur sortie en salle, au Québec, au Canada, en France, aux États-Unis?
10. Quels sont les acteurs ayant doublé Clint Eastwood en français dans au moins deux films?
 */



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



-- 2. Quels sont les films produits aux États-Unis pour lesquels il existe une version doublée au Québec?
---------------------------------------------------------------------------------------------------------
select distinct films.id_film, films.titre  -- On veut que les films apparaissent seulement une fois
from films
join productions_films pf using (id_film)
join doublages_films df using (id_film)

-- Selection du pays de production.
where pf.localisation = 'US' and

-- Selection de la langue en francais quebecois
df.id_langue = 'frqc'
;



-- 3. Dans quels films Ingrid Bergman et Marcello Mastroianni ont-ils joué ensemble?
------------------------------------------------------------------------------------
select films.id_film, films.titre
from films
join participations_films pf using (id_film)

-- On veut que le film ait la participation de Ingrid Bergman
where exists(
    select *
    from participations_films
    where pf.id_artisan = (
        select id_artisan
        from artisans
        where prenom = 'Ingrid' and
              nom = 'Bergman'
        )
    )

-- Et on veut egalement que le film comporte la participation de Marcello Mastroianni
and exists(
    select *
    from participations_films
    where pf.id_artisan = (
        select id_artisan
        from artisans
        where prenom = 'Marcello' and
              nom = 'Mastroianni'
        )
    )
;



-- 4. Quels sont les films coproduits par un producteur français et un producteur italien?
------------------------------------------------------------------------------------------
select films.id_film, films.titre
from films
join productions_films pf using (id_film)

where exists(
    select *
    from productions_films
    where localisation = 'FR' and
          productions_films.id_film = pf.id_film
    )

and exists(
    select *
    from productions_films
    where localisation = 'IT' and
          productions_films.id_film = pf.id_film
    )
;



-- 5. Quels sont les acteurs italiens ayant gagné le prix d’interprétation masculine au Festival de Cannes?
-----------------------------------------------------------------------------------------------------------
select artisans.id_artisan, artisans.prenom, artisans.nom
from artisans
join remises_prix_artisans using (id_artisan)
join nationalites using (id_artisan)

where nationalites.id_pays = 'IT' and
      remises_prix_artisans.id_prix = (
          select id_prix
          from prix
          where nom_prix ilike '%Festival de Cannes%interpretation masculine%'
      )
;


-- 6. Quelles sont les actrices ayant une triple nationalité?
-------------------------------------------------------------
select a.id_artisan, a.prenom, a.nom
from artisans a
where sexe = 'F'
and (
    select count(id_artisan)
    from nationalites n
    group by n.id_artisan
    ) = 3
;



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



-- 8. Quelle est la distribution par pays des Palmes d’or au Festival de Cannes?
--------------------------------------------------------------------------------
select pf.localisation, count(*) as nb_total_de_palmes_dor
from remises_prix_films rpf
join productions_films pf using (id_film)
join prix p using (id_prix)

-- Le prix doit etre la palme d'or de Cannes
where p.nom_prix ilike '%Festival de Cannes%Palmes d’or%'

-- On regroupe les films selon leur origine
group by (pf.localisation);



-- 9. Quels sont les 10 films québécois ayant eu le plus d’entrées payantes à leur sortie en salle, au Québec, au Canada, en France, aux États-Unis?
----------------------------------------------------------------------------------------------------------------------------------------------------

-- Comme nous ne considerons pas que le Quebec est un pays, nous allons remplacer cette selection par la suivante qui est plus idoine
-- 9. Quels sont les 10 films canadiens ayant eu le plus d’entrées payantes à leur sortie en salle, au Canada, en France, aux États-Unis?

CREATE OR REPLACE VIEW films_canadiens(id_film, titre, annee_de_parution, origine) as (
    select f.id_film, f.titre, f.annee_de_parution, pf.localisation
    from films f
    join productions_films pf using (id_film)
    where pf.localisation = 'CA'
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



-- 10. Quels sont les acteurs ayant doublé Clint Eastwood en français dans au moins deux films?
-----------------------------------------------------------------------------------------------
select a.id_artisan, a.prenom, a.nom
from artisans a
where (
    select count(*)
    from doublages_films df
    where artisan_double = (
        select id_artisan
        from artisans
        where prenom = 'Clint' and
              nom = 'Eastwood')
    and df.id_langue like 'fr%'
    group by id_artisan
    ) >= 2
;
