Implémentez un script SQL qui :
○ Démarre une transaction pour un retour de livre.
○ Met à jour la disponibilité du livre à "Oui".
○ Ajoute la DateRetourReelle dans la table Emprunts.
○ Annule la transaction si le livre n’est pas retrouvé dans les emprunts en
cours.


CREATE TRIGGER transaction
AFTER UPDATE ON Emprunts
FOR EACH ROW
BEGIN
    UPDATE Livres
    SET Disponibilité = "Oui"
    WHERE ID = NEW.LivreID; 

    UPDATE Emprunts
    SET DateRetourReelle = DATE(NOW());
END$$

DELIMITER ;


UPDATE Livres SET Disponibilite = true WHERE id = 10;
-- id en minuscule alors que c'est en majuscule, true alors que que on veut juste du Oui ou Non ERROR 3819 (HY000): Check constraint 'disponibilite_check' is violated

UPDATE Livres SET Disponibilite = 'Oui' WHERE ID = 10;
