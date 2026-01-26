BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "graph_edge" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "graph_edge" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "sourceNodeId" bigint NOT NULL,
    "targetNodeId" bigint NOT NULL,
    "weight" double precision NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "ingestion_job" ADD COLUMN "stageProgress" bigint NOT NULL DEFAULT 0;

--
-- MIGRATION VERSION FOR resonance
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('resonance', '20260126140127234', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260126140127234', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260109031533194', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109031533194', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
