//
//  ContentView.swift
//  NanoML
//
//  Created by Fernando de Lucas da Silva Gomes on 16/06/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var x: String = ""
    @State var y: String = ""
    @State var z: String = ""
    
    var body: some View {
        VStack{
        LinearGradient(gradient: Gradient(colors: [.purple, .white]), startPoint: .top, endPoint: .bottom)
          .mask(Image("vanilla-flower")
            .resizable()
            .padding()
            .aspectRatio(contentMode: .fit)
          ).frame(width: 100, height: 100, alignment: .center)
            Text("Iris Classifier").foregroundColor(.purple)
        }
        VStack{
            TextField("X", text: $x).foregroundColor(.purple)
            TextField("Y", text: $y).foregroundColor(.purple)
            TextField("Z", text: $z).foregroundColor(.purple)
        }.textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.leading, 100)
        .padding(.trailing, 100)
        Button(action: prepareTo) {
            Text("Classificar")
        }
        .padding(.bottom, 17)
        ForEach(viewModel.itens, id: \.self) { itens in
            HStack{
                Text(itens.name + ":")
                Text("\(itens.ocurency)")
            }
        }
}
    func prepareTo(){
        viewModel.calculate(x: Double(self.x)!, y: Double(self.y)!, z: Double(self.z)!)
    }

}
