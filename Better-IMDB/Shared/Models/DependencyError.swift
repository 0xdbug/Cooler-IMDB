//
//  DependencyError.swift
//  Better-IMDB
//
//  Created by dbug on 4/30/25.
//


enum DependencyError: Error {
    case dependencyNotRegistered(String)
}