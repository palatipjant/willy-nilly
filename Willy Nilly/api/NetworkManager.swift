//
//  NetworkManager.swift
//  Willy Nilly
//
//  Created by Palatip Jantawong on 6/2/2567 BE.
//

import Foundation
import UIKit


final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://api.themoviedb.org/3"
    //  End point
    private let discoverED = baseURL + "/discover/movie"
    private let genresED = baseURL + "/genre/movie/list?language=en"
    private let popED = baseURL + "/trending/movie/day?language=en-US"
    
    let authToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNzRjZDZhN2RlNGE3NTdhZDM3OGQzZjI0NmQ3M2JjMyIsInN1YiI6IjY1ODMxY2NhODU4Njc4NTUyZWY2ODQwMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IbiXRbuekxsTNA0DmI5rfLVipO0VZlxMylkzMPkmCuA"
    
    private init() {}
    
    func fetchNewMovie() async throws -> [NewMovie] {
        
        guard let url = URL(string: discoverED) else {
            throw APError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            return try decoder.decode(NewMovieResponse.self, from: data).results
        } catch {
            throw APError.invalidData
        }
    }
    func fetchGenres() async throws -> [Genre] {
        guard let url = URL(string: genresED) else {
            throw APError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            return try decoder.decode(GenreListResponse.self, from: data).genres
        } catch {
            throw APError.invalidData
        }
    }
    
    func fetchPopMovie() async throws -> [PopMovie] {
        guard let url = URL(string: popED) else {
            throw APError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            return try decoder.decode(PopMovieResponse.self, from: data).results
        } catch {
            throw APError.invalidData
        }
    }
    
    func fetchSearch(query: String, page: Int) async throws -> [SearchMovie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=true&language=en-US&page=\(page)") else {
            throw APError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            return try decoder.decode(SearchResponse.self, from: data).results
        } catch {
            throw APError.invalidData
        }
    }
    
}