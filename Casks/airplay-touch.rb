cask "airplay-touch" do
  version "1.0"
  sha256 "58fe6922c440108dcd9986b94c5b3639db6a196e8d2f14239229270abfb32d37"

  url "https://github.com/jobtools/airplay-android/releases/download/mac-v#{version}/AirPlay-Touch-mac-v#{version}.zip"
  name "AirPlay Touch"
  desc "AirPlay receiver companion that pairs with the Android app"
  homepage "https://github.com/jobtools/airplay-android"

  depends_on macos: ">= :sonoma"

  app "AirPlay Touch.app"

  postflight do
    cert_pem = <<~PEM
      -----BEGIN CERTIFICATE-----
      MIIDBzCCAe+gAwIBAgIUV/9Ur89ObWP1CF9eGexm1yQvTVowDQYJKoZIhvcNAQEL
      BQAwGzEZMBcGA1UEAwwQQWlyUGxheVRvdWNoIERldjAeFw0yNjAzMTIwMTMxNDBa
      Fw0zNjAzMDkwMTMxNDBaMBsxGTAXBgNVBAMMEEFpclBsYXlUb3VjaCBEZXYwggEi
      MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC6KwnV1OOdsl0vtFhXdmfi8CNa
      5dsKNu/BZnHrzqgqdeskdt6SEjS3US2NFFCaaQhu2jcA8wWDVvBPji+LiLgEbDJG
      Q4UeARarORoL0XN+BSlNN6v1FsQnzkl0x4zVWEPGpJzFst8OXIvnGozW42Js+es1
      59dbRv4dtESYA2OXjvPNA3k6dwJGFkctzlr8ojkXqU5MDE5f+H22FWUNDEwVIN6/
      9579WX0CeycrSzIe/cJBGJlTTsTFeXMLZEA9ZNp4Cyr8b0KbU+/VxhlJlG1LE4oC
      +WLpoTBla600kmi7FiCcgBi+ze3mIAGwENc15RiMmrQpNtB5hrzMwC2pcDTdAgMB
      AAGjQzBBMAsGA1UdDwQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzAdBgNVHQ4E
      FgQUHbIqi2QxLQlx3PoYW+0KWgajQC0wDQYJKoZIhvcNAQELBQADggEBAIHOvz8e
      bhzzk/lZo6JJ4pQAv/4AWn4LpzMZD4Lve6bMZJc0lpRvtHxvtHIMgkILbRunEMHF
      cZYe4s8ZXmeEuByEKVbVz767lE+jiaTTHB09ntN2XpD40MG4Ha8sCI3DItAjjFnv
      +sOa8YnR7lOaOcrLeA3rL8ra3+jwo1lCMWevuIS5YfO2Gr3Ff7r0CMStqQbBKahG
      vIT7heZH5zy5GW4wgBIgcukapXB+3YDOPfTPv864sYE8x+SZGxzieuVBOUSUnNx7
      XHbjSBaSJJ/IMjNETHcP7JllygYXhMm5sSYO29PUzRgPKdO35Rdo8gwTzvsc5r4H
      bu9cmVUqglhmUNs=
      -----END CERTIFICATE-----
    PEM

    require "tempfile"
    Tempfile.create(["airplay-touch", ".pem"]) do |f|
      f.write(cert_pem)
      f.flush
      system_command "/usr/bin/security",
                     args: ["add-trusted-cert", "-r", "trustRoot", "-p", "codeSign",
                            "-k", "#{ENV["HOME"]}/Library/Keychains/login.keychain-db",
                            f.path],
                     must_succeed: false
    end

    [
      "#{staged_path}/AirPlay Touch.app",
      "#{appdir}/AirPlay Touch.app",
    ].each do |path|
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", path],
                     must_succeed: false
    end
  end

  caveats <<~CAVEATS
    AirPlay Touch is self-signed. The installer registers the signing
    certificate in your login keychain so Gatekeeper trusts the app —
    macOS may show a one-time prompt asking you to allow this.

    The companion needs Accessibility permission to forward touch events.
  CAVEATS

  zap trash: [
    "~/Library/Application Support/AirPlay Touch",
  ]
end
