$(document).ready(function() {
  $('.tab-load').on("click", loadTabContents);
});

loadTabContents = function(e) {
  var currentTab = $(this).attr('href');
  var vis = $(currentTab).is(':visible');
  var id = this.dataset.id;
  var file_name = this.dataset.fileName;
  $.ajax({
    type: "GET",
    url: "/pictures/"+id,
    success: function(data, textStatus, jqXHR) {
      $('#'+file_name+"_"+id).html(data);
      if(vis) {
        
      } else {
        $('#ul-tab').children('.active').removeClass('active');
        $('#tab-content').children('.active').removeClass('active')
        $(currentTab).addClass('active');
      }
      return init_papercrop();
    }
  });
};

createTabContent = function(info) {
  var div = document.createElement('div');
  div.setAttribute('class','tab-pane');
  div.setAttribute('class','tab-pane');
  div.setAttribute('id',info.image_file_name.replace(/\.[^/.]+$/, "")+"_"+info.id);
  div.setAttribute('role','tabpanel');
  return div;
};

createLi = function(info) {

  var fileName = info.image_file_name.replace(/\.[^/.]+$/, "")+"_"+info.id;

  var entry = document.createElement('li');
  entry.setAttribute('role', 'presentation');

  var anchor = document.createElement('a');
  anchor.href = '#'+info.image_file_name.replace(/\.[^/.]+$/, "")+"_"+info.id;
  anchor.setAttribute('aria-controls',info.image_file_name.replace(/\.[^/.]+$/, "")+"_"+info.id);
  anchor.setAttribute('data-toggle','tab');
  anchor.setAttribute('class','tab-load');
  anchor.setAttribute('data-file-name',info.image_file_name.replace(/\.[^/.]+$/, ""));
  anchor.setAttribute('data-id',info.id);
  anchor.setAttribute('role','tab');
  anchor.setAttribute('aria-expanded','false');

  anchor.text = info.image_file_name.replace(/\.[^/.]+$/, "");
  
  entry.appendChild(anchor)

  return entry;

};

createTr = function(info) {
  var tr = document.createElement('tr');
  
  var td = document.createElement('td');
  var img = document.createElement('img');
  img.src = info.thumbnail;
  td.appendChild(img);
  tr.appendChild(td);

  td = document.createElement('td');
  td.textContent = info.title
  tr.appendChild(td);

  td = document.createElement('td');
  td.textContent = info.description;
  tr.appendChild(td);

  td = document.createElement('td');
  td.textContent = info.image_file_name;
  tr.appendChild(td);

  td = document.createElement('td');
  td.textContent = info.cropped;
  tr.appendChild(td);

  return tr;
};

Dropzone.options.myAwesomeDropzone = {
  paramName: "picture[image]", // The name that will be used to transfer the file
  maxFilesize: 5, // MB
  parallelUploads: 5,
  addRemoveLinks: true,
  acceptedFiles: 'image/jpg,image/jpeg,image/png',
  sending: function(file, xhr, formData) {
  	formData.append("authenticity_token", $('#session_key').val());
  	formData.append("picture[my_work_id]", $('#my_work_id').val());
  },
  success: function(file, response){
    this.removeFile(file);
    $('#ul-tab').append(createLi(response));
    $('#pictures-tbody').append(createTr(response));
    $('#tab-content').append(createTabContent(response));
    $('.tab-load').unbind("click");
    $('.tab-load').on("click", loadTabContents);
  }
};