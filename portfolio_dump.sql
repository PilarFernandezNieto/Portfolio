-- Valentina Studio --
-- MySQL dump --
-- ---------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- ---------------------------------------------------------


-- DROP TABLE "about" ------------------------------------------
DROP TABLE IF EXISTS `about` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "about" ----------------------------------------
CREATE TABLE `about`( 
	`id` BigInt( 0 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`bio` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`details` JSON NOT NULL,
	`created_at` Timestamp NULL DEFAULT NULL,
	`updated_at` Timestamp NULL DEFAULT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 3;
-- -------------------------------------------------------------


-- DROP TABLE "cache" ------------------------------------------
DROP TABLE IF EXISTS `cache` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "cache" ----------------------------------------
CREATE TABLE `cache`( 
	`key` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`value` MediumText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`expiration` BigInt( 0 ) NOT NULL,
	PRIMARY KEY ( `key` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- DROP TABLE "cache_locks" ------------------------------------
DROP TABLE IF EXISTS `cache_locks` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "cache_locks" ----------------------------------
CREATE TABLE `cache_locks`( 
	`key` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`owner` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`expiration` BigInt( 0 ) NOT NULL,
	PRIMARY KEY ( `key` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- DROP TABLE "failed_jobs" ------------------------------------
DROP TABLE IF EXISTS `failed_jobs` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "failed_jobs" ----------------------------------
CREATE TABLE `failed_jobs`( 
	`id` BigInt( 0 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`uuid` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`connection` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`queue` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`payload` LongText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`exception` LongText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`failed_at` Timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `failed_jobs_uuid_unique` UNIQUE( `uuid` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- DROP TABLE "job_batches" ------------------------------------
DROP TABLE IF EXISTS `job_batches` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "job_batches" ----------------------------------
CREATE TABLE `job_batches`( 
	`id` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`total_jobs` Int( 0 ) NOT NULL,
	`pending_jobs` Int( 0 ) NOT NULL,
	`failed_jobs` Int( 0 ) NOT NULL,
	`failed_job_ids` LongText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`options` MediumText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`cancelled_at` Int( 0 ) NULL DEFAULT NULL,
	`created_at` Int( 0 ) NOT NULL,
	`finished_at` Int( 0 ) NULL DEFAULT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- DROP TABLE "jobs" -------------------------------------------
DROP TABLE IF EXISTS `jobs` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "jobs" -----------------------------------------
CREATE TABLE `jobs`( 
	`id` BigInt( 0 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`queue` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`payload` LongText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`attempts` SmallInt( 0 ) UNSIGNED NOT NULL,
	`reserved_at` Int( 0 ) UNSIGNED NULL DEFAULT NULL,
	`available_at` Int( 0 ) UNSIGNED NOT NULL,
	`created_at` Int( 0 ) UNSIGNED NOT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- DROP TABLE "migrations" -------------------------------------
DROP TABLE IF EXISTS `migrations` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "migrations" -----------------------------------
CREATE TABLE `migrations`( 
	`id` Int( 0 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`migration` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`batch` Int( 0 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 9;
-- -------------------------------------------------------------


-- DROP TABLE "password_reset_tokens" --------------------------
DROP TABLE IF EXISTS `password_reset_tokens` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "password_reset_tokens" ------------------------
CREATE TABLE `password_reset_tokens`( 
	`email` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`token` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`created_at` Timestamp NULL DEFAULT NULL,
	PRIMARY KEY ( `email` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- DROP TABLE "personal_access_tokens" -------------------------
DROP TABLE IF EXISTS `personal_access_tokens` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "personal_access_tokens" -----------------------
CREATE TABLE `personal_access_tokens`( 
	`id` BigInt( 0 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`tokenable_type` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`tokenable_id` BigInt( 0 ) UNSIGNED NOT NULL,
	`name` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`token` VarChar( 64 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`abilities` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`last_used_at` Timestamp NULL DEFAULT NULL,
	`expires_at` Timestamp NULL DEFAULT NULL,
	`created_at` Timestamp NULL DEFAULT NULL,
	`updated_at` Timestamp NULL DEFAULT NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `personal_access_tokens_token_unique` UNIQUE( `token` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 13;
-- -------------------------------------------------------------


-- DROP TABLE "project_images" ---------------------------------
DROP TABLE IF EXISTS `project_images` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "project_images" -------------------------------
CREATE TABLE `project_images`( 
	`id` BigInt( 0 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`project_id` BigInt( 0 ) UNSIGNED NOT NULL,
	`path` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`order` Int( 0 ) UNSIGNED NOT NULL DEFAULT 0,
	`created_at` Timestamp NULL DEFAULT NULL,
	`updated_at` Timestamp NULL DEFAULT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 36;
-- -------------------------------------------------------------


-- DROP TABLE "projects" ---------------------------------------
DROP TABLE IF EXISTS `projects` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "projects" -------------------------------------
CREATE TABLE `projects`( 
	`id` BigInt( 0 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`title` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`intro` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`description` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`image` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`url` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`technologies` JSON NOT NULL,
	`order` Int( 0 ) UNSIGNED NOT NULL DEFAULT 0,
	`visible` TinyInt( 1 ) NOT NULL DEFAULT 1,
	`created_at` Timestamp NULL DEFAULT NULL,
	`updated_at` Timestamp NULL DEFAULT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 10;
-- -------------------------------------------------------------


-- DROP TABLE "sessions" ---------------------------------------
DROP TABLE IF EXISTS `sessions` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "sessions" -------------------------------------
CREATE TABLE `sessions`( 
	`id` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`user_id` BigInt( 0 ) UNSIGNED NULL DEFAULT NULL,
	`ip_address` VarChar( 45 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`user_agent` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`payload` LongText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`last_activity` Int( 0 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- DROP TABLE "users" ------------------------------------------
DROP TABLE IF EXISTS `users` CASCADE;
-- -------------------------------------------------------------


-- CREATE TABLE "users" ----------------------------------------
CREATE TABLE `users`( 
	`id` BigInt( 0 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`email` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`email_verified_at` Timestamp NULL DEFAULT NULL,
	`password` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`remember_token` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`created_at` Timestamp NULL DEFAULT NULL,
	`updated_at` Timestamp NULL DEFAULT NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `users_email_unique` UNIQUE( `email` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 2;
-- -------------------------------------------------------------


-- Dump data of "about" ------------------------------------
BEGIN;

INSERT INTO `about`(`id`,`bio`,`details`,`created_at`,`updated_at`) VALUES 
( '1', 'Soy desarrolladora full-stack con base en Gijón. Llegué a la programación después de años trabajando de cara al público, y eso cambió bastante cómo entiendo este trabajo: me importa que las cosas funcionen bien para quien las usa, no solo para quien las escribe.', '[{"label": "Experiencia", "value": "2+ años en desarrollo web"}, {"label": "Formación", "value": "CFGS DAW · CIFP La Laboral"}, {"label": "Ubicación", "value": "Gijón, Asturias"}, {"label": "Idiomas", "value": "Español nativo · Inglés B2"}]', '2026-05-26 18:43:24', '2026-05-26 18:43:24' ),
( '2', 'Soy desarrolladora full-stack con base en Gijón. Llegué a la programación después de años trabajando de cara al público, y eso cambió bastante cómo entiendo este trabajo: me importa que las cosas funcionen bien para quien las usa, no solo para quien las escribe.', '[{"label": "Experiencia", "value": "2+ años en desarrollo web"}, {"label": "Formación", "value": "CFGS DAW · CIFP La Laboral"}, {"label": "Ubicación", "value": "Gijón, Asturias"}, {"label": "Idiomas", "value": "Español nativo · Inglés B2"}]', '2026-05-26 18:44:03', '2026-05-26 18:44:03' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "cache" ------------------------------------
BEGIN;

INSERT INTO `cache`(`key`,`value`,`expiration`) VALUES 
( 'laravel-cache-5c785c036466adea360111aa28563bfd556b5fba', 'i:1;', '1782758939' ),
( 'laravel-cache-5c785c036466adea360111aa28563bfd556b5fba:timer', 'i:1782758939;', '1782758939' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "cache_locks" ------------------------------
-- ---------------------------------------------------------


-- Dump data of "failed_jobs" ------------------------------
-- ---------------------------------------------------------


-- Dump data of "job_batches" ------------------------------
-- ---------------------------------------------------------


-- Dump data of "jobs" -------------------------------------
-- ---------------------------------------------------------


-- Dump data of "migrations" -------------------------------
BEGIN;

INSERT INTO `migrations`(`id`,`migration`,`batch`) VALUES 
( '1', '0001_01_01_000000_create_users_table', '1' ),
( '2', '0001_01_01_000001_create_cache_table', '1' ),
( '3', '0001_01_01_000002_create_jobs_table', '1' ),
( '4', '2026_05_25_180229_create_projects_table', '2' ),
( '5', '2026_05_25_180236_create_about_table', '2' ),
( '6', '2026_05_25_181338_create_personal_access_tokens_table', '3' ),
( '7', '2026_06_22_000000_create_project_images_table', '4' ),
( '8', '2026_06_28_000000_add_intro_to_projects_table', '5' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "password_reset_tokens" --------------------
-- ---------------------------------------------------------


-- Dump data of "personal_access_tokens" -------------------
BEGIN;

INSERT INTO `personal_access_tokens`(`id`,`tokenable_type`,`tokenable_id`,`name`,`token`,`abilities`,`last_used_at`,`expires_at`,`created_at`,`updated_at`) VALUES 
( '12', 'App\\Models\\User', '1', 'portfolio-token', 'b1d8037df6f1d5f170384ed66d01e243fcfc018bc82fb0c6615aaf0bb9d1e012', '["*"]', '2026-06-29 18:28:07', NULL, '2026-06-29 18:23:43', '2026-06-29 18:28:07' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "project_images" ---------------------------
BEGIN;

INSERT INTO `project_images`(`id`,`project_id`,`path`,`order`,`created_at`,`updated_at`) VALUES 
( '23', '3', 'projects/DFPbyMPYOdaKFcxM2SRTrqwTTgF6IFmISzQwDWLx.png', '1', '2026-06-28 17:30:29', '2026-06-28 17:45:39' ),
( '24', '3', 'projects/GRkkGhN2OWq2UtxPYmYR8oHFnuY44vOecL3Bz1vk.png', '3', '2026-06-28 17:30:39', '2026-06-28 17:45:39' ),
( '25', '3', 'projects/Wu8vrPcKI2pmL28jHUqFd5hrPM8eXLbY989nqkyx.png', '6', '2026-06-28 17:31:30', '2026-06-28 17:45:39' ),
( '26', '3', 'projects/KvaOaWrM5M1Bpcsc4wlCdvw3J2bxdiH4SRhDPG53.png', '0', '2026-06-28 17:31:40', '2026-06-28 17:45:39' ),
( '27', '3', 'projects/AfaIRRhFrbMI3nocS7VE80lyWI9CotiwdicenXzf.png', '7', '2026-06-28 17:42:33', '2026-06-28 17:45:39' ),
( '28', '3', 'projects/ukDJMPjzod4k0irny7zYkFVyeLn4zUtOr1Vcknmy.png', '5', '2026-06-28 17:42:37', '2026-06-28 17:45:39' ),
( '29', '3', 'projects/A63S04uG60lXqbpZhaJFQLIYidlk2hZU4hXdCOmI.png', '4', '2026-06-28 17:42:46', '2026-06-28 17:45:39' ),
( '31', '7', 'projects/zoWJvRrkLB64xJNUkq1K7I1NdDxuGxF6dCOD3wBe.png', '0', '2026-06-29 15:59:10', '2026-06-29 15:59:10' ),
( '32', '7', 'projects/DNQcaqLL28oxtqcR2e8EI3QtGeUa7ESpbk84Xs76.png', '1', '2026-06-29 15:59:16', '2026-06-29 15:59:16' ),
( '33', '7', 'projects/nkYCxA4BuhCOFCFSFZ1dKcicbHStcssYLEf7AloX.png', '2', '2026-06-29 15:59:20', '2026-06-29 15:59:20' ),
( '34', '7', 'projects/cd1sOZKV86iFTTOYuAUKlR88TYDRY2kmo8LjVjsT.png', '3', '2026-06-29 15:59:24', '2026-06-29 15:59:24' ),
( '35', '7', 'projects/FhbyWSmpUOdWBnVU1ifk6aTkpP1GDUP66uZfh2Jg.png', '4', '2026-06-29 15:59:27', '2026-06-29 15:59:27' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "projects" ---------------------------------
BEGIN;

INSERT INTO `projects`(`id`,`title`,`intro`,`description`,`image`,`url`,`technologies`,`order`,`visible`,`created_at`,`updated_at`) VALUES 
( '3', 'The Electric Buffalo', 'Mi primer proyecto personal: el sitio web de una banda de música real, con todo lo que eso implica - decisiones de diseño propias, problemas inesperados y la satisfacción de verlo publicado y funcionando.', '<p>Desarrollado con <strong>Laravel</strong>, <strong>Blade</strong>, <strong>Livewire </strong>y <strong>Tailwind CSS</strong>. Más allá de las tecnologías, este proyecto me permitió enfrentarme a retos concretos: gestión de contenidos en base de datos (discografía, imágenes, información de la banda), formulario de contacto con <strong>reCAPTCHA v3, </strong>política de cookies donde el usuario elige qué acepta y una zona de administración protegida para que la banda pueda actualizar sus contenidos de forma autónoma, sin depender de nadie.</p><p>El despliegue en un servidor propio también fue parte del aprendizaje: entender el flujo completo desde el entorno local hasta producción, y no dar nada por sentado. A partir de ahí, el trabajo no terminó: optimización del rendimiento en móvil, mejora de los tiempos de carga, conversión de imágenes a formatos más eficientes... cada mejora, pequeña o grande, sumó.</p><p>Un proyecto que empezó siendo como un encargo y acabó siendo una escuela.</p><p></p><p></p>', 'projects/ONLFPNIxXItf1gUG6yQA46bOJhcC40uYag4XhM0O.png', 'https://www.theelectricbuffalo.com', '["Laravel", "Blade", "Livewire", "Tailwind CSS", "MySQL"]', '0', '1', '2026-05-25 18:48:49', '2026-06-29 15:58:18' ),
( '7', 'Recetario', 'Aplicación web personal para centralizar, organizar y buscar recetas propias o recopiladas de cualquier fuente, con la posibilidad de añadir ingredientes, categorías, imágenes y notas propias. Una especie de recetario digital personal, siempre accesible y fácil de consultar.', '<p>Recetario nació de una necesidad muy concreta: dejar de perder recetas. Esas que guardamos en Instagram, en un grupo de WhatsApp o en un vídeo de TikTok y que luego son imposibles de encontrar cuando las necesitamos de verdad.</p><p>Desarrollado íntegramente desde cero con una arquitectura desacoplada — API REST en Laravel 12 y SPA en Vue 3 — el proyecto refleja decisiones técnicas reales tomadas con criterio profesional. El backend implementa autenticación con Sanctum, autorización mediante Policies, transformación de respuestas con API Resources y validación robusta con Form Requests. El frontend es una SPA reactiva construida con composables reutilizables, gestión de estado con Pinia y comunicación con la API mediante Axios. La base de datos MySQL corre en producción sobre infraestructura OVH, con migraciones versionadas y un esquema pensado para escalar.</p><p>Durante el desarrollo he utilizado Claude como asistente técnico: para revisar decisiones de arquitectura, debatir enfoques alternativos y entender en profundidad cada patrón implementado. No como atajo, sino como herramienta de aprendizaje y contraste que ha elevado la calidad del código y acelerado el proceso de toma de decisiones.</p>', 'projects/nZWSwtxCzyMekpo5xghUnFQ6wv6lkmCx7kjoQc2Z.png', 'https://endpointy.es/', '["Laravel 12", "Vue 3", "Pinia", "Vue Router", "TailwindCSS", "MySQL", "REST API", "PHP 8.3", "Apache", "Axios", "Laravel Sanctum", "Eloquent ORM", "OVH", "Claude AI"]', '1', '1', '2026-06-07 08:35:20', '2026-06-29 15:58:42' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "sessions" ---------------------------------
BEGIN;

INSERT INTO `sessions`(`id`,`user_id`,`ip_address`,`user_agent`,`payload`,`last_activity`) VALUES 
( 'OzUKPtxi11R93vt4vRo3afyWi8vb15Vd3SmeEPpV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJGcXdmbzB6RVkycTRDWkp1aDJtUUN5YnBpTGVXSFA1SHlUczhHd1BSIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', '1782668804' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "users" ------------------------------------
BEGIN;

INSERT INTO `users`(`id`,`name`,`email`,`email_verified_at`,`password`,`remember_token`,`created_at`,`updated_at`) VALUES 
( '1', 'Pilar', 'pilarfnieto@gmail.com', NULL, '$2y$12$CwPAQQH71t8UTKpKT5OCiOlUK/0XxKxW7HeVg0FsG/Vw2ZPSw.yWq', NULL, '2026-05-25 18:53:56', '2026-05-25 18:53:56' );
COMMIT;
-- ---------------------------------------------------------


-- CREATE INDEX "cache_expiration_index" -----------------------
CREATE INDEX `cache_expiration_index` USING BTREE ON `cache`( `expiration` );
-- -------------------------------------------------------------


-- CREATE INDEX "cache_locks_expiration_index" -----------------
CREATE INDEX `cache_locks_expiration_index` USING BTREE ON `cache_locks`( `expiration` );
-- -------------------------------------------------------------


-- CREATE INDEX "failed_jobs_connection_queue_failed_at_index" -
CREATE INDEX `failed_jobs_connection_queue_failed_at_index` USING BTREE ON `failed_jobs`( `connection`, `queue`, `failed_at` );
-- -------------------------------------------------------------


-- CREATE INDEX "jobs_queue_index" -----------------------------
CREATE INDEX `jobs_queue_index` USING BTREE ON `jobs`( `queue` );
-- -------------------------------------------------------------


-- CREATE INDEX "personal_access_tokens_expires_at_index" ------
CREATE INDEX `personal_access_tokens_expires_at_index` USING BTREE ON `personal_access_tokens`( `expires_at` );
-- -------------------------------------------------------------


-- CREATE INDEX "personal_access_tokens_tokenable_type_tokenable_id_index" 
CREATE INDEX `personal_access_tokens_tokenable_type_tokenable_id_index` USING BTREE ON `personal_access_tokens`( `tokenable_type`, `tokenable_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "project_images_project_id_foreign" ------------
CREATE INDEX `project_images_project_id_foreign` USING BTREE ON `project_images`( `project_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "sessions_last_activity_index" -----------------
CREATE INDEX `sessions_last_activity_index` USING BTREE ON `sessions`( `last_activity` );
-- -------------------------------------------------------------


-- CREATE INDEX "sessions_user_id_index" -----------------------
CREATE INDEX `sessions_user_id_index` USING BTREE ON `sessions`( `user_id` );
-- -------------------------------------------------------------


-- CREATE LINK "project_images_project_id_foreign" -------------
ALTER TABLE `project_images`
	ADD CONSTRAINT `project_images_project_id_foreign` FOREIGN KEY ( `project_id` )
	REFERENCES `projects`( `id` )
	ON DELETE Cascade
	ON UPDATE No Action;
-- -------------------------------------------------------------


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- ---------------------------------------------------------


