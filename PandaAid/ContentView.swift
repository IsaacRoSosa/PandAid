//
//  ContentView.swift
//  PandaAid
//
//  Created by Javier Yahir Juárez Arroyo on 29/03/25.
//
import SwiftUI

struct InventoryItem: Identifiable {
    var id = UUID()
    var name: String
    var count: Int
    var category: String
}

struct ContentView: View {
    let items = [
        InventoryItem(name: "Abrigos", count: 40, category: "Vestimenta"),
        InventoryItem(name: "Playeras", count: 40, category: "Vestimenta"),
        InventoryItem(name: "Calcetines", count: 40, category: "Vestimenta"),
        InventoryItem(name: "Bloques de Construcción", count: 40, category: "Juguetes"),
        InventoryItem(name: "Trenes", count: 40, category: "Juguetes")
    ]
    
    var body: some View {
        ZStack {
            // Background color
            Color(hex: "FFF2DD")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Inventory")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        // Add action
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(Color(hex: "AABD8C"))
                    }
                    .padding(.trailing)
                }
                .padding(.vertical)
                
                // Inventory List
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(items.indices, id: \.self) { index in
                            if index == 0 || items[index].category != items[index-1].category {
                                Text(items[index].category)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top, index > 0 ? 10 : 0)
                            }
                            
                            InventoryItemView(item: items[index])
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                }
                
                Spacer()
            }
            
            // Bottom Navigation Bar
            VStack {
                Spacer()
                BottomNavBar()
            }
        }
    }
}

struct InventoryItemView: View {
    let item: InventoryItem
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "A5CDAF"), lineWidth: 2)
                )
            
            HStack {
                Text(item.name)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.leading)
                
                Spacer()
                
                Text("\(item.count)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "719056"))
                    .padding(.trailing)
            }
            .padding(.vertical, 16)
        }
        .frame(height: 65)
    }
}

struct BottomNavBar: View {
    var body: some View {
        ZStack {
            // Nav bar background
            Rectangle()
                .fill(Color(hex: "A5CDAF"))
                .frame(height: 90)
                .edgesIgnoringSafeArea(.bottom)
            
            // Main donation button (center, larger)
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .shadow(radius: 2)
                    
                    Image("panda") // You would need to add this to your assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }
                .offset(y: -30)
                
                Spacer()
            }
            
            // Other nav items
            HStack {
                Spacer()
                
                // Box icon
                NavBarItem(iconName: "box")
                
                Spacer()
                
                // Location icon
                NavBarItem(iconName: "mappin.and.ellipse")
                
                Spacer()
                Spacer() // Extra spacer for the center item
                Spacer()
                
                // Calendar icon
                NavBarItem(iconName: "calendar.badge.plus")
                
                Spacer()
                
                // Person icon
                NavBarItem(iconName: "person")
                
                Spacer()
            }
        }
    }
}

struct NavBarItem: View {
    let iconName: String
    
    var body: some View {
        Button(action: {
            // Action for this nav item
        }) {
            Image(systemName: iconName)
                .font(.title3)
                .foregroundColor(Color(hex: "4D4D4D"))
        }
    }
}

// Helper extension to create colors from hex values
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// For the panda image in the center tab, you would need to create a custom view
// or add an image to your assets catalog
struct PandaView: View {
    var body: some View {
        ZStack {
            // This would be replaced with your actual panda image
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 60, height: 60)
                )
                .clipShape(Circle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
