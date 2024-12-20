○ 3 livres : Le Petit Prince (Auteur : Saint-Exupéry), 1984 (Auteur :
Orwell), Dune (Auteur : Herbert).

○ 2 auteurs : Antoine de Saint-Exupéry (Nationalité : Française), George
Orwell (Nationalité : Anglaise).

○ 2 adhérents : Adherent A (email : a@mail.com), Adherent B (email :
b@mail.com).

○ 1 emprunt : Livre 1984 par l’Adhérent A, DateEmprunt : 2024-12-01,
DateRetourPrevue : 2024-12-15.




INSERT INTO Auteurs(Nom, Nationalite)
VALUES
("Antoine de Saint-Exupéry", "Française"),
("George Orwell", "Anglaise"),
("Frank Herbert", "Américaine");


INSERT INTO Livres (Titre, AuteurID, Genre, Disponibilité)
VALUES
("Le Petit Prince", 1, "Fiction", "Oui"),
("1984", 2, "Dystopie", "Oui"),
("Dune", 3, "Science-fiction", "Oui");

INSERT INTO Adherents(Nom, Email, DateAdhesion)
VALUES 
("A", "a@mail.com", '2024-11-19'),
("B", "b@mail.com", '2024-11-18');

INSERT INTO Emprunts(LivreID, AdherentID, DateEmprunt, DateRetourPrevue, DateRetourReelle)
VALUES (2, 1, '2024-12-01',  '2024-12-15', NULL);

Afficher tous les livres empruntés par un adhérent spécifique (Adherent A).

SELECT Livres.* FROM Emprunts 
JOIN Livres ON Emprunts.LivreID = Livres.ID
JOIN Adherents ON  Emprunts.AdherentID = Adherents.ID
WHERE Adherents.Nom = "A";


Mettre à jour la disponibilité d’un livre après un emprunt (par exemple, passer
de "Oui" à "Non")

CREATE TRIGGER Changer_disponibilite_livre
AFTER INSERT ON Emprunts
FOR EACH ROW
BEGIN
    UPDATE Livres
    SET Disponibilité = "Non"
    WHERE ID = NEW.LivreID; 
END$$

DELIMITER ;

Lister les livres disponibles uniquement.

SELECT * FROM Livres
WHERE Disponibilite = "Oui";