class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  attr_accessor :redirect_url, :cancel_url, :render_view
  scope :filter, ->(column, data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(column => data)}
  scope :limit_data, ->(data) {data.blank? ? all : limit(data.to_i)}

  BANCOSOL_EMAIL_REGEX = /\A[a-z0-9._%+-]+@bancosol.ao/i
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9._%+-].[a-z0-9._%+-]/i
  CELLPHONE_REGEX = /[[:digit:]]{9}/
  NAME_REGEX        = /\A[a-zA-Z0-90\W\w\s\-]*$\z/i
  PAYGRADE_ORDER = [[1, 'a'], [1, 'b'], [1, 'c'], [1, 'd'],
                    [2, 'a'], [2, 'b'], [2, 'c'], [2, 'd'],
                    [3, 'a'], [3, 'b'], [3, 'c'], [3, 'd'],
                    [4, 'a'], [4, 'b'], [4, 'c'], [4, 'd'],
                    [5, 'a'], [5, 'b'], [5, 'c'], [5, 'd'],
                    [6, 'a'], [6, 'b'], [6, 'c'], [6, 'd'],
                    [7, 'a'], [7, 'b'], [7, 'c'], [7, 'd'],
                    [8, 'a'], [8, 'b'], [8, 'c'], [8, 'd'],
                    [9, 'a'], [9, 'b'], [9, 'c'], [9, 'd'],
                    [10, 'a'], [10, 'b'], [10, 'c'], [10, 'd']].freeze

  # Substitui buscas como where("extract(day from periodo) = ? AND extract(month from periodo) = ?", dia, mes)
  # Com where_data(:periodo, mes: mes, dia: dia)
  def self.where_date(coluna, data = {})
    coluna = coluna.to_s;
    return self if data.blank? || coluna.blank?
    ext = []

    data.each do |k,v|
      ext2 = []
      [v].flatten.each do |x|
        ext2 << "extract(#{k} from #{coluna}) = '#{x}'"
      end
      ext2 = ext2.join(' OR ')
      ext << "(#{ext2})"
    end
    ext = ext.join(' N/D ')
    ext.present? ? where(ext) : self
  end

  def self.filter_employee_can_be_assessed_and_function_skill
    where('next_sgad_employees.can_be_assessed' => true).where("employee_skills.skill_id = function_skills.skill_id")
  end

  def self.latest
    self.order(id: :asc).last
  end

  def can_destroy?
    self.class.reflect_on_all_associations.all? do |assoc|
      ([:restrict_with_error, :restrict_with_exception].exclude? assoc.options[:dependent]) ||
        (assoc.macro == :has_one && self.send(assoc.name).nil?) ||
        (assoc.macro == :has_many && self.send(assoc.name).empty?)
    end
  end

  def cannot_destroy?
    !can_destroy?
  end

  # Substitui a busca where("nome LIKE ? OR nome LIKE ?", '%#{n}%', '%#{m}%')
  # Com where_like(:nome, n, m)
  def self.where_like(coluna, *opcoes)
    return self if coluna.blank?
    ext = []
    opcoes.each do |o|
      ext << "#{coluna.to_s} LIKE '%#{o.to_s}%'"
    end
    ext = ext.join(' OR ')
    ext.present? ? where(ext) : self
  end

  # Substitui a busca where("lower(nome) LIKE ? OR lower(nome) LIKE ?", '%#{n.to_s.downcase}%', '%#{m.to_s.downcase}%')
  # Com where_like_insensitive(:nome, n, m)
  def self.where_like_ins(coluna, *opcoes)
    return self if coluna.blank?
    ext = []
    opcoes.each do |o|
      ext << "lower(#{coluna.to_s}) LIKE '%#{o.to_s.downcase}%'"
    end
    ext = ext.join(' OR ')
    ext.present? ? where(ext) : self
  end

  def self.none_if_blank(params, *keys)
    keys.each do |key|
      return self.all if params[key.to_s].present?
    end
    self.none
  end

  def cancel_url
    @cancel_url.present? ? @cancel_url : nil
  end

  def redirect_url
    @redirect_url.present? ? @redirect_url : nil
  end

  def render_view
    @render_view.present? ? @render_view : nil
  end

  # overrides paginate and calls it only if options[:cannot_paginate].blank?
  def next_paginate(options)
    if options.delete(:cannot_paginate).blank? || options.delete(:format).eqls?('pdf', 'xls', 'xlsx', 'xml')
      paginate(options)
    else
      all
    end
  end

  # get value
  def enum_v(attribute)
    self.class.send(attribute.to_s.pluralize)[self.send(attribute)]
  end

  # return an enum translated
  def enum_t(attribute)
    I18n.t("enums.#{self.class.name.to_s.tableize.singularize}.#{attribute}.#{read_attribute(attribute)}", default: [:"enums.defaults.#{read_attribute(attribute)}"])
  end

  # return an enum translated
  def boolean_t(attribute)
    I18n.t("booleans.#{self.class.name.to_s.tableize.singularize}.#{attribute}.#{read_attribute(attribute)}", default: [:"booleans.defaults.#{read_attribute(attribute)}"])
  end

  # creates filter data
  def self.map_for_filter(column = 'name')
    [[I18n.t(:everything), :all]] + all.map {|f| [f.send(column), f.id]}
  end

  # return an enum likes this enum status: {active: 0, pending: 1, inactive: 2}
  # [[active, I18n.t(:active)], [pending, I18n.t(:pending)], [inactive, I18n.t(:inactive)]]
  def self.enums_map_t(attribute)
    self.send(attribute.to_s.pluralize).map{|k,v| [I18n.t("enums.#{name.to_s.tableize.singularize}.#{attribute}.#{k}", default: [:"enums.defaults.#{k}"]), k]}
  end

  # return an enum likes this enum status: {active: 0, pending: 1, inactive: 2}
  # [[active, I18n.t(:active)], [pending, I18n.t(:pending)], [inactive, I18n.t(:inactive)]]
  def self.enums_for_filter_t(attribute)
    [[I18n.t(:everything), :all]] + self.send(attribute.to_s.pluralize).map{|k,v| [I18n.t("enums.#{name.to_s.tableize.singularize}.#{attribute}.#{k}", default: [:"enums.defaults.#{k}"]), k]}
  end

  # return an enum likes this
  # {"dad"=>0, "mom"=>1, "brother"=>2, "sister"=>3}
  # to this [{:text=>"Pai", :value=>"dad"}, {:text=>"Mãe", :value=>"mom"}, {:text=>"Irmão", :value=>"brother"}, {:text=>"Irmã", :value=>"sister"}]
  def self.editable_enums_map_t(attribute)
    self.send(attribute.to_s.pluralize).map{|k,v| {text: I18n.t("enums.#{name.to_s.tableize.singularize}.#{attribute}.#{k}", default: [:"enums.defaults.#{k}"]), value: k}}
  end

  # maps a collection of objects like User.map_for_select(:full_name)
  # User.all.map{|u| [u.full_name, u.id]}
  def self.map_for_select(attr_name, label_method = :to_s)
    all.map{|u| [u.send(attr_name).send(label_method), u.id]}
  end

  # maps a collection of objects like User.map_for_select(:full_name)
  # User.all.map{|u| [u.full_name, u.id]}
  def self.editable_map_for_select(attr_name)
    all.map{|u| {text: u.send(attr_name), value: u.id} }
  end

  # translate create errors messages
  def errors_t(attr, error_message, options = {})
    options[:default] ||= [:"activerecord.errors.messages.#{error_message}", error_message.to_s.humanize]
    I18n.t("activerecord.errors.models.#{self.class.name.tableize.singularize}.attributes.#{attr}.#{error_message}", options)
  end

  def kwanza_t(column_or_value, options = {})
    value = column_or_value.class.name.eql?(Symbol.name) ? self.send(column_or_value) : column_or_value
    options[:unit] ||= 'AKZ'
    options[:separator] ||= ','
    options[:delimiter] ||= '.'
    options[:format] ||= '%n  %u'
    ActiveSupport::NumberHelper.number_to_currency(value, options)
  end

  def percentage_t(column_or_value, options = {})
    value = column_or_value.class.name.eql?(Symbol.name) ? self.send(column_or_value) : column_or_value
    options[:precision] ||= 2
    options[:format] ||= '%n  %'
    ActiveSupport::NumberHelper.number_to_percentage(value, options)
  end

  def error_messages_t()
    errors.messages.map{|key, errs| [I18n.t("simple_form.labels.#{self.class.name.tableize.singularize}.#{key}", default: ["simple_form.labels.defaults.#{key}", key.to_s.humanize.titleize]), errs]}.to_h
  end

  def simple_form_label_t(key)
    I18n.t("simple_form.labels.#{self.class.name.tableize.singularize.split('/').last}.#{key}", default: ["simple_form.labels.defaults.#{key}".to_sym, key.to_s.humanize.titleize])
  end

  def date_l(column, options = {})
  options[:format] = :default
    I18n.l(send(column), options)
  end

  def dup_and_update(params = {})
    assign_attributes(params)
    dupped = dup
    dupped.save
  end

  def cancel_url_to(url)
    self.cancel_url = url
  end

  def redirect_url_to(url)
    self.redirect_url = url
  end

  def cancel_and_redirect_url_to(url)
    self.redirect_url = self.cancel_url = url
  end

  def goto_cancel_url_or(url)
    cancel_url.present? ? cancel_url : url
  end

  def goto_redirect_url_or(url)
    redirect_url.present? ? redirect_url : url
  end

  def css_class
    "#{self.class.name.dasherize.singularize.gsub('/', '_')}_#{id}"
  end

  def self.css_class
    "#{self.class.name.dasherize.singularize.gsub('/', '_')}"
  end

  def create_number
    tipo = self.class.name
    return unless tipo.eql?(Position.name) || tipo.eql?(Employee.name) || tipo.eql?(Department.name) || tipo.eql?(Function.name)
    i = self.class.all.map{|i| i.number.to_s.gsub(/\D/, '').to_i}.compact.sort.last || 0
    i = i + 1
    return unless number.blank?
    self.number = "#{self.class::INITIAL_LETTER}#{i.to_s.rjust(8, '0')}"
  end

  def create_number!
    self.create_number
    self.save
  end
end
