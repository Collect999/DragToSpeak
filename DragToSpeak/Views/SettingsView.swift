//
//  SettingsView.swift
//  DragToSpeak
//
//  Created by Will Wade on 26/01/2024.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settingsOpen: Bool
    @EnvironmentObject var settings: AppSettings

    var body: some View {
        NavigationStack {
            Form {
                dragTypeSection
                layoutSection
                dwellTimeSection
                toggleSection(title: "Show Trail", binding: $settings.showTrail)
                toggleSection(title: "Enlarge Keys on Hover", binding: $settings.enlargeKeys)
                toggleSection(title: "Auto Correct words on Finish", binding: $settings.autocorrectEnabled)
                toggleSection(title: "Write Without Spaces", binding: $settings.writeWithoutSpacesEnabled)
                resetOnboardingSection
            }
            .navigationTitle("Settings")
            .toolbar { doneButton }
        }
    }

    private var dragTypeSection: some View {
        Section {
            Picker("Drag Type", selection: $settings.dragType) {
                Text("Direction Change").tag(DragType.direction)
                Text("Dwell").tag(DragType.dwell)
            }
            .pickerStyle(.segmented)
        } footer: {
            Text("Change how we calculate letter selection")
        }
    }
    
    private var layoutSection: some View {
        Section {
            Picker("Layout", selection: $settings.layout) {
                                   Text("Alphabetical").tag(Layout.alphabetical)
                                   Text("Frequency").tag(Layout.frequency)
                                   Text("QWERTY").tag(Layout.qwerty)
                               }
        } footer: {
            Text("The layout of the letters on the grid")
        }
    }

    private var dwellTimeSection: some View {
        Section(content: {
            VStack {
                                HStack {
                                    Text("Dwell Time")
                                    Spacer()
                                    Text(String(format: "%.2f", settings.dwellTime))
                                }
                                
                                Slider(
                                    value: $settings.dwellTime,
                                    in: 0.1...10,
                                    step: 0.1
                                ) {
                                    Text("Dwell Time")
                                } minimumValueLabel: {
                                    Text("0.1s")
                                } maximumValueLabel: {
                                    Text("2s")
                                }
                            }
                        }, footer: {
                            Text("The amount of time you must keep your finger on a letter to register a click. This only work in Dwell mode")
                        })
    }

    private var resetOnboardingSection: some View {
        Section(content: {
                            Button("Reset Onboarding") {
                                settings.hasLaunchedBefore = false
                                        }
                        }, footer: {
                            Text("If you want to watch the introduction video again turn this on")
                        })
    }
    
    private var doneButton: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            Button("Done") { settingsOpen = false }
        }
    }
}

// Reusable toggle section
private func toggleSection(title: String, binding: Binding<Bool>) -> some View {
    Section {
        Toggle(title, isOn: binding)
    }
}