cropImage = function(e) {
	e.stopPropagation();
  e.preventDefault();
  var id = this.dataset.id;
  var file_name = this.dataset.fileName;
  var form = $('#edit_picture_'+id)[0];
  var params = {};
  params['picture'] = {};
  jQuery.each(form.getElementsByTagName('input'), function(index, value) {
  	if (this.name != "" && this.name != "_method") {
  		var found = this.name.search(/\[.+\]$/i)
  		if (found == -1) {
  			params[this.name] = this.value;
  		} else {
  			params['picture'][this.name.substring(found+1,this.name.length-1)] = this.value
  		}
  	}
  });
  return $.ajax({
    type: 'PATCH',
    url: '/pictures/'+params.picture.id,
    dataType: 'json',
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    data: {
    	utf8: params.utf8,
    	authenticity_token: params.authenticity_token,
      picture: params.picture
    },
    success: function(data, textStatus) {
    	// set the new tab contents
    	$('#'+file_name+"_"+id+"-content").html(showImage(data));
    	//  if there is a title on the image lets update the tab and index
    	if (params.picture.title.length > 0) {
    		$('#ul-tab').children('.active').children('a')[0].text = params.picture.title
    		$('#'+file_name+"_"+id+"-tr").children('.title').text(params.picture.title);
    	}
    	//  if description then update the index
    	if (params.picture.description.length > 0) {
    		$('#'+file_name+"_"+id+"-tr").children('.description').text(params.picture.description);
    	}
    	//  update image on index
    	var img = $('#'+file_name+"_"+id+"-tr").children('.mini-pic').children('img')[0];
    	img.alt = data.title;
    	img.src = data.thumbnail;
    	//  remove red border from tab
    	$('#'+file_name+"_"+id+"-tab").children('a').removeClass('not-cropped');
    	//  add radio button to index
    	$('#'+file_name+"_"+id+"-tr").children('.main_image')[0].textContent = "";
    	$('#'+file_name+"_"+id+"-tr").children('.main_image')[0].appendChild(createInput(data));
    	//  rebind button
    	$('.edit-image').unbind("click");
    	$('.edit-image').on("click", editImage);
    }
  });
  console.log(params);
};

editImage = function(e) {
	e.stopPropagation();
  e.preventDefault();
  var id = this.dataset.id;
  var file_name = this.dataset.fileName;
  return $.ajax({
    type: 'GET',
    url: '/pictures/'+id+'/edit',
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(data, textStatus) {
    	$('#'+file_name+"_"+id+"-content").html(data);
      $('.crop-image').unbind("click");
      $('.crop-image').on("click", cropImage);
    }
  });
};

createInput = function(image) {
	var input = document.createElement('input');
  input.setAttribute('name','main_image');
  input.setAttribute('type','radio');
  input.setAttribute('value','true');
  input.setAttribute('class','update-main-image');
  input.setAttribute('data-id',image.id);
  return input;
};

showImage = function(image) {
	var div = document.createElement('div');

	var button = document.createElement('button');
	button.setAttribute('class','btn btn-default edit-image inline pull-right');
	button.setAttribute('type', 'button');
	button.setAttribute('data-id', image.id);
	button.setAttribute('data-file-name', image.image_file_name.replace(/\.[^/.]+$/, ""));
	button.textContent = 'Edit Image Details'

	div.appendChild(button);
	// the title
	var p = document.createElement('p');
	p.setAttribute('class','inline');

	var b = document.createElement('b');
	b.textContent = 'Title:'

	var text = document.createTextNode(image.title);

	p.appendChild(b);
	p.appendChild(text);

	div.appendChild(p);
	// the description
	p = document.createElement('p');

	b = document.createElement('b');
	b.textContent = 'Description:'

	text = document.createTextNode(image.description);

	p.appendChild(b);
	p.appendChild(text);

	div.appendChild(p);
	// the image
	p = document.createElement('p');

	p.appendChild(createImageTag(image,'large'));

	div.appendChild(p);

	return div;
};

createImageTag = function(image,size) {
	var img = document.createElement('img');
	img.alt = image.title;
	img.src = image[size];
	return img;
};