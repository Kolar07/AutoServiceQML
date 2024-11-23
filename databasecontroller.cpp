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

bool DatabaseController::addVehicle(int customerId, QString brand, QString model, QString year, QString version, QString engine,int typeId, QString type, QString vin, QString registrationNumber)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!"<<db.lastError();
        return false;
    }

    QSqlQuery query;
    query.prepare("INSERT INTO vehicles (customer_id,brand,model,year,version,engine,type_id,type,vin,registration_number) VALUES (?,?,?,?,?,?,?,?,?,?)");
    query.addBindValue(customerId);
    query.addBindValue(brand);
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

bool DatabaseController::removeMultipleVehicles(QVector<int> vehiclesIds)
{

        if (!db.open()) {
            qDebug() << "Database is not open:" << db.lastError();
            return false;
        }

        if (vehiclesIds.isEmpty()) {
            qDebug() << "No vehicle IDs provided to remove.";
            return false;
        }

        QSqlQuery query;
        QString placeholders;
        for (int i = 0; i < vehiclesIds.size(); ++i) {
            placeholders += (i > 0 ? "," : "") + QString(":id%1").arg(i);
        }

        QString queryString = QString("DELETE FROM vehicles WHERE id IN (%1)").arg(placeholders);
        query.prepare(queryString);

        for (int i = 0; i < vehiclesIds.size(); i++) {
            query.bindValue(QString(":id%1").arg(i), vehiclesIds[i]);
        }

        if (!query.exec()) {
            qDebug() << "Failed to execute query:" << query.lastError();
            return false;
        }

        qDebug() << "Vehicles removed successfully.";
        return true;

}

bool DatabaseController::updateVehicle(int vehicleId, QString brand, QString model, QString year, QString version, QString engine, int typeId, QString type, QString vin, QString registrationNumber)
{
    QString updateQuery = "UPDATE vehicles SET ";
    QStringList setClauses;

    if (!brand.isEmpty()) {
        setClauses.append("brand = ?");
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
    if (typeId != -1) {
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

    for (const QString &clause : setClauses) {
        if (clause.startsWith("mark")) {
            query.addBindValue(brand);
            qDebug() << "Updating brand to:" << brand;
        } else if (clause.startsWith("brand")) {
            query.addBindValue(model);
            qDebug() << "Updating model to:" << model;
        } else if (clause.startsWith("year")) {
            query.addBindValue(year.toInt());
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

    query.addBindValue(vehicleId);


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
    query.prepare("SELECT id,brand,model,year,version,engine,type_id,type,vin,registration_number FROM vehicles WHERE customer_id = :customerId");
    query.bindValue(":customerId", customer_id);
    if(query.exec()) {
        QVector<Vehicle*> vehiclesVector;
        while(query.next()) {
            VehicleType type(query.value(6).toInt(), query.value(7).toString());
            Vehicle *vehicle = new Vehicle(query.value(0).toInt(),type,query.value(1).toString(),query.value(2).toString(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toString(),query.value(8).toString(),query.value(9).toString());
            connect(this, &DatabaseController::servicesFetched, vehicle, &Vehicle::onFetchedServices);
            connect(vehicle, &Vehicle::fetchServices, this, &DatabaseController::onFetchServices);
            emit vehicle->fetchServices(vehicle->getId());
            disconnect(this, &DatabaseController::servicesFetched, vehicle, &Vehicle::onFetchedServices);
            disconnect(vehicle, &Vehicle::fetchServices, this, &DatabaseController::onFetchServices);
            vehiclesVector.push_back(vehicle);
        }
        emit vehiclesFetched(vehiclesVector);
    }
        else {
            qDebug()<<"Query execution failed: "<<query.lastError();
            return;
        }
}

void DatabaseController::onFetchServices(int vehicleId)
{
    qDebug()<<"Started fetching services for vehicle id: "<<vehicleId;

    if(!db.open()) {
        qDebug()<<"Database is not open!"<<db.lastError();
        return;
    }
    QSqlQuery query;
    query.prepare("SELECT id, mileage,type,interval_km,service_date,interval_time,service,oil,oil_filter,air_filter,cabin_filter,timing,custom_parts,note FROM services WHERE vehicle_id = :vehicleId");
    query.bindValue(":vehicleId", vehicleId);
    if(query.exec()) {
        QVector<std::shared_ptr<Service>> services;
        while(query.next()) {
            if(query.value(2).toString() == "MaintenanceService") {
                std::shared_ptr<Service> service = std::make_shared<MaintenanceService>(query.value(0).toInt(),query.value(1).toInt(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toInt(),query.value(6).toString(),query.value(2).toString(),query.value(13).toString());
                services.push_back(std::move(service));
            } else if(query.value(2).toString() == "RepairService") {
                std::shared_ptr<Service> service = std::make_shared<RepairService>(query.value(0).toInt(),query.value(1).toInt(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toInt(),query.value(6).toString(),query.value(2).toString(),query.value(12).toString(),query.value(13).toString());
                services.push_back(std::move(service));
            } else if(query.value(2).toString() == "ServiceOil") {
                std::shared_ptr<Service> service = std::make_shared<ServiceOil>(query.value(0).toInt(),query.value(1).toInt(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toInt(),query.value(6).toString(),query.value(2).toString(),query.value(7).toString(), query.value(8).toString(),query.value(9).toString(), query.value(10).toString(),query.value(13).toString());
                services.push_back(std::move(service));
            } else if(query.value(2).toString() == "ServiceTiming") {
                std::shared_ptr<Service> service = std::make_shared<ServiceTiming>(query.value(0).toInt(),query.value(1).toInt(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toInt(),query.value(6).toString(),query.value(2).toString(),query.value(11).toString(),query.value(13).toString());
                services.push_back(std::move(service));
            } else return;
        }
        qDebug()<<"Services successfully fetched.";
        emit servicesFetched(vehicleId,services);
    } else {
        qDebug()<<"Query execution failed: "<<query.lastError();
        return;
    }
}

void DatabaseController::onServicesFetchVersionSpecifiedVehicle(int vehicleId)
{
    qDebug()<<"DEBUGING SERVICES FETCHING FOR VEHICLE ID: "<<vehicleId;

    if(!db.open()) {
        qDebug()<<"Database is not open!"<<db.lastError();
        return;
    }
    QSqlQuery query;
    query.prepare("SELECT id, mileage,type,interval_km,service_date,interval_time,service,oil,oil_filter,air_filter,cabin_filter,timing,custom_parts,note FROM services WHERE vehicle_id = :vehicleId");
    query.bindValue(":vehicleId", vehicleId);
    if(query.exec()) {
        QVector<std::shared_ptr<Service>> services;
        while(query.next()) {
            if(query.value(2).toString() == "MaintenanceService") {
                std::shared_ptr<Service> service = std::make_shared<MaintenanceService>(query.value(0).toInt(),query.value(1).toInt(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toInt(),query.value(6).toString(),query.value(2).toString(),query.value(13).toString());
                services.push_back(std::move(service));
            } else if(query.value(2).toString() == "RepairService") {
                std::shared_ptr<Service> service = std::make_shared<RepairService>(query.value(0).toInt(),query.value(1).toInt(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toInt(),query.value(6).toString(),query.value(2).toString(),query.value(12).toString(),query.value(13).toString());
                services.push_back(std::move(service));
            } else if(query.value(2).toString() == "ServiceOil") {
                std::shared_ptr<Service> service = std::make_shared<ServiceOil>(query.value(0).toInt(),query.value(1).toInt(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toInt(),query.value(6).toString(),query.value(2).toString(),query.value(7).toString(), query.value(8).toString(),query.value(9).toString(), query.value(10).toString(),query.value(13).toString());
                services.push_back(std::move(service));
            } else if(query.value(2).toString() == "ServiceTiming") {
                std::shared_ptr<Service> service = std::make_shared<ServiceTiming>(query.value(0).toInt(),query.value(1).toInt(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toInt(),query.value(6).toString(),query.value(2).toString(),query.value(11).toString(),query.value(13).toString());
                services.push_back(std::move(service));
            } else return;
        }
        qDebug()<<"SERVICESS SUCCESSFULLY FETCHED - DEBUG";
        emit servicesFetchedVersionSpecifiedVehicle(vehicleId,services);
        qDebug() << "DEBUG - Emitting servicesFetched for vehicle ID:" << vehicleId << ", Services size:" << services.size();
    } else {
        qDebug()<<"Query execution failed: "<<query.lastError();
        return;
    }
}


bool DatabaseController::addService(int vehicle_id, QString mileage, QString type, QString interval_km, QString service_date, QString interval_time, QString service, QString oil, QString oilFilter, QString airFilter, QString cabinFilter, QString timing, QString customParts,QString note)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!"<<db.lastError();
        return false;
    }
    QSqlQuery query;
    query.prepare("INSERT INTO services (vehicle_id, mileage, type, interval_km, service_date,interval_time, service, oil, oil_filter, air_filter, cabin_filter, timing, custom_parts,note) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
    query.addBindValue(note);

    if(!query.exec()) {
        qDebug()<<"Nope "<<query.lastError();
        return false;
    } return true;

}

bool DatabaseController::updateService(int serviceId, QString mileage, QString interval_km, QString interval_time, QString service, QString oil, QString oilFilter, QString airFilter, QString cabinFilter, QString timing, QString customParts,QString note)
{
    QString updateQuery = "UPDATE services SET ";
    QStringList setClauses;

    if (!mileage.isEmpty()) {
        qDebug()<<"mileage: "<<mileage;
        setClauses.append("mileage = ?");
    }
    if (!interval_km.isEmpty()) {
        qDebug()<<"interval_km: "<<interval_km;
        setClauses.append("interval_km= ?");
    }
    if (!interval_time.isEmpty()) {
        qDebug()<<"interval time: "<<interval_time;
        setClauses.append("interval_time = ?");
    }
    if (!service.isEmpty()) {
        qDebug()<<"service: "<<service;
        setClauses.append("service = ?");
    }
    if (!oil.isEmpty()) {
        qDebug()<<"Oil: "<<oil;
        setClauses.append("oil = ?");
    }
    if (!oilFilter.isEmpty()) {
        qDebug()<<"OIL FILTER: "<<oilFilter;
        setClauses.append("oil_filter = ?");
    }
    if (!airFilter.isEmpty()) {
        qDebug()<<"airfilter: "<<airFilter;
        setClauses.append("air_filter = ?");
    }
    if (!cabinFilter.isEmpty()) {
        qDebug()<<"cabinfilter: "<<cabinFilter;
        setClauses.append("cabin_filter = ?");
    }
    if (!timing.isEmpty()) {
        qDebug()<<"timing: "<<timing;
        setClauses.append("timing = ?");
    }
    if(!customParts.isEmpty()) {
        qDebug()<<"customparts: "<<customParts;
        setClauses.append("custom_parts = ?");
    }
    if(!note.isEmpty()) {
        qDebug()<<"note: "<<note;
        setClauses.append("note = ?");
    }

    if (setClauses.isEmpty()) {
        qDebug() << "No fields to update.";
        return false;
    }

    updateQuery += setClauses.join(", ") + " WHERE id = ?";

    QSqlQuery query;
    query.prepare(updateQuery);

    for (const QString &clause : setClauses) {
        if (clause.startsWith("mileage")) {
            query.addBindValue(mileage.toInt());
            qDebug() << "Updating mileage to:" << mileage;
        } else if (clause.startsWith("interval_km")) {
            query.addBindValue(interval_km.toInt());
            qDebug() << "Updating interval_km to:" << interval_km;
        } else if (clause.startsWith("interval_time")) {
            query.addBindValue(interval_time.toInt());
            qDebug() << "Updating interval_time to:" << interval_time;
        } else if (clause.startsWith("service")) {
            query.addBindValue(service);
            qDebug() << "Updating service to:" << service;
        } else if (clause == "oil = ?") {
            query.addBindValue(oil);
            qDebug() << "Updating oil to:" << oil;
        } else if (clause == "oil_filter = ?") {
            query.addBindValue(oilFilter);
            qDebug() << "Updating oil_filter to:" << oilFilter;
        } else if (clause.startsWith("air_filter")) {
            query.addBindValue(airFilter);
            qDebug() << "Updating air_filter to:" << airFilter;
        } else if (clause.startsWith("cabin_filter")) {
            query.addBindValue(cabinFilter);
            qDebug() << "Updating cabin_filter to:" << cabinFilter;
        } else if (clause.startsWith("timing")) {
            query.addBindValue(timing);
            qDebug() << "Updating timing to:" << timing;
        } else if (clause.startsWith("custom_parts")) {
            query.addBindValue(customParts);
            qDebug() << "Updating custom_parts to:" << customParts;
        } else if (clause.startsWith("note")) {
            query.addBindValue(note);
            qDebug() << "Updating note to:" << note;
        }
    }
    query.addBindValue(serviceId);
    qDebug()<<"service id: "<<serviceId;

    if (!query.exec()) {
        qDebug() << "Failed to update service: " << query.lastError();
        return false;
    }
    qDebug() << "Service with ID" << serviceId << "successfully updated.";
    return true;


    //Maybe add date change too?
}

bool DatabaseController::removeService(int serviceId)
{

        if (!db.open()) {
            qDebug() << "Database is not open:" << db.lastError();
            return false;
        }

        QSqlQuery query;
        query.prepare("DELETE FROM services WHERE id  =:id");
        query.bindValue(":id",serviceId);
        if (!query.exec()) {
            qDebug() << "Failed to execute query:" << query.lastError();
            return false;
        }
        qDebug()<<"Service removed successfully";
        return true;
}

bool DatabaseController::removeMultipleServices(QVector<int> serviceIds)
{
    if (!db.open()) {
        qDebug() << "Database is not open:" << db.lastError();
        return false;
    }

    if (serviceIds.isEmpty()) {
        qDebug() << "No service IDs provided to remove.";
        return false;
    }

    QSqlQuery query;
    QString placeholders;
    for (int i = 0; i < serviceIds.size(); ++i) {
        placeholders += (i > 0 ? "," : "") + QString(":id%1").arg(i);
    }

    QString queryString = QString("DELETE FROM services WHERE id IN (%1)").arg(placeholders);
    query.prepare(queryString);

    for (int i = 0; i < serviceIds.size(); i++) {
        query.bindValue(QString(":id%1").arg(i), serviceIds[i]);
    }

    if (!query.exec()) {
        qDebug() << "Failed to execute query:" << query.lastError();
        return false;
    }

    qDebug() << "Services removed successfully.";
    return true;
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
