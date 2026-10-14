CREATE PROCEDURE create_area(
    a_id_area VARCHAR,
    a_nama_area VARCHAR,
    a_status_area status_area_enum
)
LANGUAGE plpgsql
AS '
BEGIN
    BEGIN
        INSERT INTO Area (id_area, nama_area, status_area) 
        VALUES (a_id_area, a_nama_area, a_status_area);
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';

CREATE PROCEDURE update_area(
    a_id_area VARCHAR,
    a_nama_area VARCHAR,
    a_status_area status_area_enum
)
LANGUAGE plpgsql
AS '
BEGIN
    BEGIN
        UPDATE Area 
        SET nama_area = a_nama_area, 
            status_area = a_status_area
        WHERE id_area = a_id_area;
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';

CREATE PROCEDURE delete_area(
    a_id_area VARCHAR
)
LANGUAGE plpgsql
AS '
BEGIN
    BEGIN
        DELETE FROM Area WHERE id_area = a_id_area;
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';

CALL create_area('AR-04', 'Gudang Logistik Utama', 'Aman');
SELECT * FROM Area WHERE id_area = 'AR-04';
SELECT * FROM v_rekap_status_area;
CALL update_area('AR-04', 'Gudang Logistik Utama', 'Gangguan');
CALL delete_area('AR-04');