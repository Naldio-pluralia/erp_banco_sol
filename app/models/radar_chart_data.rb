
class RadarChartData < Object
  attr_accessor :labels, :datasets
  # {['Assíduidade', 'Tales de Milteto'] => 2, ['Assíduidade', 'Cavelipa Tchipa Calucango'] => 4, ['Assíduidade', 'Atendimentos'] => 5}

  #TODO Não alterar a ordem das cores - para não alterar a legenda do radar (Employee Asssessment)
  def background_colors
    ['rgba(33,150,243, 0.1)',
     'rgba(250, 176, 51, 0.1)',
     'rgba(0, 128, 0, 0.1)',
     'rgba(24, 255, 255, 1)',
     'rgba(208, 24, 30, 0.1)',
     'rgba(236, 64, 122, 0.1)',
     'rgba(171, 71, 188, 0.1)',
     'rgba(94, 53, 177, 0.1)',
     'rgba(57, 73, 171, 0.1)',
     'rgba(30, 136, 229, 0.1)',
     'rgba(3, 155, 229, 0.1)',
     'rgba(0, 172, 193, 0.1)']
  end

  def border_colors
    ['rgba(33,150,243, 1)',
     'rgba(250, 176, 51, 1)',
     'rgba(0, 128, 0, 1)',
     'rgba(24, 255, 255, 1)',
     'rgba(208, 24, 30, 1)',
     'rgba(236, 64, 122, 1)',
     'rgba(171, 71, 188, 1)',
     'rgba(94, 53, 177, 1)',
     'rgba(57, 73, 171, 1)',
     'rgba(30, 136, 229, 1)',
     'rgba(3, 155, 229, 1)',
     'rgba(0, 172, 193, 1)']
  end

  def initialize(data = {})
    self.labels, self.datasets = [], []#, {height: '220px', scale: {ticks: {begin_at_zero: true, min: 0, max: 5, step_size: 1}}}]
    data_labels = data.map {|k, v| k.first}.uniq
    datasets_labels = data.map {|k, v| k.second}.uniq
    data_labels.each_with_index do |label, label_index|
      self.labels << label
      datasets_labels.each_with_index do |data_set, dataset_index|
        self.datasets.insert(dataset_index, {data: [], border_color: 2, background_color: background_colors[dataset_index], border_width: border_colors[dataset_index], label: data_set}) if datasets[dataset_index].nil?
        v = data[[label, data_set]].class.name == Array.name ? data[[label, data_set]].size : data[[label, data_set]].to_s
        self.datasets[dataset_index][:data].insert(label_index, v)
      end
    end
  end

  def get_data
    {labels: labels, datasets: datasets}
  end
end
