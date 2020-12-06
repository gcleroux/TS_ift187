/*############################################################################
 un script SQL pour les interfaces MM offertes – vues, routines et déclencheurs (triggers)
 ############################################################################*/



--######################################################################################################################
-- Creation d'une view qui regroupe tous les films canadiens de la bd
---------------------------------------------------------------------
CREATE OR REPLACE VIEW films_canadiens(id_film, titre, annee_de_parution, origine) as (
    select f.id_film, f.titre, f.annee_de_parution, pf.localisation
    from films f
    join productions_films pf using (id_film)
    where pf.localisation = 'CA' -- Le film est canadien
);
--######################################################################################################################



--######################################################################################################################
-- Automatisme qui ajoute un film a la view des films_canadiens a l'ajout d'un film canadien dans la table productions_films
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION validation_films_canadiens()
    returns trigger as
    $$
        BEGIN
            if(
                select new.localisation
                from productions_films
                ) = 'CA'
                THEN
                    with merger_film(id_film, titre, annee, origine) as(
                        select f.id_film, f.titre, f.annee_de_parution, pf.localisation
                        from productions_films pf
                        join films f using (id_film)
                        where id_film = new.id_film and
                              localisation = new.localisation
                    )
                insert into films_canadiens(id_film, titre, annee_de_parution, origine) VALUES
                (new.id_film, merger_film.titre, merger_film.annee, new.localisation);
                return new;
            end if;

            return new; -- Si la localisation du nouveau film n'est pas canadien, on fait l'insertion normale
        end
    $$
LANGUAGE plpgsql;

create trigger insertions_films_canadiens
    before insert
    on productions_films
    for each row
    execute procedure validation_films_canadiens();
--######################################################################################################################