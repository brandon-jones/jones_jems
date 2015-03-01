
Dropzone.options.myAwesomeDropzone = {
  paramName: "picture[image]", // The name that will be used to transfer the file
  maxFilesize: 5, // MB
  parallelUploads: 5,
  accept: function(file, done) {
    if (file.name.match(/.+\.(jpg|jpeg|png)$/i)) {
      done();
    }
    else { done("jpg, jpeg, or png"); }
  },
  sending: function(file, xhr, formData) {
  	formData.append("authenticity_token", $('#session_key').val());
  },
  success: function(file, response){
    console.log(response);
  }
};