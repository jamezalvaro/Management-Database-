
CREATE FUNCTION cek_tingkat_gangguan_area(p_id_area VARCHAR)
RETURNS INT
LANGUAGE plpgsql
AS '
DECLARE
    total_gangguan INT;
BEGIN
    SELECT COUNT(id_perangkat) INTO total_gangguan 
    FROM Perangkat 
    WHERE id_area = p_id_area AND status_alat != ''Aktif'';
    RETURN total_gangguan;
END;
';

CREATE FUNCTION cek_beban_kerja_teknisi(p_id_personel INT)
RETURNS INT
LANGUAGE plpgsql
AS '
DECLARE
    total_tugas INT;
BEGIN
    SELECT COUNT(id_maintenance) INTO total_tugas 
    FROM Maintenance 
    WHERE id_personel = p_id_personel AND status_perbaikan = ''Sedang Dikerjakan'';
    RETURN total_tugas;
END;
';

select cek_tingkat_gangguan_area('AR-01') as total_alat_bermasalah_area2;

CREATE FUNCTION fungsi_sinkronisasi_area()
RETURNS TRIGGER
LANGUAGE plpgsql
AS '
DECLARE
    v_total_gangguan INT;
BEGIN
    v_total_gangguan := cek_tingkat_gangguan_area(NEW.id_area);
    IF v_total_gangguan > 0 THEN
        UPDATE Area SET status_area = ''Gangguan'' WHERE id_area = NEW.id_area;
    ELSE
        UPDATE Area SET status_area = ''Aman'' WHERE id_area = NEW.id_area;
    END IF;
    RETURN NEW;
END;
';

CREATE TRIGGER trg_update_status_perangkat
AFTER UPDATE OF status_alat ON Perangkat
FOR EACH ROW
EXECUTE FUNCTION fungsi_sinkronisasi_area();

CREATE FUNCTION fungsi_update_status_selesai()
RETURNS TRIGGER
LANGUAGE plpgsql
AS '
BEGIN
    IF OLD.status_perbaikan = ''Sedang Dikerjakan'' AND NEW.status_perbaikan = ''Selesai'' THEN
        UPDATE Perangkat 
        SET status_alat = ''Aktif'' WHERE id_perangkat = NEW.id_perangkat;
    END IF;
    
    RETURN NEW;
END;
';

CREATE TRIGGER trg_maintenance_selesai
AFTER UPDATE OF status_perbaikan ON Maintenance
FOR EACH ROW
EXECUTE FUNCTION fungsi_update_status_selesai();
