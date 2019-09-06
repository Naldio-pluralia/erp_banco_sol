class SalaryFamily < ApplicationRecord
  belongs_to :salary_grid
  belongs_to :salary_category
  belongs_to :salary_area
  belongs_to :salary_layer
  belongs_to :salary_group
  has_many :employee_salary_families
  validates_presence_of :salary_grid_id, :salary_category_id, :salary_area_id, :salary_layer_id, :salary_group_id, :code, :family, :core
  validates_uniqueness_of :salary_grid_id, scope: [:salary_category_id, :salary_area_id, :salary_layer_id, :salary_group_id, :code, :family, :core]
  validates_numericality_of :code, :family, :core, greate_than: 0

  def name
    "#{salary_grid&.gs} - #{salary_category&.name} - #{salary_area&.name} - #{salary_layer&.name} - #{family} - #{salary_group&.name} - #{core} - #{salary_grid&.kwanza_t(:value_100, precision: 0)}"
  end

  def self.latest
    where(code: SalaryFamily.maximum(:code)).includes(:salary_grid, :salary_category, :salary_area, :salary_layer, :salary_group)
  end

  def add_family
    latest = SalaryFamily.where.not(id: id).latest
    grids = SalaryGrid.latest.map{|g| [g.number, g.id]}.to_h
    SalaryFamily.create(latest.map{|f| {code: code, salary_grid_id: grids[f.salary_grid.number], salary_category_id: f.salary_category_id, family: f.family, salary_area_id: f.salary_area_id, salary_layer_id: f.salary_layer_id, salary_group_id: f.salary_group_id, core: f.core}})
  end

  def remove_family
    latest = SalaryFamily.where(code: code).where.not(id: id).latest
    grids = SalaryGrid.latest.map{|g| [g.number, g.id]}.to_h
    SalaryFamily.create(latest.map{|f| {code: code + 1, salary_grid_id: grids[f.salary_grid.number], salary_category_id: f.salary_category_id, family: f.family, salary_area_id: f.salary_area_id, salary_layer_id: f.salary_layer_id, salary_group_id: f.salary_group_id, core: f.core}})
  end

  def self.update_families
    code = (all.maximum(:code) || 0) + 1
    grids = SalaryGrid.latest.map{|g| [g.number, g.id]}.to_h
    SalaryFamily.create(all.map{|f| {code: code, salary_grid_id: grids[f.salary_grid.number], salary_category_id: f.salary_category_id, family: f.family, salary_area_id: f.salary_area_id, salary_layer_id: f.salary_layer_id, salary_group_id: f.salary_group_id, core: f.core}})
  end
end
