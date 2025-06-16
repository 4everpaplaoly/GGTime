// LectureManager.swift
import Foundation

class LectureManager {
    static let shared = LectureManager()

    var lectures: [Lecture] = []
    var nextLecture: Lecture?

    private init() {}
}

