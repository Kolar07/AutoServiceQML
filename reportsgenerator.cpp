#include "reportsgenerator.h"

ReportsGenerator::ReportsGenerator(QObject *parent)
    : QObject{parent}
{}

void ReportsGenerator::generateReport(Customer &customer, QString _path)
{
    if(_path.isEmpty()) {
     _path = QCoreApplication::applicationDirPath();

    QDir dir(_path);
    if (!dir.exists("Raporty")) {
        dir.mkdir("Raporty");
    }

    }

    QPrinter printer(QPrinter::PrinterResolution);
    printer.setOutputFormat(QPrinter::PdfFormat);
    printer.setOutputFileName(_path);

    QPainter painter;
    if (!painter.begin(&printer)) {
        qWarning() << "Nie można rozpocząć rysowania do PDF";
        return;
    }
}

void ReportsGenerator::generateServicesCSV(Customer &customer, QString _path)
{
    qDebug()<<"EXPORTING TO CSV: customer name:"<<customer.getName()<<"customer vehicles:" <<customer.getVehicles()->getVehicles().size();
    QFile file("services.csv");
    if (file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        stream << "Customer Name & Surname,Customer ID,Vehicle ID,Vehicle Brand,Vehicle Model,Vehicle Year,Vehicle Version,Vehicle Engine,Vehicle Type,"
                               "Vehicle VIN,Vehicle Registration,Service ID,Service Mileage,Service Type,Service Date,Service Interval Km,Service Interval Months,Service Short Description,Service Long Description,"
                              "Service Custom Parts,Service Oil,Service Oil Filter,Service Air Filter,Service Cabin Filter,Service Timing\n";
        for (const auto& vehicle : customer.getVehicles()->getVehicles()) {

                for (const auto& service : vehicle->getServices()->getServices()) {
                stream  << customer.getName() + " " + customer.getSurname() << ","
                        << customer.getId() << ","
                        << vehicle->getId() << ","
                        << vehicle->getBrand() << ","
                        << vehicle->getModel() << ","
                        << vehicle->getYear() << ","
                        << vehicle->getVersion() << ","
                        << vehicle->getEngine() << ","
                        << vehicle->getTypeString() << ","
                        << vehicle->getVin() << ","
                        << vehicle->getRegistrationNumber() << ",";

                    if(auto repairService = dynamic_cast<RepairService*>(service.get())) {
                        stream  << repairService->getId() << ","
                                << repairService->getMileage() << ","
                                << repairService->getType() << ","
                                << repairService->getServiceDate().toString("dd-MM-yyyy") << ","
                                << repairService->getInterval_km() << ","
                                << repairService->getInterval_time() << ","
                                << repairService->getService() << ","
                                << repairService->getNote() << ","
                                << repairService->getCustomParts();
                    }
                    else if(auto oilService = dynamic_cast<ServiceOil*>(service.get())) {

                        stream  << oilService->getId() << ","
                                << oilService->getMileage() << ","
                                << oilService->getType() << ","
                                << oilService->getServiceDate().toString("dd-MM-yyyy") << ","
                               << oilService->getInterval_km() << ","
                                << oilService->getInterval_time() << ","
                               << oilService->getService() << ","
                                << oilService->getNote() << ","
                                << "Empty" << ","
                                << oilService->getOil() << ","
                               << oilService->getOilFilter() << ","
                               << oilService->getAirFilter() << ","
                               << oilService->getCabinFilter();
                    }
                    else if(auto timingService = dynamic_cast<ServiceTiming*>(service.get())) {
                        stream  << timingService->getId() << ","
                               << timingService->getMileage() << ","
                              << timingService->getType() << ","
                                << timingService->getServiceDate().toString("dd-MM-yyyy") << ","
                                << timingService->getInterval_km() << ","
                                << timingService->getInterval_time() << ","
                                << timingService->getService() << ","
                                << timingService->getNote() << ","
                                 << "Empty" << ","
                         << "Empty" << ","
                         << "Empty" << ","
                           << "Empty" << ","
                           << "Empty" << ","
                               << timingService->getTiming();
                    }
                    else if(auto maintenanceService = dynamic_cast<MaintenanceService*>(service.get())) {
                        stream  << maintenanceService->getId() << ","
                                << maintenanceService->getMileage() << ","
                                << maintenanceService->getType() << ","
                                << maintenanceService->getServiceDate().toString("dd-MM-yyyy") << ","
                                << maintenanceService->getInterval_km() << ","
                                << maintenanceService->getInterval_time() << ","
                                << maintenanceService->getService() << ","
                                << maintenanceService->getNote() << ","
                         << "Empty" << ","
                         << "Empty" << ","
                         << "Empty" << ","
                         << "Empty" << ","
                         << "Empty" << ","
                         << "Empty";
                    }
                    stream << "\n";
                }
            }
        file.close();
    }
    qDebug()<<"EXPORTED TO CSV";
}


void ReportsGenerator::generateVehiclesCSV(Customer &customer, QString _path)
{
    qDebug()<<"EXPORTING TO CSV: customer name:"<<customer.getName()<<"customer vehicles:" <<customer.getVehicles()->getVehicles().size();
    QFile file("vehicles.csv");
    if (file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        stream << "Customer Name & Surname,Customer ID,Vehicle ID,Vehicle Brand,Vehicle Model,Vehicle Year,Vehicle Version,Vehicle Engine,Vehicle Type,"
                  "Vehicle VIN,Vehicle Registration\n";
        for (const auto& vehicle : customer.getVehicles()->getVehicles()) {
                stream << customer.getName() + " " + customer.getSurname() << ","
                   <<customer.getId() << ","
                   <<   vehicle->getId() << ","
                   <<   vehicle->getBrand() << ","
                   <<   vehicle->getModel() << ","
                   <<  vehicle->getYear() << ","
                   <<   vehicle->getVersion() << ","
                   <<   vehicle->getEngine() << ","
                        << vehicle->getTypeString() << ","
                        << vehicle->getVin() << ","
                    << vehicle->getRegistrationNumber();
                        stream << "\n";
        }
        file.close();
    }
    qDebug()<<"EXPORTED TO CSV";
}
