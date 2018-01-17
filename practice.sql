ALTER DATABASE mschmitt5 CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS clap;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS profile;

CREATE TABLE profile (
  profileId BINARY(16) NOT NULL,
  profileEmail VARCHAR(128) NOT NULL,
  profileHash CHAR(128) NOT NULL,
  profileName VARCHAR(32) NOT NULL,
  profileSalt CHAR(64) NOT NULL,
  profileStatement VARCHAR(128),
  UNIQUE(profileEmail),
  PRIMARY KEY(profileId)
);

CREATE TABLE article (
  articleId BINARY(16) NOT NULL,
  articleProfileId BINARY(16) NOT NULL,
  articleText VARCHAR(65535) NOT NULL,
  articleTitle VARCHAR(128) NOT NULL,
  INDEX (articleProfileId),
  FOREIGN KEY(articleProfileId) REFERENCES profile(profileId),
  PRIMARY KEY(articleId)
);

CREATE TABLE clap(
  clapId BINARY(16) NOT NULL,
  clapArticleId BINARY(16) NOT NULL,
  clapProfileId BINARY(16) NOT NULL,
  INDEX(clapArticleId),
  INDEX(clapProfileId),
  FOREIGN KEY(clapArticleId) REFERENCES article(articleId),
  FOREIGN KEY(clapProfileId) REFERENCES profile(profileId),
  PRIMARY KEY(clapId)
);

INSERT INTO profile (profileId, profileEmail, profileHash, profileName, profileSalt, profileStatement)
VALUES (UNHEX(REPLACE("f135186a-f29e-41b4-84bf-504b1f008d4b")), "schmitt.mary7@gmail.com", unhex(replace("7e321d5d-0e80-4a79-8106-05f737b1fd6a")), "Mary Schmitt", unhex(replace("903a5a88-b04d-439e-8aa1-a1c370e60ef3
")), "Here is a string. My author profile."
);

INSERT INTO article (articleId, articleProfileId, articleText, articleTitle) VALUES (unhex(replace("cb228c4c-855e-4dc0-ae5f-e0b7a3ee4fb6
")), unhex(replace("f135186a-f29e-41b4-84bf-504b1f008d4b")), "Another string. What a short article.", "String. Title is as long as the article"
);

INSERT INTO clap (clapId, clapArticleId, clapProfileId) VALUES (unhex(replace("8c08c76e-318c-40a7-bf3b-c8bf2795bb3b")), unhex(replace("cb228c4c-855e-4dc0-ae5f-e0b7a3ee4fb6")), unhex(replace("f135186a-f29e-41b4-84bf-504b1f008d4b")));

UPDATE profile
SET profileEmail = "macmillan.mary7@gmail.com", profileName = "Mary MacMillan"
  WHERE profileId = "f135186a-f29e-41b4-84bf-504b1f008d4b";

UPDATE article
SET articleTitle = "Short Title"
WHERE articleId = "cb228c4c-855e-4dc0-ae5f-e0b7a3ee4fb6";

DELETE FROM article
WHERE articleId = "cb228c4c-855e-4dc0-ae5f-e0b7a3ee4fb6
";

DELETE FROM profile
WHERE profileId = "f135186a-f29e-41b4-84bf-504b1f008d4b";

SELECT articleTitle, articleText
FROM article
WHERE articleProfileId = "f135186a-f29e-41b4-84bf-504b1f008d4b";

SELECT profileName, profileEmail, profileStatement
FROM profile
WHERE profileId = "f135186a-f29e-41b4-84bf-504b1f008d4b";

SELECT clapProfileId, profileName
FROM clap
INNER JOIN profile on clap.clapProfileId = profile.profileId
WHERE clapId = "8c08c76e-318c-40a7-bf3b-c8bf2795bb3b";
