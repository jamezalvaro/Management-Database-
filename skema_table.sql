CREATE TYPE status_area_enum AS ENUM ('Aman', 'Gangguan');
CREATE TYPE status_alat_enum AS ENUM ('Aktif', 'Rusak', 'Perlu Maintenance');
CREATE TYPE role_enum AS ENUM ('Admin', 'Engineer'); 
CREATE TYPE status_perbaikan_enum AS ENUM ('Sedang Dikerjakan', 'Selesai'); 

CREATE TABLE Area (
    id_area VARCHAR(10) PRIMARY KEY,
    nama_area VARCHAR(100) NOT NULL,
    status_area status_area_enum DEFAULT 'Aman'
);

CREATE TABLE Personel (
    id_personel SERIAL PRIMARY KEY,
    nama_personel VARCHAR(100) NOT NULL,
    nomor_hp VARCHAR(15),
    divisi VARCHAR(50),
    password VARCHAR(255) NOT NULL,
    role role_enum NOT NULL
);

CREATE TABLE Perangkat (
    id_perangkat VARCHAR(20) PRIMARY KEY,
    id_area VARCHAR(10) REFERENCES Area(id_area),
    nama_alat VARCHAR(100) NOT NULL,
    spesifikasi TEXT,
    ip_address VARCHAR(15),
    status_alat status_alat_enum DEFAULT 'Aktif'
);

CREATE TABLE Maintenance (
    id_maintenance SERIAL PRIMARY KEY,
    id_perangkat VARCHAR(20) REFERENCES Perangkat(id_perangkat),
    id_personel INT REFERENCES Personel(id_personel),
    laporan_perbaikan TEXT NOT NULL,
    status_perbaikan status_perbaikan_enum DEFAULT 'Sedang Dikerjakan',
    tanggal_laporan TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
