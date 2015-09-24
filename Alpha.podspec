Pod::Spec.new do |spec|
  spec.name                   = "Alpha"
  spec.version                = "0.2.6"
  spec.summary                = "Next generation debugging framework for iOS"
  spec.description            = <<-DESC
                                - A simple unified debugging plugin API.
                                - Lives entirely in app sandbox.
                                - Easy integration with no code changes.
                                - Display device information, network connections and console logs.
                                - Log push notifications and inspect payload.
                                - Follow application life-cycle and user events.
                              DESC

  spec.license                = { :type => "MIT", :file => "LICENSE" }
  spec.homepage               = "https://github.com/legoless/Alpha"
  spec.screenshots            = [ "https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Intro.gif",
                                  "https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Default_Theme.png",
                                  "https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Formentera_Theme.png",
                                  "https://raw.githubusercontent.com/Legoless/Alpha/master/Resources/Notio_Theme.png" ]

  spec.documentation_url      = "https://github.com/Legoless/Alpha/wiki"
  spec.author                 = { "Dal Rupnik" => "legoless@gmail.com" }
  spec.social_media_url       = "https://twitter.com/thelegoless"
  spec.platform               = :ios, "9.0"
  spec.source                 = { :git => "https://github.com/legoless/Alpha.git", :tag => "#{spec.version}" }
  spec.ios.deployment_target  = '8.0'
  spec.source_files           = "Alpha/Alpha.h"
  spec.requires_arc           = true

  #
  # Asset framework (non-dependent)
  #
  spec.subspec 'Asset' do |subspec|
    subspec.source_files = 'Alpha/Asset/**/*.{h,m}'
    subspec.dependency 'Haystack'
  end

  #
  # Private framework (non-dependent)
  #

  spec.subspec 'Private' do |subspec|
    subspec.source_files = 'Alpha/Private/**/*.{h,m}'
  end

  #
  # Utility framework (non-dependent)
  #

  spec.subspec 'Utility' do |subspec|
    subspec.source_files = 'Alpha/Utility/**/*.{h,m}'
    subspec.dependency 'Haystack'
  end

  #
  # Theme framework
  #

  spec.subspec 'Theme' do |subspec|
    subspec.source_files = 'Alpha/Themes/**/*.{h,m}'
    subspec.dependency 'Alpha/Asset'
  end

  #
  # Model framework
  #

  spec.subspec 'Model' do |subspec|
    subspec.source_files = 'Alpha/Model/**/*.{h,m}'

    subspec.dependency 'Alpha/Utility'
    subspec.dependency 'Alpha/Theme'
  end

  #
  # Core framework
  #

  spec.subspec 'Core' do |subspec|
    subspec.source_files = 'Alpha/Manager/**/*.{h,m}'

    subspec.dependency 'Alpha/Asset'
    subspec.dependency 'Alpha/Theme'
    subspec.dependency 'Alpha/Model'
    subspec.dependency 'Alpha/Private'
  end

  #
  # Integration framework
  #

  spec.subspec 'Integration' do |subspec|
    subspec.source_files = 'Alpha/Integration/**/*.{h,m}'

    subspec.dependency 'Alpha/Core'
  end

  #
  # View framework
  #

  spec.subspec 'View' do |subspec|
    subspec.source_files = 'Alpha/View/**/*.{h,m}'

    subspec.dependency 'Alpha/Core'
  end

  #
  # Palette framework
  #

  spec.subspec 'Palettes' do |subspec|
    subspec.source_files = 'Alpha/Palettes/**/*.{h,m}'
    subspec.dependency 'Alpha/Theme'
  end

  #
  # Render framework
  #

  spec.subspec 'Render' do |subspec|
    subspec.source_files = 'Alpha/Renderers/**/*.{h,m}'

    subspec.dependency 'Alpha/Core'
    subspec.dependency 'Alpha/View'
  end

  #
  # Trigger framework
  #

  spec.subspec 'Trigger' do |subspec|
    subspec.source_files = 'Alpha/Triggers/**/*.{h,m}'

    subspec.dependency 'Alpha/Core'
  end


  #
  # Plugins
  #

  #
  # Interface
  #

  spec.subspec 'Interface' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Interface/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
    subspec.dependency 'Alpha/Render'
  end

  #
  # Application
  #

  spec.subspec 'Application' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Application/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
  end

  #
  # Bonjour
  #

  spec.subspec 'Bonjour' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Bonjour/**/*.{h,m}'

    subspec.dependency 'Alpha/Core'
    subspec.dependency 'DTBonjour'
  end

  #
  # Bootstrap
  #

  spec.subspec 'Bootstrap' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Bootstrap/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
  end

  #
  # Console
  #

  spec.subspec 'Console' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Console/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
  end

  #
  # Event
  #

  spec.subspec 'Event' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Event/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
  end

  #
  # File
  #

  spec.subspec 'File' do |subspec|
    subspec.source_files = 'Alpha/Plugins/File/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
  end

  #
  # Global
  #

  spec.subspec 'Global' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Global/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
  end

  #
  # Heap
  #

  spec.subspec 'Heap' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Heap/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
    subspec.dependency 'Alpha/Object'
    subspec.dependency 'Alpha/Global'
  end

  #
  # Network
  #

  spec.subspec 'Network' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Network/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
  end

  #
  # Notification
  #

  spec.subspec 'Notification' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Notification/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
  end

  #
  # Object
  #

  spec.subspec 'Object' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Object/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
    subspec.dependency 'Alpha/Global'
    subspec.dependency 'Alpha/Render'
  end

  #
  # Remote
  #

  spec.subspec 'Remote' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Screenshot/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
    subspec.dependency 'DTBonjour'
  end

  #
  # Screenshot
  #

  spec.subspec 'Screenshot' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Screenshot/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
  end

  #
  # State
  #

  spec.subspec 'State' do |subspec|
    subspec.source_files = 'Alpha/Plugins/State/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'

    subspec.frameworks = 'CoreTelephony'
  end

  #
  # Touch
  #

  spec.subspec 'Touch' do |subspec|
    subspec.source_files = 'Alpha/Plugins/Touch/**/*.{h,m}'
    subspec.dependency 'Alpha/Core'
  end

  #
  # View
  #

  spec.subspec 'ViewHierarchy' do |subspec|
    subspec.source_files = 'Alpha/Plugins/View/**/*.{h,m}'
    subspec.dependency 'Alpha/Integration'
    subspec.dependency 'Alpha/Render'
  end

end
