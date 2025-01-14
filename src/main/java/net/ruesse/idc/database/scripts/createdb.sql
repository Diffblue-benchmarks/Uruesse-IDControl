DROP TABLE IDCLOCAL.SCANLOG;
DROP TABLE IDCREMOTE.RECHNUNG;
DROP TABLE IDCREMOTE.BEITRAG;
DROP TABLE IDCREMOTE.BANKVERBINDUNG;
DROP TABLE IDCREMOTE.ADDRESS;
DROP TABLE IDCREMOTE.CONTACT;
DROP TABLE IDCREMOTE.CV;
DROP TABLE IDCREMOTE.OFFENERECHNUNGEN;

DROP INDEX IDCREMOTE.PERSON_IX_NAME;
DROP TABLE IDCREMOTE.PERSON;

DROP TABLE IDCREMOTE.FAMILY;

DROP TABLE IDCLOCAL.AUSWAHL;

CREATE TABLE IDCREMOTE.FAMILY (
  FNR INT PRIMARY KEY
);

CREATE TABLE IDCREMOTE.PERSON (
    MGLNR BIGINT PRIMARY KEY,
    FNR INT ,
    FIRMA VARCHAR(128),
    ANREDE VARCHAR(128),
    TITEL VARCHAR(128),
    NACHNAME VARCHAR(128),
    VORNAME VARCHAR(128),
    HAUPTKATEGORIE VARCHAR(128),
    GEBURTSDATUM DATE,
    BEMERKUNG VARCHAR(128),
    STATUS VARCHAR(128),
    EINTRITT DATE,
    AUSTRITT DATE,
    KUENDIGUNG DATE,
    ABWEICHENDERZAHLER BOOLEAN,
    FREMDZAHLER BIGINT,
    ZAHLUNGSMODUS VARCHAR(128),
    FOREIGN KEY(FNR) REFERENCES IDCREMOTE.FAMILY(FNR)
);

CREATE INDEX IDCREMOTE.PERSON_IX_NAME ON IDCREMOTE.PERSON (NACHNAME, FNR, VORNAME);

CREATE TABLE IDCREMOTE.ADDRESS (
    ID BIGINT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
    MGLNR BIGINT,
    STRASSE VARCHAR(128),
    PLZ VARCHAR(16),
    ORT VARCHAR(128),
    LAND VARCHAR(128),
    FOREIGN KEY(MGLNR) REFERENCES IDCREMOTE.PERSON(MGLNR)
);

CREATE TABLE IDCREMOTE.CONTACT (
    ID BIGINT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
    MGLNR BIGINT,
    CONTACTKEY VARCHAR(128),
    CONTACTVALUE VARCHAR(128),
    FOREIGN KEY(MGLNR) REFERENCES IDCREMOTE.PERSON(MGLNR)
);

CREATE TABLE IDCREMOTE.CV (
    ID BIGINT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
    MGLNR BIGINT,
    CVKEY VARCHAR(128),
    CVVALUE VARCHAR(128),
    VALIDFROM DATE,
    VALIDTO DATE,
    KURZTEXT VARCHAR(128),
    LANGTEXT VARCHAR(1024),
    FOREIGN KEY(MGLNR) REFERENCES IDCREMOTE.PERSON(MGLNR)
);

CREATE TABLE IDCREMOTE.BANKVERBINDUNG (
    ID BIGINT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
    MGLNR BIGINT,
    FNR INT,
    IBAN VARCHAR(128),
    BIC VARCHAR(128),
    KONTOINHABER VARCHAR(128),
    MANDATSREFERENZ VARCHAR(128),
    MANDAT_VORHANDEN BOOLEAN,
    FOREIGN KEY(MGLNR) REFERENCES IDCREMOTE.PERSON(MGLNR),
    FOREIGN KEY(FNR) REFERENCES IDCREMOTE.FAMILY(FNR)
);

CREATE TABLE IDCREMOTE.BEITRAG (
    ID BIGINT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
    MGLNR BIGINT,
    FNR INT,
    BEITRAGSPOSITION VARCHAR(128),
    BEITRAGSKOMMENTAR VARCHAR(128),
    FAELLIG_START date,
    FAELLIG_ENDE date,
    ABRECHNUNGSSTATUS VARCHAR(128),
    ZAHLUNGSWEISE VARCHAR(128),
    FOREIGN KEY(MGLNR) REFERENCES IDCREMOTE.PERSON(MGLNR),
    FOREIGN KEY(FNR) REFERENCES IDCREMOTE.FAMILY(FNR)
);

CREATE TABLE IDCREMOTE.RECHNUNG (
    RECHNUNGSNUMMER BIGINT PRIMARY KEY,
    MGLNR BIGINT,
    FNR INT,
    RECHNUNGSDATUM DATE,
    RECHNUNGSSUMME INT,
    ZAHLMODUS varchar(128),
    ZAHLUNGSZIEL date,
    FOREIGN KEY(MGLNR) REFERENCES IDCREMOTE.PERSON(MGLNR),
    FOREIGN KEY(FNR) REFERENCES IDCREMOTE.FAMILY(FNR)
);

CREATE TABLE IDCREMOTE.OFFENERECHNUNGEN (
    RECHNUNGSNUMMER BIGINT PRIMARY KEY,
    MGLNR BIGINT,
    FNR INT,
    RECHNUNGSDATUM DATE,
    ZAHLUNGSZIEL DATE,
    ZAHLMODUS VARCHAR(128),
    MAHNSTUFE INT,
    RECHNUNGSSUMME INT,
    FOREIGN KEY(MGLNR) REFERENCES IDCREMOTE.PERSON(MGLNR),
    FOREIGN KEY(FNR) REFERENCES IDCREMOTE.FAMILY(FNR)
);


CREATE TABLE IDCLOCAL.SCANLOG (
    ID BIGINT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
    MGLNR BIGINT,
    SCANTIME TIMESTAMP,
    FOREIGN KEY(MGLNR) REFERENCES IDCREMOTE.PERSON(MGLNR)
);

CREATE TABLE IDCLOCAL.AUSWAHL (
    MGLNR BIGINT PRIMARY KEY
);