CREATE TABLE "futur_simples" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "je" varchar(255), "tu" varchar(255), "il" varchar(255), "nous" varchar(255), "vous" varchar(255), "ils" varchar(255), "verb_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "imparfaits" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "je" varchar(255), "tu" varchar(255), "il" varchar(255), "nous" varchar(255), "vous" varchar(255), "ils" varchar(255), "verb_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "passe_composes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "je" varchar(255), "tu" varchar(255), "il" varchar(255), "nous" varchar(255), "vous" varchar(255), "ils" varchar(255), "verb_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "passe_simples" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "je" varchar(255), "tu" varchar(255), "il" varchar(255), "nous" varchar(255), "vous" varchar(255), "ils" varchar(255), "verb_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "plus_que_parfaits" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "je" varchar(255), "tu" varchar(255), "il" varchar(255), "nous" varchar(255), "vous" varchar(255), "ils" varchar(255), "verb_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "presents" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "je" varchar(255), "tu" varchar(255), "il" varchar(255), "nous" varchar(255), "vous" varchar(255), "ils" varchar(255), "verb_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "subjonctifs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "je" varchar(255), "tu" varchar(255), "il" varchar(255), "nous" varchar(255), "vous" varchar(255), "ils" varchar(255), "verb_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "verbs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "infinitive" varchar(255), "group" integer, "created_at" datetime, "updated_at" datetime, "translation" varchar(255));
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20130910080326');

INSERT INTO schema_migrations (version) VALUES ('20130910080604');

INSERT INTO schema_migrations (version) VALUES ('20130910080913');

INSERT INTO schema_migrations (version) VALUES ('20130910080928');

INSERT INTO schema_migrations (version) VALUES ('20130910080943');

INSERT INTO schema_migrations (version) VALUES ('20130910081026');

INSERT INTO schema_migrations (version) VALUES ('20130910081042');

INSERT INTO schema_migrations (version) VALUES ('20130910081115');

INSERT INTO schema_migrations (version) VALUES ('20130916093051');
