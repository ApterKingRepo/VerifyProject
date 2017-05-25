
def pod_install()

  #修改Podfile

  # 执行pod install安装
  cocoapods

end

def build_ipa(config)
  #unlock_keychain(
  #  path: "login.keychain",
  #  password: ENV['FL_KEYCHAIN_PASSWORD']
  #)
  # sh 'security unlock-keychain -u ~/Library/Keychains/login.keychain'
  gym(
    sdk: "iPhoneOS10.3.sdk",
    destination: "generic/platform=iOS",
    workspace: ENV['FL_WORKSPACE_PATH'],
    configuration: config,
    scheme: ENV['FL_SCHEME'],
    silent: true,
    clean: true,
    include_bitcode: true,
    output_directory: File.expand_path("#{ENV['FL_OUTPUT_ROOT_DIRECTORY']}/fastlane/result/archive/#{config}/ipa"),
    output_name: "#{config}.ipa",
    build_path: File.expand_path("#{ENV['FL_OUTPUT_ROOT_DIRECTORY']}/fastlane/result/archive/#{config}/archive"),
  )
end

### deploy to pgyer (Release platform)
def deploy_to_pgyer(config, user_key, api_key)
  pgyer(
    file: File.expand_path("#{ENV['FL_OUTPUT_ROOT_DIRECTORY']}/fastlane/result/archive/#{config}/ipa/#{config}.ipa"),
    user_key: user_key,
    api_key: api_key
  )
end
