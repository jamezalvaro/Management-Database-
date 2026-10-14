CREATE VIEW v_profil_personel AS
SELECT 
    id_personel,
    nama_personel,
    nomor_hp,
    divisi,
    role
FROM Personel;

CREATE VIEW v_detail_perangkat AS
SELECT 
    pr.id_perangkat,
    pr.nama_alat,
    pr.spesifikasi,
    pr.ip_address,
    pr.status_alat,
    a.nama_area,
    a.status_area
FROM Perangkat pr
JOIN Area a ON pr.id_area = a.id_area;

CREATE VIEW v_tugas_maintenance AS
SELECT 
    m.id_maintenance,
    m.tanggal_laporan,
    pr.nama_alat,
    a.nama_area,
    p.nama_personel AS teknisi_bertugas,
    m.laporan_perbaikan,
    m.status_perbaikan
FROM Maintenance m
JOIN Personel p ON m.id_personel = p.id_personel
JOIN Perangkat pr ON m.id_perangkat = pr.id_perangkat
JOIN Area a ON pr.id_area = a.id_area;

CREATE VIEW v_rekap_status_area AS
SELECT 
    a.nama_area,
    COUNT(p.id_perangkat) AS total_alat,
    COUNT(p.id_perangkat) FILTER (WHERE p.status_alat != 'Aktif') AS total_bermasalah
FROM Area a
JOIN Perangkat p ON a.id_area = p.id_area
GROUP BY a.nama_area;

SELECT * From v_tugas_maintenance
