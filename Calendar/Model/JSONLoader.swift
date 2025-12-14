////
////  JSONLoader.swift
////  Calendar
////
////  Created by Bakhtovar Umarov on 12/13/25.
////
//
//import Foundation
//import Calendar
//
//final class JSONLoader {
//
//    static func load<T: Decodable>(_ filename: String) -> T {
//        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
//            fatalError("❌ Не найден файл \(filename).json")
//        }
//
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .formatted(DateFormatter.api)
//            return try decoder.decode(T.self, from: data)
//        } catch {
//            fatalError("❌ Ошибка парсинга \(filename): \(error)")
//        }
//    }
//}
