import SwiftUI

struct OnboardingView: View {
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("My Plants 🌱")
                    .font(.title.bold())
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 8)

            Divider()

            Spacer()

            VStack(spacing: 16) {
                Image("PLANT;O")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 210, height: 210)
                    .foregroundColor(.green)

                Text("Start your plant journey!")
                    .font(.headline)

                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)

            Spacer()

            Button(action: onStart) {
                Text("Set Plant Reminder")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color(red: 0.20, green: 0.50, blue: 0.41))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onStart: {})
    }
}
