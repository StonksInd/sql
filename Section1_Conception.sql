Livres : ID, Titre, AuteurID, Genre, Disponibilité (Oui/Non).
Auteurs : ID, Nom, Nationalité.
Adherents : ID, Nom, Email, DateAdhesion.
Emprunts : ID, LivreID, AdherentID, DateEmprunt, DateRetourPrevue, DateRetourReelle.



CREATE TABLE Auteurs(
    ID INT AUTO_INCREMENT,
    Nom VARCHAR(255) NOT NULL,
    Nationalite VARCHAR(255)NOT NULL,
    PRIMARY KEY(ID)
);


CREATE TABLE Livres(
    ID INT AUTO_INCREMENT,
    Titre VARCHAR(255) NOT NULL,
    AuteurID INT,
    Genre VARCHAR(255),
    Disponibilite VARCHAR(255) NOT NULL,
    FOREIGN KEY (AuteurID) REFERENCES Auteurs (ID),
    CONSTRAINT disponibilite_check CHECK (Disponibilite IN ('Oui', 'Non')),
    PRIMARY KEY(ID)
);


CREATE TABLE Adherents(
    ID INT AUTO_INCREMENT,
    Nom VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    DateAdhesion DATE NOT NULL,
    PRIMARY KEY(ID)
);

CREATE TABLE Emprunts(
    ID INT AUTO_INCREMENT,
    LivreID INT NOT NULL,
    AdherentID INT NOT NULL,
    FOREIGN KEY (LivreID) REFERENCES Livres (ID),
    FOREIGN KEY (AdherentID) REFERENCES Adherents (ID),
    DateEmprunt DATE NOT NULL,
    DateRetourPrevue DATE NOT NULL,
    DateRetourReelle DATE,
    PRIMARY KEY(ID)
);