drop database if exists nexogamerdb;
create database nexogamerdb;
use nexogamerdb;

-- Creación de la tabla de usuarios de la página web de NexoGamer
CREATE TABLE users(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    contraseña VARCHAR(200),
    telefono CHAR(9),
    email VARCHAR(100),
    juegoFavoritoId INT, /*Clave foránea*/
    comentarioJuegoId INT, /*Clave foránea*/
    sessionToken VARCHAR(500)
);

-- Creación de la tabla de juegos de NexoGamer
CREATE TABLE juegos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    genero VARCHAR(200),
    fechaSalida YEAR,
    consola VARCHAR(200),
    descripcion VARCHAR(1000),
    urlImagen VARCHAR(200),
    compañia VARCHAR(1000),
    valoracion INT,
    comentarioId INT /*Clave foránea*/
);

-- Creación de la tabla que albergará todos los comentarios de cada juego. Se hace esta distinción tan clara entre tablas para no equivocarse facilmente
CREATE TABLE comentariosJuegos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    comentario VARCHAR(500),
    juegoId INT, /*Clave foránea*/
    userId INT /*Clave foránea*/
);

-- Creación de la tabla favoritos de NexoGamer
CREATE TABLE favoritos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    juegoId INT, /*Clave foránea*/
    userId INT, /*Clave foránea*/
    esFavorito BOOLEAN
);

-- Creación de la tabla plataformasJuegos que almacenará todas las plataformas como Steam, Epic Games, etc de NexoGamer
CREATE TABLE plataformasJuegos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    juegoId INT /*Clave foránea*/
);

-- Inserciones de la tabla users
INSERT INTO users (nombre, apellidos, contraseña, telefono, email, juegoFavoritoId, comentarioJuegoId) VALUES
('John', 'Doe', 'Contraseña123', '123456789', 'john.doe@email.com', 1, 1),
('Jane', 'Smith', 'OtraContraseña', '987654321', 'jane.smith@email.com', 2, 2),
('Michael', 'Johnson', 'Pass123', '555666777', 'michael.johnson@email.com', 3, 3),
('Emily', 'Williams', 'SecurePwd', '111222333', 'emily.williams@email.com', 4, 4),
('David', 'Brown', 'SecretPass', '999888777', 'david.brown@email.com', 5, 5),
('Olivia', 'Davis', 'Hidden123', '333444555', 'olivia.davis@email.com', 6, 6),
('William', 'Martinez', 'TopSecret', '777888999', 'william.martinez@email.com', 7, 7),
('Sophia', 'Anderson', 'Confidential', '444555666', 'sophia.anderson@email.com', 8, 8),
('James', 'Taylor', 'Secure123', '666777888', 'james.taylor@email.com', 9, 9),
('Emma', 'Hernandez', 'SafePwd', '888999000', 'emma.hernandez@email.com', 10, 10);

-- Inserciones de la tabla juegos
INSERT INTO juegos (nombre, genero, fechaSalida, consola, descripcion, urlImagen, compañia, valoracion, comentarioId) VALUES
('League of Legends','MOBA',2009,'Ordenador','League of Legends es un juego de estrategia en tiempo real donde dos equipos de cinco jugadores compiten para destruir la base enemiga. Cada jugador controla un campeón único con habilidades especiales, y la cooperación en equipo es esencial para la victoria. Con constantes actualizaciones de contenido y una gran variedad de campeones, LoL ha sido un pilar en la escena de los deportes electrónicos desde su lanzamiento en 2009.','https://i.blogs.es/ff4f41/elqk-v1wmauw09m/1366_2000.jpg','Riot Games', 8.5, 1),
('VALORANT','Shooter',2019,'Ordenador','Valorant es un shooter táctico en primera persona desarrollado por Riot Games, donde dos equipos de cinco jugadores compiten en rondas para completar objetivos. Cada jugador elige un agente con habilidades únicas que complementan la estrategia del equipo. Con un enfoque en la precisión y la coordinación del equipo, Valorant combina elementos de juego táctico con mecánicas de disparos rápidos. Desde su lanzamiento en 2020, Valorant ha ganado popularidad como un título destacado en el género de los shooters tácticos.','https://i.blogs.es/3f15c2/valorant/1366_2000.jpg','Riot Games', 9, 2),
('Stardew Valley','Simulacion',2016,'Ordenador','Stardew Valley es un juego de simulación de granja desarrollado por ConcernedApe, donde los jugadores heredan una granja y trabajan para restaurarla a su antigua gloria. Los jugadores cultivan cultivos, cuidan animales, pescan y exploran la encantadora ciudad rural de Stardew Valley. Con una jugabilidad relajante y una amplia variedad de actividades, el juego ofrece una experiencia tranquila y gratificante. Desde su lanzamiento en 2016, Stardew Valley ha sido elogiado por su encanto, profundidad y capacidad para cautivar a los jugadores con su estilo de vida rural virtual.','https://pbs.twimg.com/media/EsxAdS4XMAIB8Bm.jpg:large','ConcernedApe, Sickhead Games, The Secret Police Limited', 10, 3),
('Inazuma Eleven: Heroes Victory Road','Rol',2024,'Ordenador/Nintendo Switch/Xbox/Playstation/Teléfono','Inazuma Eleven: Heroes Victory Road es un juego de rol y fútbol desarrollado por Level-5 para la consola Nintendo 3DS. Los jugadores asumen el papel de un entrenador que lidera un equipo de fútbol en su camino hacia la victoria. Con mecánicas de juego únicas que combinan elementos de RPG y deportes, los jugadores reclutan jugadores, entrenan habilidades y compiten en emocionantes partidos. Con su cautivadora historia y carismáticos personajes, Heroes Victory Road ofrece una experiencia emocionante tanto para los fanáticos de Inazuma Eleven como para los amantes de los juegos de rol.','https://assetsio.gnwcdn.com/inazuma.png?width=1200&height=600&fit=crop&enable=upscale&auto=webp','Level-5', 9, 4),
('Elden Ring','Rol',2022,'Ordenador/Playstation 5/Playstation 4/Xbox Series X y Series S/Xbox One','Elden Ring es un esperado juego de rol de acción desarrollado por FromSoftware en colaboración con el autor de fantasía George R. R. Martin. Ambientado en un vasto mundo abierto lleno de misterio y peligro, los jugadores exploran paisajes épicos, enfrentan desafiantes enemigos y descubren una historia rica en lore. Con un énfasis en la exploración, la personalización del personaje y el combate desafiante, Elden Ring promete ofrecer una experiencia inmersiva para los aficionados de los juegos de rol y los seguidores de la obra de Martin. Su lanzamiento altamente anticipado ha generado gran expectativa entre la comunidad de videojuegos.','https://image.api.playstation.com/vulcan/ap/rnd/202107/1612/Y5RHNmzAtc6sRYwZlYiKHAxN.png','FromSoftware', 9, 5),
('Red Dead Redemption 2','Acción/Aventuras',2018,'Playstation 4/Xbox One/Ordenador','Red Dead Redemption 2 es un épico juego de acción y aventura desarrollado por Rockstar Games. Ambientado en el Salvaje Oeste estadounidense a fines del siglo XIX, el juego sigue la historia de Arthur Morgan, un forajido y miembro de la banda de Van der Linde. Los jugadores exploran un vasto y detallado mundo abierto, participan en actividades como la caza, la pesca y el juego, y se enfrentan a peligros tanto humanos como naturales. Con una narrativa inmersiva, personajes memorables y un impresionante nivel de detalle, Red Dead Redemption 2 es aclamado como uno de los mejores juegos de la última década.','https://cdn1.epicgames.com/b30b6d1b4dfd4dcc93b5490be5e094e5/offer/RDR2476298253_Epic_Games_Wishlist_RDR2_2560x1440_V01-2560x1440-2a9ebe1f7ee202102555be202d5632ec.jpg','Rockstar Games', 9.2, 6),
('Grand Theft Auto V','Acción/Aventura',2013,'Playstation 4/Playstation 5/Playstation 3/Xbox 360/Xbox One/Xbox Series X y Series S/Ordenador','Grand Theft Auto V (GTA V) es un juego de acción y aventura desarrollado por Rockstar Games. Ambientado en la ficticia ciudad de Los Santos y sus alrededores, los jugadores asumen el papel de tres protagonistas: Michael, Franklin y Trevor, quienes se involucran en una serie de actividades criminales mientras navegan por el mundo del crimen organizado, la corrupción y la traición. Con su vasto mundo abierto, repleto de misiones, actividades secundarias y un modo multijugador robusto, GTA V ofrece una experiencia de juego dinámica y llena de acción. Desde su lanzamiento en 2013, ha sido uno de los juegos más exitosos y aclamados por la crítica de todos los tiempos.','https://assetsio.gnwcdn.com/eurogamer-zjp1vx.jpg?width=1200&height=1200&fit=bounds&quality=70&format=jpg&auto=webp','Rockstar Games', 9, 7),
('Fall Guys','Battle Royale',2020,'Nintendo Switch/PlayStation 5/PlayStation 4/Ordenador/Xbox Series X y Series S','Fall Guys: Ultimate Knockout es un juego de tipo battle royale desarrollado por Mediatonic. En él, hasta 60 jugadores controlan adorables personajes llamados "Fall Guys" en una serie de desafiantes pruebas y obstáculos en una competencia estilo juego de televisión. Los jugadores deben superar diversos obstáculos, competir en mini-juegos y evitar caer en eliminaciones hasta que solo quede un ganador. Con su diseño colorido, mecánicas simples pero divertidas, y la emoción de la competencia multijugador, Fall Guys ha ganado popularidad como un juego socialmente divertido y accesible para jugadores de todas las edades.','https://fs-prod-cdn.nintendo-europe.com/media/images/10_share_images/games_15/nintendo_switch_download_software_1/2x1_NSwitchDS_FallGuys_image1600w.jpg','Mediatonic', 9.5, 8),
('Dark Souls III','Rol',2016,'Xbox One/Playstation 4/Ordenador','Dark Souls 3 es un desafiante juego de rol de acción desarrollado por FromSoftware. Situado en un oscuro y desolado mundo de fantasía, los jugadores asumen el papel de un no muerto que se aventura a través de peligrosas tierras en busca de la salvación. Con combates intensos y estratégicos, un mundo interconectado lleno de secretos y una atmósfera opresiva, Dark Souls 3 ofrece una experiencia inmersiva y desafiante. La habilidad del jugador para aprender y adaptarse es fundamental para sobrevivir en este mundo brutal y hostil. Desde su lanzamiento, ha sido elogiado por su diseño de niveles ingenioso, su jugabilidad satisfactoria y su narrativa ambiental profunda.','https://static.bandainamcoent.eu/high/dark-souls/dark-souls-3/00-page-setup/ds3_game-thumbnail.jpg','FromSoftware', 9, 9),
('Sea of Thieves','Acción/Aventuras',2018,'PlayStation 5/Xbox One/Xbox Series X y Series S/Ordenador','Sea of Thieves es un juego de aventuras en línea desarrollado por Rare Ltd. En él, los jugadores asumen el papel de piratas que navegan por un vasto mundo abierto lleno de islas exóticas, tesoros ocultos y peligrosos enemigos. Ya sea explorando islas misteriosas, enfrentándose a otros jugadores en batallas navales o buscando tesoros enterrados, la cooperación en equipo y la comunicación son clave para el éxito. Con su estilo visual único y su enfoque en la libertad de juego, Sea of Thieves ofrece una experiencia de piratería llena de diversión y aventura para jugadores de todas las edades.','https://xxboxnews.blob.core.windows.net/prod/sites/2/2023/12/Wire_SoT_SeasonTen_DecKeyArt_1920-1c2858eaa9526cae0631.jpg','Rare', 9, 10);

-- Inserciones de la tabla comentariosJuegos
INSERT INTO comentariosJuegos (comentario, juegoId, userId) VALUES
('Hasta os juevos deste xojiño de los cullons', 1, 1),
('Matante correndo',2,2),
('Perfecto jueguito cando javier ta modo fojonero',3,3),
('Mellor serie non pode existir neste planeta',4,4),
('Xoguiño de elevada dificultade',5,5),
('IDK',6,6),
('Ladron promedio = ekko',7,7),
('Follar jeis',8,8),
('Terceiras sombras mas oscuras',9,9),
('O mare dos piratas',10,10);

-- Inserciones de la tabla favoritos
INSERT INTO favoritos (juegoId, userId, esFavorito) VALUES 
(1, 1, true),
(2, 2, true),
(3, 3, true),
(4, 4, true),
(5, 5, true),
(6, 6, true),
(7, 7, true),
(8, 8, true),
(9, 9, true),
(10, 10, true),
(null,1,false),
(1,null,false);

-- Inserciones de la tabla plataformasJuegos
INSERT INTO plataformasJuegos (nombre, juegoId) VALUES 
('Indie', 1),
('Indie', 2),
('Steam', 3),
('En desarrollo', 4),
('Steam', 5),
('Rockstar Games', 6),
('Rockstar Games', 7),
('Epic Games', 8),
('Steam', 9),
('Steam', 10);

/*Ahora añadimos todas las claves foráneas correspondientes para el proyecto de NexoGamer*/

/*USERS*/
ALTER TABLE users ADD FOREIGN KEY (juegoFavoritoId) REFERENCES favoritos(id);
ALTER TABLE users ADD FOREIGN KEY (comentarioJuegoId) REFERENCES comentariosJuegos(id);

/*JUEGOS*/
ALTER TABLE juegos ADD FOREIGN KEY (comentarioId) REFERENCES comentariosJuegos(id);

/*COMENTARIOS JUEGOS*/
ALTER TABLE comentariosJuegos ADD FOREIGN KEY (juegoId) REFERENCES juegos(id);
ALTER TABLE comentariosJuegos ADD FOREIGN KEY (userId) REFERENCES users(id);

/*FAVORITOS*/
ALTER TABLE favoritos ADD FOREIGN KEY (juegoId) REFERENCES juegos(id);
ALTER TABLE favoritos ADD FOREIGN KEY (userId) REFERENCES users(id);

/*PLATAFORMAS JUEGOS*/
ALTER TABLE plataformasJuegos ADD FOREIGN KEY (juegoId) REFERENCES juegos(id);
