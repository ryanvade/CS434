#!/usr/bin/env python3

import MySQLdb
from PCPartPicker_API import pcpartpicker

def initialize_mysql_connection(host, user, password, db):
    return MySQLdb.connect(host=host, user=user, password=password, db=db)

def insert_part(db, SKU, Name, Description, Release_Date, ManufacturerID):
    conn = db.cursor()
    conn.execute("""INSERT INTO Part (SKU, Name, Description, Release_Date, ManufacturerID),
                 VALUES (%s, %s, %s, %s, %s)""", (SKU, Name, Description, Release_Date, ManufacturerID,))
    return conn.lastrowid

def insert_manufacturer(db, Name):
    conn = db.cursor()
    conn.execute("""INSERT INTO Manufacturer (Name) VALUES(%s)""", (Name,))
    return conn.lastrowid


def insert_socket(db, ManufacturerID, Name):
    conn = db.cursor()
    conn.execute("""INSERT INTO Socket (ManufacturerID, Name) VALUES(%s, %s)""", (ManufacturerID, Name))
    return conn.lastrowid

def insert_store(db, Name, URL):
    conn = db.cursor()
    conn.execute("""INSERT INTO Store (Name, URL) VALUES (%s, %s)""", (Name, URL))
    return conn.lastrowid

def insert_sells(db, StoreID, PartID, Cost):
    conn = db.cursor()
    conn.execute("""INSERT INTO Sells (StoreID, PartID, Cost) VALUES (%s, %s)""", (StoreID, PartID, Cost))
    return conn.lastrowid

def insert_graphics_connector(db, Name, Version):
    conn = db.cursor()
    conn.execute("""INSERT INTO GraphicsConnector (Name, Version) VALUES (%s, %s)""", (Name, Version))
    return conn.lastrowid


def insert_supports_connector(db, MotherBoardID, GraphicsCardID, MonitorID, GraphcsConnectorID, Count):
    conn = db.cursor()
    conn.execute("""INSERT INTO SupportsConnector (MotherBoardID, GraphicsCardID, MonitorID, GraphcsConnectorID, Count)
                 Values (%s, %s, %s, %s, %s)""", (MotherBoardID, GraphicsCardID, MonitorID, GraphcsConnectorID, Count))
    return conn.lastrowid
