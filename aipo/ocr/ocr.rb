require 'ocr/OCR'

ocr = OCR.new()
for filename in ARGV do
  p ocr.readfile(filename).getText()
end