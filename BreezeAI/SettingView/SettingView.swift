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
    @ObservedObject var appState = AppState.shared
    @State var selected =  "gpt-3.5-turbo"
    var body: some View {
        ZStack{
            VStack{
                generalButton
                Divider()
                    .foregroundColor(.gray)
                apiKeyTextField
                openApiModelView
                doneBTn
                Spacer()
            }
            .frame(height: 300)
        }
        .background(Color.bgColor)
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
            Text("General")
                .foregroundColor(.white)
        }
    }
    
    var apiKeyTextField: some View {
        HStack{
            Text("OpenAI API key")
                .foregroundColor(Color.inputText)
            SecureField("", text: $appState.apiKeyTF)
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
            
            Picker(selection: $appState.openAPIModel, label: Text("")) {
                ForEach(appState.openAPIModels, id: \.self) { api in
                    Text(api)
                }
            }
        }
        .padding([.leading, .trailing], 40)
    }
    
    var doneBTn: some View {
        Button{
            
//
            AppState.shared.router = .done
            if appState.selectedText == "" {
                if let window = NSApp.windows.first {
                    //hide title and bar
                    window.titleVisibility = .hidden
                    window.titlebarAppearsTransparent = true
                    window.backgroundColor = .clear
                    window.hasShadow = false
                    window.isOpaque = false
                    let x = ((NSScreen.main?.frame.width ?? 1080) / 2) - 376
                    let y = ((NSScreen.main?.frame.height ?? 1080) / 2) - 37
                    window.setFrame(CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: 752, height: 100)), display: true)
                }
                
            }
        } label: {
            Text("Done")
                .font(.custom("Roboto-Medium", size: 12))
                .padding([.leading, .trailing], 16)
                .padding(.top, 2)
                .padding([.top, .bottom], 8)
                .background(Color.buttonColor)
                .foregroundColor(Color.inputText)
        }
        .buttonStyle(.borderless)
        .cornerRadius(5)
        .padding(.top, 50)
        .padding(.bottom, 50)
    }
}
