class Object
  CASE_INSENSITIVE_LETTERS = ["a", "é", "o", "ao", "aos", "as", "nos", "nós", "no", "na", "mas", "até", "da", "de", "di", "do", "das", "dos"]
  # Uses eql? method to test more than one option
  # Ex.: 123.eqls?(1,2,3,4,5,6,7,8,123) #=> true
  def eqls?(*others)
    others.each do |other|
      return true if self.eql?(other)
    end
    return false
  end

  # groups a string in blocs of n
  # 'AO0006382737213985727'.group_in(4) #=> "AO00 0638 2737 2139 8572 7"
  def group_in(n = 0)
    self.scan(/.{#{n}}|.+/).join(" ")
  end

  # Split an array in n parts
  # [1,2,3,4,5,6,7,8].split_in(3) #=> [[1, 2, 3], [4, 5, 6], [7, 8]]
  def split_in(n = 1)
    size = self.size
    n = 1 if n > size
    self.each_slice((size.to_f/n).ceil).to_a
  end

  # # Pega o primeiro e ultimo elemnto de um array e escreve uma data
  # # Ex.: [1/15/2017, 6/12/2012] e escreve o 12 de junho de 2012 á 15 de Janeiro de 2017
  # # Ex.: [1/15/2017, 6/12/2017] e escreve o 12 de junho de 2012 á 15 de Janeiro de 2017
  # def escreve_intervalo_de_datas
  #   return '' if self.blank?
  #   ini = self.first
  #   fim = self.last
  #   mesmo_ano = ini.year == fim.year
  #   mesmo_mes = mesmo_ano && ini.month == fim.month
  #   mesmo_dia = mesmo_mes && ini.day == fim.day
  #   if mesmo_dia
  #     ini.to_string('%d %b %Y')
  #   elsif mesmo_mes
  #     "#{ini.to_string('%d')} à #{fim.to_string('%d %b %Y')}"
  #   elsif mesmo_ano
  #     "#{ini.to_string('%d %b')} à #{fim.to_string('%d %b %Y')}"
  #   else
  #     "#{ini.to_string('%d %b %Y')} à #{fim.to_string('%d %b %Y')}"
  #   end
  # end
  def average_descriptioin
    if self.present?
      if self&.to_f >= 4.5 && self&.to_f <= 5
        "EXCELENTE"
      elsif self&.to_f >= 4 && self&.to_f < 4.5
        "BOM"
      elsif self&.to_f >= 3 && self&.to_f < 4
        "SUFICIENTE"
      elsif self&.to_f >= 2 && self&.to_f < 3
        "INSUFICIENTE"
      elsif self&.to_f >= 0 && self&.to_f < 2
        "MAU"
      else
        " "
      end
    else
      " "
    end
  end

  # rounds up a number to n decimals
  # 12345.54321.round_up(2) #=> 12345.55
  def round_up(n = 1)
    n = n.to_i
    (self*(10**n)).ceil.to_f/(10**n)
  end

  # uses include to test more than one option
  # ["abc", String, Integer, 12.3, 14].includes?(24, String) #=> true
  def includes?(*others)
    others.each do |other|
      return true if self.include?(other)
    end
    return false
  end

  def intersects?(array)
    !(self.to_a & array.to_a).empty?
  end

  # conta as oorrenciassss de x no array
  def count_x(x)
    self.select{|a| a==x}.size
  end

  def avg
    if size > 0
     sum.to_f / size
    else
      0
    end
  end

  # titleize a string except some substrings
  # "Estou a titularizar esta string".next_titleize #=>
  def next_titleize
    if self.class.nil?
      self
    elsif self.class.eqls?(String, ActiveSupport::Multibyte::Chars)
      exeption = CASE_INSENSITIVE_LETTERS
      self.mb_chars.downcase.split(' ').map{|w| exeption.include?(w) ? w : w.titleize}.join(' ')
    else
      self.titleize
    end
  end

  # Converts enums
  # "date".pt turns into  I18n.t('date')
  # "date".pt(:lm) turns into  I18n.t('date_lm')
  def pt(suffix = nil)
    suffix = suffix.present? ? "_#{suffix}" : suffix
    I18n.t("#{self}#{suffix}")
  end

  # Short for translate
  # Calls the t(self)
  def ts(options = {})
    I18n.t("#{options[:prepend]}#{self}", options)
  end

  # translate routes
  def ts_route(options = {})
    "routes.#{self}".ts(options)
  end

  # recieves a hash {1: :data, 2: :data2} and returns {data: :data, data2: :data2}
  # method_name recieves a method name to be invoked on th value
  # {1: :data, 2: :data2}.for_select(:ts) #=> {1: :data.ts, 2: :data2.ts}
  def for_select(method_name = nil)
    if method_name.nil?
      self.map{|k,v| [k, k]}
    else
      self.map{|k,v| [k.to_s.send(method_name), k]}
    end
  end

  # converts an integer to month
  # 2.to_month #=> "Fevereiro"
  def to_month
    return self if self.nil?
    if (1..12).include?(self.to_i)
      I18n.t('date.month_names')[self.to_i]
    end
  end

  # Converts an integer to abbreviated month
  # 2.to_month #=> "Fev"
  def to_month_abbr
    return self if self.nil?
    if (1..12).include?(self.to_i)
      I18n.t('date.abbr_month_names')[self.to_i]
    end
  end

  # Converts numeric values to kwanza currency
  # 1234.to_kwanza #=> 1234,00 AKZ
  def to_kwanza
    return self if self.nil?
    valor = self
    valor = 0 if valor.blank?
    number_to_currency(valor, :locale => :ao)
  end

  # Formats string as cell number
  # "992563019".to_cell #=> "+244 992 563 019"
  def to_cell(options = {})
    return options[:or] if self.nil? || self.blank?
    self.blank? ? '' : "+244 #{self.scan(/.{3}|.+/).join(" ")}"
  end

  def abr_name(options = {})
    return options[:or] if self.nil? || self.blank?
    nome = []
    nome[0] = self.split(' ').first.next_titleize
    self.split(' ').each_with_index do |part, i|
      nome[1] = part.next_titleize if i > 0
    end
    nome.join(' ')
  end

  def abr_middle_name(options = {})
    return options[:or] if self.nil? || self.blank?
    nome = []
    nome << self.split(' ').first.next_titleize
    self.split(' ').each_with_index do |part, i|
      nome << "#{part.first.capitalize}." if i > 0 && self.split(' ').last != part && !part.eqls?(*CASE_INSENSITIVE_LETTERS)
      nome << part if i > 0 && self.split(' ').last == part
    end
    nome.join(' ').squeeze
  end

  # get de x percentage of self considering tha self is y%
  # 2.4.2 :001 > 52000.x_percent(80)
  # => 41600.0
  # 2.4.2 :002 > 41600.x_percent(100, 80)
  # => 52000.0
  # 2.4.2 :003 > 41600.x_percent(110, 80)
  # => 57200.0
  # 2.4.2 :004 > 41600.x_percent(125, 80)
  # => 65000.0
  # 2.4.2 :005 > 57200.x_percent(100, 110)
  # => 52000.0
  # 2.4.2 :006 > 65000.x_percent(100, 125)
  # => 52000.0
  def x_percent(x, y = 100)
    self.to_f * (x.to_f/y.to_f)
  end

  # 2.4.2 :008 > 52000.plus_x_percent(10)
  # => 57200.0
  # 2.4.2 :009 > 52000.plus_x_percent(25)
  # => 65000.0
  # 2.4.2 :010 > 52000.plus_x_percent(-20)
  # => 41600.0
  def plus_x_percent(x)
    self + self.x_percent(x)
  end

  # 2.4.2 :011 > 52000.minus_x_percent(20)
  # => 41600.0
  # 2.4.2 :012 > 52000.minus_x_percent(-10)
  # => 57200.0
  # 2.4.2 :013 > 52000.minus_x_percent(-25)
  # => 65000.0
  # 2.4.2 :014 >
  def minus_x_percent(x)
    plus_x_percent(x*(-1))
  end

  # 2.4.2 :001 > 12345.percentage_in(12345)
  # => 100.0
  # 2.4.2 :002 > 123.percentage_in(1234)
  # => 9.967585089141005
  # 2.4.2 :003 > 500.percentage_in(1000)
  # => 50.0
  # 2.4.2 :004 >
  def percentage_in(x)
    if x == 0
      0
    else
      (self.to_f/x) * 100
    end
  end

  # Converte data para string
  # #W ou #w Semana #=> week
  # #Q ou #q quinzena #=> fortnight
  # #B ou #b bimestre #=> two months
  # #T ou #t trimestre #=> fortnight
  # #S ou #s semestre #=> fortnight
  def to_string(string = '')
    return "" if self.blank?
    date = self.to_datetime rescue ""
    return "" if date.blank?
    string = string.gsub('#W', "#{date.semana}ª Semana")
                   .gsub('#Q', "#{date.quinzena}ª Quinzena")
                   .gsub('#B', "#{date.bimestre}º Bimestre")
                   .gsub('#T', "#{date.trimestre}º Trimestre")
                   .gsub('#S', "#{date.semestre}º Semestre")
                   .gsub('#w', "#{date.semana}ª Seman.")
                   .gsub('#q', "#{date.quinzena}ª Quin.")
                   .gsub('#b', "#{date.bimestre}º Bim.")
                   .gsub('#t', "#{date.trimestre}º Trim.")
                   .gsub('#s', "#{date.semestre}º Semes.")
                   .gsub('%A', "#{I18n.t(date.strftime("%A"))}")
                   .gsub('%a', "#{I18n.t(date.strftime("%a"))}")
                   .gsub('%B', "#{I18n.t(date.strftime("%B"))}")
                   .gsub('%b', "#{I18n.t(date.strftime("%b"))}")

    date.strftime(string)
  end

  # devolve o semestre de acordo ao mes
  def semestre
    case self.month
    when 1..6 then 1
    when 7..12 then 2
    end
  end

  # devolve o trimestre de acordo ao mes
  def trimestre
    case self.month
    when 1..3 then 1
    when 4..6 then 2
    when 7..9 then 3
    when 10..12 then 4
    end
  end

   # devolve o bimestre de acordo ao mes
  def bimestre
    case self.month
    when 1..2 then 1
    when 3..4 then 2
    when 5..6 then 3
    when 7..8 then 4
    when 9..10 then 5
    when 11..12 then 6
    end
  end

  # devolve a quinzena de acordo ao dia
  def quinzena
    case self.day
    when 1..15 then 1
    when 16..31 then 2
    end
  end

  # devolve a semana de acordo ao dia
  def semana
    case self.day
    when 1..7 then 1
    when 8..14 then 2
    when 15..21 then 3
    when 22..31 then 4
    end
  end

  # devolve inicio semestre de acordo ao mes
  def inicio_do_semestre
    case self.month
    when 1..6 then self.change(month: 1).beginning_of_month
    when 7..12 then self.change(month: 7).beginning_of_month
    end
  end

  # devolve inicio trimestre de acordo ao mes
  def inicio_do_trimestre
    case self.month
    when 1..3 then self.change(month: 1).beginning_of_month
    when 4..6 then self.change(month: 4).beginning_of_month
    when 7..9 then self.change(month: 7).beginning_of_month
    when 10..12 then self.change(month: 10).beginning_of_month
    end
  end

   # devolve inicio bimestre de acordo ao mes
  def inicio_do_bimestre
    case self.month
    when 1..2 then self.change(month: 1).beginning_of_month
    when 3..4 then self.change(month: 3).beginning_of_month
    when 5..6 then self.change(month: 5).beginning_of_month
    when 7..8 then self.change(month: 7).beginning_of_month
    when 9..10 then self.change(month: 9).beginning_of_month
    when 11..12 then self.change(month: 11).beginning_of_month
    end
  end

  # devolve inicio quinzena de acordo ao dia
  def inicio_da_quinzena
    case self.day
    when 1..15 then self.beginning_of_month
    when 16..31 then self.change(day: 16).beginning_of_day
    end
  end

  # devolve inicio semana de acordo ao dia
  def inicio_da_semana
    case self.day
    when 1..7 then self.beginning_of_month
    when 8..14 then self.change(day: 8).beginning_of_day
    when 15..21 then self.change(day: 15).beginning_of_day
    when 22..31 then self.change(day: 22).beginning_of_day
    end
  end

  # devolve fim semestre de acordo ao mes
  def fim_do_semestre
    case self.month
    when 1..6 then self.change(month: 6).end_of_month
    when 7..12 then self.change(month: 12).end_of_month
    end
  end

  # devolve fim trimestre de acordo ao mes
  def fim_do_trimestre
    case self.month
    when 1..3 then self.change(month: 3).end_of_month
    when 4..6 then self.change(month: 6).end_of_month
    when 7..9 then self.change(month: 9).end_of_month
    when 10..12 then self.change(month: 12).end_of_month
    end
  end

   # devolve fim bimestre de acordo ao mes
  def fim_do_bimestre
    case self.month
    when 1..2 then self.change(month: 2).end_of_month
    when 3..4 then self.change(month: 4).end_of_month
    when 5..6 then self.change(month: 6).end_of_month
    when 7..8 then self.change(month: 8).end_of_month
    when 9..10 then self.change(month: 10).end_of_month
    when 11..12 then self.change(month: 12).end_of_month
    end
  end

  # devolve fim quinzena de acordo ao dia
  def fim_da_quinzena
    case self.day
    when 1..15 then self.change(day: 15).end_of_day
    when 16..31 then self.end_of_month
    end
  end

  # devolve fim semana de acordo ao dia
  def fim_da_semana
    case self.day
    when 1..7 then self.change(day: 7).end_of_day
    when 8..14 then self.change(day: 14).end_of_day
    when 15..21 then self.change(day: 21).end_of_day
    when 22..31 then self.end_of_month
    end
  end

  def previous_month
    self - 1.month
  end

  def next_month
    self + 1.month
  end

  def new_range(data)
    DateRange.new(self, data)
  end


  def trim_decimal
    self == self.to_i ? self.to_i : self
  end

  # defaults to default if self.nil?
  def defs_to(default)
    if self.nil?
      default
    else
      self
    end
  end
  COMMON_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def n_days_in_month()
   # return 29 if self.month == 2 && Date.gregorian_leap?(self.year)
   # COMMON_DAYS_IN_MONTH[self.month]
   self.end_of_month.day
  end

  def month_days
    (self.to_date.beginning_of_month..self.to_date.end_of_month).to_a
  end

  #  2.4.2 :003 > 'utf8=✓&period=&employee%5B%5D=2&employee%5B%5D=4&employee%5B%5D=6&employee%5B%5D=8&employee%5B%5D=9&modal_open=%23filter-presences-modal'.parse_query
  # => {"utf8"=>"✓", "period"=>"", "employee[]"=>["2", "4", "6", "8", "9"], "modal_open"=>"#filter-presences-modal"}
  def parse_query
    params = {}
    splited = self.split('&').map{|f| f.split('=',2).collect{|v| CGI::unescape(v) }}
    splited.each do |key, value|
      if key.last(2).eql?("[]") || splited.map(&:first).count(key) > 1
        params[key] ||= []
        params[key] << value
      else
        params[key] = value
      end
    end
    params.default=[].freeze
    params
  end

  def parse_params
    self.map{|key, value| value.is_a?(Array) ? value.map{|f| "#{key}=#{f}" } : "#{key}=#{value}"}.flatten.uniq.sort.join('&')
  end

  #   2.4.2 :002 > Date.current.weekend?
  #  => false
  def weekend?
    sunday? || saturday?
  end

  # desencriptar o dado
  def decript
    Base64.decode64("#{self}")
  end

  # encriptar o dado
  def encript
    Base64.encode64("#{self}")
  end

end
