CREATE DATABASE CS434;
USE CS434;
CREATE TABLE Store
(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(32),
    URL VARCHAR(32) NOT NULL
);
CREATE UNIQUE INDEX Store_Name_ID_uindex ON Store (Name, ID);

CREATE TABLE Manufacturer
(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(32)
);
CREATE UNIQUE INDEX Manufacturer_ID_uindex ON Manufacturer(ID);

CREATE TABLE Socket
(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    ManufacturerID INT UNSIGNED,
    Name VARCHAR(32),
    CONSTRAINT Socket_Manufactuerer_ID_fk FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer (ID) ON DELETE CASCADE
);
CREATE UNIQUE INDEX Socket_Name_ManufactuererID_ID_uindex ON Socket (ID, ManufacturerID, Name);

CREATE TABLE Part
(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    SKU VARCHAR(128),
    Name VARCHAR(32),
    Description TEXT,
    Release_Date DATETIME,
    ManufacturerID INT UNSIGNED,
    CONSTRAINT Part_Manufacturer_ID_fk FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer (ID) ON DELETE CASCADE
);
CREATE UNIQUE INDEX Part_SKU_uindex ON Part (SKU);
CREATE INDEX Part_ID_SKU_Name_index ON Part (ID, SKU, Name);



CREATE TABLE Ram
(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(16),
    Speed VARCHAR(16),
    CONSTRAINT Ram_Part_ID_fk FOREIGN KEY (ID) REFERENCES Part (ID) ON DELETE CASCADE
);
CREATE INDEX RAM_ID_uindex ON Ram (ID);

CREATE TABLE CPU
(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `#Cores` INT UNSIGNED,
    `#vCores` INT UNSIGNED,
    TurboClock DOUBLE,
    Clock DOUBLE,
    MaxPowerDraw INT UNSIGNED,
    SocketID INT UNSIGNED,
    CONSTRAINT CPU_Part_ID_fk   FOREIGN KEY (ID)       REFERENCES Part   (ID) ON DELETE CASCADE,
    CONSTRAINT CPU_Socket_ID_fk FOREIGN KEY (SocketID) REFERENCES Socket (ID) ON DELETE CASCADE
);
CREATE INDEX CPU_ID_uindex ON CPU (ID);

CREATE TABLE Motherboard
(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `#RamSlots` TINYINT UNSIGNED,
    MaxRam SMALLINT UNSIGNED,
    `#PCIESlots` TINYINT UNSIGNED,
    `#SataPorts` TINYINT UNSIGNED,
    SocketID INT UNSIGNED,
    CONSTRAINT Motherboard_Part_ID_fk   FOREIGN KEY (ID)       REFERENCES Part   (ID) ON DELETE CASCADE,
    CONSTRAINT Motherboard_Socket_ID_fk FOREIGN KEY (SocketID) REFERENCES Socket (ID) ON DELETE CASCADE
);
CREATE INDEX Motherboard_ID_uindex ON Motherboard (ID);

CREATE TABLE GraphicsCard
(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `#Shaders` SMALLINT UNSIGNED,
    `#Vram` SMALLINT UNSIGNED,
    MinClock DOUBLE,
    Clock DOUBLE,
    CONSTRAINT GraphicsCard_Part_ID_fk FOREIGN KEY (ID) REFERENCES Part (ID) ON DELETE CASCADE
);
CREATE INDEX GraphicsCard_ID_uindex ON GraphicsCard (ID);


CREATE TABLE Monitor
(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Size DOUBLE,
    Width SMALLINT UNSIGNED,
    Height SMALLINT UNSIGNED,
    Refresh_Rate DOUBLE,
    CONSTRAINT Monitor_Part_ID_fk FOREIGN KEY (ID) REFERENCES Part (ID) ON DELETE CASCADE
);
CREATE INDEX Monitor_ID_uindex ON GraphicsCard (ID);

CREATE TABLE GraphicsConnector
(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(32),
    Version VARCHAR(16)
);
CREATE UNIQUE INDEX GraphicsConnector_ID_uindex ON GraphicsConnector (ID);

CREATE TABLE SupportsConnector
(
    MotherBoardID INT UNSIGNED,
    GraphicsCardID INT UNSIGNED,
    MonitorID INT UNSIGNED,
    GraphicsConnectorID INT UNSIGNED,
    Count SMALLINT UNSIGNED,
    CONSTRAINT SupportsConnector_Motherboard_ID_fk FOREIGN KEY (MotherBoardID) REFERENCES Motherboard (ID) ON DELETE CASCADE,
    CONSTRAINT SupportsConnector_GraphicsCard_ID_fk FOREIGN KEY (GraphicsCardID) REFERENCES GraphicsCard (ID) ON DELETE CASCADE,
    CONSTRAINT SupportsConnector_Monitor_ID_fk FOREIGN KEY (MonitorID) REFERENCES Monitor (ID) ON DELETE CASCADE
);
CREATE INDEX SupportsConnector_MotherBoardID_GraphicsCardID_MonitorID_index ON SupportsConnector (MotherBoardID, GraphicsCardID, MonitorID);

CREATE TABLE Sells
(
    StoreID INT UNSIGNED,
    PartID INT UNSIGNED,
    Cost DOUBLE UNSIGNED,
    CONSTRAINT Sells_Store_ID_fk FOREIGN KEY (StoreID) REFERENCES Store (ID) ON DELETE CASCADE,
    CONSTRAINT Sells_Part_ID_fk FOREIGN KEY (PartID) REFERENCES Part (ID) ON DELETE CASCADE
);
CREATE INDEX Sells_StoreID_PartID_index ON Sells (StoreID, PartID);

