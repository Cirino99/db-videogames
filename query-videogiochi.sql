--QUERY SELECT

--1- Selezionare tutte le software house americane (3)
--SELECT * 
--FROM software_houses
--WHERE country = 'United States';

--2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)
--SELECT *
--FROM players
--WHERE city = 'Rogahnland';

--3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)
--SELECT *
--FROM players
--WHERE name LIKE '%a';

--4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)
--SELECT *
--FROM reviews
--WHERE player_id = 800;

--5- Contare quanti tornei ci sono stati nell'anno 2015 (9)
--SELECT count(*)
--FROM tournaments
--where year = '2015';

--6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)
--SELECT *
--FROM awards
--WHERE description LIKE '%facere%';

--7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)
--SELECT DISTINCT videogame_id
--FROM category_videogame
--WHERE category_id = 2 OR category_id = 6;

--8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)
--SELECT *
--FROM reviews
--WHERE rating >= 2 AND rating <=4;

--9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)
--SELECT *
--FROM videogames
--WHERE release_date >= '01/01/2020' AND release_date <= '31/12/2020';

--10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da 5 stelle, mostrandoli una sola volta (443)
--SELECT DISTINCT videogame_id
--FROM reviews
--WHERE rating = 5;

--*********** BONUS ***********

--11- Selezionare il numero e la media delle recensioni per il videogioco con ID = 412 (review number = 12, avg_rating = 3)
--SELECT count(*) as [review number], avg(rating) as [avg rating]
--FROM reviews
--WHERE videogame_id = 412
--GROUP BY videogame_id;

--12- Selezionare il numero di videogame che la software house con ID = 1 ha rilasciato nel 2018 (13)
--SELECT count(*) as [number videovame]
--FROM videogames
--WHERE software_house_id = 1 AND release_date >= '01/01/2018' AND release_date <= '31/12/2018';
--SELECT count(*) as [number videovame]
--FROM videogames
--WHERE software_house_id = 1 AND datepart(year,release_date) = '2018';

--QUERY CON GROUPBY

--1- Contare quante software house ci sono per ogni paese (3)
--SELECT count(*) as [software house], country
--FROM software_houses
--GROUP BY country;

--2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)
--SELECT count(*) as [number review], videogame_id
--FROM reviews
--GROUP BY videogame_id;

--3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)
--SELECT count(*) as [number videogame], pegi_label_id
--FROM pegi_label_videogame
--GROUP BY pegi_label_id;

--4- Mostrare il numero di videogiochi rilasciati ogni anno (11)
--SELECT count(*) as [number videogame], datepart(year,release_date)
--FROM videogames
--GROUP BY datepart(year,release_date);

--5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)
--SELECT count(*) as [number videogame], device_id
--FROM device_videogame
--GROUP BY device_id;

--6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)
--SELECT videogame_id, avg(rating) as [avg rating]
--FROM reviews
--GROUP BY videogame_id;

--QUERY CON JOIN

--1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)
--SELECT DISTINCT players.*
--FROM players
--INNER JOIN reviews
--ON reviews.player_id = players.id;

--2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)
--SELECT videogames.id, videogames.name
--FROM videogames
--INNER JOIN tournament_videogame
--ON videogames.id = tournament_videogame.videogame_id
--INNER JOIN tournaments
--ON tournament_videogame.tournament_id = tournaments.id
--WHERE tournaments.year = '2016'
--GROUP BY videogames.id, videogames.name;

--3- Mostrare le categorie di ogni videogioco (1718)
--SELECT videogames.id, videogames.name, categories.id, categories.name
--FROM videogames
--INNER JOIN category_videogame
--ON videogames.id = category_videogame.videogame_id
--INNER JOIN categories
--ON category_videogame.category_id = categories.id

--4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
--SELECT DISTINCT software_houses.*
--FROM software_houses
--INNER JOIN videogames
--ON software_houses.id = videogames.software_house_id
--WHERE videogames.release_date > '2020';

--5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)
--SELECT software_houses.id, software_houses.name, awards.id, awards.name
--FROM software_houses
--INNER JOIN videogames
--ON software_houses.id = videogames.software_house_id
--INNER JOIN award_videogame
--ON videogames.id = award_videogame.videogame_id
--INNER JOIN awards
--ON award_videogame.award_id = awards.id
--ORDER BY software_houses.id;

--6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
--SELECT DISTINCT  videogames.name, categories.name, pegi_labels.name
--FROM categories
--INNER JOIN category_videogame
--ON categories.id = category_videogame.category_id
--INNER JOIN videogames
--ON category_videogame.videogame_id = videogames.id
--INNER JOIN pegi_label_videogame
--ON videogames.id = pegi_label_videogame.videogame_id
--INNER JOIN pegi_labels
--ON pegi_label_videogame.pegi_label_id = pegi_labels.id
--INNER JOIN reviews
--ON videogames.id = reviews.videogame_id
--WHERE reviews.rating >=4;

--7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)
--SELECT DISTINCT videogames.id, videogames.name
--FROM videogames
--INNER JOIN tournament_videogame
--ON videogames.id = tournament_videogame.videogame_id
--INNER JOIN tournaments
--ON tournament_videogame.tournament_id = tournaments.id
--INNER JOIN player_tournament
--ON tournaments.id = player_tournament.tournament_id
--INNER JOIN players
--ON player_tournament.player_id = players.id
--WHERE players.name LIKE 'S%';

--8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)
--SELECT DISTINCT tournaments.city
--FROM tournaments
--INNER JOIN tournament_videogame
--ON tournaments.id = tournament_videogame.tournament_id
--INNER JOIN videogames
--ON tournament_videogame.videogame_id = videogames.id
--INNER JOIN award_videogame
--ON videogames.id = award_videogame.videogame_id
--INNER JOIN awards
--ON award_videogame.award_id = awards.id
--WHERE awards.id = 1 AND award_videogame.year = '2018';

--9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)
--SELECT players.*, tournaments.name
--FROM tournaments
--INNER JOIN player_tournament
--ON tournaments.id = player_tournament.tournament_id
--INNER JOIN players
--ON player_tournament.player_id = players.id
--INNER JOIN tournament_videogame
--ON tournaments.id = tournament_videogame.tournament_id
--INNER JOIN videogames
--ON tournament_videogame.videogame_id = videogames.id
--INNER JOIN award_videogame
--ON videogames.id = award_videogame.videogame_id
--INNER JOIN awards
--ON award_videogame.award_id = awards.id
--WHERE awards.id = 2 AND award_videogame.year = '2018' AND tournaments.year = '2019'
--ORDER BY players.id;


--*********** BONUS ***********

--10- Selezionare i dati della prima software house che ha rilasciato un gioco, assieme ai dati del gioco stesso (software house id : 5)
--SELECT TOP 1 software_houses.id, software_houses.name, videogames.id, videogames.name, videogames.release_date
--FROM software_houses
--INNER JOIN videogames
--ON software_houses.id = videogames.software_house_id
--ORDER BY videogames.release_date ASC;

--11- Selezionare i dati del videogame (id, name, release_date, totale recensioni) con più recensioni (videogame id : 398)
--SELECT TOP 1 videogames.id, videogames.name, videogames.release_date, count(*) as [number_review]
--FROM videogames
--INNER JOIN reviews
--ON videogames.id = reviews.videogame_id
--GROUP BY videogames.id, videogames.name, videogames.release_date
--ORDER BY number_review DESC;

--12- Selezionare la software house che ha vinto più premi tra il 2015 e il 2016 (software house id : 1)
--SELECT TOP 1 software_houses.id, software_houses.name, count(*) as [number_awards]
--FROM software_houses
--INNER JOIN videogames
--ON software_houses.id = videogames.software_house_id
--INNER JOIN award_videogame
--ON videogames.id = award_videogame.videogame_id
--WHERE award_videogame.year >= '2015' AND award_videogame.year <= '2016'
--GROUP BY software_houses.id, software_houses.name
--ORDER BY number_awards DESC;

----13- Selezionare le categorie dei videogame i quali hanno una media recensioni inferiore a 1.5 (10)
--SELECT categories.id, categories.name, avg(cast(reviews.rating as decimal)) as [avg_reviews]
--FROM categories
--INNER JOIN category_videogame
--ON categories.id = category_videogame.category_id
--INNER JOIN videogames
--ON category_videogame.videogame_id = videogames.id
--INNER JOIN reviews
--ON videogames.id = reviews.videogame_id
--GROUP BY categories.id, categories.name, videogames.id
--HAVING avg(cast(reviews.rating as decimal)) < 1.5
--ORDER BY avg_reviews ASC;