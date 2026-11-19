CREATE DATABASE IF NOT EXISTS transport_public;
USE transport_public;

CREATE TABLE Depouri (
    id_depou INT AUTO_INCREMENT PRIMARY KEY,
    nume_depou VARCHAR(100) NOT NULL,
    adresa VARCHAR(200),
    capacitate_maxima INT CHECK (capacitate_maxima > 0)
);

CREATE TABLE Angajati (
    id_angajat INT AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR(100) NOT NULL,
    functie VARCHAR(50) NOT NULL,
    telefon VARCHAR(20)
);

CREATE TABLE Vehicule (
    id_vehicul INT AUTO_INCREMENT PRIMARY KEY,
    id_depou INT NOT NULL,
    nr_inmatriculare VARCHAR(20) NOT NULL UNIQUE,
    capacitate INT NOT NULL CHECK (capacitate > 0),
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_depou) REFERENCES Depouri(id_depou)
);

CREATE TABLE Revizii (
    id_revizie INT AUTO_INCREMENT PRIMARY KEY,
    id_vehicul INT NOT NULL,
    data_revizie DATE NOT NULL,
    tip_revizie VARCHAR(50) NOT NULL,
    cost DECIMAL(10, 2) CHECK (cost >= 0),
    FOREIGN KEY (id_vehicul) REFERENCES Vehicule(id_vehicul)
);

CREATE TABLE Incidente (
    id_incident INT AUTO_INCREMENT PRIMARY KEY,
    id_vehicul INT NOT NULL,
    tip_incident VARCHAR(50) NOT NULL,
    descriere TEXT,
    FOREIGN KEY (id_vehicul) REFERENCES Vehicule(id_vehicul)
);

CREATE TABLE Rute (
    id_ruta INT AUTO_INCREMENT PRIMARY KEY,
    indicativ_linie VARCHAR(20) NOT NULL UNIQUE,
    denumire VARCHAR(150) NOT NULL
);

CREATE TABLE Statii (
    id_statie INT AUTO_INCREMENT PRIMARY KEY,
    nume_statie VARCHAR(100) NOT NULL,
    locatie VARCHAR(150)
);

CREATE TABLE Rute_Statii (
    id_ruta INT NOT NULL,
    id_statie INT NOT NULL,
    ordine_oprire INT NOT NULL CHECK (ordine_oprire > 0),
    PRIMARY KEY (id_ruta, id_statie),
    FOREIGN KEY (id_ruta) REFERENCES Rute(id_ruta),
    FOREIGN KEY (id_statie) REFERENCES Statii(id_statie)
);

CREATE TABLE Curse (
    id_cursa INT AUTO_INCREMENT PRIMARY KEY,
    id_ruta INT NOT NULL,
    id_vehicul INT NOT NULL,
    id_angajat INT NOT NULL,
    data_ora_plecare DATETIME NOT NULL,
    FOREIGN KEY (id_ruta) REFERENCES Rute(id_ruta),
    FOREIGN KEY (id_vehicul) REFERENCES Vehicule(id_vehicul),
    FOREIGN KEY (id_angajat) REFERENCES Angajati(id_angajat)
);

CREATE TABLE Bilete (
    id_bilet INT AUTO_INCREMENT PRIMARY KEY,
    id_cursa INT NOT NULL,
    pret DECIMAL(6, 2) NOT NULL CHECK (pret >= 0),
    tip_bilet VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_cursa) REFERENCES Curse(id_cursa)
);

CREATE TABLE Clienti (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nume_complet VARCHAR(100) NOT NULL,
    cnp VARCHAR(13) NOT NULL UNIQUE,
    email VARCHAR(100)
);

CREATE TABLE Abonamente (
    id_abonament INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT NOT NULL,
    id_ruta INT NOT NULL,
    tip_abonament VARCHAR(50) NOT NULL,
    pret DECIMAL(8, 2) NOT NULL CHECK (pret >= 0),
    data_emitere DATE NOT NULL,
    data_expirare DATE NOT NULL,
    FOREIGN KEY (id_client) REFERENCES Clienti(id_client),
    FOREIGN KEY (id_ruta) REFERENCES Rute(id_ruta)
);