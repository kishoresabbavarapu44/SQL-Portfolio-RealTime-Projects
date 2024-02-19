Create Database Hospital_Management_system

Use Hospital_Management_system


-- Physician Table
CREATE TABLE physician (
    employeeid INTEGER PRIMARY KEY,
    name TEXT,
    position TEXT,
    ssn INTEGER UNIQUE
);

-- Department Table
CREATE TABLE department (
    departmentid INTEGER PRIMARY KEY,
    name TEXT,
    head INTEGER,
    FOREIGN KEY (head) REFERENCES physician(employeeid)
);



-- Affiliated Table
CREATE TABLE affiliated (
    physician INTEGER,
    department INTEGER,
    primaryaffiliation BIT,
    FOREIGN KEY (physician) REFERENCES physician(employeeid),
    FOREIGN KEY (department) REFERENCES department(departmentid)
);

-- Patient Table
CREATE TABLE patient (
    ssn INTEGER PRIMARY KEY,
    name TEXT,
    address TEXT,
    phone TEXT,
    insuranceid INTEGER,
    pcp INTEGER,
    FOREIGN KEY (pcp) REFERENCES physician(employeeid)
);

-- Nurse Table
CREATE TABLE nurse (
    employeeid INTEGER PRIMARY KEY,
    name TEXT,
    position TEXT,
    registered BIT,
    ssn INTEGER UNIQUE
);

-- Room Table
CREATE TABLE room (
    roomnumber INTEGER PRIMARY KEY,
    roomtype TEXT,
    blockfloor INTEGER,
    blockcode INTEGER,
    unavailable BIT
);

-- Block Table
CREATE TABLE block (
    blockfloor INTEGER,
    blockcode INTEGER PRIMARY KEY 
);

-- Stay Table
CREATE TABLE stay (
    stayid INTEGER PRIMARY KEY,
    patient INTEGER,
    room INTEGER,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (patient) REFERENCES patient(ssn),
    FOREIGN KEY (room) REFERENCES room(roomnumber)
);

-- Appointment Table
CREATE TABLE appointment (
    appointmentid INTEGER PRIMARY KEY,
    patient INTEGER,
    physician INTEGER,
    start_dt_time DATETIME,
    end_dt_time DATETIME,
    examinationroom TEXT,
    FOREIGN KEY (patient) REFERENCES patient(ssn),
    FOREIGN KEY (physician) REFERENCES physician(employeeid)
);

-- Medication Table
CREATE TABLE medication (
    code INTEGER PRIMARY KEY,
    name TEXT,
    brand TEXT,
    description TEXT
);

-- Prescribes Table
CREATE TABLE prescribes (
    physician INTEGER,
    patient INTEGER,
    medication INTEGER,
    date DATETIME,
    appointment INTEGER,
    dose TEXT,
    FOREIGN KEY (physician) REFERENCES physician(employeeid),
    FOREIGN KEY (patient) REFERENCES patient(ssn),
    FOREIGN KEY (medication) REFERENCES medication(code),
    FOREIGN KEY (appointment) REFERENCES appointment(appointmentid)
);

-- Procedure Table
CREATE TABLE medical_procedure (
    code INTEGER PRIMARY KEY,
    name TEXT,
    cost REAL
);

-- Undergoes Table
CREATE TABLE undergoes (
    patient INTEGER,
    medical_procedure INTEGER,
    stay INTEGER,
    date DATETIME,
    physician INTEGER,
    assistingnurse INTEGER,
    FOREIGN KEY (patient) REFERENCES patient(ssn),
    FOREIGN KEY (medical_procedure) REFERENCES medical_procedure(code),
    FOREIGN KEY (stay) REFERENCES stay(stayid),
    FOREIGN KEY (physician) REFERENCES physician(employeeid),
    FOREIGN KEY (assistingnurse) REFERENCES nurse(employeeid)
);

-- On_Call Table

CREATE TABLE on_call (
    nurse INTEGER,
    blockfloor INTEGER,
    blockcode INTEGER,
    oncallstart DATETIME,
    oncallend DATETIME,
    FOREIGN KEY (nurse) REFERENCES nurse(employeeid),
    FOREIGN KEY ( blockcode) REFERENCES block(blockcode)
);

-- Trained_In Table
CREATE TABLE trained_in (
    physician INTEGER,
    treatment INTEGER,
    certificationdate DATE,
    certificationexpires DATE,
    FOREIGN KEY (physician) REFERENCES physician(employeeid),
    FOREIGN KEY (treatment) REFERENCES medical_procedure(code)
);
