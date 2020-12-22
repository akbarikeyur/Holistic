//
//  ClinicCategoryModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 31/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct ClinicCategoryModel {
    var name, image, color : String!
    
    init(_ dict : [String : Any]) {
        name = dict["name"] as? String ?? ""
        image = dict["image"] as? String ?? ""
        color = dict["color"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["name" : name!, "image" : image!, "color" : color!]
    }
}

struct ClinicUserModel {
    var ID, Email, FullName, Age, Gender : String!
    var Address1, Address2, Address3, City, State, Country, PostalCode : String!
    var BelongToOrgName, DOB, Mobile, OrganisationName, EmergencyContactPersonRelationWithPatient : String!
    var IsFamilyHead : Bool!
    
    
    init(_ dict : [String : Any]) {
        ID = AppModel.shared.getStringValue(dict, "ID")
        Email = dict["Email"] as? String ?? ""
        FullName = dict["FullName"] as? String ?? ""
        Age = dict["Age"] as? String ?? ""
        Gender = dict["Gender"] as? String ?? ""
        Address1 = dict["Address1"] as? String ?? ""
        Address2 = dict["Address2"] as? String ?? ""
        Address3 = dict["Address3"] as? String ?? ""
        City = dict["City"] as? String ?? ""
        State = dict["State"] as? String ?? ""
        Country = dict["Country"] as? String ?? ""
        PostalCode = AppModel.shared.getStringValue(dict, "PostalCode")
        BelongToOrgName = dict["BelongToOrgName"] as? String ?? ""
        DOB = dict["DOB"] as? String ?? ""
        Mobile = AppModel.shared.getStringValue(dict, "Mobile")
        OrganisationName = dict["OrganisationName"] as? String ?? ""
        IsFamilyHead = AppModel.shared.getBoolenValue(dict, "IsFamilyHead")
        EmergencyContactPersonRelationWithPatient = dict["EmergencyContactPersonRelationWithPatient"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["ID" : ID!, "Email" : Email!, "FullName" : FullName!, "Age" : Age!, "Gender" : Gender!, "Address1" : Address1!, "Address2" : Address2!, "Address3" : Address3!, "City" : City!, "State" : State!, "Country" : Country!, "PostalCode" : PostalCode!, "BelongToOrgName" : BelongToOrgName!, "DOB" : DOB!, "Mobile" : Mobile!, "OrganisationName" : OrganisationName!, "IsFamilyHead" : IsFamilyHead!, "EmergencyContactPersonRelationWithPatient" : EmergencyContactPersonRelationWithPatient!]
    }
}

struct AppointmentModel {
    var AppointmentStatus, AppointmentStatusInt, BookedByPatientID, CreatedDatetime, PatientName, PatientID, ServiceName, OrganisationName : String!
    
    init(_ dict : [String : Any]) {
        AppointmentStatus = AppModel.shared.getStringValue(dict, "AppointmentStatus")
        AppointmentStatusInt = AppModel.shared.getStringValue(dict, "AppointmentStatusInt")
        BookedByPatientID = AppModel.shared.getStringValue(dict, "BookedByPatientID")
        CreatedDatetime = AppModel.shared.getStringValue(dict, "CreatedDatetime")
        PatientName = AppModel.shared.getStringValue(dict, "PatientName")
        PatientID = AppModel.shared.getStringValue(dict, "PatientID")
        ServiceName = AppModel.shared.getStringValue(dict, "ServiceName")
        OrganisationName = AppModel.shared.getStringValue(dict, "OrganisationName")
    }
    
    func dictionary() -> [String : Any] {
        return ["AppointmentStatus" : AppointmentStatus!, "AppointmentStatusInt" : AppointmentStatusInt!, "BookedByPatientID" : BookedByPatientID!, "CreatedDatetime" : CreatedDatetime!, "PatientName" : PatientName!, "PatientID" : PatientID!, "ServiceName" : ServiceName!, "OrganisationName" : OrganisationName!]
    }
}

struct PrescriptionModel {
    var RxName, RxDosageUnit, RxDosageFrequencyInfo, RxNameWithDuration, RxDosageInstruction, RxDurationUnit, RxDosageStrength : String!
    var RxDuration : Double!
    
    
    init(_ dict : [String : Any]) {
        RxName = dict["RxName"] as? String ?? ""
        RxDosageUnit = dict["RxDosageUnit"] as? String ?? ""
        RxDosageFrequencyInfo = dict["RxDosageFrequencyInfo"] as? String ?? ""
        RxNameWithDuration = dict["RxNameWithDuration"] as? String ?? ""
        RxDosageInstruction = dict["RxDosageInstruction"] as? String ?? ""
        RxDosageStrength = dict["RxDosageStrength"] as? String ?? ""
        RxDuration = AppModel.shared.getDoubleValue(dict, "RxDuration")
        RxDurationUnit = dict["RxDurationUnit"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["RxName" : RxName!, "RxDosageUnit" : RxDosageUnit!, "RxDosageFrequencyInfo" : RxDosageFrequencyInfo!, "RxNameWithDuration" : RxNameWithDuration!, "RxDosageInstruction" : RxDosageInstruction!, "RxDosageStrength" : RxDosageStrength!, "RxDuration" : RxDuration!, "RxDurationUnit" : RxDurationUnit!]
    }
}

struct ClinicPackageModel {
    var ID, HeadOrganisationID, BillID, DoctorName, OrganisationName, PatientName, PackageSoldOnDate, PackageName : String!
    var PackageIsCompleted, PackageIsClosed, PackageServiceTotalCount, PackageServiceCompletedCount : Int!
    
    init(_ dict : [String : Any]) {
        ID = dict["ID"] as? String ?? ""
        HeadOrganisationID = dict["HeadOrganisationID"] as? String ?? ""
        BillID = dict["BillID"] as? String ?? ""
        DoctorName = dict["DoctorName"] as? String ?? ""
        OrganisationName = dict["OrganisationName"] as? String ?? ""
        PatientName = dict["PatientName"] as? String ?? ""
        PackageSoldOnDate = dict["PackageSoldOnDate"] as? String ?? ""
        PackageName = dict["PackageName"] as? String ?? ""
        PackageIsCompleted = AppModel.shared.getIntValue(dict, "PackageIsCompleted")
        PackageIsClosed = AppModel.shared.getIntValue(dict, "PackageIsClosed")
        PackageServiceTotalCount = AppModel.shared.getIntValue(dict, "PackageServiceTotalCount")
        PackageServiceCompletedCount = AppModel.shared.getIntValue(dict, "PackageServiceCompletedCount")
    }
}


struct DietPlanModel {
    var DocumentDisplayName, DocumentOnlineName, DocumentOnlineURL, ID : String!
    
    init(_ dict : [String : Any]) {
        DocumentDisplayName = dict["DocumentDisplayName"] as? String ?? ""
        DocumentOnlineName = dict["DocumentOnlineName"] as? String ?? ""
        DocumentOnlineURL = dict["DocumentOnlineURL"] as? String ?? ""
        ID = dict["ID"] as? String ?? ""
    }
}
