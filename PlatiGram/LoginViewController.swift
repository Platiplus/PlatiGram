//
//  LoginViewController.swift
//  PlatiGram
//
//  Created by Platiplus on 17/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    //Ação do Botão de Login
    @IBAction func loginPressed(_ sender: Any) {
        
        //Checa se os textfields não estão vazios, retornando em caso de não preenchimento, protegendo o BD com o comando GUARD.
        guard emailField.text != "", pwdField.text != "" else{return}
        
        //Métodos do Firebase para Login com autenticação do Usuário no BD
        //Auth (Classe) - "auth()" e "signIn()" (Métodos)
        //Os parâmetros passados para este método em particular são os textos dos textfields de e-mail e senha
        Auth.auth().signIn(withEmail: emailField.text!, password: pwdField.text!) { (user, error) in
            
            //Checa se Houve erro na autenticação e mostra uma mensagem não tratada ao usuário
            if let error = error {
                print(error.localizedDescription)
            }
            //Checa se o login funcionou e transfere para a ViewController principal do aplicativo.
            if let user = user {
                let vc_home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC")
                
                self.present(vc_home, animated: true, completion: nil)
            }
            
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
