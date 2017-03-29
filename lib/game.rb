class Game
  MAX_ERRORS = 7

  def initialize(slovo)
    @letters = get_letters(slovo)

    @errors = 0

    @good_letters = []
    @bad_letters = []

    @status = 0
  end

  def get_letters(slovo)
    return slovo.split("")
  end

  def ask_next_letter
    puts("\n Введите следующую букву")
    letter = ""

    while letter == "" do
      letter = STDIN.gets.encode("UTF-8").downcase.chomp
    end

    next_step(letter)
  end

  def is_good?(letter)
    @letters.include?(letter) ||
      (letter == "е" && letters.include?("ё")) ||
      (letter == "ё" && letters.include?("е")) ||
      (letter == "и" && letters.include?("й")) ||
      (letter == "й" && letters.include?("и"))
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
      when 'и' then letters << 'й'
      when 'й' then letters << 'и'
      when 'е' then letters << 'ё'
      when 'ё' then letters << 'е'
    end
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def lost?
    @errors >= MAX_ERRORS
  end

  def next_step(letter)
    return if @status == -1 || @status == 1

    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)

      @status = 1 if solved?

    else
      add_letter_to(@bad_letters, letter)
      @errors += 1

      @status = -1 if lost?
    end
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end

  def status
    @status
  end

  def errors
    @errors
  end
end