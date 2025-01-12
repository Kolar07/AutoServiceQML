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
    qDebug()<<"Works fine";
    return true;
}

void DatabaseController::close()
{
    if(db.isOpen()){
        db.close();
    }
}

void DatabaseController::init()
{


    if (!db.open()) {
        qDebug()<<"Failed connecting with database: " + db.lastError().text();
        return;
    }


    const QString createVehiclesTable = R"(
        CREATE TABLE IF NOT EXISTS vehicles (
          id INT NOT NULL AUTO_INCREMENT,
          customer_id INT DEFAULT NULL,
          brand VARCHAR(255) NOT NULL,
          model VARCHAR(255) NOT NULL,
          year INT NOT NULL,
          version VARCHAR(255) NOT NULL,
          engine VARCHAR(255) NOT NULL,
          type_id INT DEFAULT NULL,
          type VARCHAR(255) DEFAULT NULL,
          vin VARCHAR(255) NOT NULL,
          registration_number VARCHAR(255) NOT NULL,
          PRIMARY KEY (id),
          UNIQUE (customer_id, registration_number),
          UNIQUE (customer_id, vin),
          CONSTRAINT fk_type_id FOREIGN KEY (type_id) REFERENCES vehicle_types (id) ON DELETE SET NULL ON UPDATE CASCADE,
          CONSTRAINT vehicles_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE ON UPDATE CASCADE)
    )";

    const QString createServicesTable = R"(
        CREATE TABLE IF NOT EXISTS services (
          id INT NOT NULL AUTO_INCREMENT,
          vehicle_id INT NOT NULL,
          mileage INT NOT NULL,
          type ENUM('ServiceOil','ServiceTiming','RepairService','MaintenanceService') NOT NULL,
          interval_km INT DEFAULT NULL,
          service_date DATE NOT NULL,
          interval_time INT DEFAULT NULL,
          service VARCHAR(255) NOT NULL,
          oil VARCHAR(255) DEFAULT NULL,
          oil_filter VARCHAR(255) DEFAULT NULL,
          air_filter VARCHAR(255) DEFAULT NULL,
          cabin_filter VARCHAR(255) DEFAULT NULL,
          timing VARCHAR(255) DEFAULT NULL,
          custom_parts VARCHAR(255) DEFAULT NULL,
          note VARCHAR(255) DEFAULT NULL,
          PRIMARY KEY (id),
          CONSTRAINT services_ibfk_1 FOREIGN KEY (vehicle_id) REFERENCES vehicles (id) ON DELETE CASCADE ON UPDATE CASCADE)
    )";

    const QString createVehicleTypesTable = R"(
        CREATE TABLE IF NOT EXISTS vehicle_types (
          id INT NOT NULL AUTO_INCREMENT,
          type_name VARCHAR(50) UNIQUE NOT NULL,
          PRIMARY KEY (id))
    )";

    const QString createCustomersTable = R"(
        CREATE TABLE IF NOT EXISTS customers (
          id INT NOT NULL AUTO_INCREMENT,
          name VARCHAR(255) DEFAULT NULL,
          surname VARCHAR(255) DEFAULT NULL,
          email VARCHAR(255) UNIQUE NOT NULL,
          password VARCHAR(255) NOT NULL,
          PRIMARY KEY (id))
    )";

    const QString createNotificationsTable = R"(
        CREATE TABLE IF NOT EXISTS notifications (
          id int NOT NULL auto_increment,
          service_id int NOT NULL,
          service_date date NOT NULL,
          next_service_date date,
          next_service_km int,
          service varchar(255) NOT NULL,
          service_type varchar(255) NOT NULL,
          vehicle_registration varchar(255) NOT NULL,
          customer_id INT NOT NULL,
          PRIMARY KEY (id),
          CONSTRAINT fk_service_id FOREIGN KEY (service_id) REFERENCES services(id)
            ON DELETE CASCADE ON UPDATE CASCADE,
          CONSTRAINT fk_vehicle_registration FOREIGN KEY (customer_id, vehicle_registration) REFERENCES vehicles(customer_id,registration_number)
            ON UPDATE CASCADE ON DELETE CASCADE,
          CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(id)
            ON UPDATE CASCADE ON DELETE CASCADE
    ))";

    if (!executeQuery(createVehicleTypesTable) ||
        !executeQuery(createCustomersTable) ||
        !executeQuery(createVehiclesTable) ||
        !executeQuery(createServicesTable) ||
        !executeQuery(createNotificationsTable)) {
        return;
    }
    qDebug()<<"Database created or existing";
}

bool DatabaseController::executeQuery(const QString &query)
{
    QSqlQuery q;
    if (!q.exec(query)) {
        qDebug()<< "Błąd podczas tworzenia tabeli: " + q.lastError().text() << " dla polecenia: " <<query;
        return false;
    }
    else {
        qDebug()<<"Query executed";
        return true;

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

bool DatabaseController::changeCustomerPassword(QString _email, QString _name, QString _surname, QString _password)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!";
        return false;
    }

    QSqlQuery queryCheck;
    queryCheck.prepare("SELECT name, surname FROM customers WHERE email = :emailCheck");
    queryCheck.bindValue(":emailCheck", _email);


    if(!queryCheck.exec()) {
        qDebug()<<"Failed to change password.";
        return false;
    } else {
        if(queryCheck.next()) {
            qDebug()<<"Found account with email: " << _email;
            QString dbName = queryCheck.value("name").toString().toLower();
            QString dbSurname = queryCheck.value("surname").toString().toLower();
            qDebug()<<"Name and surname from db: " << dbName << " " << dbSurname;
            qDebug()<<"Name and surname to compare : " << _name << " " << _surname;
            if(dbName == _name.toLower() && dbSurname == _surname.toLower()) {

            RegisterController reg;
            QByteArray salt = reg.generateSalt();
            QString psw = reg.hashPassword(_password, salt);
    QSqlQuery query;
    query.prepare("UPDATE customers SET password = :password WHERE email = :email");
    query.bindValue(":password", psw);
    query.bindValue(":email", _email);

    qDebug()<<"New password: " << psw;

    if(!query.exec()) {
        qDebug()<<"Failed to change password.";
        return false;
    }
        } else {
            qDebug()<<"Failed to change password.";
            return false;
        }
        } else  {
            qDebug()<<"Failed to find account with given email";
            return false;
        }
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
    query.addBindValue(registrationNumber.toUpper());


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
    query.prepare("DELETE FROM vehicles WHERE id =:id");
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
        qDebug()<<"UPDATING BRAND: " << brand;
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
        if (clause.startsWith("brand")) {
            query.addBindValue(brand);
            qDebug() << "Updating brand to:" << brand;
        } else if (clause.startsWith("model")) {
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
    //qDebug()<<"Started fetching services for vehicle id: "<<vehicleId;

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
    //qDebug()<<"DEBUGING SERVICES FETCHING FOR VEHICLE ID: "<<vehicleId;

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
        //qDebug()<<"SERVICESS SUCCESSFULLY FETCHED - DEBUG";
        emit servicesFetchedVersionSpecifiedVehicle(vehicleId,services);
        //qDebug() << "DEBUG - Emitting servicesFetched for vehicle ID:" << vehicleId << ", Services size:" << services.size();
    } else {
        qDebug()<<"Query execution failed: "<<query.lastError();
        return;
    }
}

void DatabaseController::onFetchNotifications(int customerId)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!"<<db.lastError();
        db.open();
        return;
    }

    QSqlQuery query;
    query.prepare("SELECT id,service_date,next_service_date,next_service_km,service,service_type,vehicle_registration FROM notifications WHERE customer_id = :id");
    query.bindValue(":id", customerId);
    QVector<Notification*> _notifications;
    if(query.exec()) {
        while(query.next()) {
            Notification *notification = new Notification(query.value(0).toInt(),query.value(1).toDate(),query.value(2).toDate(),query.value(3).toInt(),query.value(4).toString(),query.value(5).toString(),query.value(6).toString());
            _notifications.append(notification);
        }
        emit notificationsFetched(_notifications);
        db.close();
    }         else {
        qDebug()<<"Query execution failed: "<<query.lastError();
        db.close();
        return;
    }
}


bool DatabaseController::addService(int customerId,int vehicle_id, QString mileage, QString type, QString interval_km, QString service_date, QString interval_time, QString service, QString oil, QString oilFilter, QString airFilter, QString cabinFilter, QString timing, QString customParts,QString note,QString _vehicleRegistration)


{
    if (!db.open()) {
        qDebug() << "Database is not open!" << db.lastError();
        return false;
    }

    QSqlQuery query;


    db.transaction();

    query.prepare("INSERT INTO services (vehicle_id, mileage, type, interval_km, service_date, interval_time, service, oil, oil_filter, air_filter, cabin_filter, timing, custom_parts, note) "
                  "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
    query.addBindValue(vehicle_id);
    query.addBindValue(mileage.toInt());
    query.addBindValue(type);

    if (interval_time.isEmpty()) {
        query.addBindValue(QVariant());
    } else {
        query.addBindValue(interval_km.toInt());
    }

    query.addBindValue(service_date);
    if (interval_time.isEmpty()) {
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

    if (!query.exec()) {
        qDebug() << "Error while inserting service: " << query.lastError();
        db.rollback();
        return false;
    }

    if (interval_km.toInt() > 0 || interval_time.toInt() > 0) {

        int service_id = query.lastInsertId().toInt();

        int calculated = mileage.toInt() + interval_km.toInt();
        qDebug()<<"Service date:::: " <<service_date;

        QStringList dateParts = service_date.split("-");
        int year = dateParts[0].toInt();
        int month = dateParts[1].toInt();
        int day = dateParts[2].toInt();
        QDate nextServiceDate(year,month,day);
        if(nextServiceDate.isValid()) {
        nextServiceDate = nextServiceDate.addMonths(interval_time.toInt());
           qDebug() << "Next service date:" << nextServiceDate.toString("yyyy-MM-dd");
        } else {
        qDebug() << "Invalid date!";
    }

        QSqlQuery notificationQuery;
        notificationQuery.prepare("INSERT INTO notifications (service_id,service_date,next_service_date,next_service_km,service,service_type,vehicle_registration,customer_id) VALUES (?,?,?,?,?,?,?,?)");
        notificationQuery.addBindValue(service_id);
        notificationQuery.addBindValue(service_date);
        notificationQuery.addBindValue(nextServiceDate);
        qDebug()<<"NEXT SERVICE DATE FOR NOTIF: "<<nextServiceDate.toString("dd-MM-yyy");
        notificationQuery.addBindValue(calculated);
        notificationQuery.addBindValue(service);
        notificationQuery.addBindValue(type);
        notificationQuery.addBindValue(_vehicleRegistration);
        notificationQuery.addBindValue(customerId);
        if (!notificationQuery.exec()) {
            qDebug() << "Error while inserting notification: " << notificationQuery.lastError();
            db.rollback();
            return false;
        }
    }

    db.commit();
    return true;
}


bool DatabaseController::updateService(int serviceId, QString mileage, QString interval_km, QString interval_time, QString service, QString oil, QString oilFilter, QString airFilter, QString cabinFilter, QString timing, QString customParts,QString note)
{
    if (!db.open()) {
        qDebug() << "Database is not open!" << db.lastError();
        return false;
    }

    QString updateQuery = "UPDATE services SET ";
    QStringList setClauses;

    if (!mileage.isEmpty()) {
        qDebug()<<"mileage: "<<mileage;
        setClauses.append("mileage = ?");
    }
    if (!interval_km.isEmpty()) {
        qDebug()<<"interval_km: "<<interval_km;
        setClauses.append("interval_km = ?");
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
    } else
        return true;
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

bool DatabaseController::addNotification(int customerId, QDate _serviceDate, QString _mileage, QString _intervalMonths, QString _intervalKm, int _serviceId, QString _service, QString _serviceType, QString _vehicleRegistration)
{
    if (!db.open()) {
        qDebug() << "Database is not open:" << db.lastError();
        return false;
    }

    QSqlQuery findNotif;
    findNotif.prepare("SELECT * FROM notifications WHERE service_id = ?");
    findNotif.addBindValue(_serviceId);
    if(!findNotif.exec()) {
        qDebug()<<"Failed to execute query for finding notification";
        return false;
    }
    if(!findNotif.next() && (_intervalKm.toInt() > 0 || _intervalMonths.toInt() > 0)) {
        int calculated = _mileage.toInt() + _intervalKm.toInt();
        QDate nextServiceDate = _serviceDate.addMonths(_intervalMonths.toInt());

        QSqlQuery query;
        query.prepare("INSERT INTO notifications (service_id,service_date,next_service_date,next_service_km,service,service_type,vehicle_registration,customer_id) VALUES (?,?,?,?,?,?,?,?)");
        query.addBindValue(_serviceId);
        query.addBindValue(_serviceDate);
        if(_intervalMonths.toInt() == 0) {
            query.addBindValue(QVariant());
        } else query.addBindValue(nextServiceDate);
        if(calculated == _mileage.toInt()){
            query.addBindValue(QVariant());
        } else query.addBindValue(calculated);
        query.addBindValue(_service);
        query.addBindValue(_serviceType);
        query.addBindValue(_vehicleRegistration);
        query.addBindValue(customerId);

        if(!query.exec()) {
            qDebug()<<"Nope not working"<<query.lastError();
            return false;
        } return true;
    } else {
        qDebug()<<"Notification for this service already exists!";
        return false;
    }
}

bool DatabaseController::removeNotification(int notificationId)
{
    if (!db.open()) {
        qDebug() << "Database is not open:" << db.lastError();
        return false;
    }

    QSqlQuery query;
    query.prepare("DELETE FROM notifications WHERE id  =:id");
    query.bindValue(":id",notificationId);
    if (!query.exec()) {
        qDebug() << "Failed to execute query:" << query.lastError();
        return false;
    }
    qDebug()<<"Notification removed successfully";
    return true;
}

bool DatabaseController::updateNotificationWithService(int serviceId, int customerId)
{

    int upToDateMileage = 0;
    int upToDateIntervalKm = 0;
    QDate upToDateServiceDate;
    int upToDateIntervalTime = 0;
    QString upToDateService;
    QString upToDateType;
    int newNotifNextServiceKm = 0;
    QDate newNotifNextServiceDate;
    QString newNotifService;
    QString notificationQuery = "UPDATE notifications SET ";
    QStringList setClausesNotifications;


    QSqlQuery dataFromService;
    dataFromService.prepare("SELECT mileage, interval_km, service_date, interval_time,service,type FROM services WHERE id = ?");
    dataFromService.addBindValue(serviceId);
    if(!dataFromService.exec()) {
        qDebug()<<"Failed to execute query for finding service";
        return false;
    }
    if(dataFromService.next()) {
        upToDateMileage = dataFromService.value(0).toInt();
        upToDateIntervalTime = dataFromService.value(3).toInt();
        upToDateIntervalKm = dataFromService.value(1).toInt();
        qDebug()<<"INTERVAL_KM: "<<dataFromService.value(1).toInt();
        upToDateServiceDate = dataFromService.value(2).toDate();
        qDebug()<<"SERVICE DATE: "<<upToDateServiceDate.toString("dd-MM-yyyy");
        upToDateService = dataFromService.value(4).toString();
        upToDateType = dataFromService.value(5).toString();
    }


    QSqlQuery findNotif;
    findNotif.prepare("SELECT * FROM notifications WHERE service_id = ?");
    findNotif.addBindValue(serviceId);
    if(!findNotif.exec()) {
        qDebug()<<"Failed to execute query for finding notification";
    }
    if(findNotif.next()) {

        if(upToDateIntervalKm != 0 && upToDateMileage + upToDateIntervalKm != findNotif.value(4).toInt()) {
            qDebug() << "Updating next_service_km: " << newNotifNextServiceKm;
            newNotifNextServiceKm = upToDateMileage + upToDateIntervalKm;
            setClausesNotifications.append("next_service_km = ?");
        }

        if(upToDateIntervalTime !=0 && upToDateServiceDate.addMonths(upToDateIntervalTime) != findNotif.value(3).toDate()) {
            qDebug() << "Updating next_service_date: " << newNotifNextServiceDate;
            newNotifNextServiceDate = upToDateServiceDate.addMonths(upToDateIntervalTime);
            setClausesNotifications.append("next_service_date = ?");
        }

        if(upToDateService != findNotif.value(5).toString()) {
            qDebug() << "Updating service field in notification.";
            newNotifService = upToDateService;
            setClausesNotifications.append("service = ?");
        }

        if (setClausesNotifications.isEmpty()) {
            qDebug() << "No fields to update.";
        } else {

            notificationQuery += setClausesNotifications.join(", ") + " WHERE service_id = ?";

            QSqlQuery queryNotif;
            queryNotif.prepare(notificationQuery);
            for (const QString &clause : setClausesNotifications) {
                if (clause ==  "next_service_km = ?") {
                    queryNotif.addBindValue(newNotifNextServiceKm);
                } else if (clause == "next_service_date = ?") {
                    queryNotif.addBindValue(newNotifNextServiceDate);
                } else if (clause.startsWith("service")) {
                    queryNotif.addBindValue(newNotifService);
                }
            }
            queryNotif.addBindValue(serviceId);

            qDebug() << "Notification Query: " << queryNotif.executedQuery();
            qDebug() << "Bound values for notification: " << newNotifNextServiceKm << newNotifNextServiceDate << newNotifService << serviceId;

            if (!queryNotif.exec()) {
                qDebug() << "Failed to update notification: " << queryNotif.lastError();
                return false;
            } else {
                return true;
            }
        }

    } else {

        QString registrationNumber;
        QSqlQuery queryReg;
        queryReg.prepare(R"(
                        SELECT vehicles.registration_number
                        FROM services
                        JOIN vehicles ON services.vehicle_id = vehicles.id
                        WHERE services.id = :service_id
                    )");
        queryReg.bindValue(":service_id", serviceId);

        if (queryReg.exec() && queryReg.next()) {
            registrationNumber = queryReg.value(0).toString();
        } else {
            qDebug() << "Failed to find registration number:" << queryReg.lastError().text();
            return false;
        }
        if(!addNotification(customerId,upToDateServiceDate,QString::number(upToDateMileage),QString::number(upToDateIntervalTime),QString::number(upToDateIntervalKm),serviceId,upToDateService,upToDateType,registrationNumber)) {
            return false;
        }
    }
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
