#include "databasecontroller.h"

DatabaseController::DatabaseController(const QString &hostname, const QString &username, const QString &password, const QString &dbName)
{
    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setDatabaseName(dbName);
    db.setHostName(hostname);
    db.setUserName(username);
    db.setPassword(password);
}

DatabaseController::~DatabaseController()
{
    close();
}

bool DatabaseController::open() {
    if(!db.open()){
        qDebug()<<"Database error: "<< db.lastError().text();
        return false;
    }
    qDebug()<<"Works fine brutha";
    return true;
}

void DatabaseController::close()
{
    if(db.isOpen()){
        db.close();
    }
}

bool DatabaseController::addCustomer(QString name, QString surname, QString email, QString password)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!";
        return false;
    }
    qDebug()<<"Adding to database";
    QSqlQuery query;
    query.prepare("INSERT INTO customers (name, surname, email, password) VALUES (?,?,?,?)");
    query.addBindValue(name);
    query.addBindValue(surname);
    query.addBindValue(email);
    query.addBindValue(password);

    if(!query.exec()) {
        qDebug()<<"Failed to add new customer to database.";
        return false;
    }
    return true;

}

bool DatabaseController::changeCustomerPassword(int &customerId, QString &newPassword)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!";
        return false;
    }
    QSqlQuery query;
    query.prepare("UPDATE customers SET password = :password WHERE id = :id");
    query.bindValue(":password", newPassword);
    query.bindValue(":id", customerId);

    if(!query.exec()) {
        qDebug()<<"Failed to add new customer to database.";
        return false;
    }
    return true;
}

QMap<QString, QVariant> DatabaseController::getCustomerByEmail(QString &email)
{
    QMap<QString, QVariant> customerData;

    if(!db.open()) {
        qDebug()<<"Database is not open!";
        return customerData;
    }

    QSqlQuery query;
    query.prepare("SELECT * from customers WHERE email = :email");
    query.bindValue(":email", email);
    if(!query.exec()) {
        qDebug()<<"Failed to execute query.";
        return customerData;
    }

    if(query.next()) {
        QSqlRecord record = query.record();
        for(int i=0; i<record.count(); i++) {
            customerData.insert(record.fieldName(i), record.value(i));
        }
        qDebug() << "Got customer data from database for email:" << email;
    } else {
        qDebug() << "No customer found with that email:" << email;
    }
    return customerData;
}

bool DatabaseController::addVehicleType(QString type)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!";
        return false;
    }
     QSqlQuery query;
    query.prepare("INSERT INTO vehicle_types (type_name) VALUES (?)");
    query.addBindValue(type);
    if(!query.exec()) {
        qDebug()<<"Failed to execute query." << query.lastError();
        return false;
    }

    return true;
}

// bool DatabaseController::fetchVehiclesForCustomer(Customer &currentCustomer)
// {
//     if(!db.open()) {
//         qDebug()<<"Database is not open!";
//         return false;
//     }

//     QSqlQuery query;
//     query.prepare("SELECT v.id, v.mark, v.model, v.year, v.version, v.engine, vt.type_name, v.vin, v.registration_number "
//                   "FROM vehicles v "
//                   "JOIN vehicle_types vt ON v.type_id = vt.id "
//                   "WHERE v.customer_id = ?");
//     query.bindValue(0, currentCustomer.getId());
//     if (!query.exec()) {
//         qDebug() << "Query execution error:" << query.lastError();
//         return false;
//     }

//     VehicleType type;
//     QVector<Vehicle*> vehicles;
//     while(query.next()){
//         type.setTypeName(query.value("type_name").toString());
//         type.setId(query.value("type_id").toInt());
//         Vehicle *vehicle = new Vehicle (
//             query.value("id").toInt(),
//             type,
//             query.value("mark").toString(),
//             query.value("model").toString(),
//             query.value("year").toInt(),
//             query.value("version").toString(),
//             query.value("engine").toString(),
//             query.value("vin").toString(),
//             query.value("registration_number").toString()
//             );
//         vehicles.append(vehicle);

//     }
//     currentCustomer.getVehicles()->setData(vehicles);
//     qDebug()<<"Vehicles set successfully";
//     return true;
// } //FINISH SERVICES AND NOTIFICATIONS AND CORRECT THIS METHOD

bool DatabaseController::fetchVehicleTypes()
{
    QVector<QPair<int, QString>> vehicleTypes;
    if(!db.open()) {
        qDebug()<<"Database is not open!"<<db.lastError();
        return false;
    }

    QSqlQuery query;
    query.prepare("SELECT id, type_name FROM vehicle_types");

    if(query.exec()) {
        while(query.next()) {
            int id = query.value(0).toInt();
            QString type = query.value(1).toString();
            vehicleTypes.append(qMakePair(id,type));
        }
    } else {
        qDebug()<<"Query execution failed: "<<query.lastError();
        return false;
    }
    emit vehicleTypesFetched(vehicleTypes);
    return true;
}

bool DatabaseController::addVehicle(int customerId, QString mark, QString model, QString year, QString version, QString engine,int typeId, QString type, QString vin, QString registrationNumber)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!"<<db.lastError();
        return false;
    }

    QSqlQuery query;
    query.prepare("INSERT INTO vehicles (customer_id,mark,model,year,version,engine,type_id,type,vin,registration_number) VALUES (?,?,?,?,?,?,?,?,?,?)");
    query.addBindValue(customerId);
    query.addBindValue(mark);
    query.addBindValue(model);
    query.addBindValue(year.toInt());
    query.addBindValue(version);
    query.addBindValue(engine);
    query.addBindValue(typeId);
    query.addBindValue(type);
    query.addBindValue(vin);
    query.addBindValue(registrationNumber);


    if(!query.exec()) {
        qDebug()<<"Nope "<<query.lastError();
        return false;
    } return true;
}

void DatabaseController::onFetchVehicles(int customer_id)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!"<<db.lastError();
        return;
    }

    QSqlQuery query;
    query.prepare("SELECT id,mark,model,year,version,engine,type_id,type,vin,registration_number FROM vehicles WHERE customer_id = :customerId");
    query.bindValue(":customerId", customer_id);
    if(query.exec()) {
        QVector<Vehicle*> vehiclesVector;
        while(query.next()) {
            VehicleType type(query.value(6).toInt(), query.value(7).toString());
            Vehicle *vehicle = new Vehicle(query.value(0).toInt(),type,query.value(1).toString(),query.value(2).toString(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toString(),query.value(8).toString(),query.value(9).toString());
            vehiclesVector.push_back(vehicle);
        }
        VehicleModel* model = new VehicleModel();
        model->setData(vehiclesVector);
        emit vehiclesFetched(model);
    }
        else {
            qDebug()<<"Query execution failed: "<<query.lastError();
            return;
        }
}

bool DatabaseController::addService(int vehicle_id, int mileage, QString type, int interval_km, QString service_date, QString interval_time, QString service, QString oil, QString oilFilter, QString airFilter, QString cabinFilter, QString timing)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!"<<db.lastError();
        return false;
    }
    QSqlQuery query;
    query.prepare("INSERT INTO services (vehicle_id, mileage, type, interval_km, service_date,interval_time, service, oil, oil_filter, air_filter, cabin_filter, timing) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
    query.addBindValue(vehicle_id);
    query.addBindValue(mileage);
    query.addBindValue(type);
    query.addBindValue(interval_km);
    query.addBindValue(service_date);
    query.addBindValue(interval_time);
    query.addBindValue(service);
    query.addBindValue(oil);
    query.addBindValue(oilFilter);
    query.addBindValue(airFilter);
    query.addBindValue(cabinFilter);
    query.addBindValue(timing);

    if(!query.exec()) {
        qDebug()<<"Nope "<<query.lastQuery();
        return false;
    } return true;

}

void DatabaseController::registrationSuccess(const QString &name, const QString &surname, const QString &email, const QString &password)
{
    qDebug()<<"Performing signal answer";
    if(!addCustomer(name,surname,email,password)){
        qDebug()<<"DATABASE SLOT : CUSTOMER NOT ADDED";
    } else {
        qDebug()<<"DATABASE SLOT: CUSTOMER ADDED";
    }
}
