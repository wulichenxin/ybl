/**
 * 让jqueryUi dialog支持html title
 */
$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
	_title : function(title) {
		var $title = this.options.title || '&nbsp;';
		if (("title_html" in this.options)&& this.options.title_html == true)
			title.html($title);
		else
			title.text($title);
	}
}));