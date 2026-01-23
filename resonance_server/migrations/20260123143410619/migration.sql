BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "graph_node_idx";
CREATE INDEX "graph_node_idx" ON "graph_node" USING btree ("userId", "videoId", "primarySpeakerId");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "podcast" ADD COLUMN "graphExists" boolean NOT NULL DEFAULT false;

--
-- MIGRATION VERSION FOR resonance
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('resonance', '20260123143410619', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260123143410619', "timestamp" = now();

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
