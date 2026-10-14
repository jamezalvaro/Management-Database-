CREATE INDEX idx_perangkat_status ON Perangkat(status_alat);
CREATE INDEX idx_perangkat_area ON Perangkat(id_area);
CREATE INDEX idx_maintenance_status ON Maintenance(status_perbaikan);
CREATE INDEX idx_area_status ON Area(status_area);

EXPLAIN ANALYZE
SELECT * FROM Perangkat WHERE status_alat = 'Rusak';

EXPLAIN ANALYZE
SELECT * FROM Maintenance WHERE status_perbaikan = 'Sedang Dikerjakan';

