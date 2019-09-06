
// Vai pegar uma célula de uma tabela e formatar para mostrar as informações de presença
var absenceTypeFormatter = function(cell, formatterParams){
  row_data =  cell.getData();
  cell_data = cell.getValue();
  if(cell_data != undefined){
    cell.getElement().addClass('absence-type-' + cell_data.toLowerCase());
    return '<a class="jpanel" title="Data: ' + cell.getField() + '" style="color: #fff; font-weight: 500;" data-remote="true" href="/employees/' + row_data.employee_id + '/' + cell.getField() + '/presence.html?layout_type=no_layout">' + cell_data.split("-")[0] + '</a>';
  }else{
    ""
  }
};

var linkTypeFormatter = function(cell, formatterParams){
  row_data =  cell.getData();
  cell_data = cell.getValue();
  if(cell_data != undefined){
    cell.getElement().addClass('absence-type-' + cell_data.toLowerCase());
    if(row_data.url){
      return '<a href="' + row_data.url + '">' + row_data.employee_name + '</a>';
    }
    else {
      return row_data.employee_name
    }
  }else{
    ""
  }
};

var personaCardFormatter = function(cell, formatterParams){
  // Expects a employee with user position function directorate position inside
  // formatterParams = {
  //   dataRemote: (true || false) to set lisk as remote
  //   href: String card link url
  //   linkClass: String classes to add to the link

  // }
  var dataRemote, name_and_number, position_name, initials, avatar = "";
  var row_data = cell.getData();
  if(formatterParams.dataRemote == true){
    dataRemote = "data-remote='true'";
  }
  if(formatterParams.href){
    dataRemote = "data-remote='true'";
  }
  name_and_number = row_data.number;
  if(row_data.user){
    initials += row_data.user.first_name.toString().substring(0, 1).toUpperCase();
    initials += row_data.user.last_name.toString().substring(0, 1).toUpperCase();
    name_and_number += ` - ${row_data.user.first_name} ${row_data.user.last_name}`;
    if(row_data.user.avatar){
      avatar = `<img class="ms-Persona-image" src="${avatar}" alt="User">`;
    }else{
      avatar = `<div class="ms-Persona-initials ms-Persona-initials--blue">${initials.replace("undefined", '')}</div>`;
    }
  }else{
    initials += row_data.first_name.toString().substring(0, 1).toUpperCase();
    initials += row_data.last_name.toString().substring(0, 1).toUpperCase();
    name_and_number += ` - ${row_data.first_name} ${row_data.last_name}`;
    avatar = `<div class="ms-Persona-initials ms-Persona-initials--blue">${initials.replace("undefined", '')}</div>`;
  }

  if(row_data.efective_position){
    position_name = row_data.efective_position.new_name_and_number;
  }else{
    position_name = "N/D";
  }

  var data = `
    <a class="ms-Link ${formatterParams.linkClass}" title="Registar Atraso do(a) 1 - Bruna Nogueira" href="${formatterParams.href}" ${dataRemote}>
      <div class="ms-Persona ms-Persona--sm" style='padding-bottom: 11px;">
        <div class="ms-Persona-imageArea" style='padding-bottom: 11px;">${avatar}</div>
        <div class="ms-Persona-details">
          <div class="ms-Persona-primaryText">${name_and_number}</div>
          <div class="ms-Persona-secondaryText">${position_name}</div>
        </div>
      </div>
    </a>
  `;
  // console.log(data);
  // data = data.replace( /<data>(.*?)<\/data>/g, function(match){
  //   match = match.replace(/<data>/g, '');
  //   match = match.replace(/<\/data>/g, '');
  //   return getValue(row_data, match);
  // });

  data = data.replace( /%3Cdata%3E(.*?)%3C%2Fdata%3E/g, function(match){
    // console.log("retyu");
    // console.log(match);
    match = match.replace("%3Cdata%3E", '');
    match = match.replace("%3C%2Fdata%3E", '');
    // match = match.replace(/<data>/g, '');
    // match = match.replace(/<\/data>/g, '');
    return getValue(row_data, match);
  });

  return data;
};


langs = {
  "en-gb":{
      "custom":{
          "site_name":"What A Great Table Based Site!!!",
      },
      "columns":{
          "name":"Name", //replace the title of column name with the value "Name";
      },
      "ajax":{
          "loading":"A Carregar", //ajax loader text
          "error":"Erro", //ajax error text
      },
      "pagination":{
          "first":"First", //text for the first page button
          "first_title":"First Page", //tooltip text for the first page button
          "last":"Last",
          "last_title":"Last Page",
          "prev":"Prev",
          "prev_title":"Prev Page",
          "next":"Next",
          "next_title":"Next Page",
      },
  },
  "pt-ao":{
      "custom":{
          "site_name":"What A Great Table Based Site!!!",
      },
      "columns":{
          "name":"Nome"
      },
      "ajax":{
          "loading":"A Carregar", //ajax loader text
          "error":"Erro", //ajax error text
      },
      "pagination":{
          "first":"<i class='material-icons' style='font-size: 13px;display: inline-block;width: 1em;height: 1em;line-height: 13px;vertical-align: middle;'>first_page</i>", //text for the first page button
          "first_title":"Primeira Pagina", //tooltip text for the first page button
          "last":"<i class='material-icons' style='font-size: 13px;display: inline-block;width: 1em;height: 1em;line-height: 13px;vertical-align: middle;'>last_page</i>",
          "last_title":"Ultima Pagina",
          "prev":"<i class='material-icons' style='font-size: 13px;display: inline-block;width: 1em;height: 1em;line-height: 13px;vertical-align: middle;'>chevron_left</i>",
          "prev_title":"Pagina Anterior",
          "next":"<i class='material-icons' style='font-size: 13px;display: inline-block;width: 1em;height: 1em;line-height: 13px;vertical-align: middle;'>chevron_right</i>",
          "next_title":"Proxima Pagina",
      },
  }
};
