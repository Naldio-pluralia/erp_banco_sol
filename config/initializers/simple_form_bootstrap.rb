# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_class = 'alert alert-danger'
  config.button_class = 'btn btn-default'
  config.boolean_label_class = nil

  config.wrappers :vertical_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input, class: 'form-control'
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  config.wrappers :vertical_file_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  config.wrappers :vertical_boolean, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: 'div', class: 'checkbox' do |ba|
      ba.use :label_input
    end

    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  config.wrappers :vertical_radio_and_checkboxes, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'control-label'
    b.use :input
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  config.wrappers :horizontal_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-3 control-label'

    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: {tag: 'span', class: 'help-block'}
      ba.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
    end
  end

  config.wrappers :horizontal_file_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: 'col-sm-3 control-label'

    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input
      ba.use :error, wrap_with: {tag: 'span', class: 'help-block'}
      ba.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
    end
  end

  config.wrappers :horizontal_boolean, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: 'div', class: 'col-sm-offset-3 col-sm-9' do |wr|
      wr.wrapper tag: 'div', class: 'checkbox' do |ba|
        ba.use :label_input
      end

      wr.use :error, wrap_with: {tag: 'span', class: 'help-block'}
      wr.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
    end
  end

  config.wrappers :horizontal_radio_and_checkboxes, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-sm-3 control-label'

    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input
      ba.use :error, wrap_with: {tag: 'span', class: 'help-block'}
      ba.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
    end
  end

  config.wrappers :inline_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'sr-only'

    b.use :input, class: 'form-control'
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  config.wrappers :multi_select, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'control-label'
    b.wrapper tag: 'div', class: 'form-inline' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: {tag: 'span', class: 'help-block'}
      ba.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
    end
  end


  config.wrappers :dropify_file_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: 'col-sm-3 control-label'

    b.use :input, class: 'dropify-fr'
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  # config.wrappers :bootstrap_file_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
  #   b.use :html5
  #   b.use :placeholder
  #   b.optional :maxlength
  #   b.optional :minlength
  #   b.optional :readonly
  #   b.use :label, class: 'col-sm-3 control-label'

  #   b.use :input
  #   b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
  #   b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  # end

  config.wrappers :bootstrap_switch_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label
    b.wrapper tag: 'div', class: 'col-sm-offset-3 col-sm-9' do |wr|
      wr.use :input
      wr.use :error, wrap_with: {tag: 'span', class: 'help-block'}
      wr.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
    end
  end

  config.wrappers :bootstrap_datepicker_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input, class: 'form-control datepicker'
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  config.wrappers :flatpickr_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input, class: 'form-control flatpickr'
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  config.wrappers :flatpickr_time_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input, class: 'form-control flatpicker_time'
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  config.wrappers :flatpickr_datetime_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input, class: 'form-control flatpickr_datetime'
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  config.wrappers :flatpickr_date_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input, class: 'form-control flatpickr_date'
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  config.wrappers :air_datepicker_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input, class: 'form-control air_datepicker', 'data-language' => 'pt', 'data-position' => 'right top' #, 'data-' => '', 'data-' => '', 'data-' => ''
    b.use :error, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
  end

  # Wrappers for forms and inputs using the Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :vertical_form
  config.wrapper_mappings = {
      check_boxes: :vertical_radio_and_checkboxes,
      radio_buttons: :vertical_radio_and_checkboxes,
      file: :vertical_file_input,
      boolean: :vertical_boolean,
      datetime: :flatpickr_datetime,
      dropify: :dropify_file_input,
      # bootstrap_file: :bootstrap_file_input,
      bootstrap_switch: :bootstrap_switch_input,
      # bootstrap_datepicker: :bootstrap_datepicker_input,
      # date: :flatpickr_date,
      time: :flatpickr_time
  }
end
