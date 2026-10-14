INSERT INTO Area (id_area, nama_area, status_area) VALUES
('AR-01', 'Ruang Server Utama', 'Aman'),
('AR-02', 'Lobby Gedung B', 'Gangguan'),
('AR-03', 'Gudang Logistik', 'Aman');

INSERT INTO Personel (nama_personel, nomor_hp, divisi, password, role) VALUES
('Budi Admin', '08123456789', 'IT Core', 'hash123', 'Admin'),
('James Teknisi', '08987654321', 'IT Support', 'hash321', 'Engineer'),
('Siti Jaringan', '08111222333', 'Network Team', 'hash456', 'Engineer');

INSERT INTO Perangkat (id_perangkat, id_area, nama_alat, spesifikasi, ip_address, status_alat) VALUES
('RT-001', 'AR-01', 'Router MikroTik', 'RB1100AHx4', '192.168.1.1', 'Aktif'),
('SW-002', 'AR-02', 'Switch Cisco', 'Catalyst 2960', '192.168.2.1', 'Rusak'),
('AP-003', 'AR-03', 'Access Point UniFi', 'UAP-AC-Pro', '192.168.3.1', 'Perlu Maintenance');

INSERT INTO Maintenance (id_perangkat, id_personel, laporan_perbaikan, status_perbaikan) VALUES 
('SW-002', 2, 'Port 1-5 mati total akibat korsleting', 'Sedang Dikerjakan'),
('AP-003', 3, 'Sinyal wifi sering putus-putus', 'Sedang Dikerjakan'),
('RT-001', 2, 'Pengecekan rutin kabel LAN', 'Selesai');


SELECT * From Maintenance