//
//  ViewController.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 7.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Kingfisher
class ViewController: UIViewController {

    @IBOutlet weak var anasayfaTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var yemekelerListe = [Yemekler]()
    var filterData = [Yemekler]()
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        anasayfaTableView.delegate = self
        anasayfaTableView.dataSource = self
        searchBar.delegate = self
        AnasayfaRouter.createModule(ref: self)
        searchBar.backgroundColor = .yellow
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.yemekleriYukle()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            let yemek = sender as? Yemekler
            let toVC = segue.destination as! DetayVC
            toVC.yemek = yemek
        }
    }
}
extension ViewController: PresenterToViewAnasayfaProtocol {
    func dataToView(yemeklerListesi: Array<Yemekler>) {
        self.yemekelerListe = yemeklerListesi
        self.filterData = yemeklerListesi
        DispatchQueue.main.async {
            self.anasayfaTableView.reloadData()
        }
    }
    
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = filterData[indexPath.row]
        let cell = anasayfaTableView.dequeueReusableCell(withIdentifier: "AnasayfaHucre", for: indexPath) as! AnasayfaHucre
        cell.yemekAdLabel.text = yemek.yemek_adi
        cell.yemekFiyatLabel.text =  "Fiyat: \(yemek.yemek_fiyat)₺"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi)"){
                DispatchQueue.main.async {
                    cell.anasayfaImage.kf.setImage(with: url)
                }
        }
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yemek = filterData[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        anasayfaTableView.deselectRow(at: indexPath, animated: true)
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterData = self.yemekelerListe.filter{yemek in
            if yemek.yemek_adi.lowercased().contains(searchText.lowercased()){
                return true
            }
            if searchText == ""{
                return true
            }
            return false
        }
        self.anasayfaTableView.reloadData()
    }
}
