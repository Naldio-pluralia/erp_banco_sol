class CreateSalaryFamilies < ActiveRecord::Migration[5.1]
  def up
    create_table :salary_families do |t|
      t.integer :code, null: false
      t.references :salary_grid, foreign_key: true
      t.references :salary_category, foreign_key: true
      t.references :salary_area, foreign_key: true
      t.integer :family, null: false
      t.references :salary_layer, foreign_key: true
      t.references :salary_group, foreign_key: true
      t.integer :core, null: false

      t.timestamps
    end

    p categories = SalaryCategory.all.map{|s| [s.name, s.id]}.to_h
    p areas = SalaryArea.all.map{|s| [s.name, s.id]}.to_h
    p layers = SalaryLayer.all.map{|s| [s.name, s.id]}.to_h
    p groups = SalaryGroup.all.map{|s| [s.name, s.id]}.to_h
    p grids = SalaryGrid.latest.map{|s| [s.number, s.id]}.to_h

    salary_families = [
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Auxiliar'], salary_grid_id: grids[12], salary_layer_id: layers['Supervisor'], family: 1, salary_group_id: groups['Supervisão'], core: 2},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Auxiliar'], salary_grid_id: grids[13], salary_layer_id: layers['Supervisor'], family: 2, salary_group_id: groups['Supervisão'], core: 2},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Auxiliar'], salary_grid_id: grids[9], salary_layer_id: layers['Especialista'], family: 1, salary_group_id: groups['Execução | Supervisão'], core: 2},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Auxiliar'], salary_grid_id: grids[8], salary_layer_id: layers['Sénior'], family: 1, salary_group_id: groups['Execução | Supervisão'], core: 2},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Auxiliar'], salary_grid_id: grids[6], salary_layer_id: layers['Pleno'], family: 1, salary_group_id: groups['Execução'], core: 2},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Auxiliar'], salary_grid_id: grids[2], salary_layer_id: layers['Assistente'], family: 1, salary_group_id: groups['Execução'], core: 2},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Auxiliar'], salary_grid_id: grids[3], salary_layer_id: layers['Assistente'], family: 2, salary_group_id: groups['Execução'], core: 2},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Auxiliar'], salary_grid_id: grids[4], salary_layer_id: layers['Assistente'], family: 3, salary_group_id: groups['Execução'], core: 2},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Auxiliar'], salary_grid_id: grids[1], salary_layer_id: layers['Júnior'], family: 1, salary_group_id: groups['Execução'], core: 2},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[15], salary_layer_id: layers['Superior'], family: 1, salary_group_id: groups['Coordenação | Departamento'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[16], salary_layer_id: layers['Superior'], family: 2, salary_group_id: groups['Coordenação | Departamento'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[14], salary_layer_id: layers['Supervisor'], family: 1, salary_group_id: groups['Supervisão'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[12], salary_layer_id: layers['Especialista'], family: 1, salary_group_id: groups['Execução | Supervisão'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[10], salary_layer_id: layers['Sénior'], family: 1, salary_group_id: groups['Execução | Supervisão'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[6], salary_layer_id: layers['Pleno'], family: 1, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[6], salary_layer_id: layers['Pleno'], family: 2, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[4], salary_layer_id: layers['Assistente'], family: 1, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[5], salary_layer_id: layers['Assistente'], family: 2, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[2], salary_layer_id: layers['Júnior'], family: 1, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Comercial'], salary_grid_id: grids[3], salary_layer_id: layers['Júnior'], family: 1, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[15], salary_layer_id: layers['Superior'], family: 1, salary_group_id: groups['Coordenação | Departamento'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[16], salary_layer_id: layers['Superior'], family: 2, salary_group_id: groups['Coordenação | Departamento'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[14], salary_layer_id: layers['Supervisor'], family: 1, salary_group_id: groups['Supervisão'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[12], salary_layer_id: layers['Especialista'], family: 1, salary_group_id: groups['Execução | Supervisão'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[10], salary_layer_id: layers['Sénior'], family: 1, salary_group_id: groups['Execução | Supervisão'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[6], salary_layer_id: layers['Pleno'], family: 1, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[7], salary_layer_id: layers['Pleno'], family: 2, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[4], salary_layer_id: layers['Assistente'], family: 1, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[5], salary_layer_id: layers['Assistente'], family: 2, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[2], salary_layer_id: layers['Júnior'], family: 1, salary_group_id: groups['Execução'], core: 1},
      {code: 1, salary_category_id: categories['Técnico'], salary_area_id: areas['Operacional'], salary_grid_id: grids[3], salary_layer_id: layers['Júnior'], family: 2, salary_group_id: groups['Execução'], core: 1}
    ]

    SalaryFamily.create(salary_families).each{|s| p s.errors.messages; p s}
  end

  def down
    drop_table :salary_families
  end
end
