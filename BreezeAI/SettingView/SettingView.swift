//
//  SettingView.swift
//  BreezeAI
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Core

struct SettingView: View {
    @ObservedObject var settingVM: SettingViewModel
    @State var selected =  "gpt-3.5-turbo"
    var body: some View {
        ZStack{
            VStack{
                generalButton
                Divider()
                    .foregroundColor(.gray)
                apiKeyTextField
                openApiModelView
                Spacer()
            }
        }
        .background(Color.backgroundColor)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(settingVM: SettingViewModel())
    }
}
extension SettingView {
    var generalButton: some View {
        VStack{
            Image(systemName: "gearshape")
                .foregroundColor(.white)
                .padding(.top, 20)
            Text("General")
                .foregroundColor(.white)
        }
    }
    
    var apiKeyTextField: some View {
        HStack{
            Text("OpenAI API key")
                .foregroundColor(Color.inputText)
            SecureField("", text: $settingVM.apiKeyTF)
                .accentColor(Color.inputText)
                .foregroundColor(Color.inputText)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.gray))
                .padding(.trailing, 5)
                .padding(.leading, 50)
        }
        .padding([.leading, .trailing], 40)
    }
    var openApiModelView: some View {
        HStack{
            Text("Desired OpenAI Model")
                .foregroundColor(Color.inputText)
            
            Picker(selection: $settingVM.openAPIModel, label: Text("")) {
                ForEach(settingVM.openAPIModels, id: \.self) { api in
                    Text(api)
                }
            }
        }
        .padding([.leading, .trailing], 40)
    }
}
