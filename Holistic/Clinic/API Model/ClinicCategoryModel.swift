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
    var ID, Email, FirstName, LastName, Age, Gender : String!
    
    init(_ dict : [String : Any]) {
        ID = AppModel.shared.getStringValue(dict, "ID")
        Email = dict["Email"] as? String ?? ""
        FirstName = dict["FirstName"] as? String ?? ""
        LastName = dict["LastName"] as? String ?? ""
        Age = dict["Age"] as? String ?? ""
        Gender = dict["Gender"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["ID" : ID!, "Email" : Email!, "FirstName" : FirstName!, "LastName" : LastName!, "Age" : Age!, "Gender" : Gender!]
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
