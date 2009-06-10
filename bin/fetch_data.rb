#!/usr/bin/ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '..',  'lib')

require "open-uri"
require "fileutils"
require "jawurflex"

{
  "http://www.nttdocomo.co.jp/binary/pdf/service/imode/make/content/spec/imode_spec.pdf" => "docomo/imode_spec.pdf",
  "http://www.nttdocomo.co.jp/service/imode/make/content/spec/useragent/index.html" => "docomo/useragent/index.html",
  "http://www.nttdocomo.co.jp/service/imode/make/content/spec/screen_area/index.html" => "docomo/screen_area/index.html",
  "http://www.au.kddi.com/ezfactory/tec/spec/4_4.html" => "au/4_4.html",
  "http://www.au.kddi.com/ezfactory/tec/spec/new_win/ezkishu.html" => "au/ezkishu.html"
}.each do |k,v|
  path = File.join(Jawurflex.data_directory, v)
  FileUtils.mkdir_p(File.dirname(path))
  open(k) {|a| open(path, "w") {|b| b.write(a.read)}}
end

FileUtils.cd(File.join(Jawurflex.data_directory, "docomo")) do
  `pdftotext -layout -nopgbrk -enc UTF-8 -eol unix imode_spec.pdf`
end

puts '
Please login and get the "All handsets" csv file from Softbank at

  http://creation.mb.softbank.jp/terminal/index.html"

and save it to

  data/softbank/softbank.csv

'
