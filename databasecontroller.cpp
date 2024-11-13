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

bool DatabaseController::checkVin(QString vin)
{
    if (!db.open()) {
        qDebug() << "Database is not open:" << db.lastError();
        return false;
    }

    QSqlQuery query;
    query.prepare("SELECT 1 FROM vehicles WHERE vin = :vin LIMIT 1"); // Limit to one row, optimizing the query
    query.bindValue(":vin", vin);

    if (!query.exec()) {
        qDebug() << "Failed to execute query:" << query.lastError();
        return false;
    }

    if (query.next()) {
        qDebug() << "Found a vehicle with the given VIN";
        return true;
    }

    qDebug() << "No vehicle found with the given VIN";
    return false;
}

bool DatabaseController::checkRegistration(QString registration)
{
    if (!db.open()) {
        qDebug() << "Database is not open:" << db.lastError();
        return false;
    }

    QSqlQuery query;
    query.prepare("SELECT 1 FROM vehicles WHERE registration_number = :registration LIMIT 1");
    query.bindValue(":registration", registration);

    if (!query.exec()) {
        qDebug() << "Failed to execute query:" << query.lastError();
        return false;
    }

    if (query.next()) {
        qDebug() << "Found a vehicle with the given registration";
        return true;
    }

    qDebug() << "No vehicle found with the given registration";
    return false;
}

bool DatabaseController::removeVehicle(int id)
{
    if (!db.open()) {
        qDebug() << "Database is not open:" << db.lastError();
        return false;
    }

    QSqlQuery query;
    query.prepare("DELETE FROM vehicles WHERE id  =:id");
    query.bindValue(":id",id);
    if (!query.exec()) {
        qDebug() << "Failed to execute query:" << query.lastError();
        return false;
    }
    qDebug()<<"Vehicle removed successfully";
    return true;
}

bool DatabaseController::updateVehicle(int vehicleId, QString mark, QString model, QString year, QString version, QString engine, int typeId, QString type, QString vin, QString registrationNumber)
{
    QString updateQuery = "UPDATE vehicles SET ";
    QStringList setClauses;

    if (!mark.isEmpty()) {
        setClauses.append("mark = ?");
    }
    if (!model.isEmpty()) {
        setClauses.append("model = ?");
    }
    if (!year.isEmpty()) {
        setClauses.append("year = ?");
    }
    if (!version.isEmpty()) {
        setClauses.append("version = ?");
    }
    if (!engine.isEmpty()) {
        setClauses.append("engine = ?");
    }
    if (typeId != -1) {  // Zmiana typu, jeżeli nie jest -1
        setClauses.append("type_id = ?");
    }
    if (!type.isEmpty()) {
        setClauses.append("type = ?");
    }
    if (!vin.isEmpty()) {
        setClauses.append("vin = ?");
    }
    if (!registrationNumber.isEmpty()) {
        setClauses.append("registration_number = ?");
    }

    if (setClauses.isEmpty()) {
        qDebug() << "No fields to update.";
        return false;
    }

    updateQuery += setClauses.join(", ") + " WHERE id = ?";

    QSqlQuery query;
    query.prepare(updateQuery);

    // Dodaj wartości do zapytania
    for (const QString &clause : setClauses) {
        if (clause.startsWith("mark")) {
            query.addBindValue(mark);
            qDebug() << "Updating mark to:" << mark;
        } else if (clause.startsWith("model")) {
            query.addBindValue(model);
            qDebug() << "Updating model to:" << model;
        } else if (clause.startsWith("year")) {
            query.addBindValue(year.toInt());  // Upewnij się, że year jest konwertowany na int
            qDebug() << "Updating year to:" << year;
        } else if (clause.startsWith("version")) {
            query.addBindValue(version);
            qDebug() << "Updating version to:" << version;
        } else if (clause.startsWith("engine")) {
            query.addBindValue(engine);
            qDebug() << "Updating engine to:" << engine;
        } else if (clause.startsWith("type_id")) {
            query.addBindValue(typeId);
            qDebug() << "Updating type_id to:" << typeId;
        } else if (clause.startsWith("type")) {
            query.addBindValue(type);
            qDebug() << "Updating type to:" << type;
        } else if (clause.startsWith("vin")) {
            query.addBindValue(vin);
            qDebug() << "Updating VIN to:" << vin;
        } else if (clause.startsWith("registration_number")) {
            query.addBindValue(registrationNumber);
            qDebug() << "Updating registration_number to:" << registrationNumber;
        }
    }

    query.addBindValue(vehicleId);  // Dodajemy ID pojazdu na końcu

    // Wykonujemy zapytanie
    if (!query.exec()) {
        qDebug() << "Failed to update vehicle: " << query.lastError().text();
        return false;
    }
    qDebug() << "Vehicle with ID" << vehicleId << "successfully updated.";
    return true;
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
        //VehicleModel* model = new VehicleModel();
        // qDebug()<<"Vehicles to fetch: "<<vehiclesVector.size();
        // model->setData(vehiclesVector);
        // qDebug()<<"After setting data: "<<model->getVehicles().size();
        emit vehiclesFetched(vehiclesVector);
    }
        else {
            qDebug()<<"Query execution failed: "<<query.lastError();
            return;
        }
}

bool DatabaseController::addService(int vehicle_id, QString mileage, QString type, QString interval_km, QString service_date, QString interval_time, QString service, QString oil, QString oilFilter, QString airFilter, QString cabinFilter, QString timing, QString customParts)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!"<<db.lastError();
        return false;
    }
    QSqlQuery query;
    query.prepare("INSERT INTO services (vehicle_id, mileage, type, interval_km, service_date,interval_time, service, oil, oil_filter, air_filter, cabin_filter, timing, custom_parts) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)");
    query.addBindValue(vehicle_id);
    query.addBindValue(mileage.toInt());
    query.addBindValue(type);
    if(interval_time.isEmpty()){
        query.addBindValue(QVariant());
    } else {
        query.addBindValue(interval_km.toInt());
    }

    query.addBindValue(service_date);
    if(interval_time.isEmpty()){
        query.addBindValue(QVariant());
    } else {
        query.addBindValue(interval_time.toInt());
    }
    query.addBindValue(service);
    query.addBindValue(oil);
    query.addBindValue(oilFilter);
    query.addBindValue(airFilter);
    query.addBindValue(cabinFilter);
    query.addBindValue(timing);
    query.addBindValue(customParts);

    if(!query.exec()) {
        qDebug()<<"Nope "<<query.lastError();
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
