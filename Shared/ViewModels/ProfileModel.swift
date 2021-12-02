//
//  MovieModel.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-24.
//

import Foundation




class ProfileModel: ObservableObject {
    @Published var profiles = [Profile]()
    private var dataService: DataService?
    
    init(dataService: DataService? = nil, from_local: Bool = false) {
        if from_local {
            updateLocalProfileData()
        }   else {
            self.dataService = dataService!
            updateRemoteProfileData()
        }
    }
    
    func updateDataService(dataService: DataService) {
        self.dataService = dataService
    }
    
    func updateDataServiceAndReloadProfileData(dataService: DataService) {
        updateDataService(dataService: dataService)
        updateRemoteProfileData()
    }
    
    func getProfileNameForId(id: Int) -> String {
        return self.profiles.first(where: { $0.id == id})?.name ?? "Unkown"
    }
    
    func updateRemoteProfileData() {
        guard dataService != nil else {
            return
        }
        var urlComponents = URLComponents(string: "\(dataService!.ssl)://\(dataService!.host)/api/profile")
        urlComponents?.queryItems = [URLQueryItem(name: "apikey", value: dataService!.apiKey)]
        let url = urlComponents?.url
        guard url != nil else {
            return
        }
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let profiles = try decoder.decode([Profile].self, from: data!)
                DispatchQueue.main.async {
                    self.profiles = profiles
                }
            } catch {
                print(error)
            }
        }
        .resume()
        return
    }
    
    func updateLocalProfileData() {
        let pathString = Bundle.main.path(forResource: "ProfileData", ofType: "json")
        
        guard pathString != nil else {
            self.profiles = [Profile]()
            return
        }
        
        let url = URL(fileURLWithPath: pathString!)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let profileData = try decoder.decode([Profile].self, from: data)
            self.profiles = profileData
        } catch {
            print(error)
            self.profiles = [Profile]()
        }
    }
    
    
    
}



extension ProfileModel {
    static var sample = ProfileModel(dataService: nil, from_local: true).profiles
}


