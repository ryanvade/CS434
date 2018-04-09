#!/usr/bin/env python3

# By Ryan Owens
# For CS434 Project 4
# https://github.com/PyMySQL/mysqlclient-python
# https://github.com/thatguywiththatname/PcPartPicker-API
import re
import sys
import random
import MySQLdb
from datetime import date
from PCPartPicker_API import pcpartpicker


def initialize_mysql_connection(host, user, password, db):
    return MySQLdb.connect(host=host, user=user, password=password, db=db)

def insert_part(db, SKU, Name, Description, Release_Date, ManufacturerID):
    conn = db.cursor()
    conn.execute("""INSERT INTO Part (SKU, Name, Description, Release_Date, ManufacturerID)
                 VALUES (%s, %s, %s, %s, %s)""", (SKU.encode('utf-8'), Name.encode('utf-8')[:32], Description.encode('utf-8'), Release_Date, ManufacturerID))
    db.commit()
    return conn.lastrowid

def get_part_by_sku(db, SKU):
    conn = db.cursor()
    conn.execute("""SELECT * FROM Part WHERE SKU = %s""", (SKU,))
    return conn.fetchone()

def insert_manufacturer(db, Name):
    conn = db.cursor()
    conn.execute("""INSERT INTO Manufacturer (Name) VALUES(%s)""", (Name,))
    db.commit()
    return conn.lastrowid

def get_manufacturer(db, Name):
    conn = db.cursor()
    conn.execute("""SELECT * FROM Manufacturer WHERE Name = %s""", (Name,))
    return conn.fetchone()


def insert_socket(db, ManufacturerID, Name):
    conn = db.cursor()
    conn.execute("""INSERT INTO Socket (ManufacturerID, Name) VALUES(%s, %s)""", (ManufacturerID, Name))
    db.commit()
    return conn.lastrowid

def get_socket(db, ManufacturerID, Name):
    conn = db.cursor()
    conn.execute("""SELECT * FROM Socket WHERE ManufacturerID = %s AND Name = %s""", (ManufacturerID, Name))
    return conn.fetchone()

def get_socket_by_manufacturer(db, ManufacturerID):
    conn = db.cursor()
    conn.execute("""SELECT * FROM Socket WHERE ManufacturerID = %s""", (ManufacturerID,))
    return conn.fetchall()

def insert_store(db, Name, URL):
    conn = db.cursor()
    conn.execute("""INSERT INTO Store (Name, URL) VALUES (%s, %s)""", (Name, URL))
    db.commit()
    return conn.lastrowid

def get_store(db, Name, URL):
    conn = db.cursor()
    conn.execute("""SELECT * FROM Store WHERE Name = %s AND URL = %s""", (Name, URL))
    return conn.fetchone()

def get_stores(db):
    conn = db.cursor()
    conn.execute("""SELECT * FROM Store """,)
    return conn.fetchall()

def insert_sells(db, StoreID, PartID, Cost):
    conn = db.cursor()
    conn.execute("""INSERT INTO Sells (StoreID, PartID, Cost) VALUES (%s, %s, %s)""", (str(StoreID), str(PartID), str(Cost)))
    db.commit()
    return conn.lastrowid

def insert_graphics_connector(db, Name, Version):
    conn = db.cursor()
    conn.execute("""INSERT INTO GraphicsConnector (Name, Version) VALUES (%s, %s)""", (Name, Version))
    db.commit()
    return conn.lastrowid

def get_connector(db, Name, Version):
    conn = db.cursor()
    conn.execute("""SELECT * FROM GraphicsConnector WHERE Name = %s AND Version = %s""", (Name, Version))
    return conn.fetchone()

def get_connector_count(db):
    conn = db.cursor()
    conn.execute("""SELECT COUNT(*) FROM GraphicsConnector""")
    return conn.fetchone()


def insert_supports_connector(db, MotherBoardID, GraphicsCardID, MonitorID, GraphicsConnectorID, Count):
    conn = db.cursor()
    conn.execute("""INSERT INTO SupportsConnector (MotherBoardID, GraphicsCardID, MonitorID, GraphicsConnectorID, Count)
                 VALUES (%s, %s, %s, %s, %s)""", (MotherBoardID, GraphicsCardID, MonitorID, GraphicsConnectorID, Count))
    db.commit()
    return conn.lastrowid

def get_supports_connector(db, MotherBoardID, GraphicsCardID, MonitorID, GraphicsConnectorID):
    conn = db.cursor()
    conn.execute("""SELECT * FROM SupportsConnector WHERE MotherBoardID = %s AND GraphicsCardID = %s AND MonitorID =  %s AND GraphicsConnectorID = %s""",
                    (MotherBoardID, GraphicsCardID, MonitorID, GraphicsConnectorID))
    return conn.fetchone()


def insert_cpu(db, SKU, Name, Description, Release_Date, ManufacturerID, Cores, vCores, TurboClock, Clock, MaxPowerDraw, SocketID):
    existing_part = get_part_by_sku(db, SKU)
    if existing_part is not None:
        return
    part_id = insert_part(db, SKU, Name, Description, Release_Date, ManufacturerID)
    if part_id >= 0:
        conn = db.cursor()
        conn.execute("""INSERT INTO CPU (ID, `#Cores`, `#vCores`, TurboClock, Clock, MaxPowerDraw, SocketID)
                        VALUES (%s, %s, %s, %s, %s, %s, %s)""", (part_id, Cores, vCores, TurboClock, Clock, MaxPowerDraw, SocketID))
        db.commit()
        return (part_id, conn.lastrowid)
    else:
        print("Unable to insert CPU")
        sys.exit(1)

def insert_motherboard(db, SKU, Name, Description, Release_Date, ManufacturerID, RameSlots, MaxRam, PCIESlots, SataPorts, SocketID):
    existing_part = get_part_by_sku(db, SKU)
    if existing_part is not None:
        return
    part_id = insert_part(db, SKU, Name, Description, Release_Date, ManufacturerID)
    if part_id >= 0:
        conn = db.cursor()
        conn.execute("""INSERT INTO Motherboard (ID, `#RamSlots`, MaxRam, `#PCIESlots`, `#SataPorts`, SocketID)
                        VALUES (%s, %s, %s, %s, %s, %s)""", (str(part_id), str(RameSlots), str(MaxRam), str(PCIESlots), str(SataPorts), str(SocketID)))
        db.commit()
        return (part_id, conn.lastrowid)
    else:
        print("Unable to insert CPU")
        sys.exit(1)

def insert_monitor(db, SKU, Name, Description, Release_Date, ManufacturerID, Size, Width, Height, Refresh_Rate):
    existing_part = get_part_by_sku(db, SKU)
    if existing_part is not None:
        return
    part_id = insert_part(db, SKU, Name, Description, Release_Date, ManufacturerID)
    if part_id >= 0:
        conn = db.cursor()
        conn.execute("""INSERT INTO Monitor (ID, Size, Width, Height, Refresh_Rate)
                        VALUES (%s, %s, %s, %s, %s)""", (part_id, Size, Width, Height, Refresh_Rate))
        db.commit()
        return (part_id, conn.lastrowid)
    else:
        print("Unable to insert Monitor")
        sys.exit(1)

def get_monitor_count(db):
    conn = db.cursor()
    conn.execute("""SELECT COUNT(*) FROM Monitor""")
    return conn.fetchone()

def insert_ram(db, SKU, Name, Description, Release_Date, ManufacturerID, Type, Speed):
    existing_part = get_part_by_sku(db, SKU)
    if existing_part is not None:
        return
    part_id = insert_part(db, SKU, Name, Description, Release_Date, ManufacturerID)
    if part_id >= 0:
        conn = db.cursor()
        conn.execute("""INSERT INTO Ram (ID, Type, Speed)
                        VALUES (%s, %s, %s)""", (part_id, Type, Speed))
        db.commit()
        return (part_id, conn.lastrowid)
    else:
        print("Unable to insert Ram")
        sys.exit(1)

def insert_gpu(db, SKU, Name, Description, Release_Date, ManufacturerID, Shaders, Vram, MinClock, Clock):
    existing_part = get_part_by_sku(db, SKU)
    if existing_part is not None:
        return
    part_id = insert_part(db, SKU, Name, Description, Release_Date, ManufacturerID)
    if part_id >= 0:
        conn = db.cursor()
        conn.execute("""INSERT INTO GraphicsCard (ID, `#Shaders`, `#Vram`, MinClock, Clock)
                        VALUES (%s, %s, %s, %s, %s)""", (part_id, str(Shaders), str(Vram), str(MinClock), str(Clock)))
        db.commit()
        return (part_id, conn.lastrowid)
    else:
        print("Unable to insert GraphicsCard")
        sys.exit(1)

def get_gpu_count(db):
    conn = db.cursor()
    conn.execute("""SELECT COUNT(*) FROM GraphicsCard""")
    return conn.fetchone()

def get_motherboard(db, RameSlots, MaxRam, PCIESlots, SataPorts, SocketID):
    conn = db.cursor()
    conn.execute("""SELECT * FROM Motherboard WHERE `#RamSlots` = %s AND MaxRam = %s AND `#PCIESlots` = %s AND `#SataPorts` = %s AND SocketID = %s""", (RamSlots, MaxRam, PCIESlots, SataPorts, SocketID))
    return conn.fetchone()

def get_all_motherboards(db):
    conn = db.cursor()
    conn.execute("""SELECT * FROM Motherboard""")
    return conn.fetchall()

def get_all_graphicscards(db):
    conn = db.cursor()
    conn.execute("""SELECT * FROM GraphicsCard""")
    return conn.fetchall()

def get_all_monitors(db):
    conn = db.cursor()
    conn.execute("""SELECT * FROM Monitor""")
    return conn.fetchall()

def random_date():
    start_date = date.today().replace(day=1, month=1, year=2000).toordinal()
    end_date = date.today().toordinal()
    return date.fromordinal(random.randint(start_date, end_date))

if __name__ == '__main__':
    db = "CS434"
    host = "127.0.0.1"
    user = "root"
    password = "Eclipse"
    database = initialize_mysql_connection(host, user, password, db)

    # Stores
    stores = [
    {   'name': 'outletpc', 'url': 'https://www.outletpc.com' },
    {   'name': 'amazon', 'url': 'https:///www.amazon.com' },
    {   'name': 'b&h', 'url': 'https://www.bhphotovideo.com' },
    {   'name': 'newegg', 'url': 'https://www.newegg.com' },
    {   'name': 'superbiiz', 'url': 'https://www.superbiiz.com' },
    {   'name': 'directron', 'url': 'https://www.directron.com/' },
    ]
    # Graphics Connectors
    connectors = [
    { 'name': 'HDMI', 'version' : '1.1a'},
    { 'name': 'DisplayPort', 'version': '2.0'},
    { 'name': 'VGA', 'version': '5.0'},
    { 'name': 'DVI', 'version': 'I'},
    { 'name': 'DVI', 'version': 'D'}
    ]
    print("Inserting Connectors")
    for connector in connectors:
        c = get_connector(database, connector['name'], connector['version'])
        if c is None:
            insert_graphics_connector(database, connector['name'], connector['version'])
            c = get_connector(database, connector['name'], connector['version'])
        connector['id'] = c[0]

    print("Inserting Stores")
    for store in stores:
        s = get_store(database, store['name'], store['url'])
        if s is None:
            insert_store(database, store['name'], store['url'])
            s = get_store(database, store['name'], store['url'])
        store['id'] = s[0]
    # Motherboards
    print("Inserting Motherboards")
    total_motherboard_pages = pcpartpicker.lists.total_pages("motherboard")
    for pagenum in range(1, total_motherboard_pages + 1):
        print("Page " + str(pagenum) + " of " + str(total_motherboard_pages))
        motherboards = pcpartpicker.lists.get_list("motherboard", pagenum)
        for motherboard in motherboards:
            # Get Manufacturer
            manufacturer_name = motherboard["name"].split(' ', 1)[0].lower()
            manufaturer = get_manufacturer(database, manufacturer_name)
            if manufaturer is None:
                insert_manufacturer(database, manufacturer_name)
                manufaturer = get_manufacturer(database, manufacturer_name)

            if "lga" in motherboard['socket'].lower() \
                    or "atom" in motherboard['socket'].lower() \
                    or "celeron" in motherboard['socket'].lower() \
                    or "e-series" in motherboard['socket'].lower() \
                    or "pentium" in motherboard['socket'].lower() \
                    or "xeon" in motherboard['socket'].lower():
                socket_manufacturer_name = "Intel"
                pcie_slots = 4
                sata_ports = 6
            else:
                socket_manufacturer_name = "AMD"
                pcie_slots = 3
                sata_ports = 5
            # Get Socket Manufacturer
            socket_manufacturer = get_manufacturer(database, socket_manufacturer_name)
            if socket_manufacturer is None:
                insert_manufacturer(database, socket_manufacturer_name)
                socket_manufacturer = get_manufacturer(database, socket_manufacturer_name)
            # Get Socket
            socket = get_socket(database, socket_manufacturer[0], motherboard['socket'])
            if socket is None:
                insert_socket(database, socket_manufacturer[0], motherboard['socket'])
                socket = get_socket(database, socket_manufacturer[0], motherboard['socket'])
            # Insert Motherboard
            decription = motherboard['name'] + " " + motherboard['socket'] + " " + motherboard['form-factor']
            if motherboard['max-ram'] != "":
                max_ram = re.findall("\d+", motherboard['max-ram'])[0]
            else:
                max_ram = 0
            mb_id = insert_motherboard(database, "M:"+ motherboard['id'], motherboard['name'], decription, random_date(), manufaturer[0], motherboard['ram-slots'], max_ram, pcie_slots, sata_ports, socket[0])
            if mb_id is not None:
                if motherboard['price'] == "":
                    cost = 0
                else:
                    cost = re.findall("\d+", motherboard['price'])[0]
                insert_sells(database, random.choice(stores)['id'], mb_id[0], cost)


    # CPUs
    print("Inserting CPUs")
    total_cpu_pages = pcpartpicker.lists.total_pages("cpu")
    for pagenum in range(1, total_cpu_pages + 1):
        print("Page " + str(pagenum) + " of " + str(total_cpu_pages))
        cpus = pcpartpicker.lists.get_list("cpu", pagenum)
        for cpu in cpus:
            # Determine Manufacturer
            manufacturer = None
            if "intel" in cpu["name"].lower():
                manufacturer_name = "Intel"
            else:
                manufacturer_name = "AMD"
            manufaturer = get_manufacturer(database, manufacturer_name)
            if manufaturer is None:
                insert_manufacturer(database, manufacturer_name)
                manufaturer = get_manufacturer(database, manufacturer_name)
            # Determine Socket
            sockets = get_socket_by_manufacturer(database, manufaturer[0])
            socket = random.choice(sockets)
            # Insert CPU
            description = cpu['name'] + " " + cpu['speed'] + " " + cpu['cores']
            if manufacturer_name == "Intel":
                vCores = int(cpu['cores']) * 2
            else:
                vCores = cpu['cores']
            if cpu['speed'] == "":
                speed = 0
            else:
                speed = re.findall("\d+", cpu['speed'])[0]
            if cpu['tdp'] == "":
                tdp = 0
            else:
                tdp = re.findall("\d+", cpu['tdp'])[0]
            cpu_id = insert_cpu(database, "C:" + cpu['id'], cpu['name'], description, random_date(), manufaturer[0], cpu['cores'], vCores, speed, speed, tdp, socket[0])
            if cpu_id is not None:
                if cpu['price'] == "":
                    cost = 0
                else:
                    cost = re.findall("\d+", cpu['price'])[0]
                insert_sells(database, random.choice(stores)['id'], cpu_id[0], cost)
    # Monitors
    print("Inserting Monitors")
    total_monitor_pages = pcpartpicker.lists.total_pages('monitor')
    for pagenum in range(1, total_monitor_pages + 1):
        print("Page " + str(pagenum) + " of " + str(total_monitor_pages))
        monitors = pcpartpicker.lists.get_list('monitor', pagenum)
        for monitor in monitors:
            # Get Manufacturer
            manufacturer_name = monitor["name"].split(' ', 1)[0].lower()
            manufaturer = get_manufacturer(database, manufacturer_name)
            if manufaturer is None:
                insert_manufacturer(database, manufacturer_name)
                manufaturer = get_manufacturer(database, manufacturer_name)
            width = monitor['resolution'].split(' x ', 1)[0]
            height = monitor['resolution'].split(' x ', 1)[1]
            size = re.findall("\d+", monitor['size'])[0]
            refresh_rate = monitor['response-time'].split(' ms', 1)[0]
            if refresh_rate is None or refresh_rate == "":
                refresh_rate = 0
            description = monitor['name'] + " "  + size + " " + " monitor"
            m_id = insert_monitor(database, "MI:" + monitor['id'], monitor['name'], description, random_date(), manufaturer[0], size, width, height, refresh_rate)
            if m_id is not None:
                if monitor['price'] == "":
                    cost = 0
                else:
                    cost = re.findall("\d+", monitor['price'])[0]
                insert_sells(database, random.choice(stores)['id'], m_id[0], cost)
    # RAM
    print("Inserting Ram")
    total_ram_pages = pcpartpicker.lists.total_pages('memory')
    for pagenum in range(1, total_ram_pages + 1):
        print("Page " + str(pagenum) + " of " + str(total_ram_pages))
        memory = pcpartpicker.lists.get_list('memory', pagenum)
        for ram in memory:
            manufacturer_name = ram["name"].split(' ', 1)[0].lower()
            manufaturer = get_manufacturer(database, manufacturer_name)
            if manufaturer is None:
                insert_manufacturer(database, manufacturer_name)
                manufaturer = get_manufacturer(database, manufacturer_name)
            speed = ram['speed'].split('-', 1)[1]
            Type = ram['speed'].split('-', 1)[0]
            if ram["name"].lower() == manufacturer_name:
                # Name is just mname
                name = manufacturer_name + " " + speed + " " + Type + " " + ram['modules']
            else:
                name = ram["name"]
            description = ram["name"] + " " + speed + " " + Type + " " + ram['modules']
            r_id = insert_ram(database, "R:" + ram["id"], name, description, random_date(), manufaturer[0], Type, speed)
            if r_id is not None:
                if ram['price'] == "":
                    cost = 0
                else:
                    cost = re.findall("\d+", ram['price'])[0]
                insert_sells(database, random.choice(stores)['id'], r_id[0], cost)

    # Graphics Cards
    print("Inserting Graphics Cards")
    total_gpu_pages = pcpartpicker.lists.total_pages('video-card')
    for pagenum in range(1, total_gpu_pages + 1):
        print("Page " + str(pagenum) + " of " + str(total_gpu_pages))
        gpus = pcpartpicker.lists.get_list('video-card', pagenum)
        for gpu in gpus:
            manufacturer_name = gpu["name"].split(' ', 1)[0].lower()
            manufaturer = get_manufacturer(database, manufacturer_name)
            if manufaturer is None:
                insert_manufacturer(database, manufacturer_name)
                manufaturer = get_manufacturer(database, manufacturer_name)
            shaders = random.randint(2000, 6000)
            vram = re.findall("\d+", gpu['memory'])[0]
            if gpu['core-clock'] is None or gpu['core-clock'] == "" or gpu['core-clock'] == "N/A":
                minClock = 0
            else:
                minClock = re.findall("\d+", gpu['core-clock'])[0]
            clock = minClock
            description = gpu['name'] + " " + gpu['chipset']
            name = gpu['name']
            g_id = insert_gpu(database, "G:" + gpu["id"], name, description, random_date(), manufaturer[0], shaders, vram, minClock, clock)
            if g_id is not None:
                if gpu['price'] == "":
                    cost = 0
                else:
                    cost = re.findall("\d+", gpu['price'])[0]
                insert_sells(database, random.choice(stores)['id'], g_id[0], cost)


    # Setup SupportsConnector
    print("Adding Graphics Connectors")
    all_motherboards = get_all_motherboards(database)
    all_gpus = get_all_graphicscards(database)
    all_monitors = get_all_monitors(database)
    for connectorID in range(0, len(connectors)):
        total = 0
        monitors = random.sample(all_monitors, random.randint(0, int(len(all_monitors) / 4) ))
        gpus = random.sample(all_gpus, random.randint(0, int(len(all_gpus) / 4)))
        motherboards = random.sample(all_motherboards, random.randint(0, int(len(all_motherboards) / 4)))
        for motherboard in motherboards:
            for gpu in gpus:
                for monitor in monitors:
                    count = random.randint(1, 3)
                    if get_supports_connector(database, motherboard[0], gpu[0], monitor[0], connectorID) is None:
                        insert_supports_connector(database, motherboard[0], gpu[0], monitor[0], connectorID, count)
                        total = total + 1
                        print("Total Supports Graphics Added: " + str(total))
