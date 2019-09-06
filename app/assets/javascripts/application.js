// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require jquery-ui.min
//= require twitter/bootstrap
//= require materialize/initial
//= require materialize/jquery.easing.1.4
//= require materialize/animation
//= require materialize/velocity.min
//= require materialize/hammer.min
//= require materialize/jquery.hammer
//= require materialize/global
//= require materialize/collapsible
//= require materialize/dropdown
//= require materialize/modal
//= require materialize/materialbox
//= require materialize/parallax
//= require materialize/tabs
//= require materialize/tooltip
//= require materialize/waves
//= require materialize/toasts
//= require materialize/sideNav
//= require materialize/scrollspy
//= require materialize/slider
//= require materialize/cards
//= require materialize/chips
//= require materialize/pushpin
//= require materialize/buttons
//= require materialize/transitions
//= require materialize/scrollFire
//= require materialize/character_counter
//= require materialize/carousel
//= require materialize/tapTarget
//= require Chart.bundle.min
//= require wNumb
//= require stupidtable.min.js
//= require chosen.jquery.min
//= require selectize
//= require moment
//= require jquery.steps.min
//= require bootstrap-switch.min
//= require plugins/piexif.min
//= require plugins/purify.min
//= require plugins/sortable.min
//= require flatpickr/dist/flatpickr.min
//= require flatpickr/dist/l10n/pt
//= require datepicker.min
//= require i18n/datepicker.pt
//= require editable/bootstrap-editable
//= require editable/rails
//= require fullcalendar.min
//= require fullcalendar-locale/pt
//= require jspanel.min
//= require jspanel-extensions/jspanel.contextmenu.min
//= require jspanel-extensions/jspanel.hint.min
//= require jspanel-extensions/jspanel.modal.min
//= require jspanel-extensions/jspanel.tooltip.min
//= require jspanel-extensions/jspanel.layout.min
//= require jspanel-extensions/jspanel.overlay.min
//= require jquery.contextMenu.min
//= require jquery.ui.position.min
//= require jquery.tabulator/dist/js/tabulator.min
//= require tabulator_helpers
//= require quill/dist/quill.min
//= require malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min
//= require trix
//= require trix_settings
//= require jquery-menu
//= require jquery.uploadfile.min
//= require office-ui-fabric-js/dist/js/fabric.min
//= require_tree .


var preloader_html = '<div style="text-align: center;">' +
    '<div class="preloader-wrapper big active">' +
      '<div class="spinner-layer spinner-blue-only">' +
        '<div class="circle-clipper left">' +
          '<div class="circle"></div>' +
        '</div><div class="gap-patch">' +
          '<div class="circle"></div>' +
        '</div><div class="circle-clipper right">' +
          '<div class="circle"></div>' +
        '</div>' +
      '</div>' +
    '</div>' +
  '</div>';

var error_html = '<div style="padding: 10px 0; font-size: 17px; color: red;">' +
    'Ocorreu um erro' +
  '</div>;';

jQuery(document).ready(function ($) {
  // #= require twitter/bootstrap/transition
  // #= require twitter/bootstrap/alert
  // #= require twitter/bootstrap/modal
  // #= require twitter/bootstrap/button
  // #= require twitter/bootstrap/collapse
  jsPanel.defaults.boxShadow = 5;
  jsPanel.defaults.theme =  'none';
  jsPanel.defaults.container = document.body;
  jsPanel.defaults.contentOverflow = 'hidden auto';
  jsPanel.defaults.panelSize = {width: '95%', height: '90%'};
  jsPanel.defaults.paneltype = 'standard';
  jsPanel.defaults.position = 'center 0 0';
  var body = $('body');
  initPlugins(body);
  reload_remove_parent_events();
});

function initPlugins(from){

  from.find('[tabulate]').each(function(){
    var options = JSON.parse($(this).attr('tabulate'));
    var obj = $(this);
    $(this).removeAttr('tabulate');
    $.each(options.columns, function( index, value ) {
      if(options.columns[index].formatter != undefined){
        options.columns[index].formatter = window[options.columns[index].formatter]
      }
    });
    options.renderComplete = function(){
      initPlugins(obj);
    }
    if(options.langs == undefined || options.langs == null){
      options.locale = true;
      options.langs = langs;
    }
    // options.tableBuilt = function(){
    //   initPlugins(obj);
    // }
    $(this).tabulator(options);
    $(this).tabulator("setLocale", "pt-ao");
  });

  from.find('[retabulate]').on('ajax:success', function(evt, data, status, xhr, e){
    $($(this).attr('retabulate')).tabulator('replaceData');
  });

  from.find('input.air_datepicker').attr('autocomplete','off');
  // from.find("[data-ctmenu]").each(function() {

  //   $(this).contextMenu($(this).data('ctmenu'));
  // });
  // var ContextualMenuElements = from.find('').document.querySelectorAll(".ms-ContextualMenuExample");
  // for (var i = 0; i < ContextualMenuElements.length; i++) {
  //   var ButtonElement = ContextualMenuElements[i].querySelector(".ms-Button");
  //   var ContextualMenuElement = ContextualMenuElements[i].querySelector(".ms-ContextualMenu");
  //   new fabric['ContextualMenu'](ContextualMenuElement, ButtonElement);
  // }

  // from.find('.ajax-tabulator').each(function(){
  //   var obj = $(this);
  //   $("#" + $(this).attr('id')).tabulator({
  //     height:"311px",
  //     layout:"fitColumns",
  //     ajaxURL: obj('ajax-url'),
  //     ajaxProgressiveLoad:"scroll",
  //     paginationSize:20,
  //     placeholder:"No Data Set",
  //     columns:[
  //       {title:"Name", field:"name", sorter:"string", width:200},
  //       {title:"Progress", field:"progress", sorter:"number", formatter:"progress"},
  //       {title:"Gender", field:"gender", sorter:"string"},
  //       {title:"Rating", field:"rating", formatter:"star", align:"center", width:100},
  //       {title:"Favourite Color", field:"col", sorter:"string", sortable:false},
  //       {title:"Date Of Birth", field:"dob", sorter:"date", align:"center"},
  //       {title:"Driver", field:"car", align:"center", formatter:"tickCross", sorter:"boolean"},
  //     ],
  //   });
  //   // var obj = $(this);
  //   // $("#" + $(this).attr('id')).tabulator({
  //   //   pagination:"remote",
  //   //   ajaxURL: obj.attr('ajax-ur'),
  //   // //   paginationSize: 5
  //   // });
  // });

  from.find('.ms-Persona').each(function(){
    new fabric['Persona'](this);
  });

  from.find(".ms-PanelExample").each(function() {
    var PanelExampleButton = this.querySelector(".activate-panel");
    var PanelExamplePanel = this.querySelector(".ms-Panel");
    PanelExampleButton.addEventListener("click", function(i) {
      new fabric['Panel'](PanelExamplePanel);
    });
  });

  from.find(".ms-CommandBar").each(function() {
    new fabric['CommandBar'](this);
  });

  from.find(".ms-ContextualMenuExample").each(function() {
    var ButtonElement = this.querySelector(".ms-Button");
    var ContextualMenuElement = this.querySelector(".ms-ContextualMenu");
    new fabric['ContextualMenu'](ContextualMenuElement, ButtonElement);
  });

  // FilePond.registerPlugin(
  //   FilePondPluginFileEncode,
  //   FilePondPluginFileValidateType,
  //   FilePondPluginImageExifOrientation,
  //   FilePondPluginImagePreview,
  //   FilePondPluginImageCrop,
  //   FilePondPluginImageResize,
  //   FilePondPluginImageTransform
  // );

  // from.find("a").click(function(){
  //   var obj = $(this);
  //   var url =

  //   $.ajax({success: function(data, status, xhr) {
  //     console.log(data);
  //     $(obj.data('selector')).html(data);
  //   }});
  //   obj.preventDefault();
  // });


  from.find(".jquery-file-upload").each(function() {
    var obj = $(this);
    obj.uploadFile({
      url: obj.data('url'),
      method: obj.data('method'),
      fileName: obj.data('url'),
      maxFileCount: 1,
      dragDrop: false,
      dragDropStr: "Arrasta e Larga e Vídeo",
      uploadStr: "Carregar",
      abortStr: "Abortar",
      cancelStr: "Cancelar",
      doneStr: "Feito",
      maxFileSize: 1048576*500,
      allowedTypes: 'mov,mp4,3gp,mkv,webm,m4v,avi',
      acceptFiles: 'video/',
      multiDragErrorStr: "Não é Permitido Arrastar Multiplos Ficheiros",
      extErrorStr: "Tipo de Ficheiro Não Permitido. Tipos Permitidos: ",
      duplicateErrorStr: "Ficheiro já existe",
      sizeErrorStr: "Tamanho máximo de ser: ",
      uploadErrorStr: "Carregamento não permitido",
      maxFileCountErrorStr: "Número maximo de ficheiros é:"
    });
  });
  from.find("[data-rcat]").each(function() {
    $(this).catMenu({
      menu: $(this).data('rcat'),

      // or 'left': left click
      mouse_button: 'right',

      // min/max width
      min_width: 120,
      max_width: 0,

      // in milliseconds
      delay: 500,

      // enable keyboard interactions
      keyboard: true,

      // enable hoverIntent jQuery plugin
      hover_intent: false
    });
  });
  from.find("[data-lcat]").each(function() {
    $(this).catMenu({
      menu: $(this).data('lcat'),

      // or 'left': left click
      mouse_button: 'left',

      // min/max width
      min_width: 120,
      max_width: 0,

      // in milliseconds
      delay: 500,

      // enable keyboard interactions
      keyboard: true,

      // enable hoverIntent jQuery plugin
      hover_intent: false

    });
  });
  from.find(".catMenu").click(function(){
    $(this).find('.hover').removeClass('hover');
    $(this).css('display', 'none')
  });

  from.find(".next-scrollbar").mCustomScrollbar({scrollButtons: {enable: true}, theme: 'dark-thin'});
  from.find("[data-save-chart]").click(function() {
    var canvas = $($(this).data('save-chart')).get(0);
    $(this).attr('href', canvas.toDataURL('image/png'));
  });
  jsPanel.ziBase = 1000;
  $.fn.editableform.buttons = '<button type="submit" class="btn editable-submit"><i class="fa fa-check"></i></button>' +
                              '<a class="editable-cancel"><i class="fa fa-close"></i></button>';
  $.fn.editable.defaults.emptytext = "Clique Para Editar";
  from.find('.editable').editable({
    mode: 'inline',
    error: function(response, newValue) {
      // if(response.status === 500) {
      //   return 'Serviço Indisponível, Tente mais novamente mais tarde.';
      // } else {
      //   var err_message = '';
      //   // jQuery.each((response.responseText), function(i, val) {
      //   //   console.log(i);
      //   //   console.log(val);
      //   //   err_message += i + ": " + val.join(', ') + "<br>";
      //   // });
      //   $(".editable-error-block").html(err_message);
      // }
    }
  });

  $('[data-tooltip]').tooltip({delay: 50});

  from.find('.add_result_text').click(function(){
    $('.add_result_form').removeClass('hide');
    $('.add_result_text').addClass('hide');
  });

  from.find('.close-result-form').click(function(){
    $('.add_result_form').addClass('hide');
    $('.add_result_text').removeClass('hide');
  });

  from.find('.lobipanel').lobiPanel();

  from.find('[data-load-from]').each(function(){
    $(this).html(preloader_html);
    $(this).load( $(this).data('load-from') + " .partial_view_application", function( response, status, xhr ) {
      if ( status == "error" ) {
        //$(this).html(error_html);
      }else if(status == "success"){
        initPlugins($(this));
      }
    });
  });

  from.on('click', '[data-fill-modal-with]', function(){
    var target = $('#application_modal');
    var target_content = target.find('.modal-content');
    target_content.html(preloader_html);
    target.modal('open');
    target.find('.box-title span').html($(this).data('modal-title'));
    target_content.load( $(this).data('fill-modal-with') + " .partial_view_application", function( response, status, xhr ) {
      if ( status == "error" ){
        //$(this).html(error_html);
      }else if(status == "success"){
        initPlugins(target_content);
      }
    });
  });

  // from.find('a[data-remote][data-jpanel]').on('ajax:before', function(){
  //   $('ms-Spinner').remove();
  //   $('body').append('<div class="ms-Spinner ms-Spinner--large"></div>');
  //   var SpinnerElements = document.querySelectorAll(".ms-Spinner");
  //   for (var i = 0; i < SpinnerElements.length; i++) {
  //     new fabric['Spinner'](SpinnerElements[i]);
  //   }
  // });

  // from.find('a[data-remote][data-jpanel]').on('ajax:complete', function(evt, data, status, xhr, e){
  //   $('ms-Spinner').remove();
  // });
  // Primeira tentativa
  from.find('a[data-remote][data-jpanel]').on('ajax:success', function(evt, data, status, xhr, e){
    ob = $(this);
    var panel = jsPanel.create({
      theme:       'none',
      headerTitle: ob.data('jpanel'),
      position:    'center 0 0',
      contentSize: ($(document).width() - 50) + ' ' + ($(document).height() - 215),
      container: 'body',
      panelSize: {width: '95%', height: '90%'},
      content: evt.detail[0]
    });
    $(panel.content).mCustomScrollbar({scrollButtons: {enable: true}, theme: 'dark-thin'});
    $(panel.content).on('ajax:success', 'a[data-remote].close_panel', function(evt, data, status, xhr, e){
      panel.close();
      Materialize.toast('Actualizado', 3500, 'rounded');
    });
    initPlugins($(panel.content));
  });

  from.find('a[data-remote][data-jmodal]').on('ajax:success', function(evt, data, status, xhr, e){
    ob = $(this);
    var panel = jsPanel.modal.create({
      theme:       'none',
      headerTitle: ob.data('jmodal'),
      panelSize: {width: '95%', height: '90%'},
      position:    'center 0 0',
      contentSize: ($(document).width() - 50) + ' ' + ($(document).height() - 215),
      container: 'body',
      content: evt.detail[0],
      contentOverflow: 'hidden scroll',
      headerControls: {
        smallify: 'disable',
        smallifyrev: 'disable',
        minimize: "disable"
      },
      dragit:         true,
      resizeit:       true
    });
    $(panel.content).mCustomScrollbar({scrollButtons: {enable: true}, theme: 'dark-thin'});
    $(panel.content).on('ajax:success', 'form.simple_form[data-remote="true"]', function(evt, data, status, xhr, e){
      panel.close();
      Materialize.toast('Gravado', 3500, 'rounded')
    });
    initPlugins($(panel.content));
  });

  from.find('a[data-remote][data-replace]').on('ajax:success', function(evt, data, status, xhr, e){
    ob = $(this);
    $(ob.data('replace')).replaceWith(evt.detail[0]);
    Materialize.toast('Gravado', 3500, 'rounded');
    initPlugins($(evt.detail[0]));
  });
  // Segunda Tentativa
  from.find('a[data-remote][jpanel]').on('ajax:success', function(evt, data, status, xhr, e){
    ob = $(this);
    var panel = jsPanel.create({
      theme:       'none',
      headerTitle: ob.attr('jpanel'),
      position:    'center 0 0',
      container: 'body',
      panelSize: {width: '95%', height: '90%'},
      content: $(evt.detail[0]).find("body:first").html(),
      callback: function () {
        this.content.style.padding = '10px';
      },
    });
    $(panel.content).mCustomScrollbar({scrollButtons: {enable: true}, theme: 'dark-thin'});
    initPlugins($(panel.content));
  });

  from.find('a[data-remote][jmodal]').on('ajax:success', function(evt, data, status, xhr, e){
    ob = $(this);
    var panel = jsPanel.modal.create({
      theme:       'none',
      headerTitle: ob.attr('jmodal'),
      panelSize: {width: '95%', height: '90%'},
      position:    'center 0 0',
      container: 'body',
      content: $(evt.detail[0]).find("body:first").html(),
      contentOverflow: 'hidden scroll',
      headerControls: {
        smallify: 'disable',
        smallifyrev: 'disable',
        minimize: "disable"
      },
      callback: function () {
        this.content.style.padding = '10px';
      },
      dragit:         true,
      resizeit:       true
    });
    $(panel.content).mCustomScrollbar({scrollButtons: {enable: true}, theme: 'dark-thin'});
    $(panel.content).on('ajax:success', 'form.simple_form[data-remote="true"]', function(evt, data, status, xhr, e){
      panel.close();
      Materialize.toast('Gravado', 3500, 'rounded');
    });
    $(panel.content).on('ajax:error', 'form.simple_form[data-remote="true"]', function(evt, data, status, xhr, e){
      Materialize.toast('Não Gravado', 3500, 'rounded error');
    });
    initPlugins($(panel.content));
  });

  from.find('a[data-remote][data-replace]').on('ajax:success', function(evt, data, status, xhr, e){
    ob = $(this);
    $(ob.data('replace')).replaceWith(evt.detail[0]);
    Materialize.toast('Gravado', 3500, 'rounded');
    initPlugins($(ob.data('replace')));
  });
  // Terceira Tentativa
  from.find('a[data-remote].jpanel').on('ajax:success', function(evt, data, status, xhr, e){
    var ob = $(this);
    var panel = jsPanel.create({
      headerTitle: ob.attr('title'),
      id: ob.attr('href'),
      content: $(evt.detail[0]).find("body:first").html(),
      callback: function () {
        this.content.style.padding = '10px';
      }
    });
    initPlugins($(panel.content));
    $(panel.content).on('ajax:success', 'a.reload-panel[data-remote]', function(evt, data, status, xhr, e){
      $(panel.content).html($(evt.detail[0]).find("body:first").html());
      initPlugins($(panel.content));
    });
  });

  from.find('a[data-remote].jmodal').on('ajax:success', function(evt, data, status, xhr, e){
    var ob = $(this);
    var panel = jsPanel.modal.create({
      headerTitle: ob.attr('title'),
      id: ob.attr('href'),
      content: $(evt.detail[0]).find("body:first").html(),
      headerControls: {
        smallify: 'disable',
        smallifyrev: 'disable',
        minimize: "disable"
      },
      callback: function () {
        this.content.style.padding = '10px';
      },
      dragit: {
        disableOnMaximized: true
      },
      resizeit: {
        handles:   'n, e, s, w, ne, se, sw, nw'
      },
      onclosed: [
        function(){
          var onCloseUrl = ob.attr('onpanelclose');
          if(onCloseUrl != undefined){
            $.ajax({url: onCloseUrl});
          }
        }
      ]
    });
    panel.resizeit('enable');
    panel.dragit('enable');
    // $(panel.content).mCustomScrollbar({scrollButtons: {enable: true}, theme: 'dark-thin'});
    $(panel.content).on('ajax:success', 'form.simple_form[data-remote="true"]', function(evt, data, status, xhr, e){
      panel.close();
      Materialize.toast('Gravado', 3500, 'rounded');
    });
    $(panel.content).on('ajax:error', 'form.simple_form[data-remote="true"]', function(evt, data, status, xhr, e){
      Materialize.toast('Não Gravado', 3500, 'rounded error');
    });
    initPlugins($(panel.content));
    var onCloseUrl = ob.attr('onpanelclose');
    if(onCloseUrl != undefined){
      panel.options.onclosed.push(
        function(){
          $.ajax({url: onCloseUrl});
        }
      );
    }
  });

  // from.on('click', '[data-jspanel-url]', function(){
  //   var div = $('<div></div>');
  //   div.load( $(this).data('jspanel-url') + " .partial_view_application", function( response, status, xhr ) {
  //     if ( status == "error" ) {
  //       //$(this).html(error_html);
  //     }else if(status == "success"){
  //       initPlugins(div);
  //     }
  //   });
  //   console.log(div);
  //   jsPanel.create({
  //     container: '.page-content',
  //     theme:       'primary',
  //     headerTitle: 'my panel #1',
  //     position:    'center-top 0 30',
  //     contentSize: '550 350',
  //     content:     div.get(),
  //     callback: function () {
  //         this.content.style.padding = '20px';
  //     }
  //   });
  // });

  from.on('click', '[data-fill][data-fill-with]', function(){
    var target = $($(this).data('fill'));
    target.html(preloader_html);
    target.load( $(this).data('fill-with') + " .partial_view_application", function( response, status, xhr ) {
      if ( status == "error" ) {
        //$(this).html(error_html);
      }else if(status == "success"){
        initPlugins(target);
        target.find('.modal').modal('open');
      }
    });
  });

  var kwanzaFormat = wNumb({
    mark: ',',
    thousand: '.',
    prefix: '',
    suffix: ' AKZ'
  });

  flatpickr.localize(flatpickr.l10ns.pt);
  // import { flatpickr_pt } from "flatpickr/dist/l10n/pt.d.js"
  // flatpickr('input.flatpickr', {time_24hr: 'true', language: 'pt', disable: [
  //   function(date){
  //     //console.log(this.data-dates-to-disable);
  //   }
  // ]});
  from.find('input.flatpickr').flatpickr({
    time_24hr: 'true',
    altInput: true,
    altFormat: "j \\d\\e F \\d\\e Y",
    dateFormat: "Y-m-d",
  });
  from.find('input.flatpickr_datetime').flatpickr({
    time_24hr: 'true',
    altInput: true,
    altFormat: "j \\d\\e F \\d\\e Y \\a\\s H:i",
    dateFormat: "Y-m-d H:i",
  });
  from.find('input.flatpickr_time').flatpickr({
    enableTime: true,
    noCalendar: true,
    time_24hr: 'true',
    dateFormat: "H:i",
  });
  from.find('input.flatpicker_range').flatpickr({
    mode: "range",
    time_24hr: 'true',
    altInput: true,
    altFormat: "j F Y",
    dateFormat: "Y-m-d",
    onChange: function(selectedDates, dateStr, instance) {
      console.log(selectedDates);
      console.log(dateStr);
      console.log(instance);
    },
  });
  from.on('click', '[data-show-airdatepicker]', function(){
    $($(this).attr('data-show-airdatepicker')).datepicker().data('datepicker').show();
  });

  from.find('input.air_datepicker').datepicker({
    onSelect: function(formattedDate, date, inst) {
      $(inst.el).trigger('change');
    }
  });

  $.fn.bootstrapSwitch.defaults.size = 'small';
  $.fn.bootstrapSwitch.defaults.onText = 'Sim';
  $.fn.bootstrapSwitch.defaults.offText = 'Não';

  from.find('input[type="file"]:not([multiple]).dropify').dropify({
    messages: {
      'default': 'Arrasta e larga um ficheiro aqui ou clica',
      'replace': 'Arrasta e larga um ficheiro aqui ou clica para Substituir',
      'remove':  'Remover',
      'error':   'Ooops, Occorreu um erro.'
    }
  });

  //  ++++++++++++++++  METODOS E FUNCÕES DO MATERIALLIZE +++++++++++++++++++++++
  // ============================================================================
  from.find('ul.tabs').tabs();

  from.find('.collapsible').collapsible();

  from.find(".button-collapse").sideNav();

  from.find('.modal:not(.filter-modal):not(#wizard-modal):not(.user-password-reset)').modal({
    dismissible: false, // Modal can be dismissed by clicking outside of the modal
    }
  );

  from.find('.modal.bottom-sheet.filter-modal').modal({
    outDuration: 100,
    ready: function (modal, trigger) { // Callback for Modal open. Modal and trigger parameters available.
      $(modal).find('form').append('<input name="modal_open" type="hidden" value="#' + modal.attr('id') + '">');
    },
    complete: function (modal) {
      $(modal).find('[name="modal_open"][value="' + modal.attr('id') + '"]').remove();
    }
  });

  from.find('#set-initial-position').modal('open');

  from.find('.user-password-reset').each(function () {
    $(this).modal();
    $(this).modal('open');
  });

  from.find('table.next-stupid-sort').stupidtable();

  from.find('.selectize:not(.remote-selectize):not(.custom):not(.sele-5)').selectize({
    delimiter: ';',
    maxItems: 4,
    plugins: ['remove_button'],
    closeAfterSelect: true,
    selectOnTab: true
  });

  from.find('select.default-selectize').selectize();


  from.find('.dropdown-button').dropdown({
    constrainWidth: false
  });
  from.find('.next-dropdown-button').dropdown({
    constrainWidth: false
  });


  //  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  // ============================================================================

  // from.find('dropdown-content.select-dropdown.multiple-select-dropdown').each(function () {
  //     var options = $(this).children();
  //     $(this).prepend('<li data-select-all="true">Todos</li>');
  //     $(this).find('[data-select-all]').click(function () {
  //         if ($(this).is(':selected')) {
  //             console.log('c');
  //             options.attr('selected', 'selected');
  //         } else {
  //             console.log('a');
  //             options.removeProp('selected');
  //         }
  //     });
  // });
  //
  // from.find('[data-select-all]').change();


  from.find('[data-slider-for]').each(function () {
    var slider = this;
    var input = $($(slider).data('slider-for'));
    var val = 0;
    if (input.val() != '') {
        val = input.val();
    }
    noUiSlider.create(slider, {
      connect: true,
      start: val,
      step: 1,
      orientation: 'horizontal',
      range: {
        'min': 0,
        'max': 31
      },
      format: wNumb({
        decimals: 0
      })
    });

    slider.noUiSlider.on('update', function (values, handle) {
        input.val(values[handle]);
        from.find('[data-set-from-slider="' + $(slider).data('slider-for') + '"]').each(function () {
            $(this).html(values[handle]);
        });
    });
  });

  from.find('[data-reactivate-modal]').each(function () {
      $(this).modal('open');
  });


  // ================ Acção de validar e Invalidar Resultado (Checked) ===========
  from.find('.line-through-result').click(function () {
    var result_id = $(this).attr('id');
    var input_checkbox = from.find("input#filled-in-box-" + result_id).is(':checked');

    if (from.find("input#filled-in-box-" + result_id).is(':checked')) {
      from.find("input#filled-in-box-" + result_id).removeProp('checked');
    } else {
      from.find("input#filled-in-box-" + result_id).prop('checked', true);
    }
  });

  from.find("div.title").addClass("hide");

  // ================================ REMOVER RESULT =============================

  from.find('li').find('.remove-result-row').click(function () {
    $(this).closest('li').remove();
  });


  from.find('[data-sliders-for]').each(function () {
    var slider = this;
    var inputs = $($(slider).data('sliders-for'));
    if (!inputs.length) {
        return;
    }
    var val = 0;
    var start = [];
    inputs.each(function () {
      if ($(this).val() != '') {
          start = start.concat($(this).val());
      } else {
          start = start.concat(0);

      }
    });

    noUiSlider.create(slider, {
      start: start,
      connect: true,
      step: 1,
      orientation: 'horizontal',
      margin: 1,
      range: {
          'min': 0,
          'max': 31
      },
      format: wNumb({
          decimals: 0
      })
    });

    slider.noUiSlider.on('update', function (values, handle) {
        $(inputs[handle]).val(values[handle]);
        from.find('[data-set-from-slider="#' + $(inputs[handle]).attr('id') + '"]').each(function () {
            $(this).html(values[handle]);
        });
    });
  });


  from.find("div.title").addClass("hide");

  update_fileds_onjustification();

  from.on('change', '#justification_assessment_id,#justification_position_id', function(){
    update_fileds_onjustification();
  });

  from.find('.side-nav ul.collapsible>li').each(function () {
    if ($(this).find('.collapsible-body a.collapsible-header[href]').length <= 0 && $(this).children('a[href]').length <= 0) {
      $(this).addClass('hide');
    }
  });

  from.find(".collapsible").each(function () {
    $(this).children().each(function (index, el) {
      $(this).attr('data-pos', index);
      var it = $(this).children('a.collapsible-header[href="' + window.location.href.split('?')[0].split('#')[0] + '"]').last();
      if (window.location.href.split('?')[0].split('#')[0] == it.attr('href')) {
        it.addClass('current-url');
        it.parents('li[data-pos]').each(function () {
          $(this).parent().collapsible('open', $(this).data('pos'));
        });
      }
    });
    $(this).collapsible();
  });


  // ===========================    Abrir Modal quando ter erro ==================


  from.find('.has-error, .help-block, .error-block').parents('.modal').modal('open');


  // ===========================    Abrir Modal quando a página recarregar depois de um filtro ==================

  from.find('input[name="modal_open"]').parents('.modal').modal('open');


  // ===========================    Auto Submit (Filtros) ==================


  from.on('change', '.auto_submit_form>*', function(){
    $(this).parents('.auto_submit_form').submit();
  });

  from.on('click', '.sn_button', function(){
    from.toggleClass('minimized');
  });

  from.find('[data-toast]').each(function () {
    var $toastContent = $(this);
    Materialize.toast($toastContent, 3000, $(this).attr('class'));

  });


  from.find('[data-orgchart-type=1]').each(function () {
    var oc = $(this).orgchart({
      'data': $(this).data('orgchart-url'),
      'pan': true,
      'draggable': true,
      'depth': 5,
      'zoom': true,
      'zoominLimit': 1,
      'zoomoutLimit': 0.3,
      'exportButton': false,
      'exportFilename': 'organigram',
      'createNode': function (node, data) {
        orgChartNode1(node, data);
      },
      'toggleSiblingsResp': true
    })
    from.find('.oc-btn-png').click(function () {
      //oc.export();
    });
  });

  from.find('[data-image-from]').each(function () {
    var img = $(this);
    $(img.data('image-from')).change(function () {
      img.attr('src', $(this).val());
    });
  });

  from.find('#assessment_skill_percentage, #assessment_objective_percentage, #assessment_attendance_percentage').each(function () {
      $(this).keyup(function () {
        update_percentages_field($(this));
      });

      $(this).change(function () {
        update_percentages_field($(this));
      });

  });

  from.on('click', '[data-href]', function(){
    window.location = $(this).data('href');
  });

  from.find('[data-show-on-bigger-than]').each(function () {
    var elemento = $(this);
    var input_id = elemento.data('show-on-bigger-than').split(',')[0];
    var selected_value = elemento.data('show-on-bigger-than').split(',')[1];
    show_on_bigger_than(elemento, input_id, selected_value);
    $(input_id).keyup(function () {
      show_on_bigger_than(elemento, input_id, selected_value);
    });
    $(input_id).change(function () {
      show_on_bigger_than(elemento, input_id, selected_value);
    });
  });

  from.find('[data-show-on-select]').each(function () {
    var elemento = $(this);
    var input_id = elemento.data('show-on-select').split(',')[0];
    var selected_value = elemento.data('show-on-select').split(',')[1];
    show_on_select(elemento, input_id, selected_value);
    $(input_id).change(function () {
      show_on_select(elemento, input_id, selected_value);
    });
  });

  from.find('[data-hide-on-select]').each(function () {
    var elemento = $(this);
    var input_id = elemento.data('hide-on-select').split(',')[0];
    var selected_value = elemento.data('hide-on-select').split(',')[1];
    hide_on_select($(this), input_id, selected_value);
    $(input_id).change(function () {
      hide_on_select(elemento, input_id, selected_value);
    });
  });

  from.find('[data-on-check]').each(function () {
    var elemento = $(this);
    var input_id = elemento.data('on-check').split(',')[0];
    var value = elemento.data('on-check').split(',')[1];
    on_check($(this), input_id, value);
    $(input_id).change(function () {
      on_check(elemento, input_id, value);
    });
  });

  from.find('[data-switch-get]').on('click', function () {
    var type = $(this).data('switch-get');
    window.alert(from.find('#switch-' + type).bootstrapSwitch(type));
  });

  //======================== Ordenação das tabelas ===============================

  from.find('table.stupid-sort').stupidtable();

  from.find('table.stupid-sort').on("beforetablesort", function (event, data) {
    from.find('.mc-loader-container.hide').removeClass('hide');
  });

  from.find('table.stupid-sort').on("aftertablesort", function (event, data) {
    from.find('.mc-loader-container').addClass('hide');
  });

  //======================= Activa o collapse para filtros =======================

  from.find('.filter-active').click(function () {
    toggle_id = $(this).attr('data-filter');
    from.find("#" + toggle_id).toggle();
  });

  initialize_wage_form(from);

}

function initialize_wage_form(from){
  var kwanzaFormat = wNumb({
    mark: ',',
    thousand: '.',
    prefix: '',
    suffix: ' AKZ'
  });
  var wage_counter = -1;
  var line = '<tr class="removable_row">' +
              '<td style="text-align: right; padding-right: 2%;">' +
                '<span style="">' +
                  'Desde ' +
                '</span> ' +
                '<span class="from_span">0,00 AKZ</span>' +
                '<span style=""> Até </span>' +
                '<div class="form-group decimal required tax_type_wage_income_tax_items_to" style="max-width: 130px;display: inline-block;"><input class="form-control numeric decimal required ms-input" type="number" step="any" value="0" name="tax_type[wage_income_tax_items_attributes][replace_with_number][to]" id="tax_type_wage_income_tax_items_attributes_replace_with_number_to"></div>' +
              '</td>' +
              '<td><div class="form-group decimal required tax_type_wage_income_tax_items_fixed_portion" style="max-width: 130px;display: inline-block;"><input class="form-control numeric decimal required ms-input" type="number" step="any" value="0" name="tax_type[wage_income_tax_items_attributes][replace_with_number][fixed_portion]" id="tax_type_wage_income_tax_items_attributes_replace_with_number_fixed_portion"></div></td>' +
              '<td style="text-align: left;">' +
                '<div style="width: 80px;display: inline-block;" class="form-group decimal required tax_type_wage_income_tax_items_percentage_over_the_excess"><input class="form-control numeric decimal required ms-input" type="number" step="any" value="0" name="tax_type[wage_income_tax_items_attributes][replace_with_number][percentage_over_the_excess]" id="tax_type_wage_income_tax_items_attributes_replace_with_number_percentage_over_the_excess"></div>' +
                '<span style=""> Sobre o Excesso de <span class="excess_of_span">0,00 AKZ</span>' +
              '</td>' +
            '</tr>';

  from.find('#add').click(function(){
    wage_counter = wage_counter - 1
    from.find('#wage_form_table tr.last_row').before(line.replace(/replace_with_number/g, wage_counter));
    set_values();
  });

  from.on('click', 'a.delete_row', function() {
    from.find('#wage_form_table tr.removable_row').last().remove();
    set_values();
  });

  from.on('change keyup', '#wage_form_table tbody tr .tax_type_exempt_up_to>input, #wage_form_table tbody tr .tax_type_wage_income_tax_items_to>input', function() {
    set_values();
  });

  function set_values(){
    var preview_row_value = 0;
    if(from.find('#wage_form_table tr.removable_row').length <= 2){
      from.find('a.delete_row').addClass('hide');
    }else{
      from.find('a.delete_row').removeClass('hide');
    }
    from.find('#wage_form_table tbody tr').each(function(){
      var row = $(this);
      row.find('.excess_of_span').html(kwanzaFormat.to(preview_row_value));
      row.find('.from_span').html(kwanzaFormat.to(preview_row_value + 1));
      preview_row_value = Math.round(row.find('.tax_type_exempt_up_to>input, .tax_type_wage_income_tax_items_to>input').val());
    });
  }
}

function update_percentages_field(input) {
  var skill_percentage = $('#assessment_skill_percentage');
  var objective_percentage = $('#assessment_objective_percentage');
  var attendance_percentage = $('#assessment_attendance_percentage');

  switch (input.attr('id')) {
      case "#assessment_skill_percentage":
          // TODO add validations to percentages input
          break;
      case "#assessment_objective_percentage":
          // TODO add validations to percentages input
          break;
      case "#assessment_attendance_percentage":
          // TODO add validations to percentages input
          break;
  }
}

function orgChartNode1(node, data) {

  $("div.title").addClass("hide");

  node.append(
      '<a href="positions/' + data.id + '/edit" data-remote="true" >' +
      '<div class="content">' +
      '<div class="' + data.my_position + ' ' + data.my_supervisor_color + ' ' + 'orgchart-container">' +
      '<img class="orgchart-avatar" src="' + data.avatar + '">' +
      '<div class="text"> ' +
      '<p class="" style="font-size: 10px;">' + data.name + '</p>' +
      '<p class="" style="font-size: 9px; font-weight: 100">' + data.ocupation + '</p>' +
      '<p class="" style="font-size: 9px; font-weight: 100">' + data.function + '</p>' +
      '</div>' +
      '</div>' +
      '</div>' +
      '</a>'
  );

}

// ======================== ABREVIAÇÃO DO NOME =================================

// function truncate_name(name){
// 	var arr = []
//   array_of_name = name.split(" ");
//   firts_name = array_of_name.shift();
//   last_name = array_of_name.pop();
//
//   var another_names = " "
//
//   for (i = 0; i < array_of_name.length; i++) {
//     another_names += array_of_name[i].charAt(0) + "." + " " ;
// 	}
//
//   return firts_name + another_names + last_name
//
// }

// =============================================================================

function hide_on_select(elemento, input_id, selected_value) {
  if ($(input_id + " option:selected").val() == selected_value) {
      elemento.addClass('hide');
  } else {
      elemento.removeClass('hide');
  }
}

// Mostra o 'elemento' se o 'input_id' estiver com e 'selected_value' seleccionado
function show_on_select(elemento, input_id, selected_value) {
  if ($(input_id + " option:selected").val() == selected_value) {
      elemento.removeClass('hide');
  } else {
      elemento.addClass('hide');
  }
}

// Mostra o 'elemento' se o 'input_id' estiver com e 'selected_value' seleccionado
function show_on_bigger_than(elemento, input_id, selected_value) {
  if (parseFloat($(input_id).val()) > parseFloat(selected_value)) {
      elemento.removeClass('hide');
  } else {
      elemento.addClass('hide');
  }
}

function on_check(elemento, input_id, value) {
  if ($(input_id).is(':checked')) {
      if (value == 'show') {
          elemento.removeClass('hide');
      } else if (value == 'hide') {
          elemento.addClass('hide');
      }
  } else {
      if (value == 'show') {
          elemento.addClass('hide');
      } else if (value == 'hide') {
          elemento.removeClass('hide');
      }
  }
}

function on_switch(elemento, state, action) {
  if (state) {
      if (action == 'show') {
          elemento.removeClass('hide');
      } else if (action == 'hide') {
          elemento.addClass('hide');
      }
  } else {
      if (action == 'show') {
          elemento.addClass('hide');
      } else if (action == 'hide') {
          elemento.removeClass('hide');
      }
  }
}

function reload_remove_parent_events() {
  $('.remove_parent').each(function () {
    $(this).mouseover(function () {
      $(this).parent().addClass('hoverable');
    });

    $(this).click(function () {
      $(this).parent().remove();
    });
  });
}

function update_fileds_onjustification() {
  var position_id = $('#justification_position_id').val();
  var assessment_id = $('#justification_assessment_id').val();
  $('#justification_attendance_ids_').children().each(function () {
    if ($(this).data('position-id') == position_id && $(this).data('assessment-id') == assessment_id) {
      $(this).removeProp('disabled');
    } else {
      $(this).attr('disabled', 'disabled');
      $(this).removeProp('selected');
    }
  });

}

// a.replace( pattern, function replacer(match){
//   return match.toUpperCase();
// } );

// template.replace(
//   /(<span id=")(.*?)(">)(<\/span>)/g,
//   function(match,$1,$2,$3,$4){
//       return $1 + $2 + $3 + prices[$2] + $4;
//   }
// );

// Deep Search a Object to get its value
function getValue(data, keys){
  var data_aux = data;
  var keys = keys.split(".");
  var len = keys.length;
  for (i = 0 ; i < len; i++) {
    var key = keys[i];
    if(data_aux && data_aux[key]){
      data_aux = data_aux[key];
    }else{
      return data_aux;
    }
  }
  return data_aux;
}
