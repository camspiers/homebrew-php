require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Augmentedtypes < AbstractPhp55Extension
  init
  homepage 'https://github.com/box/augmented_types'
  url 'https://github.com/box/augmented_types/archive/7398253b82f8cab9e9ef0da1c0b9e7e507c37390.tar.gz'
  sha1 'b6beb7ba192e302f14357aa4a30af2f9b56cc773'
  head 'https://github.com/box/augmented_types.git'
  version '7398253'

  def extension_type; "zend_extension"; end
  
  def extension
    "augmented_types"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-augmented_types"
    system "make"
    prefix.install "modules/augmented_types.so"
    write_config_file unless build.include? "without-config-file"
  end

  def config_file
    super + <<-EOS.undent
      augmented_types.enforce_by_default = 1
    EOS
  end
end
