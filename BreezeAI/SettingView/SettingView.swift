//
//  SettingView.swift
//  BreezeAI
//
//  Created by Nick Smet on 12/05/2023.
//

import SwiftUI
import Core
import LaunchAtLogin


struct SettingView: View {
    @EnvironmentObject var appState: AppState
    
    private enum Tabs: Hashable {
       case general
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center) {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .opacity(0.6)
                    Text("General")
                        .font(.custom("Roboto-Medium", size: 16))
                        .foregroundColor(.white)
                        .padding(.top, 8)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.inputText)
                        .opacity(0.6)
                    Divider()
                }
            }
            VStack {
                GeneralSettingsView().environmentObject(AppState.shared)
                
                Spacer()
                
                Button{
                    AppState.shared.router = .contentView
                } label: {
                    Text("Done")
                        .font(.custom("Roboto-Medium", size: 14))
                        .padding([.top, .trailing, .leading, .bottom], 8)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 24)
            }
            Spacer()
        }
        .padding(24)
        .preferredColorScheme(.dark)
        .background(Color.bgColor.opacity(0.98).blur(radius: 0.8))
        .cornerRadius(5)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(AppState.shared)
    }
}

struct GeneralSettingsView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Form() {
            VStack(alignment: .center) {
                HStack {
                    LaunchAtLogin.Toggle {
                        Text("Launch at login (recommended)")
                            .foregroundColor(Color.inputText)
                            .multilineTextAlignment(.leading)
                            .font(.custom("Roboto-Medium", size: 14))
                            .padding(.leading, 8)
                    }
                    Spacer()
                }.padding(.bottom, 24)
                
                HStack {
                    Text("OpenAI API key")
                        .foregroundColor(Color.inputText)
                        .frame(width: 200, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Roboto-Medium", size: 14))
                    
                    SecureField("", text: $appState.openAIApiKey)
                        .accentColor(Color.inputText)
                        .foregroundColor(Color.inputText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.gray))
                        .frame(maxWidth: .infinity)
                }
                .padding([ .bottom], 16)
                
                HStack() {
                    Text("Desired OpenAI Model")
                        .foregroundColor(Color.inputText)
                        .frame(width: 200, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Roboto-Medium", size: 14))
                    
                    Picker(selection: $appState.openAIPromptModel, label: Text("")) {
                        ForEach(appState.openAPIModels, id: \.self) { api in
                            Text(api)
                        }
                    }
                    .frame(maxWidth: 150, alignment: .leading)
                    .padding(.leading, -5)
                    Spacer()
                }
                
                
               
            }
            .padding(20)
        }
    }
}
