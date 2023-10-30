//
//  ContentView.swift
//  MemoryGame
//
//  Created by dinoearn on 30/10/2566 BE.
//


import SwiftUI

let carnival_emojis = ["🤡","🎡","🎢","🎠","🧸","🎈"] + ["🤡","🎡","🎢","🎠","🧸","🎈"]
let sealife_emojis = ["🦀","🐡","🦑","🐬","🦈","🦐","🐋","🐟"] + ["🦀","🐡","🦑","🐬","🦈","🦐","🐋","🐟"]
let food_emojis = ["⚽️","🏀","🏸","🏓","🥊","🤺","🏹","⛷️","🏊🏻‍♂️","🏌🏻"] +
["⚽️","🏀","🏸","🏓","🥊","🤺","🏹","⛷️","🏊🏻‍♂️","🏌🏻"]

struct ContentView: View {
    @State var theme = carnival_emojis
    @State var theme_color = Color(.orange)
    
    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(0..<theme.count, id: \.self) { index in
                CardView(content: theme[index])
                    .aspectRatio(1/1.6, contentMode: .fit)
            }
        }
        .foregroundColor(theme_color)
    }
    
    var themeButtons : some View {
        HStack {
            carnivalTheme
            sealifeTheme
            sportsTheme
        }
    }
    
    func themeButton(by emoji_set: Array<String>, tcolor: Color, header: String, symbol: String) -> some View {
        VStack {
            Button(action: {
                theme = emoji_set.shuffled()
                theme_color = tcolor
            }, label: {
                Image(systemName: symbol)
            })
            .foregroundColor(theme_color)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding(2)
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 20, maxWidth: 50, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 20, maxHeight: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(header)
                .font(.footnote)
                .foregroundColor(theme_color)
        }
    }
    
    var carnivalTheme: some View {
        themeButton(by: carnival_emojis, tcolor: Color(.orange), header: "Canival", symbol: "balloon.2")
    }
    
    var sealifeTheme: some View {
        themeButton(by: sealife_emojis, tcolor: Color(.cyan),header: "Sea Life", symbol: "fish")
    }
    
    var sportsTheme: some View {
        themeButton(by: food_emojis, tcolor: Color(.green), header: "Sports", symbol: "soccerball")
    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(colorScheme == .dark ? .black : .white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
