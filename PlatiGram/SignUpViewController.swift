//
//  SignUpViewController.swift
//  PlatiGram
//
//  Created by Platiplus on 17/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var comPwdField: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    //Declara o ImagePicker para selecionar a foto de Perfil
    let picker = UIImagePickerController()
    //Declara as Referências ao armazenamento do usuário e do banco de dados
    var userStorage: StorageReference!
    var dbRef: DatabaseReference!
    
    override func viewDidLoad() {
        
        //Propriedade estéticas da imagem do usuário
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true
        
        super.viewDidLoad()
        
        //O delegate do picker de fotos
        picker.delegate = self
        
        //Informações sobre a localização do armazenamento e do banco de dados
        let storage = Storage.storage().reference(forURL:"gs://platigram.appspot.com")
        dbRef = Database.database().reference()
        //Declara que o usuário será salvo na pasta USERS
        userStorage = storage.child("users")

    }
    
    //Ação para a troca da foto
    @IBAction func selectImagePressed(_ sender: Any) {
        
        //Define as propriedades do Picker como: se é possível editar, localização padrão das fotos e apresentação do mesmo
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    //Função que troca a foto da ImageView do Usuario caso a foto exista
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.userImageView.image = image
        }
        //Fecha o picker quando a imagem é selecionada
        self.dismiss(animated: true, completion: nil)
    }
    
    //Ação para cadastro
    @IBAction func signUpPressed(_ sender: Any) {
        
        //Protege o banco contra exceções com o GUARD, garantindo que os textfields não estejam vazios
        guard usernameField.text != "", emailField.text != "", pwdField.text != "", comPwdField.text != "" else {return}
        
        //Caso os campos de senha e confirmação de senha tenham conteúdos iguais, segue o fluxo do programa
        if pwdField.text == comPwdField.text {
        
            //Método para criação de novo usuário seguindo os parâmetros abaixo, pegando informações dos textfields.
            Auth.auth().createUser(withEmail: emailField.text!, password: pwdField.text!, completion: { (user, error) in
                //Trata o erro
                if let error = error {
                    print (error.localizedDescription)
                }
                //Em caso de sucesso, começam as alterações no usuário e posterior commit das mesmas
                if let user = user{
                    
                    let changeRequest = Auth.auth().currentUser!.createProfileChangeRequest()
                    changeRequest.displayName = self.usernameField.text
                    changeRequest.commitChanges(completion: nil)
                    
                    //Localização e propriedade da imagem de perfil que será salva e enviada ao banco
                    let imageREF = self.userStorage.child("\(user.uid).jpg")
                    //Método que diz qual é a imagem e as propriedades de compressão da mesma e guarda numa variável
                    let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.5)
                    
                    //Começa a declarar a task de upload das informações para o banco
                    let uploadTask = imageREF.putData(data!, metadata: nil, completion: { (metadata, err) in
                        if err != nil {
                            print(err!.localizedDescription)
                        }
                        
                        imageREF.downloadURL(completion: { (url, er) in
                            if er != nil{
                                print(er!.localizedDescription)
                            }
                        
                            if let url = url {
                                //Informações com que serão inseridas no banco
                                let userInfo: [String:Any] = ["uid": user.uid,
                                                              "username": self.usernameField.text!,
                                                              "urlToImage": url.absoluteString]
                                
                                self.dbRef.child("users").child(user.uid).setValue(userInfo)
                                
                                //Ao completar a operação com sucesso, manda para a ViewController principal do aplicativo para usuários logados
                                let vc_home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC")
                                
                                self.present(vc_home, animated: true, completion: nil)
                                
                            }
                            
                        })
                    })
                    
                    uploadTask.resume()
                    
                }
            })
            
        }
        
        else{
            print("Passwords does not match!")
        }
    
}
}
