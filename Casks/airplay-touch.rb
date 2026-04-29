cask "airplay-touch" do
  version "1.0"
  sha256 "58fe6922c440108dcd9986b94c5b3639db6a196e8d2f14239229270abfb32d37"

  url "https://github.com/jobtools/airplay-android/releases/download/mac-v#{version}/AirPlay-Touch-mac-v#{version}.zip"
  name "AirPlay Touch"
  desc "AirPlay receiver companion that pairs with the Android app"
  homepage "https://github.com/jobtools/airplay-android"

  depends_on macos: ">= :sonoma"

  app "AirPlay Touch.app"

  zap trash: [
    "~/Library/Application Support/AirPlay Touch",
  ]
end
