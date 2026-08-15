//
//  ContentView.swift
//  order-up
//
//  Created by YJ Soon on 14/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var milo = 0
    @State private var teh = 0
    @State private var toast = 0
    @State private var flag = false
    @State private var arr: [String] = []
    @State private var showOrder = false
    @State private var showHistory = false
    @State private var history: [String] = []

    var body: some View {
        VStack(spacing: 20) {
            Text("Order Up")
                .font(.largeTitle)
                .bold()

            Text("Kopitiam snacks. Tap + to add.")
                .font(.title3)
                .foregroundStyle(.secondary)

            HStack {
                Text("🥤  Milo")
                    .font(.title2)
                Text("$1.50")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(milo)")
                    .font(.title)
                    .monospacedDigit()
                Button {
                    milo -= 1
                    if milo < 0 { milo = 0 }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                }
                .disabled(milo == 0)
                .opacity(milo == 0 ? 0.3 : 1)
                Button {
                    milo += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
            .background(Color.orange.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            HStack {
                Text("🍵  Teh")
                    .font(.title2)
                Text("$1.20")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(teh)")
                    .font(.title)
                    .monospacedDigit()
                Button {
                    teh -= 1
                    if teh < 0 { teh = 0 }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                }
                .disabled(teh == 0)
                .opacity(teh == 0 ? 0.3 : 1)
                Button {
                    teh += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
            .background(Color.brown.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            HStack {
                Text("🍞  Kaya Toast")
                    .font(.title2)
                Text("$2.00")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(toast)")
                    .font(.title)
                    .monospacedDigit()
                Button {
                    toast -= 1
                    if toast < 0 { toast = 0 }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                }
                .disabled(toast == 0)
                .opacity(toast == 0 ? 0.3 : 1)
                Button {
                    toast += 1
                    arr.append("x")
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
            .background(Color.yellow.opacity(0.22))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Text("Total  $\(Double(milo) * 1.5 + Double(toast) * 2.0 + Double(teh) * 1.20, specifier: "%.2f")")
                .font(.title)
                .bold()
                .padding(.top, 8)

            Button("Place Order") {
                showOrder = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .font(.title2)

            Button("History") {
                showHistory = true
            }
            .controlSize(.large)
            .font(.title2)
        }
        .padding(20)
        .sheet(isPresented: $showOrder) {
            NavigationStack {
                VStack(spacing: 12) {
                    Text("Order Placed")
                        .font(.largeTitle)
                        .bold()
                    if milo > 0 {
                        HStack {
                            Text("🥤  Milo x\(milo)")
                            Spacer()
                            Button {
                                milo -= 1
                                if milo < 0 { milo = 0 }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                            }
                            Button {
                                milo += 1
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                    if teh > 0 {
                        HStack {
                            Text("🍵  Teh x\(teh)")
                            Spacer()
                            Button {
                                teh -= 1
                                if teh < 0 { teh = 0 }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                            }
                            Button {
                                teh += 1
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                    if toast > 0 {
                        HStack {
                            Text("🍞  Kaya Toast x\(toast)")
                            Spacer()
                            Button {
                                toast -= 1
                                if toast < 0 { toast = 0 }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                            }
                            Button {
                                toast += 1
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                    Text("Total  $\(Double(milo) * 1.5 + Double(toast) * 2.0 + Double(teh) * 1.20, specifier: "%.2f")")
                        .font(.title2)
                        .bold()
                        .padding(.top, 8)
                    Button("Back to Order") {
                        var summary = "\(dateFormatter.string(from: Date()))\n"
                        if milo > 0 { summary += "🥤 Milo x\(milo)\n" }
                        if teh > 0 { summary += "🍵 Teh x\(teh)\n" }
                        if toast > 0 { summary += "🍞 Kaya Toast x\(toast)\n" }
                        summary += String(format: "Total $%.2f", Double(milo) * 1.5 + Double(toast) * 2.0 + Double(teh) * 1.20)
                        history.insert(summary, at: 0)
                        milo = 0
                        teh = 0
                        toast = 0
                        showOrder = false
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
            }
        }
        .sheet(isPresented: $showHistory) {
            NavigationStack {
                List(history, id: \.self) { entry in
                    Text(entry)
                        .font(.title3)
                }
                .navigationTitle("Order History")
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        return f
    }
}

#Preview {
    ContentView()
}
