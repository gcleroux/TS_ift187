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
 un script SQL pour les invariants requis – vues, routines et déclencheurs (triggers)
 ############################################################################*/



--######################################################################################################################
-- Trigger qui s'assure qu'un artisan ne peut pas avoir une date de deces inferieure a sa date de naissance
------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION validation_date_deces()
RETURNS TRIGGER AS
    $$
    BEGIN
        if (
            select date_naissance
            from DATES_NAISSANCE
            where id_artisan = new.id_artisan
        ) > new.date_deces -- La date de naissances ne peut pas etre plus tard que la date de deces
        THEN
        RAISE NOTICE 'Erreur lors de l''insertion. L''artisan n''etait pas ne a cette date!';
        RETURN null;

        -- S'il n'y a aucune date de naissance dans la table DATES_NAISSANCE, on peut inserer normalement la valeur
        ELSE RETURN new;
        end if;
    END
    $$
LANGUAGE plpgsql;

create trigger insertions_date_deces
    before insert
    on date_deces
    for each row
    execute procedure validation_date_deces();
--######################################################################################################################



--######################################################################################################################
-- Trigger qui s'assure qu'un doublage peut etre fait seulement si les deux artisans participent au meme film et que l'un
-- d'eux est un acteur, et que l'autre est un doubleur
------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION validation_doublages_films_participations()
RETURNS TRIGGER AS
    $$
    BEGIN

        -- Verification du doubleur
        if (not exists(
                select *
                from participations_films df
                where df.id_film = new.id_film and
                      df.id_artisan = new.artisan_doubleur and
                      df.id_emploi = (select id_emploi from emplois where emploi = 'Doubleur')
                )

            -- Verification de l'artisan double
            or not exists(
                select *
                from participations_films df
                where df.id_film = new.id_film and
                      df.id_artisan = new.artisan_double and
                      df.id_emploi = (select id_emploi from emplois where emploi = 'Acteur')
                )
            ) then
            raise notice 'Erreur dans la selection des artisans. Veuillez verifier qu''ils sont bien dans la table participation_films avec les bon emplois!';
            return null;

        else return new;
        end if;

    END
    $$
LANGUAGE plpgsql;

create trigger insertions_doublages_films_participations
    before insert
    on doublages_films
    for each row
    execute procedure validation_doublages_films_participations();
--######################################################################################################################



--######################################################################################################################
-- Trigger qui s'assure que un artisan ne peut pas se doubler lui meme.

-- ** Techniquement possible qu'un artisan puisse se doubler lui meme dans une autre langue, mais le prof nous a indique
-- que nous devrions avoir une contrainte pour ne pas avoir de duplicata **
------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION validation_doublages_films_duplicata()
RETURNS TRIGGER AS
    $$
    BEGIN
        if (new.artisan_doubleur = new.artisan_double) then
            raise notice 'Erreur lors de l''insertion. L''artisan doubleur ne peut pas etre l''artisan double!';
            return null;

        else return new;
        end if;

    END
    $$
LANGUAGE plpgsql;

create trigger insertions_doublages_films_duplicata
    before insert
    on doublages_films
    for each row
    execute procedure validation_doublages_films_duplicata();
--######################################################################################################################



--######################################################################################################################
-- Trigger qui s'assure qu'un artisan soit ne a la sortie d'un film pour assurer la validite de sa participation
------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION validation_participations_films_date_naissance()
RETURNS TRIGGER AS
    $$
    BEGIN
        if (
            (select extract(year from date_naissance)
            from DATES_NAISSANCE
            where id_artisan = new.id_artisan)
            >
            (select annee_de_parution
            from films
            where id_film = new.id_film))
            then
            raise notice 'Erreur lors de l''insertion. L''artisan n''etait pas ne a la sortie du film!';
            return null;

        else return new;
        end if;

    END
    $$
LANGUAGE plpgsql;

create trigger insertions_participations_films
    before insert
    on participations_films
    for each row
    execute procedure validation_participations_films_date_naissance();
--######################################################################################################################



--######################################################################################################################
-- Trigger qui s'assure qu'un film soit bien sorti en salle lors de l'annee de la remise d'un prix
------------------------------------------------------------------------------------------------------------------------
create or replace function validation_remises_prix_films_annee()
returns trigger as
    $$
        begin
            if (
                new.annee
                <
                (select annee_de_parution
                from films
                where id_film = new.id_film)
                ) then
                raise notice 'Erreur lors de l''insertion. Le film n''etait pas sorti a l''annee de la remise de ce prix!';
                return null;

            else return new;
            end if;
        end
    $$
language plpgsql;

create trigger insertions_remises_prix_films
    before insert
    on remises_prix_films
    for each row
    execute procedure validation_remises_prix_films_annee();
--######################################################################################################################



--######################################################################################################################
-- Trigger qui s'assure qu'un artisan soit bien present dans un film pour assurer la validite du prix qu'il lui est remis
------------------------------------------------------------------------------------------------------------------------
create or replace function validation_remises_prix_artisans_participation()
returns trigger as
    $$
        begin
            if (
                not exists(
                    select *
                    from participations_films pf
                    where pf.id_artisan = new.id_artisan)
                ) then
                raise notice 'Erreur lors de l''insertion. L''artisan ne fait pas parti de ce film!';
                return null;

            else return new;
            end if;
        end
    $$
language plpgsql;

create trigger insertions_remises_prix_artisans_participation
    before insert
    on remises_prix_artisans
    for each row
    execute procedure validation_remises_prix_artisans_participation();
--######################################################################################################################



--######################################################################################################################
-- Trigger qui s'assure qu'un artisan soit ne a l'annee de la remise de son prix
------------------------------------------------------------------------------------------------------------------------
create or replace function validation_remises_prix_artisans_annee()
returns trigger as
    $$
        begin
            if (
                new.annee
                <
                (select annee_de_parution
                from films
                where id_film = new.id_film)
                ) then
                raise notice 'Erreur lors de l''insertion. Le film n''etait pas sorti a l''annee de la remise de ce prix!';
                return null;

            else return new;
            end if;
        end
    $$
language plpgsql;

create trigger insertions_remises_prix_artisans_annee
    before insert
    on remises_prix_artisans
    for each row
    execute procedure validation_remises_prix_artisans_annee();
--######################################################################################################################



--######################################################################################################################
-- Trigger qui s'assure qu'un film est bien ete presente dans un pays dans leqyel pour qu'il y ait des recettes associees
------------------------------------------------------------------------------------------------------------------------
create or replace function validation_recettes_pays()
returns trigger as
    $$
        begin
            if (not exists(
                select *
                from pays_presentes pp
                where pp.id_film = new.id_film and
                      pp.id_pays = new.id_pays
                )) then
                raise notice 'Erreur lors de l''insertion. Le film n''a pas ete presente dans ce pays!';
                return null;

            else return new;
            end if;
        end
    $$
language plpgsql;

create trigger insertions_recettes_pays
    before insert
    on recettes
    for each row
    execute procedure validation_recettes_pays();
--######################################################################################################################



--######################################################################################################################
-- Trigger qui s'assure qu'un film est bien sorti a l'annee des recettes associees
------------------------------------------------------------------------------------------------------------------------
create or replace function validation_recettes_annee()
returns trigger as
    $$
        begin
            if (
                new.annee
                <
                (select annee_de_parution
                from films
                where id_film = new.id_film)
                ) then
                raise notice 'Erreur lors de l''insertion. Le film n''etait pas sorti a l''annee entree!';
                return null;

            else return new;
            end if;
        end
    $$
language plpgsql;

create trigger insertions_recettes_annee
    before insert
    on recettes
    for each row
    execute procedure validation_recettes_annee();
--######################################################################################################################