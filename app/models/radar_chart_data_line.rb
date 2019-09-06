
class RadarChartDataLine < Object
  attr_accessor :labels, :datasets
  # {['Assíduidade', 'Tales de Milteto'] => 2, ['Assíduidade', 'Cavelipa Tchipa Calucango'] => 4, ['Assíduidade', 'Atendimentos'] => 5}

  #TODO Não alterar a ordem das cores - para não alterar a legenda do radar (Employee Asssessment)
  def background_colors
    [
      '#2ecc71',
      '#3498db',
      '#f39c12'
    ]
  end

  def border_colors
    [
      '#2ecc71',
      '#3498db',
      '#f39c12'
    ]
  end

  def initialize(data = {})
    self.labels, self.datasets = [], []#, {height: '220px', scale: {ticks: {begin_at_zero: true, min: 0, max: 5, step_size: 1}}}]
    data_labels = data.map {|k, v| k.first}.uniq
    datasets_labels = data.map {|k, v| k.second}.uniq
    data_labels.each_with_index do |label, label_index|
      self.labels << label
      datasets_labels.each_with_index do |data_set, dataset_index|
        self.datasets.insert(dataset_index, {data: [], border_color: 1,  borderWidth: 1, backgroundColor: "transparent", borderColor: background_colors[dataset_index], fill: false, pointBorderWidth: 1, pointBackgroundColor: background_colors[dataset_index], pointBorderColor: background_colors[dataset_index], label: data_set}) if datasets[dataset_index].nil?
        v = data[[label, data_set]].class.name == Array.name ? data[[label, data_set]].size : data[[label, data_set]].to_s
        self.datasets[dataset_index][:data].insert(label_index, v)
      end
    end
  end

  def get_data
    {labels: labels, datasets: datasets}
  end
end
