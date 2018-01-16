//
//  NewsfeedTableViewController.swift
//  PlatiGram
//
//  Created by Platiplus on 16/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit

class NewsfeedTableViewController: UITableViewController {
    
    
    var posts: [Post]?
    
    struct StoryBoard{
        static let postCell = "PostCell"
        static let postHeaderCell = "PostHeaderCell"
        static let postHeaderHeight: CGFloat = 57.0
        static let postCellDefaultHeight: CGFloat = 578.0
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Definição de propriedades e conteúdo do Newsfeed
        self.fetchPosts()
        tableView.estimatedRowHeight = StoryBoard.postCellDefaultHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clear
        
    }
    //Função que busca os Posts e atualiza o conteúdo na View
    func fetchPosts(){
        self.posts = Post.fetchPosts()
        self.tableView.reloadData()
    }
}

//Extensão da Classe NewsfeedTableViewController para sobrescrever os métodos padrão conforme a necessidade
extension NewsfeedTableViewController{
    //Numero de sessões na TableViewController é igual ao número de Posts
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let posts = posts {
            return posts.count
        }
        return 0
    }
    //Cada Post se torna uma ROW
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = posts {
            return 1
        }
        else{
            return 0
        }
    }
    //Atribui o ReuseIdentifier a uma variável que se torna o post e retira o estilo de "seleção" da tabela
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.postCell, for: indexPath) as! PostCell
        
        cell.post = self.posts?[indexPath.section]
        cell.selectionStyle = .none
        
        return cell
        
    }
    //As Propriedades abaixo são necessárias para mostrar a "Sticky Header" acima dos posts
    //Atribuindo tamanho e estilo, bem como o conteúdo.
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.postHeaderCell) as! PostHeaderCell
        
        cell.post = self.posts?[section]
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return StoryBoard.postHeaderHeight
    }
    
}











