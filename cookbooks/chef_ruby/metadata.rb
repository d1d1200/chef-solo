name              'chef_ruby'
maintainer        "Lytro, Sasanadi"
maintainer_email  "d1d1200@gmail.com"
license           "WTFPL"
description       "Installs Ruby 2.1 from source"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.mdown'))
version           "2.3.1"
supports          "ubuntu"

%w( apt build-essential ).each do |d|
  depends d
end

recipe            "default", "Installs Ruby 2.1 from source."
