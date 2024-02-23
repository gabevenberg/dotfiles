function doc2pdf --wraps='loffice --convert-to pdf --headless *.docx' --description 'alias doc2pdf loffice --convert-to pdf --headless *.docx'
  loffice --convert-to pdf --headless *.docx $argv
end
