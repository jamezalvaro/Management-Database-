CREATE PROCEDURE create_personel(
    p_nama_personel VARCHAR,
    p_nomor_hp VARCHAR,
    p_divisi VARCHAR,
    p_password VARCHAR,
    p_role role_enum
)
LANGUAGE plpgsql
AS '
BEGIN
    BEGIN
        INSERT INTO Personel (nama_personel, nomor_hp, divisi, password, role) 
        VALUES (p_nama_personel, p_nomor_hp, p_divisi, p_password, p_role);
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';

CREATE PROCEDURE update_personel(
    p_id_personel INT,
    p_nama_personel VARCHAR,
    p_nomor_hp VARCHAR,
    p_divisi VARCHAR,
    p_password VARCHAR,
    p_role role_enum
)
LANGUAGE plpgsql
AS '
BEGIN
    BEGIN
        UPDATE Personel 
        SET nama_personel = p_nama_personel,
            nomor_hp = p_nomor_hp,
            divisi = p_divisi,
            password = p_password,
            role = p_role
        WHERE id_personel = p_id_personel;
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';

CREATE PROCEDURE delete_personel(
    p_id_personel INT
)
LANGUAGE plpgsql
AS '
BEGIN
    BEGIN
        DELETE FROM Personel WHERE id_personel = p_id_personel;
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';


CALL create_personel('Rian Network', '08554433221', 'Infrastructure', 'hash789', 'Engineer');
SELECT * FROM v_profil_personel;
CALL update_personel(3, 'Alvaro', '0811998877', 'IT Support', 'hash789', 'Engineer');
CALL delete_personel(4);