$(document).ready(function() {
  $('.tab-load').on("click", loadTabContents);
  $('.edit-image').on("click", editImage);
  $('.delete-image').on("click", deleteImage);
  $('.my-work-title').on("mouseover", toggleFullTitle);
  $('.my-work-title').on("mouseout", toggleFullTitle);
  $('.publish-my-work').on("click", publishMyWork);

  loadImage();
});

publishMyWork = function(e) {
  var myWorkId = this.dataset.id
  return $.ajax({
      type: 'POST',
      url: '/my_works/' + myWorkId + '/publish',
      dataType: 'json',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(data, textStatus) {
        var base_name = '#'+data.image_file_name.replace(/\.[^/.]+$/, "")+'_'+data.id;
        $(base_name+'-tr').hide();
        $(base_name+'-tab').hide();
      }
    });
};

toggleFullTitle = function(e) {
  var fullItemId = '#my-work-title-'+this.dataset.myWorkId;
  var itemDesc = $(fullItemId);

  var temp = itemDesc[0].dataset.full;
  itemDesc[0].dataset.full = itemDesc.text();
  itemDesc.text(temp);
};

deleteImage = function(e) {
  e.stopPropagation();
  e.preventDefault();
  var pic_id = this.dataset.id;
  strconfirm = confirm("Are you sure you want to delete? This can not be undone!");
  if (strconfirm == true) {
    console.log('teseting');
    return $.ajax({
      type: 'DELETE',
      url: '/pictures/'+pic_id,
      dataType: 'json',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(data, textStatus) {
        var base_name = '#'+data.image_file_name.replace(/\.[^/.]+$/, "")+'_'+data.id;
        $(base_name+'-tr').hide();
        $(base_name+'-tab').hide();
      }
    });
  }
};

updateMainImage = function(e) {
  var id = this.dataset.id;
  var cover = this.dataset.cover;
  return $.ajax({
    type: 'PATCH',
    url: '/my_works/'+id,
    dataType: 'json',
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    data: {
      my_work: {
        id: id,
        picture_id: cover
      }
    },
    success: function(data, textStatus) {
      return;
    }
  });
};

loadTabContents = function(e) {
  e.stopPropagation();
  e.preventDefault();
  var currentTab = $(this);
  var id = this.dataset.id;
  var file_name = this.dataset.fileName;
  var width = $('#myAwesomeDropzone').width();
  if (currentTab[0].classList.contains('ajaxed')) {
    return activateTab(file_name+"_"+id);
  } else {
    $.ajax({
      type: "GET",
      url: "/pictures/"+id+"?width="+width,
      success: function(data, textStatus, jqXHR) {
        $('#'+file_name+"_"+id+"-content").html((data));
        currentTab.addClass('ajaxed');
        activateTab(file_name+"_"+id);
        $('.crop-image').unbind("click");
        $('.crop-image').on("click", cropImage);
        $('.edit-image').unbind("click");
        $('.edit-image').on("click", editImage);
        return init_papercrop();
      }
    });
  }
};

activateTab = function(tab) {
  $('#ul-tab').children('.active').removeClass('active');
  $('#tab-content').children('.active').removeClass('active')
  if (tab == 'undefined_undefined') {
    $('#pictures').addClass('active');
  } else {
    $('#'+tab+"-content").addClass('active');
    $('#'+tab+"-tab").addClass('active');  
  }
  return;
};

createTabContent = function(info) {
  var div = document.createElement('div');
  div.setAttribute('class','tab-pane');
  div.setAttribute('id',info.image_file_name.replace(/\.[^/.]+$/, "")+"_"+info.id+"-content");
  return div;
};

createLi = function(info) {

  var fileName = info.image_file_name.replace(/\.[^/.]+$/, "")+"_"+info.id;

  var entry = document.createElement('li');
  entry.id = info.image_file_name.replace(/\.[^/.]+$/, "")+"_"+info.id+"-tab";

  var anchor = document.createElement('a');
  anchor.href = '#';
  anchor.setAttribute('class','tab-load not-cropped');
  anchor.setAttribute('data-file-name',info.image_file_name.replace(/\.[^/.]+$/, ""));
  anchor.setAttribute('data-id',info.id);

  anchor.text = info.image_file_name.replace(/\.[^/.]+$/, "");
  
  entry.appendChild(anchor)

  return entry;

};

createTr = function(info) {
  var tr = document.createElement('tr');
  tr.id = info.image_file_name.replace(/\.[^/.]+$/, "")+"_"+info.id+"-tr";
  var td = document.createElement('td');
  td.setAttribute('class','mini-pic');
  var img = document.createElement('img');
  img.src = info.thumbnail;
  td.appendChild(img);
  tr.appendChild(td);

  td = document.createElement('td');
  td.setAttribute('class','title');
  td.textContent = info.title
  tr.appendChild(td);

  td = document.createElement('td');
  td.setAttribute('class','description');
  td.textContent = info.description;
  tr.appendChild(td);

  td = document.createElement('td');
  td.setAttribute('class','file_name');
  td.textContent = info.image_file_name;
  tr.appendChild(td);

  td = document.createElement('td');
  td.setAttribute('class','main_image');
  if (info.cropped == false) {
    td.textContent = 'CROP'
  } else {
    td.appendChild(createInput(info));
  }
  tr.appendChild(td);

  td = document.createElement('td');
  td.setAttribute('class','delete_image');

  a = document.createElement('a');
  a.setAttribute('class','delete-image');
  a.dataset.id = info.id
  a.setAttribute('href','#');
  a.href = '#'
  a.textContent = 'Delete Picture'
  td.appendChild(a);
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
    formData.append("picture[gallery_id]", $('#gallery_id').val());
    formData.append("picture[gallery_type]", $('#gallery_type').val());
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