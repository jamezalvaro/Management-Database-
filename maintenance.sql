CREATE PROCEDURE create_maintenance(
    p_id_perangkat VARCHAR,
    p_id_personel INT,
    p_laporan TEXT,
    p_status status_perbaikan_enum
)
LANGUAGE plpgsql
AS '
DECLARE
    v_beban_kerja INT;
BEGIN
    BEGIN
        v_beban_kerja := cek_beban_kerja_teknisi(p_id_personel);
        
        IF v_beban_kerja >= 3 THEN
            RAISE EXCEPTION ''Gagal: Teknisi ini sedang memegang terlalu banyak tiket!'';
        END IF;

        INSERT INTO Maintenance (id_perangkat, id_personel, laporan_perbaikan, status_perbaikan) 
        VALUES (p_id_perangkat, p_id_personel, p_laporan, p_status);
        
        UPDATE Perangkat SET status_alat = ''Rusak'' WHERE id_perangkat = p_id_perangkat;
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';

CREATE PROCEDURE update_maintenance(
    p_id_maintenance INT,
    p_id_perangkat VARCHAR,
    p_id_personel INT,
    p_laporan TEXT,
    p_status status_perbaikan_enum
)
LANGUAGE plpgsql
AS '
DECLARE
    v_old_personel INT;
    v_beban_kerja INT;
BEGIN
    SELECT id_personel INTO v_old_personel 
    FROM Maintenance 
    WHERE id_maintenance = p_id_maintenance;

    IF v_old_personel != p_id_personel THEN
        -- Jika ya, cek beban kerja teknisi tujuan tersebut
        v_beban_kerja := cek_beban_kerja_teknisi(p_id_personel);
        
        IF v_beban_kerja >= 3 THEN
            RAISE EXCEPTION ''Gagal: Oper tiket dibatalkan, teknisi tujuan sudah memegang beban maksimal!'';
        END IF;
    END IF;

    UPDATE Maintenance 
    SET id_perangkat = p_id_perangkat,
        id_personel = p_id_personel,
        laporan_perbaikan = p_laporan,
        status_perbaikan = p_status
    WHERE id_maintenance = p_id_maintenance;
END;
';

CREATE PROCEDURE delete_maintenance(
    p_id_maintenance INT
)
LANGUAGE plpgsql
AS '
BEGIN
    BEGIN
        DELETE FROM Maintenance WHERE id_maintenance = p_id_maintenance;
    EXCEPTION WHEN OTHERS THEN
        RAISE;
    END;
    
    COMMIT;
END;
';



CALL create_maintenance('AP-003', 2, 'Access Point diganti', 'Sedang Dikerjakan');
SELECT id_perangkat, status_alat FROM Perangkat WHERE id_perangkat = 'RT-001';

SELECT * FROM v_tugas_maintenance;

CALL update_maintenance(2, 'AP-003', 3, 'Sudah Oke', 'Selesai');
SELECT id_perangkat, status_alat FROM Perangkat WHERE id_perangkat = 'RT-001';

CALL delete_maintenance(5);