CREATE PROCEDURE create_perangkat(
    pr_id_perangkat VARCHAR,
    pr_id_area VARCHAR,
    pr_nama_alat VARCHAR,
    pr_spesifikasi TEXT,
    pr_ip_address VARCHAR,
    pr_status_alat status_alat_enum
)
LANGUAGE plpgsql
AS '
BEGIN
    BEGIN
        INSERT INTO Perangkat (id_perangkat, id_area, nama_alat, spesifikasi, ip_address, status_alat) 
        VALUES (pr_id_perangkat, pr_id_area, pr_nama_alat, pr_spesifikasi, pr_ip_address, pr_status_alat);
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';

CREATE PROCEDURE update_perangkat(
    pr_id_perangkat VARCHAR,
    pr_id_area VARCHAR,
    pr_nama_alat VARCHAR,
    pr_spesifikasi TEXT,
    pr_ip_address VARCHAR,
    pr_status_alat status_alat_enum
)
LANGUAGE plpgsql
AS '
BEGIN
    BEGIN
        UPDATE Perangkat 
        SET id_area = pr_id_area,
            nama_alat = pr_nama_alat,
            spesifikasi = pr_spesifikasi,
            ip_address = pr_ip_address,
            status_alat = pr_status_alat
        WHERE id_perangkat = pr_id_perangkat;
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';

CREATE PROCEDURE delete_perangkat(
    pr_id_perangkat VARCHAR
)
LANGUAGE plpgsql
AS '
BEGIN
    BEGIN
        DELETE FROM Perangkat WHERE id_perangkat = pr_id_perangkat;
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';


CALL create_perangkat('SW-999', 'AR-04', 'Switch Core Baru', 'Cisco Catalyst 3850', '192.168.1.99', 'Aktif');
SELECT * FROM v_detail_perangkat ;
CALL update_perangkat('AP-003', 'AR-03', 'Access Point UniFi', 'UAP-AC-Pro', '192.168.3.1', 'Perlu Maintenance');
SELECT id_area, nama_area, status_area FROM Area WHERE id_area = 'AR-01';
CALL delete_perangkat('SW-999');