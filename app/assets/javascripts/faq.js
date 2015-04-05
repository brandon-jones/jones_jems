$(document).ready(function() {
  return $('.faq-search').on("click", flashFaq);
});

flashFaq = function(e) {
	console.log('testing');
	var question = ".question_" + this.dataset.question + "_flash";
	$(question).addClass('flasher');
	run = function() {
    return $(question).removeClass('flasher');
  };
  return setTimeout(run, 1000);
};
  