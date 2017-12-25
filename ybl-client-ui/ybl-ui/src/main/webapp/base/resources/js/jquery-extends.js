
$(function(){
	

$.fn.watchProperty = function( name,handler ){
			var that = this[0];
			if ( "watch" in that ) {
				// that.watch(name,handler);
				var o = that[name];
				setInterval( function() {
					var n = that[name];
					if(o !== n) {
						o = n;
						handler.call(that);
					}
				}, 300);
			} else if ( "onpropertychange" in that ) {
				name = name.toLowerCase();
				that.onpropertychange = function() {
					if(window.event.propertyName.toLowerCase() === name) {
						handler.call(that);
					}
				}
			} else {
				var o = that[name];
				setInterval( function() {
					var n = that[name];
					if(o !== n) {
						o = n;
						handler.call(that);
					}
				}, 300);
			}
		};
		
});		