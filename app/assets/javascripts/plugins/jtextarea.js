/*
 * JQuery jtextarea v1.0
 *
 * Copyright 2011, Gianrocco Giaquinta
 * http://www.jscripts.info/
 *
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 */

(function( $ ){
	
	var jtobj, lastval="", lexe=false;
	var tags="";	
    var methods = {
		
		resize: function(char, ctl) {
			var re_nl = null;
			var ch = String.fromCharCode(char);
			  	
			var st = ctl.val();
			lastval = st;
			st = st.replace(/&/g, "&amp;").replace(/>/g, "&gt;").replace(/</g, "&lt;").replace(/"/g, "&quot;"); 
							
				var text = escape(st); 
				if(text.indexOf('%0D%0A') > -1){
					re_nl = /%0D%0A/g ;
				}else if(text.indexOf('%0A') > -1){
					re_nl = /%0A/g ;
				}else if(text.indexOf('%0D') > -1){
					re_nl = /%0D/g ;
				}
				if (re_nl) st = unescape( text.replace(re_nl,'<br />&#00;') );
				if (char == 13) st+="<br />&#00;";
									
				jt_obj.html( st+ch );
				var h = jt_obj.height(); 
			    ctl.css( { height: h+"px" } );
				setTimeout(function() {	methods.ctrltag(ctl); }, 0);
				
		},
		ctrltag: function(ctl) {
				
				if (!tags) return;
				var st = ctl.val();
				var ct = st.match(/<[^\/](.*?)>/ig);
				for (var i in ct) {
					var tag = "<"+/\w+/.exec(ct[i])+">";
					if ( (tags[0] == "!" && tags.indexOf(tag) != -1) || (tags[0] != "!" && tags.indexOf(tag) == -1) )
					{
						alert ( tag+" not permitted. ");
						ctl.val( st.replace( ct[i], "" ) );
						methods.resize(null, ctl);
						break;
					}			
				}
		},
		
		html: function (ctl) {
			
			var re_nl = null;
			var st = ctl.val();
			
				var text = escape(st);
				if(text.indexOf('%0D%0A') > -1){
					re_nl = /%0D%0A/g ;
				}else if(text.indexOf('%0A') > -1){
					re_nl = /%0A/g ;
				}else if(text.indexOf('%0D') > -1){
					re_nl = /%0D/g ;
				}
				if (re_nl) st = unescape( text.replace(re_nl,'<br />') );
		
			var reg = /^(http|https|ftp)\:\/\/([a-zA-Z0-9\.\-]+(\:[a-zA-Z0-9\.&amp;%\$\-]+)*@)?((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\-]+\.)*[a-zA-Z0-9\-]+\.[a-zA-Z]{2,4})(\:[0-9]+)?(\/[^\/][a-zA-Z0-9\.\,\?\'\\/\+&amp;%\$#\=~_\-@]*)*$/;
			
			//var reg = /^https?\:\/\/(www\d?\d?\d?\d?\.)?([A-Za-z0-9-_]+\.)?[A-Za-z0-9-_]+((\.[A-Za-z]{2,6})(\.[A-Za-z]{2})?([0-9-_%&\?\/\.=]*))$/i;

			var ns = st.match(/(<a(.*?)<\/a>)|([\w\.\/@]+)/g);
			
			for ( var i in ns ) { 
			
				if ( /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i.test(ns[i]) == true) {
					
					var rem = new RegExp("(^|[^\\:>])"+ns[i]+"(\\b)","g");
			 		st = st.replace(rem, "$1<a href='mailto:"+ns[i]+"'>"+ns[i]+"</a>");
				} else
				{
				var urlv="";
				if ( reg.test(ns[i]) ) urlv=ns[i];
				else if ( reg.test("http://"+ns[i]) ) urlv="http://"+ns[i];	
				
				if (urlv) {
					var rep = new RegExp("(^|[^\\/>])"+ns[i]+"(\\b)","g");
			 		st = st.replace(rep, "$1<a href='"+urlv+"'>"+ns[i]+"</a>"); 
				}
				}
				
				
				
								
			}
			
			return st;
		
		}	
	}

	$.fn.jhtml = function (options) {
		return methods.html( $(this) );
	}
	
	$.fn.jtextarea = function(opt) {
		
		var hmin=0;
					
		var settings = {
			tags : ""
		};
		
		if(opt)	$.extend(settings, opt);
		
		jt_obj = $('<div id="jt_clone_area"></div>')
            .css({display:'none'})
            .appendTo('body') 
			
		
		this.each(function(){	
				
			$(this).css( {overflow: "hidden", resize:"none" } );
			
			hmin = $(this).height();
			
			$(this)
			.keypress( function(e) {
				lexe = true;
				//methods.resize(e.charCode, ctl);
				methods.resize(e.charCode, $(this));
			})
			.keyup( function(e) {
				 
				if (!lexe) {
				 if (lastval !=  $(this).val() ) {
					jt_obj.css({"min-height":hmin+'px'}); 
					methods.resize(null, $(this));
				 }
				}
				lexe = false;				
			});
			
			$(this).bind("paste", function(e) {
				lexe = false;
				var ctl = $(this);				
				setTimeout(function() {	methods.resize(null, ctl); }, 0);
			});
			
			$(this).bind("cut", function(e) {
				lexe = false;
				jt_obj.css({"min-height":hmin+'px'});
				var ctl = $(this);
				setTimeout(function() {	methods.resize(null, ctl); }, 0);
			});
						
			
			$(this).focus( function(e) {
				e.preventDefault();
				tags = settings.tags;
				var w = $(this).width();
				var h = $(this).height();
				var styles = window.getComputedStyle(this, null);; 
				
				var st = null;
				for ( var i in styles ) {
					 
        			if ( /:/i.test(styles[i]) ) {
						st = styles[i].match(/font[^;]+/ig);
						var le = styles[i].match(/line-height[^;]+/ig);
						if(le) st.push(le[0]); 
						break;
        			};
      			};
								
				if (st) {
					for ( var i in st ) {
						var na = st[i].split(":");
        				jt_obj.css( na[0], na[1] );
					}
				}
				
				jt_obj.css({width:w+'px', "min-height":hmin+"px"});
				methods.resize(null, $(this));
				
			});
			
			var w = $(this).width();
			var h = $(this).height();
			var styles = window.getComputedStyle(this, null);; 
				
			var st = null;
			for ( var i in styles ) {
					 
        		if ( /:/i.test(styles[i]) ) {
					st = styles[i].match(/font[^;]+/ig);
					var le = styles[i].match(/line-height[^;]+/ig);
					if(le) st.push(le[0]); 
					break;
        		};
      		};
								
			if (st) {
				for ( var i in st ) {
					var na = st[i].split(":");
        			jt_obj.css( na[0], na[1] );
				}
			}
			jt_obj.css({width:w+'px', "min-height":hmin+"px"});
			methods.resize(null, $(this));
			
	});
	

 }
 
})( jQuery );