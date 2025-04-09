import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color("aksen")
                    .ignoresSafeArea()
                VStack {
                    Image("Adakantin.logo")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .foregroundColor(.orange)
                }
                .onAppear {
                    // Duration of splash screen
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview{
    SplashScreen()
}
