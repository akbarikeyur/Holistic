//
//  DateTimeUtility.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import Foundation

func getCurrentTimeStampValue() -> String
{
    return String(format: "%0.0f", Date().timeIntervalSince1970)
}

func getTimestampFromDate(date : Date) -> Double
{
    return date.timeIntervalSince1970
}

func getDateFromTimeStamp(_ timeStemp:Double) -> Date
{
    return Date(timeIntervalSince1970: TimeInterval(timeStemp))
}

//Date to string
func getDateStringFromDate(date : Date, format : String) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func getLocalDateStringFromDate(date : Date, format : String) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

//String to date
func getDateFromDateString(date : String, format : String) -> Date
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: date)!
}

//MARK: Date difference
func getDifferenceFromCurrentTime(_ newDate : Date) -> Int
{
    let currentDate : Date = getCurrentDate()
    let interval = currentDate.timeIntervalSince(newDate)
    return Int(interval)
}

func getCurrentDate() -> Date
{
    let currentDate : Date = Date()
    return currentDate
}

func getDifferenceFromCurrentTimeInHourInDays(_ newDate : Date) -> String
{
    let interval : Int = getDifferenceFromCurrentTime(newDate)
    
    let second : Int = interval
    let minutes : Int = interval/60
    let hours : Int = interval/(60*60)
    let days : Int = interval/(60*60*24)
    let week : Int = interval/(60*60*24*7)
    let months : Int = interval/(60*60*24*30)
    let years : Int = interval/(60*60*24*30*12)
    
    var timeAgo : String = ""
    if  second < 60
    {
        timeAgo = (second < 3) ? getTranslate("just_now") : (String(second) + getTranslate("second_sort"))
    }
    else if minutes < 60
    {
        timeAgo = String(minutes) + getTranslate("minute_sort")
    }
    else if hours < 24
    {
        timeAgo = String(hours) + getTranslate("hour_sort")
    }
    else if days < 30
    {
        timeAgo = String(days) + " "  + ((days > 1) ? getTranslate("days_sort") : getTranslate("day_sort"))
    }
    else if week < 4
    {
        timeAgo = String(week) + " "  + ((week > 1) ? getTranslate("weeks_sort") : getTranslate("week_sort"))
    }
    else if months < 12
    {
        timeAgo = String(months) + " "  + ((months > 1) ? getTranslate("months_sort") : getTranslate("month_sort"))
    }
    else
    {
        timeAgo = String(years) + " "  + ((years > 1) ? getTranslate("years_sort") : getTranslate("year_sort"))
    }
    
    return timeAgo
}

func getDifferentTimeAgo(_ newDate : Date) -> String {
    let interval : Int = getDifferenceFromCurrentTime(newDate)
    
    let days : Int = interval/(60*60*24)
    let months : Int = interval/(60*60*24*30)
    let years : Int = interval/(60*60*24*30*12)
    
    var timeAgo : String = ""
    if days < 30
    {
        timeAgo = String(days) + " "  + ((days > 1) ? getTranslate("days_ago") : getTranslate("day_ago"))
    }
    else if months < 12
    {
        timeAgo = String(months) + " "  + ((months > 1) ? getTranslate("months_ago") : getTranslate("month_ago"))
    }
    else
    {
        timeAgo = String(years) + " "  + ((years > 1) ? getTranslate("years_ago") : getTranslate("year_ago"))
    }
    return timeAgo
}
