Implémentez une procédure EnregistrerEmprunt qui :
○ Vérifie si le livre est disponible (Disponibilité = 'Oui').
○ Si oui, insère une ligne dans la table Emprunts et met à jour la disponibilité
du livre à "Non".
○ Si non, retourne un message d’erreur.
○ Appel attendu

DELIMITER $$
CREATE PROCEDURE EnregistrerEmprunt(v_LivreID INT, v_AdherentID INT)
BEGIN
SELECT Disponibilite FROM Livres
WHERE ID = v_LivreID;
IF Disponibilite = "Oui" THEN

INSERT INTO Emprunts(LivreID, AdherentID, DateEmprunt, DateRetourPrevue)
VALUES (v_LivreID, v_AdherentID, DATE(NOW()), DATE_ADD(DATE(NOW()), INTERVAL 15 DAY));
UPDATE Livres SET Disponibilite = "Non"
WHERE ID = p_LivreID;

ELSE 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = "Le livre n'est pas disponible.";
END IF;
END$$

DELIMITER ;



Créez un déclencheur qui :
○ Insère automatiquement une ligne dans une table HistoriqueEmprunts
chaque fois qu’un emprunt est enregistré ou retourné.
○ À vous de déterminer quelles informations sont importantes à stocker dans
cette nouvelle table

CREATE TABLE HistoriqueEmprunts(
    ID INT AUTO_INCREMENT,
    PRIMARY KEY(ID),
    DateEmprunt DATE NOT NULL,
    DateRetourPrevue DATE NOT NULL,
    DateRetourReelle DATE,
    LivreID INT NOT NULL,
    AdherentID INT NOT NULL,
    FOREIGN KEY (LivreID) REFERENCES Livres (ID),
    FOREIGN KEY (AdherentID) REFERENCES Adherents (ID),

);

DELIMITER $$

CREATE TRIGGER Historique 
AFTER INSERT OR UPDATE ON Emprunts 
FOR EACH ROW
BEGIN
    INSERT INTO HistoriqueEmprunts(DateEmprunt, DateRetourPrevue, DateRetourReelle, LivreID, AdherentID)
    VALUES (NEW.DateEmprunt, NEW.DateRetourPrevue, NEW.DateRetourReelle, NEW.LivreID, NEW.AdherentID)
END;
$$