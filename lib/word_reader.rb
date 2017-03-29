class WordReader
  def read_from_file(file_name)
    begin
      f = File.new(file_name, "r:UTF-8")
      lines = f.readlines
      f.close
    rescue SystemCallError
      abort "Программа не может прочитать файл: #{file_name}"
    end

    return lines.sample.downcase.chomp
  end
end